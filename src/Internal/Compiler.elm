module Internal.Compiler exposing
    ( AliasCache
    , Annotation(..)
    , AnnotationDetails
    , Declaration(..)
    , DeclarationDetails
    , Expose(..)
    , Expression(..)
    , ExpressionDetails
    , Inference
    , InferenceError(..)
    , Module
    , RenderedDeclaration(..)
    , Restrictions(..)
    , VariableCache
    , Visited
    , Warning
    , addAlias
    , addInference
    , applyType
    , denode
    , denodeAll
    , denodeMaybe
    , documentation
    , emptyAliases
    , expose
    , exposeWith
    , expression
    , facts
    , findAlias
    , fullModName
    , getAliases
    , getAnnotation
    , getAnnotationImports
    , getGenerics
    , getImports
    , getInnerAnnotation
    , getInnerInference
    , getTypeModule
    , importInferences
    , inference
    , inferenceErrorToString
    , makeImport
    , mergeAliases
    , mergeInferences
    , noImports
    , nodify
    , nodifyAll
    , parens
    , resolve
    , resolveField
    , thread
    , toExpressionDetails
    , toVar
    , unify
    , unifyOn
    )

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer
import Internal.Format as Format
import Internal.Index as Index exposing (Index)
import Result.Extra
import Set exposing (Set)


type Annotation
    = Annotation AnnotationDetails


type alias AnnotationDetails =
    { imports : List Module
    , annotation : Annotation.TypeAnnotation
    , aliases :
        AliasCache
    }


getTypeModule : Annotation -> List String
getTypeModule (Annotation annotation) =
    case annotation.annotation of
        Annotation.Typed (Node _ ( mod, _ )) _ ->
            mod

        _ ->
            []


type Declaration
    = Declaration DeclarationDetails
    | Comment String
    | Block String
    | Group
        { title : String
        , docs : String
        , decls : List Declaration
        }


type RenderedDeclaration
    = RenderedDecl Declaration.Declaration
    | RenderedComment String
    | RenderedBlock String


type alias DeclarationDetails =
    { name : String
    , exposed : Expose
    , imports : List Module
    , docs : Maybe String
    , toBody :
        Index.Index
        ->
            { declaration : Declaration.Declaration
            , additionalImports : List Module
            , warning : Maybe Warning
            }
    }


type alias Warning =
    { declaration : String
    , warning : String
    }


{-| -}
type Expression
    = Expression (Index -> ExpressionDetails)


type alias ExpressionDetails =
    { expression : Exp.Expression
    , annotation :
        Result
            (List InferenceError)
            Inference
    , imports : List Module
    }


{-| An expression should always call `Index.dive`.

This helper does that.

-}
expression : (Index -> ExpressionDetails) -> Expression
expression toExp =
    Expression
        (\index ->
            toExp (Index.dive index)
        )


{-|

    type_ = What type this expression is declared to be
    inferences = facts we know about the expression.
    aliases =

-}
type alias Inference =
    { type_ : Annotation.TypeAnnotation
    , inferences : VariableCache
    , aliases : AliasCache
    }


importInferences : Inference -> Inference -> Inference
importInferences one two =
    { type_ = two.type_
    , inferences = mergeInferences one.inferences two.inferences
    , aliases = mergeAliases one.aliases two.aliases
    }


type alias VariableCache =
    Dict.Dict String Annotation.TypeAnnotation


type alias AliasCache =
    Dict
        String
        { variables : List String
        , target : Annotation.TypeAnnotation
        }


emptyAliases : AliasCache
emptyAliases =
    Dict.empty


mergeAliases :
    AliasCache
    -> AliasCache
    -> AliasCache
mergeAliases =
    Dict.union


getAlias :
    Node ( ModuleName.ModuleName, String )
    -> AliasCache
    ->
        Maybe
            { variables : List String
            , target : Annotation.TypeAnnotation
            }
getAlias (Node.Node _ ( modName, name )) cache =
    Dict.get (formatAliasKey modName name) cache


getAliases : Annotation -> AliasCache
getAliases (Annotation ann) =
    ann.aliases


formatAliasKey : List String -> String -> String
formatAliasKey mod name =
    String.join "." mod ++ "." ++ name


addAlias : List String -> String -> Annotation -> AliasCache -> AliasCache
addAlias mod name ((Annotation annDetails) as ann) aliasCache =
    Dict.insert (formatAliasKey mod name)
        { variables = getGenerics ann
        , target = annDetails.annotation
        }
        aliasCache


{-| -}
parens : Exp.Expression -> Exp.Expression
parens expr =
    case expr of
        Exp.UnitExpr ->
            expr

        Exp.Integer _ ->
            expr

        Exp.Literal _ ->
            expr

        Exp.Hex _ ->
            expr

        Exp.Floatable _ ->
            expr

        Exp.TupledExpression _ ->
            expr

        Exp.ParenthesizedExpression _ ->
            expr

        Exp.CharLiteral _ ->
            expr

        Exp.ListExpr _ ->
            expr

        Exp.FunctionOrValue _ _ ->
            expr

        Exp.RecordAccessFunction _ ->
            expr

        Exp.RecordUpdateExpression _ _ ->
            expr

        Exp.RecordExpr _ ->
            expr

        Exp.LambdaExpression _ ->
            expr

        _ ->
            Exp.ParenthesizedExpression (nodify expr)


{-| -}
facts : Expression -> Result String (List ( String, Annotation.TypeAnnotation ))
facts (Expression exp) =
    let
        expresh : ExpressionDetails
        expresh =
            exp (Index.startIndex Nothing)
    in
    case expresh.annotation of
        Ok sig ->
            sig.inferences
                |> Dict.toList
                |> Ok

        Err inferenceError ->
            inferenceError
                |> List.map inferenceErrorToString
                |> String.join "\n\n"
                |> Err


{-| Remove duplicate values, keeping the first instance of each element which appears more than once.
unique [ 0, 1, 1, 0, 1 ]
--> [ 0, 1 ]
-}
unique : List a -> List a
unique list =
    uniqueHelp list []


uniqueHelp : List a -> List a -> List a
uniqueHelp remaining accumulator =
    case remaining of
        [] ->
            List.reverse accumulator

        first :: rest ->
            if List.member first accumulator then
                uniqueHelp rest accumulator

            else
                uniqueHelp rest (first :: accumulator)


toVar :
    Index
    -> String
    ->
        { name : String
        , typename : String
        , val : Expression
        , index : Index
        }
toVar index desiredName =
    let
        ( name, newIndex ) =
            Index.getName desiredName index

        typename : String
        typename =
            Index.protectTypeName desiredName index
    in
    { name = name
    , typename = typename
    , index = newIndex
    , val =
        Expression <|
            \_ ->
                { expression =
                    Exp.FunctionOrValue []
                        name
                , annotation =
                    Ok
                        { type_ =
                            Annotation.GenericType typename
                        , inferences = Dict.empty
                        , aliases = emptyAliases
                        }
                , imports =
                    []
                }
    }


mergeInferences :
    Dict String Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
mergeInferences one two =
    Dict.merge
        Dict.insert
        (\key oneVal twoVal d ->
            case oneVal of
                Annotation.GenericRecord recordName (Node.Node oneRange recordDefinition) ->
                    case twoVal of
                        Annotation.GenericRecord _ (Node.Node _ twoRecordDefinition) ->
                            Dict.insert key
                                (Annotation.GenericRecord recordName
                                    (Node.Node oneRange (recordDefinition ++ twoRecordDefinition))
                                )
                                d

                        _ ->
                            Dict.insert key oneVal d

                _ ->
                    Dict.insert key oneVal d
        )
        Dict.insert
        one
        two
        Dict.empty


inference : Annotation.TypeAnnotation -> Inference
inference type_ =
    { type_ = type_
    , inferences = Dict.empty
    , aliases = emptyAliases
    }


type InferenceError
    = MismatchedList Annotation.TypeAnnotation Annotation.TypeAnnotation
    | Todo String
    | EmptyCaseStatement
    | FunctionAppliedToTooManyArgs Annotation.TypeAnnotation (List Annotation.TypeAnnotation)
    | MismatchedTypeVariables
    | DuplicateFieldInRecord String
    | CaseBranchesReturnDifferentTypes
    | CouldNotFindField
        { field : String
        , existingFields : List String
        }
    | AttemptingToGetOnIncorrectType
        { field : String
        , on : Annotation.TypeAnnotation
        }
    | AttemptingGetOnTypeNameNotAnAlias
        { field : String
        , on : Annotation.TypeAnnotation
        }
    | LetFieldNotFound
        { desiredField : String
        }
    | RecordUpdateIncorrectFields
        { existingFields : List ( String, Annotation.TypeAnnotation )
        , attemptingToUpdate : List ( String, Annotation.TypeAnnotation )
        }
    | NotAppendable Annotation.TypeAnnotation
    | NotComparable Annotation.TypeAnnotation
    | UnableToUnify Annotation.TypeAnnotation Annotation.TypeAnnotation


{-|

    Elm.Writer.writeTypeAnnotation (nodify two)
        |> Elm.Writer.write

-}
inferenceErrorToString : InferenceError -> String
inferenceErrorToString inf =
    case inf of
        Todo str ->
            "Todo " ++ str

        MismatchedList one two ->
            "There are multiple different types in a list: \n\n"
                ++ "    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify one)
                        |> Elm.Writer.write
                   )
                ++ "\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify two)
                        |> Elm.Writer.write
                   )

        RecordUpdateIncorrectFields _ ->
            "Mismatched record update"

        EmptyCaseStatement ->
            "Case statement is empty"

        FunctionAppliedToTooManyArgs fn args ->
            "The following is being called as a function\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify fn)
                        |> Elm.Writer.write
                   )
                ++ "\n\nwith these arguments:\n\n    "
                ++ (List.map
                        (\arg ->
                            Elm.Writer.writeTypeAnnotation (nodify arg)
                                |> Elm.Writer.write
                        )
                        args
                        |> String.join " -> "
                   )
                ++ "\n\nbut that's wrong, right?"

        DuplicateFieldInRecord fieldName ->
            "There is a duplicate field in a record: " ++ fieldName

        CaseBranchesReturnDifferentTypes ->
            "Case returns different types."

        CouldNotFindField found ->
            "I can't find ."
                ++ found.field
                ++ ", this record only has these fields:\n\n    "
                ++ String.join "\n    " found.existingFields

        AttemptingToGetOnIncorrectType attempting ->
            "You're trying to access\n\n    ."
                ++ attempting.field
                ++ "\n\nbut this value isn't a record. It's a\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify attempting.on)
                        |> Elm.Writer.write
                   )

        AttemptingGetOnTypeNameNotAnAlias attempting ->
            "You're trying to access\n\n    ."
                ++ attempting.field
                ++ "\n\nbut this value isn't a record, it's a\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify attempting.on)
                        |> Elm.Writer.write
                   )
                ++ "\n\nIs this value supposed to be an alias for a record? If so, check out Elm.alias!"

        LetFieldNotFound details ->
            details.desiredField ++ " not found, though I was trying to unpack it in a let expression."

        NotAppendable type_ ->
            (Elm.Writer.writeTypeAnnotation (nodify type_)
                |> Elm.Writer.write
            )
                ++ " is not appendable.  Only Strings and Lists are appendable"

        NotComparable type_ ->
            (Elm.Writer.writeTypeAnnotation (nodify type_)
                |> Elm.Writer.write
            )
                ++ " is not appendable.  Only Strings and Lists are appendable"

        UnableToUnify one two ->
            "I found\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify one)
                        |> Elm.Writer.write
                   )
                ++ "\n\nBut I was expecting:\n\n    "
                ++ (Elm.Writer.writeTypeAnnotation (nodify two)
                        |> Elm.Writer.write
                   )

        MismatchedTypeVariables ->
            "Different lists of type variables"


getGenerics : Annotation -> List String
getGenerics (Annotation details) =
    getGenericsHelper details.annotation
        |> unique


getGenericsHelper : Annotation.TypeAnnotation -> List String
getGenericsHelper ann =
    case ann of
        Annotation.GenericType str ->
            [ str ]

        Annotation.Typed _ anns ->
            List.concatMap (getGenericsHelper << denode) anns

        Annotation.Unit ->
            []

        Annotation.Tupled tupled ->
            List.concatMap (getGenericsHelper << denode) tupled

        Annotation.Record recordDefinition ->
            List.concatMap
                (\(Node _ ( _, Node _ field )) ->
                    getGenericsHelper field
                )
                recordDefinition

        Annotation.GenericRecord (Node _ recordName) (Node _ recordDefinition) ->
            recordName
                :: List.concatMap
                    (\(Node _ ( _, Node _ field )) ->
                        getGenericsHelper field
                    )
                    recordDefinition

        Annotation.FunctionTypeAnnotation (Node _ one) (Node _ two) ->
            List.concatMap getGenericsHelper
                [ one
                , two
                ]


noImports : Annotation.TypeAnnotation -> Annotation
noImports tipe =
    Annotation
        { annotation = tipe
        , imports = []
        , aliases = emptyAliases
        }


getInnerAnnotation : Annotation -> Annotation.TypeAnnotation
getInnerAnnotation (Annotation details) =
    details.annotation


getInnerInference : Index -> Annotation -> Inference
getInnerInference index (Annotation details) =
    { type_ =
        details.annotation
            -- running protectAnnotation will cause the typechecking to fail :/
            -- So, there's a bug to debug
            |> protectAnnotation index
    , inferences = Dict.empty
    , aliases = details.aliases
    }


getAnnotationImports : Annotation -> List Module
getAnnotationImports (Annotation details) =
    details.imports


getImports : ExpressionDetails -> List Module
getImports exp =
    exp.imports


getInnerExpression : ExpressionDetails -> Exp.Expression
getInnerExpression exp =
    exp.expression


getAnnotation : ExpressionDetails -> Result (List InferenceError) Inference
getAnnotation exp =
    exp.annotation


documentation : String -> Declaration -> Declaration
documentation rawDoc decl =
    let
        doc : String
        doc =
            String.trim rawDoc
    in
    if String.isEmpty doc then
        decl

    else
        case decl of
            Comment _ ->
                decl

            Block _ ->
                decl

            Declaration details ->
                Declaration
                    { details
                        | docs =
                            case details.docs of
                                Nothing ->
                                    Just doc

                                Just existing ->
                                    Just (doc ++ "\n\n" ++ existing)
                    }

            Group group ->
                Group
                    { group
                        | decls =
                            List.map (documentation doc) group.decls
                    }


{-| -}
expose : Declaration -> Declaration
expose decl =
    case decl of
        Comment _ ->
            decl

        Block _ ->
            decl

        Declaration details ->
            Declaration { details | exposed = Exposed { group = Nothing, exposeConstructor = False } }

        Group group ->
            Group { group | decls = List.map expose group.decls }


{-| -}
exposeWith : { exposeConstructor : Bool, group : Maybe String } -> Declaration -> Declaration
exposeWith opts decl =
    case decl of
        Comment _ ->
            decl

        Block _ ->
            decl

        Declaration details ->
            Declaration { details | exposed = Exposed opts }

        Group group ->
            Group { group | decls = List.map (exposeWith opts) group.decls }


type alias Module =
    List String


makeImport :
    Module
    -> List ( Module, String )
    -> Module
    ->
        Maybe
            { moduleName : Node ModuleName.ModuleName
            , moduleAlias : Maybe (Node (List String))
            , exposingList : Maybe (Node Expose.Exposing)
            }
makeImport thisModule aliases name =
    if thisModule == name then
        Nothing

    else
        case name of
            [] ->
                Nothing

            _ ->
                case findAlias name aliases of
                    Nothing ->
                        if builtIn name then
                            Nothing

                        else
                            Just
                                { moduleName = nodify name
                                , moduleAlias = Nothing
                                , exposingList =
                                    if isUrlParser name then
                                        Just
                                            (nodify <|
                                                Expose.Explicit
                                                    [ nodify (Expose.InfixExpose "</>")
                                                    , nodify (Expose.InfixExpose "<?>")
                                                    ]
                                            )

                                    else if isParser name then
                                        Just
                                            (nodify <|
                                                Expose.Explicit
                                                    [ nodify (Expose.InfixExpose "|=")
                                                    , nodify (Expose.InfixExpose "|.")
                                                    ]
                                            )

                                    else
                                        Nothing
                                }

                    Just alias ->
                        Just
                            { moduleName = nodify name
                            , moduleAlias =
                                Just (nodify [ alias ])
                            , exposingList =
                                if isUrlParser name then
                                    Just
                                        (nodify <|
                                            Expose.Explicit
                                                [ nodify (Expose.InfixExpose "</>")
                                                , nodify (Expose.InfixExpose "<?>")
                                                ]
                                        )

                                else if isParser name then
                                    Just
                                        (nodify <|
                                            Expose.Explicit
                                                [ nodify (Expose.InfixExpose "|=")
                                                , nodify (Expose.InfixExpose "|.")
                                                ]
                                        )

                                else
                                    Nothing
                            }


findAlias : List String -> List ( Module, String ) -> Maybe String
findAlias modName aliases =
    case aliases of
        [] ->
            Nothing

        ( aliasModName, alias ) :: remain ->
            if modName == aliasModName then
                Just alias

            else
                findAlias modName remain


isUrlParser : List String -> Bool
isUrlParser name =
    case name of
        [ "Url", "Parser" ] ->
            True

        _ ->
            False


isParser : List String -> Bool
isParser name =
    case name of
        [ "Parser" ] ->
            True

        [ "Parser", "Advanced" ] ->
            True

        _ ->
            False


{-| Here are the default imports:
<https://package.elm-lang.org/packages/elm/core/latest/#default-imports>

Which is:

    import Basics exposing (..)
    import List exposing (List, (::))
    import Maybe exposing (Maybe(..))
    import Result exposing (Result(..))
    import String exposing (String)
    import Char exposing (Char)
    import Tuple

    import Debug

    import Platform exposing ( Program )
    import Platform.Cmd as Cmd exposing ( Cmd )
    import Platform.Sub as Sub exposing ( Sub )

-}
builtIn : List String -> Bool
builtIn name =
    case name of
        [ "List" ] ->
            True

        [ "Maybe" ] ->
            True

        [ "String" ] ->
            True

        [ "Basics" ] ->
            True

        [ "Char" ] ->
            True

        [ "Debug" ] ->
            True

        [ "Tuple" ] ->
            True

        [ "Result" ] ->
            True

        [ "Platform" ] ->
            True

        [ "Platform", "Sub" ] ->
            True

        [ "Platform", "Cmd" ] ->
            True

        [ "Sub" ] ->
            -- We specify Sub and Cmd here
            -- Because of the workaround we use in order to make sure
            -- Platform.Sub and Platform.Cmd are imported aliased.
            --  Search for SUB/CMD WORKAROUND to see the workaround
            -- it involves faking the module name when generating helpers for those modules
            True

        [ "Cmd" ] ->
            True

        _ ->
            False


fullModName : Module -> String
fullModName name =
    String.join "." name


type Expose
    = NotExposed
    | Exposed
        { group : Maybe String
        , exposeConstructor : Bool
        }


mapNode : (a -> b) -> Node a -> Node b
mapNode fn (Node range n) =
    Node range (fn n)


denode : Node a -> a
denode =
    Node.value


denodeAll : List (Node a) -> List a
denodeAll =
    List.map denode


denodeMaybe : Maybe (Node a) -> Maybe a
denodeMaybe =
    Maybe.map denode


nodify : a -> Node a
nodify exp =
    Node Range.emptyRange exp


nodifyAll : List a -> List (Node a)
nodifyAll =
    List.map nodify


nodifyMaybe : Maybe a -> Maybe (Node a)
nodifyMaybe =
    Maybe.map nodify


nodifyTuple : ( a, b ) -> ( Node a, Node b )
nodifyTuple ( a, b ) =
    ( nodify a, nodify b )



--
--autoReduce : Int -> Expression -> Expression
--autoReduce count ((Expression fn) as unchanged) =
--    if count <= 0 then
--        unchanged
--
--    else
--        case fn.annotation of
--            Ok ann ->
--                case ann of
--                    Annotation.FunctionTypeAnnotation one two ->
--                        autoReduce (count - 1)
--                            (Expression { fn | annotation = Ok (denode two) })
--
--                    _ ->
--                        unchanged
--
--            final ->
--                unchanged


toExpressionDetails : Index -> Expression -> ( Index, ExpressionDetails )
toExpressionDetails index (Expression toExp) =
    ( Index.next index, toExp index )


thread : Index -> List Expression -> List ExpressionDetails
thread index exps =
    threadHelper index exps []


threadHelper : Index -> List Expression -> List ExpressionDetails -> List ExpressionDetails
threadHelper index exps rendered =
    case exps of
        [] ->
            List.reverse rendered

        (Expression toExpDetails) :: remain ->
            threadHelper (Index.next index)
                remain
                (toExpDetails index :: rendered)


resolve : Index -> VariableCache -> Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
resolve index cache annotation =
    if Index.typecheck index then
        case resolveVariables Set.empty cache annotation of
            Ok newAnnotation ->
                let
                    restrictions : Restrictions
                    restrictions =
                        getRestrictions annotation cache
                in
                newAnnotation
                    |> rewriteTypeVariables
                    |> checkRestrictions restrictions

            Err err ->
                Err err

    else
        Err "Type inference skipped."


type alias Visited =
    Set String


resolveVariables : Visited -> VariableCache -> Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
resolveVariables visited cache annotation =
    case annotation of
        Annotation.FunctionTypeAnnotation (Node.Node oneCoords one) (Node.Node twoCoords two) ->
            Result.map2
                (\oneResolved twoResolved ->
                    Annotation.FunctionTypeAnnotation
                        (Node.Node oneCoords oneResolved)
                        (Node.Node twoCoords twoResolved)
                )
                (resolveVariables visited cache one)
                (resolveVariables visited cache two)

        Annotation.GenericType name ->
            if Set.member name visited then
                Err "Infinite type inference loop!  Whoops.  This is an issue with elm-codegen.  If you can report this to the elm-codegen repo, that would be appreciated!"

            else
                case Dict.get name cache of
                    Nothing ->
                        Ok annotation

                    Just newType ->
                        resolveVariables (Set.insert name visited) cache newType

        Annotation.Typed nodedModuleName vars ->
            Result.map (Annotation.Typed nodedModuleName)
                (resolveVariableList visited cache vars [])

        Annotation.Unit ->
            Ok Annotation.Unit

        Annotation.Tupled nodes ->
            Result.map Annotation.Tupled (resolveVariableList visited cache nodes [])

        Annotation.Record fields ->
            Result.Extra.combineMap
                (\(Node fieldRange ( name, Node fieldTypeRange fieldType )) ->
                    resolveVariables visited cache fieldType
                        |> Result.andThen
                            (\resolvedField ->
                                let
                                    restrictions : Restrictions
                                    restrictions =
                                        getRestrictions annotation cache
                                in
                                Result.map
                                    (\_ ->
                                        Node fieldRange
                                            ( name, Node fieldTypeRange resolvedField )
                                    )
                                    (checkRestrictions restrictions resolvedField)
                            )
                )
                fields
                |> Result.map Annotation.Record

        Annotation.GenericRecord baseName (Node recordNode fields) ->
            Result.Extra.combineMap
                (\(Node fieldRange ( name, Node fieldTypeRange fieldType )) ->
                    Result.map
                        (\resolvedField ->
                            Node fieldRange
                                ( name, Node fieldTypeRange resolvedField )
                        )
                        (resolveVariables visited cache fieldType)
                )
                fields
                |> Result.map
                    (\newFields ->
                        Annotation.GenericRecord baseName
                            (Node recordNode
                                newFields
                            )
                    )


resolveVariableList :
    Visited
    -> VariableCache
    -> List (Node Annotation.TypeAnnotation)
    -> List (Node Annotation.TypeAnnotation)
    -> Result String (List (Node Annotation.TypeAnnotation))
resolveVariableList visited cache nodes processed =
    case nodes of
        [] ->
            Ok (List.reverse processed)

        (Node.Node coords top) :: remain ->
            case resolveVariables visited cache top of
                Ok resolved ->
                    resolveVariableList visited cache remain (Node.Node coords resolved :: processed)

                Err err ->
                    Err err


type Restrictions
    = NoRestrictions
    | IsNumber
    | IsAppendable
    | IsComparable
    | IsAppendableComparable
    | Overconstrainted (List Restrictions)


nameToRestrictions : String -> Restrictions
nameToRestrictions name =
    if String.startsWith "number" name then
        IsNumber

    else if String.startsWith "comparable" name then
        IsComparable

    else if String.startsWith "appendable" name then
        IsAppendable

    else if String.startsWith "compappend" name then
        IsAppendableComparable

    else
        NoRestrictions


restrictFurther : Restrictions -> Restrictions -> Restrictions
restrictFurther restriction newRestriction =
    case restriction of
        NoRestrictions ->
            newRestriction

        Overconstrainted constraints ->
            case newRestriction of
                Overconstrainted newConstraints ->
                    Overconstrainted (constraints ++ newConstraints)

                NoRestrictions ->
                    restriction

                _ ->
                    Overconstrainted (newRestriction :: constraints)

        IsNumber ->
            case newRestriction of
                IsNumber ->
                    newRestriction

                NoRestrictions ->
                    restriction

                Overconstrainted constraints ->
                    Overconstrainted (restriction :: constraints)

                _ ->
                    Overconstrainted [ restriction, newRestriction ]

        IsComparable ->
            case newRestriction of
                NoRestrictions ->
                    restriction

                IsAppendableComparable ->
                    newRestriction

                IsComparable ->
                    newRestriction

                Overconstrainted constraints ->
                    Overconstrainted (restriction :: constraints)

                _ ->
                    Overconstrainted [ restriction, newRestriction ]

        IsAppendable ->
            case newRestriction of
                NoRestrictions ->
                    restriction

                IsAppendableComparable ->
                    newRestriction

                IsComparable ->
                    newRestriction

                Overconstrainted constraints ->
                    Overconstrainted (restriction :: constraints)

                _ ->
                    Overconstrainted [ restriction, newRestriction ]

        IsAppendableComparable ->
            case newRestriction of
                NoRestrictions ->
                    restriction

                IsAppendableComparable ->
                    newRestriction

                IsComparable ->
                    newRestriction

                IsAppendable ->
                    newRestriction

                Overconstrainted constraints ->
                    Overconstrainted (restriction :: constraints)

                _ ->
                    Overconstrainted [ restriction, newRestriction ]


getRestrictions :
    Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    -> Restrictions
getRestrictions notation cache =
    getRestrictionsHelper NoRestrictions notation cache


getRestrictionsHelper :
    Restrictions
    -> Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    -> Restrictions
getRestrictionsHelper existingRestrictions notation cache =
    case notation of
        Annotation.FunctionTypeAnnotation _ _ ->
            existingRestrictions

        Annotation.GenericType name ->
            getRestrictionsHelper
                (restrictFurther existingRestrictions (nameToRestrictions name))
                (Dict.get name cache
                    |> Maybe.withDefault Annotation.Unit
                )
                cache

        Annotation.Typed _ _ ->
            existingRestrictions

        Annotation.Unit ->
            existingRestrictions

        Annotation.Tupled _ ->
            existingRestrictions

        Annotation.Record _ ->
            existingRestrictions

        Annotation.GenericRecord _ _ ->
            existingRestrictions


rewriteTypeVariables : Annotation.TypeAnnotation -> Annotation.TypeAnnotation
rewriteTypeVariables type_ =
    let
        existing : Set String
        existing =
            getGenericsHelper type_
                |> Set.fromList
    in
    Tuple.second (rewriteTypeVariablesHelper existing Dict.empty type_)


rewriteTypeVariablesHelper : Set String -> Dict String String -> Annotation.TypeAnnotation -> ( Dict String String, Annotation.TypeAnnotation )
rewriteTypeVariablesHelper existing renames type_ =
    case type_ of
        Annotation.GenericType varName ->
            case Dict.get varName renames of
                Nothing ->
                    let
                        simplified : String
                        simplified =
                            simplify varName
                    in
                    if Set.member simplified existing && varName /= simplified then
                        -- We would have collided with an existing generic name
                        ( renames, Annotation.GenericType simplified )

                    else
                        ( Dict.insert varName simplified renames, Annotation.GenericType simplified )

                Just rename ->
                    ( renames, Annotation.GenericType rename )

        Annotation.Typed name vars ->
            let
                ( newUsed, newVars ) =
                    vars
                        |> List.foldl
                            (\(Node _ typevar) ( varUsed, varList ) ->
                                let
                                    ( oneUsed, oneType ) =
                                        rewriteTypeVariablesHelper existing varUsed typevar
                                in
                                ( oneUsed, nodify oneType :: varList )
                            )
                            ( renames, [] )
            in
            ( newUsed
            , Annotation.Typed name (List.reverse newVars)
            )

        Annotation.Unit ->
            ( renames, type_ )

        Annotation.Tupled _ ->
            ( renames, type_ )

        Annotation.Record _ ->
            ( renames, type_ )

        Annotation.GenericRecord _ _ ->
            ( renames, type_ )

        Annotation.FunctionTypeAnnotation (Node _ one) (Node _ two) ->
            let
                ( oneUsed, oneType ) =
                    rewriteTypeVariablesHelper existing renames one

                ( twoUsed, twoType ) =
                    rewriteTypeVariablesHelper existing oneUsed two
            in
            ( twoUsed
            , Annotation.FunctionTypeAnnotation
                (nodify oneType)
                (nodify twoType)
            )


{-| -}
simplify : String -> String
simplify fullStr =
    fullStr
        |> String.split "_"
        |> List.filter (\piece -> not <| String.all Char.isDigit piece)
        |> String.join "_"


checkRestrictions : Restrictions -> Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
checkRestrictions restrictions type_ =
    case restrictions of
        NoRestrictions ->
            Ok type_

        Overconstrainted constraints ->
            Err
                ((Elm.Writer.writeTypeAnnotation (nodify type_)
                    |> Elm.Writer.write
                 )
                    ++ " needs to be: "
                    ++ String.join ", "
                        (List.concatMap
                            (\constraint ->
                                case constraint of
                                    NoRestrictions ->
                                        []

                                    Overconstrainted _ ->
                                        []

                                    IsNumber ->
                                        [ "a number"
                                        ]

                                    IsComparable ->
                                        [ "comparable"
                                        ]

                                    IsAppendable ->
                                        [ "appendable" ]

                                    IsAppendableComparable ->
                                        [ "appendable and comparable" ]
                            )
                            constraints
                        )
                    ++ "\n\nbut that's impossible!  Or Elm Codegen's s typechecker is off."
                )

        IsNumber ->
            if isNumber type_ then
                Ok type_

            else
                Err
                    ((Elm.Writer.writeTypeAnnotation (nodify type_)
                        |> Elm.Writer.write
                     )
                        ++ " is not a number"
                    )

        IsComparable ->
            if isComparable type_ then
                Ok type_

            else
                Err
                    ((Elm.Writer.writeTypeAnnotation (nodify type_)
                        |> Elm.Writer.write
                     )
                        ++ " is not comparable.  Only Ints, Floats, Chars, Strings and Lists and Tuples of those things are comparable."
                    )

        IsAppendable ->
            if isAppendable type_ then
                Ok type_

            else
                Err
                    ((Elm.Writer.writeTypeAnnotation (nodify type_)
                        |> Elm.Writer.write
                     )
                        ++ " is not appendable.  Only Strings and Lists are appendable."
                    )

        IsAppendableComparable ->
            if isComparable type_ || isAppendable type_ then
                Ok type_

            else
                Err
                    ((Elm.Writer.writeTypeAnnotation (nodify type_)
                        |> Elm.Writer.write
                     )
                        ++ " is not appendable/comparable.  Only Strings and Lists are allowed here."
                    )


{-| -}
applyType :
    Index
    ->
        Result
            (List InferenceError)
            Inference
    -> List ExpressionDetails
    -> Result (List InferenceError) Inference
applyType index annotation args =
    case annotation of
        Err err ->
            Err err

        Ok fnAnnotation ->
            if Index.typecheck index then
                case mergeArgInferences args [] fnAnnotation.inferences of
                    Ok mergedArgs ->
                        applyTypeHelper
                            fnAnnotation.aliases
                            mergedArgs.inferences
                            fnAnnotation.type_
                            mergedArgs.types

                    Err err ->
                        Err err

            else
                Err []


mergeArgInferences :
    List ExpressionDetails
    -> List Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    ->
        Result
            (List InferenceError)
            { types : List Annotation.TypeAnnotation
            , inferences : Dict String Annotation.TypeAnnotation
            }
mergeArgInferences expressions annotations inferences =
    case expressions of
        [] ->
            Ok
                { types = List.reverse annotations
                , inferences = inferences
                }

        top :: remain ->
            case top.annotation of
                Ok ann ->
                    mergeArgInferences remain
                        (ann.type_ :: annotations)
                        (mergeInferences inferences ann.inferences)

                Err err ->
                    Err err


{-| -}
applyTypeHelper :
    AliasCache
    -> VariableCache
    -> Annotation.TypeAnnotation
    -> List Annotation.TypeAnnotation
    -> Result (List InferenceError) Inference
applyTypeHelper aliases cache fn args =
    case fn of
        Annotation.FunctionTypeAnnotation (Node _ one) (Node _ two) ->
            case args of
                [] ->
                    Ok
                        { type_ = fn
                        , inferences = cache
                        , aliases = emptyAliases
                        }

                top :: rest ->
                    case unifiable aliases cache one top of
                        ( variableCache, Ok _ ) ->
                            applyTypeHelper
                                aliases
                                variableCache
                                two
                                rest

                        ( _, Err err ) ->
                            Err [ err ]

        Annotation.GenericType varName ->
            case args of
                [] ->
                    Ok
                        { type_ = fn
                        , inferences = cache
                        , aliases = emptyAliases
                        }

                _ ->
                    let
                        resultType : Annotation.TypeAnnotation
                        resultType =
                            Annotation.GenericType (varName ++ "_result")
                    in
                    Ok
                        { type_ = resultType
                        , aliases = emptyAliases
                        , inferences =
                            cache
                                |> addInference varName
                                    (makeFunction
                                        resultType
                                        args
                                    )
                        }

        final ->
            case args of
                [] ->
                    Ok
                        { type_ = fn
                        , inferences = cache
                        , aliases = emptyAliases
                        }

                _ ->
                    Err
                        [ FunctionAppliedToTooManyArgs final args
                        ]


{-| Transform from

    [ Arg, Arg1, Arg2, Arg3 ]

To

    Fn
        Arg
        (Fn Arg1
            (Fn Arg2 Arg3)
        )

We do this by reversing the list.

Then building up the function backwards

-}
makeFunction : Annotation.TypeAnnotation -> List Annotation.TypeAnnotation -> Annotation.TypeAnnotation
makeFunction result args =
    List.reverse args
        |> makeFunctionReversedHelper result


makeFunctionReversedHelper : Annotation.TypeAnnotation -> List Annotation.TypeAnnotation -> Annotation.TypeAnnotation
makeFunctionReversedHelper last reversedArgs =
    case reversedArgs of
        [] ->
            last

        penUlt :: [] ->
            Annotation.FunctionTypeAnnotation
                (Node.Node Range.emptyRange penUlt)
                (Node.Node Range.emptyRange last)

        penUlt :: remain ->
            makeFunctionReversedHelper
                (Annotation.FunctionTypeAnnotation
                    (Node.Node Range.emptyRange penUlt)
                    (Node.Node Range.emptyRange last)
                )
                remain


reduce : Inference -> Inference
reduce inf =
    inf


unify : List ExpressionDetails -> Result (List InferenceError) Inference
unify exps =
    case exps of
        [] ->
            Ok
                { type_ = Annotation.GenericType "a"
                , inferences = Dict.empty
                , aliases = emptyAliases
                }

        top :: remain ->
            case top.annotation of
                Ok ann ->
                    unifyHelper remain ann

                Err err ->
                    Err err


unifyHelper :
    List ExpressionDetails
    -> Inference
    -> Result (List InferenceError) Inference
unifyHelper exps existing =
    case exps of
        [] ->
            Ok existing

        top :: remain ->
            case top.annotation of
                Ok ann ->
                    case unifiable ann.aliases ann.inferences ann.type_ existing.type_ of
                        ( _, Err _ ) ->
                            Err
                                [ MismatchedList ann.type_ existing.type_
                                ]

                        ( cache, Ok new ) ->
                            unifyHelper
                                remain
                                { type_ = new
                                , inferences = mergeInferences existing.inferences cache
                                , aliases = existing.aliases
                                }

                Err err ->
                    Err err


unifyOn :
    Annotation
    ->
        Result
            (List InferenceError)
            Inference
    ->
        Result
            (List InferenceError)
            Inference
unifyOn (Annotation annDetails) res =
    case res of
        Err _ ->
            res

        Ok inf ->
            let
                ( newInferences, finalResult ) =
                    unifiable inf.aliases inf.inferences annDetails.annotation inf.type_
            in
            case finalResult of
                Ok finalType ->
                    Ok
                        { type_ = finalType
                        , inferences = newInferences
                        , aliases = mergeAliases annDetails.aliases inf.aliases
                        }

                Err err ->
                    Err
                        [ err ]


unifyWithAlias :
    AliasCache
    -> VariableCache
    -> Node ( ModuleName.ModuleName, String )
    -> List (Node Annotation.TypeAnnotation)
    -> Annotation.TypeAnnotation
    -> Maybe ( VariableCache, Result error Annotation.TypeAnnotation )
unifyWithAlias aliases vars typename typeVars typeToUnifyWith =
    case getAlias typename aliases of
        Nothing ->
            Nothing

        Just foundAlias ->
            let
                fullAliasedType : Annotation.TypeAnnotation
                fullAliasedType =
                    case foundAlias.variables of
                        [] ->
                            foundAlias.target

                        _ ->
                            let
                                makeAliasVarCache : a -> Node b -> ( a, b )
                                makeAliasVarCache varName (Node.Node _ varType) =
                                    ( varName, varType )
                            in
                            case
                                resolveVariables
                                    Set.empty
                                    (Dict.fromList (List.map2 makeAliasVarCache foundAlias.variables typeVars))
                                    foundAlias.target
                            of
                                Ok resolvedType ->
                                    resolvedType

                                Err _ ->
                                    -- Whew, this is way wrong
                                    foundAlias.target

                ( returnedVars, unifiedResult ) =
                    unifiable
                        aliases
                        vars
                        fullAliasedType
                        typeToUnifyWith
            in
            case unifiedResult of
                Ok _ ->
                    -- We want to maintain the declared alias in the type signature
                    -- So, we are using `unifiable` to check that
                    Just ( returnedVars, Ok fullAliasedType )

                Err _ ->
                    Nothing


{-| -}
unifiable :
    AliasCache
    -> VariableCache
    -> Annotation.TypeAnnotation
    -> Annotation.TypeAnnotation
    -> ( VariableCache, Result InferenceError Annotation.TypeAnnotation )
unifiable aliases vars one two =
    case one of
        Annotation.GenericType varName ->
            case Dict.get varName vars of
                Nothing ->
                    case two of
                        Annotation.GenericType varNameB ->
                            if varNameB == varName then
                                ( vars, Ok one )

                            else
                                ( addInference varName two vars
                                , Ok two
                                )

                        _ ->
                            ( addInference varName two vars
                            , Ok two
                            )

                Just found ->
                    case two of
                        Annotation.GenericType varNameB ->
                            if varNameB == varName then
                                ( vars, Ok one )

                            else
                                case Dict.get varNameB vars of
                                    Nothing ->
                                        ( addInference varNameB found vars
                                        , Ok two
                                        )

                                    Just foundTwo ->
                                        unifiable aliases vars found foundTwo

                        _ ->
                            unifiable aliases vars found two

        Annotation.Typed oneName oneVars ->
            case two of
                Annotation.Typed twoName twoContents ->
                    if denode oneName == denode twoName then
                        case unifiableLists aliases vars oneVars twoContents [] of
                            ( newVars, Ok unifiedContent ) ->
                                ( newVars, Ok (Annotation.Typed twoName unifiedContent) )

                            ( newVars, Err err ) ->
                                ( newVars, Err err )

                    else
                        ( vars, Err (UnableToUnify one two) )

                Annotation.GenericType b ->
                    ( addInference b one vars
                    , Ok one
                    )

                _ ->
                    case unifyWithAlias aliases vars oneName oneVars two of
                        Nothing ->
                            ( vars, Err (UnableToUnify one two) )

                        Just unified ->
                            unified

        Annotation.Unit ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( addInference b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiable aliases vars one foundTwo

                Annotation.Unit ->
                    ( vars, Ok Annotation.Unit )

                _ ->
                    ( vars, Err (UnableToUnify one two) )

        Annotation.Tupled valsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( addInference b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiable aliases vars one foundTwo

                Annotation.Tupled valsB ->
                    case unifiableLists aliases vars valsA valsB [] of
                        ( newVars, Ok unified ) ->
                            ( newVars
                            , Ok
                                (Annotation.Tupled unified)
                            )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                _ ->
                    ( vars, Err (UnableToUnify one two) )

        Annotation.Record fieldsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( addInference b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiable aliases vars one foundTwo

                Annotation.GenericRecord (Node.Node _ twoRecName) (Node.Node _ fieldsB) ->
                    case Dict.get twoRecName vars of
                        Nothing ->
                            case unifiableFields aliases vars fieldsA fieldsB [] of
                                ( newVars, Ok unifiedFields ) ->
                                    ( newVars
                                    , Ok (Annotation.Record unifiedFields)
                                    )

                                ( newVars, Err err ) ->
                                    ( newVars, Err err )

                        Just _ ->
                            -- NOTE: we should probably check knownType in some way?
                            case unifiableFields aliases vars fieldsA fieldsB [] of
                                ( newVars, Ok unifiedFields ) ->
                                    ( newVars
                                    , Ok (Annotation.Record unifiedFields)
                                    )

                                ( newVars, Err err ) ->
                                    ( newVars, Err err )

                Annotation.Record fieldsB ->
                    case unifiableFields aliases vars fieldsA fieldsB [] of
                        ( newVars, Ok unifiedFields ) ->
                            ( newVars
                            , Ok (Annotation.Record unifiedFields)
                            )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                Annotation.Typed twoName twoVars ->
                    case unifyWithAlias aliases vars twoName twoVars one of
                        Nothing ->
                            ( vars, Err (UnableToUnify one two) )

                        Just unified ->
                            unified

                _ ->
                    ( vars, Err (UnableToUnify one two) )

        Annotation.GenericRecord _ (Node.Node _ fieldsA) ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( addInference b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiable aliases vars one foundTwo

                Annotation.GenericRecord (Node.Node _ twoRecName) (Node.Node _ fieldsB) ->
                    case Dict.get twoRecName vars of
                        Nothing ->
                            -- Here, I think we need an inference that
                            -- reVarName == twoRecName
                            -- Also, do we care if the fields match up, or do we grow the record?
                            case unifiableFields aliases vars fieldsA fieldsB [] of
                                ( newVars, Ok unifiedFields ) ->
                                    ( newVars
                                    , Ok (Annotation.Record unifiedFields)
                                    )

                                ( newVars, Err err ) ->
                                    ( newVars, Err err )

                        Just _ ->
                            -- NOTE: we should probably check knownType in some way?
                            case unifiableFields aliases vars fieldsA fieldsB [] of
                                ( newVars, Ok unifiedFields ) ->
                                    ( newVars
                                    , Ok (Annotation.Record unifiedFields)
                                    )

                                ( newVars, Err err ) ->
                                    ( newVars, Err err )

                Annotation.Record fieldsB ->
                    case unifiableFields aliases vars fieldsA fieldsB [] of
                        ( newVars, Ok unifiedFields ) ->
                            ( newVars
                            , Ok (Annotation.Record unifiedFields)
                            )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                Annotation.Typed twoName twoVars ->
                    case unifyWithAlias aliases vars twoName twoVars one of
                        Nothing ->
                            ( vars, Err (UnableToUnify one two) )

                        Just unified ->
                            unified

                _ ->
                    ( vars, Err (UnableToUnify one two) )

        Annotation.FunctionTypeAnnotation (Node _ oneA) (Node _ oneB) ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( addInference b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiable aliases vars one foundTwo

                Annotation.FunctionTypeAnnotation (Node _ twoA) (Node _ twoB) ->
                    case unifiable aliases vars oneA twoA of
                        ( aVars, Ok unifiedA ) ->
                            case unifiable aliases aVars oneB twoB of
                                ( bVars, Ok unifiedB ) ->
                                    ( bVars
                                    , Ok
                                        (Annotation.FunctionTypeAnnotation
                                            (nodify unifiedA)
                                            (nodify unifiedB)
                                        )
                                    )

                                otherwise ->
                                    otherwise

                        otherwise ->
                            otherwise

                _ ->
                    ( vars, Err (UnableToUnify one two) )


{-| Checks that all fields in `one` are in `two` and are unifiable.
-}
unifiableFields :
    AliasCache
    -> VariableCache
    -> List (Node ( Node String, Node Annotation.TypeAnnotation ))
    -> List (Node ( Node String, Node Annotation.TypeAnnotation ))
    -> List Annotation.RecordField
    ->
        ( VariableCache
        , Result InferenceError Annotation.RecordDefinition
        )
unifiableFields aliases vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( (Node _ ( Node _ oneFieldName, Node _ oneFieldVal )) :: oneRemain, twoFields ) ->
            case getField oneFieldName oneFieldVal twoFields [] of
                Ok ( matchingFieldVal, remainingTwo ) ->
                    let
                        ( newVars, unifiedFieldResult ) =
                            unifiable aliases vars oneFieldVal matchingFieldVal
                    in
                    case unifiedFieldResult of
                        Ok unifiedField ->
                            unifiableFields aliases
                                newVars
                                oneRemain
                                remainingTwo
                                (( nodify oneFieldName, nodify unifiedField ) :: unified)

                        Err err ->
                            ( newVars, Err err )

                Err notFound ->
                    ( vars, Err notFound )

        _ ->
            ( vars, Err MismatchedTypeVariables )


getField :
    String
    -> Annotation.TypeAnnotation
    -> List (Node ( Node String, Node Annotation.TypeAnnotation ))
    -> List (Node ( Node String, Node Annotation.TypeAnnotation ))
    ->
        Result
            InferenceError
            ( Annotation.TypeAnnotation
            , List (Node ( Node String, Node Annotation.TypeAnnotation ))
            )
getField name val fields captured =
    case fields of
        [] ->
            Err
                (CouldNotFindField
                    { field = name
                    , existingFields =
                        List.map
                            (denode >> Tuple.first >> denode)
                            captured
                    }
                )

        top :: remain ->
            let
                ( Node _ topName, Node _ topVal ) =
                    denode top
            in
            if topName == name then
                Ok
                    ( topVal
                    , captured ++ remain
                    )

            else
                getField name val remain (top :: captured)


unifiableLists :
    AliasCache
    -> VariableCache
    -> List (Node Annotation.TypeAnnotation)
    -> List (Node Annotation.TypeAnnotation)
    -> List Annotation.TypeAnnotation
    -> ( VariableCache, Result InferenceError (List (Node Annotation.TypeAnnotation)) )
unifiableLists aliases vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( [ Node _ oneX ], [ Node _ twoX ] ) ->
            case unifiable aliases vars oneX twoX of
                ( newVars, Ok un ) ->
                    ( newVars, Ok (nodifyAll (List.reverse (un :: unified))) )

                ( newVars, Err err ) ->
                    ( newVars, Err err )

        ( (Node _ oneX) :: oneRemain, (Node _ twoX) :: twoRemain ) ->
            case unifiable aliases vars oneX twoX of
                ( newVars, Ok un ) ->
                    unifiableLists aliases newVars oneRemain twoRemain (un :: unified)

                ( _, Err err ) ->
                    ( vars, Err err )

        _ ->
            ( vars, Err MismatchedTypeVariables )


unifyNumber :
    VariableCache
    -> String
    -> Annotation.TypeAnnotation
    -> ( VariableCache, Result String Annotation.TypeAnnotation )
unifyNumber vars numberName two =
    case two of
        Annotation.Typed (Node.Node _ ( [], "Int" )) _ ->
            ( Dict.insert numberName two vars
            , Ok two
            )

        Annotation.Typed (Node.Node _ ( [], "Float" )) _ ->
            ( Dict.insert numberName two vars
            , Ok two
            )

        Annotation.GenericType _ ->
            -- We don't know how this will resolve
            -- So, for now we say this is fine
            -- and in the resolveVariables step, we need to check that everything works
            ( Dict.insert numberName two vars
            , Ok two
            )

        _ ->
            ( Dict.insert numberName two vars
            , Err
                ((Elm.Writer.writeTypeAnnotation (nodify two)
                    |> Elm.Writer.write
                 )
                    ++ " is not a number, but it needs to be!"
                )
            )


unifyAppendable :
    VariableCache
    -> String
    -> Annotation.TypeAnnotation
    -> ( VariableCache, Result String Annotation.TypeAnnotation )
unifyAppendable vars numberName two =
    case two of
        Annotation.Typed (Node.Node _ ( [], "String" )) _ ->
            ( Dict.insert numberName two vars
            , Ok two
            )

        Annotation.Typed (Node.Node _ ( [], "List" )) _ ->
            ( Dict.insert numberName two vars
            , Ok two
            )

        Annotation.GenericType _ ->
            -- We don't know how this will resolve
            -- So, for now we say this is fine
            -- and in the resolveVariables step, we need to check that everything works
            ( Dict.insert numberName two vars
            , Ok two
            )

        _ ->
            ( Dict.insert numberName two vars
            , Err
                ((Elm.Writer.writeTypeAnnotation (nodify two)
                    |> Elm.Writer.write
                 )
                    ++ " is not appendable.  Only Strings and Lists are appendable"
                )
            )


isNumber : Annotation.TypeAnnotation -> Bool
isNumber annotation =
    case annotation of
        Annotation.Typed (Node.Node _ ( [], "Int" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [], "Float" )) _ ->
            True

        _ ->
            False


isAppendable : Annotation.TypeAnnotation -> Bool
isAppendable annotation =
    case annotation of
        Annotation.Typed (Node.Node _ ( [], "String" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [], "List" )) [ _ ] ->
            True

        _ ->
            False


isComparable : Annotation.TypeAnnotation -> Bool
isComparable annotation =
    case annotation of
        Annotation.Typed (Node.Node _ ( [], "Int" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [], "Float" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [ "Char" ], "Char" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [], "String" )) _ ->
            True

        Annotation.Typed (Node.Node _ ( [], "List" )) [ Node.Node _ inner ] ->
            isComparable inner

        Annotation.Tupled innerList ->
            List.all (isComparable << denode) innerList

        _ ->
            False


unifyComparable :
    VariableCache
    -> String
    -> Annotation.TypeAnnotation
    -> ( VariableCache, Result InferenceError Annotation.TypeAnnotation )
unifyComparable vars comparableName two =
    if isComparable two then
        ( Dict.insert comparableName two vars
        , Err
            (NotAppendable two)
        )

    else
        case two of
            Annotation.GenericType _ ->
                -- We don't know how this will resolve
                -- So, for now we say this is fine
                -- and in the resolveVariables step, we need to check that everything works
                ( Dict.insert comparableName two vars
                , Ok two
                )

            _ ->
                ( Dict.insert comparableName two vars
                , Err
                    (NotAppendable two)
                )


resolveField :
    Index
    -> Annotation.TypeAnnotation
    -> AliasCache
    -> VariableCache
    -> String
    ->
        Result
            (List InferenceError)
            { type_ : Annotation.TypeAnnotation
            , inferences : VariableCache
            , aliases : AliasCache
            }
resolveField index type_ aliases inferences fieldName =
    if Index.typecheck index then
        case type_ of
            Annotation.Record fields ->
                case getFieldFromList fieldName fields of
                    Just ann ->
                        Ok
                            { type_ = ann
                            , inferences = inferences
                            , aliases = aliases
                            }

                    Nothing ->
                        Err
                            [ CouldNotFindField
                                { field = fieldName
                                , existingFields =
                                    List.map (denode >> Tuple.first >> denode) fields
                                }
                            ]

            Annotation.GenericRecord _ (Node _ fields) ->
                case getFieldFromList fieldName fields of
                    Just ann ->
                        Ok
                            { type_ = ann
                            , inferences = inferences
                            , aliases = aliases
                            }

                    Nothing ->
                        Err
                            [ CouldNotFindField
                                { field = fieldName
                                , existingFields =
                                    List.map
                                        (denode >> Tuple.first >> denode)
                                        fields
                                }
                            ]

            Annotation.GenericType nameOfRecord ->
                inferRecordField index
                    { nameOfRecord = nameOfRecord
                    , fieldName = fieldName
                    }

            Annotation.Typed nodedModAndName _ ->
                case getAlias nodedModAndName aliases of
                    Nothing ->
                        Err
                            [ AttemptingGetOnTypeNameNotAnAlias
                                { field = fieldName
                                , on = type_
                                }
                            ]

                    Just aliased ->
                        resolveField index aliased.target aliases inferences fieldName

            Annotation.Tupled _ ->
                Err
                    [ AttemptingToGetOnIncorrectType
                        { field = fieldName
                        , on = type_
                        }
                    ]

            Annotation.Unit ->
                Err
                    [ AttemptingToGetOnIncorrectType
                        { field = fieldName
                        , on = type_
                        }
                    ]

            Annotation.FunctionTypeAnnotation _ _ ->
                Err
                    [ AttemptingToGetOnIncorrectType
                        { field = fieldName
                        , on = type_
                        }
                    ]

    else
        Err []


getFieldFromList :
    String
    -> List (Node.Node ( Node.Node String, Node.Node b ))
    -> Maybe b
getFieldFromList selector fields =
    case fields of
        [] ->
            Nothing

        (Node _ ( Node _ fieldname, Node _ contents )) :: remain ->
            if fieldname == selector then
                Just contents

            else
                getFieldFromList selector remain


addInference :
    String
    -> Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
addInference key value infs =
    Dict.update key
        (\maybeValue ->
            case maybeValue of
                Nothing ->
                    Just value

                Just (Annotation.GenericRecord (Node.Node range recordName) (Node.Node fieldRange fields)) ->
                    case value of
                        Annotation.GenericRecord _ (Node.Node _ existingFields) ->
                            Just
                                (Annotation.GenericRecord
                                    (Node.Node range recordName)
                                    (Node.Node fieldRange (mergeFieldLists fields existingFields))
                                )

                        _ ->
                            maybeValue

                Just existing ->
                    -- this is likely an error
                    Just existing
        )
        infs


{-| This is wrong.

It should be able to report the issue if the fields collide.

For now though, it will just merge them

-}
mergeFieldLists : Annotation.RecordDefinition -> Annotation.RecordDefinition -> Annotation.RecordDefinition
mergeFieldLists fieldOne fieldTwo =
    List.foldl
        (\((Node.Node _ newField) as new) existing ->
            if List.any (containsFieldByName newField << denode) existing then
                existing

            else
                new :: existing
        )
        fieldOne
        fieldTwo


containsFieldByName : Annotation.RecordField -> Annotation.RecordField -> Bool
containsFieldByName ( Node.Node _ oneName, _ ) ( Node.Node _ twoName, _ ) =
    oneName == twoName


inferRecordField : Index -> { nameOfRecord : String, fieldName : String } -> Result (List InferenceError) Inference
inferRecordField index { nameOfRecord, fieldName } =
    let
        fieldType : Annotation.TypeAnnotation
        fieldType =
            Annotation.GenericType
                (Format.formatValue
                    (fieldName ++ Index.indexToString index)
                )
    in
    Ok
        { type_ = fieldType
        , aliases =
            emptyAliases
        , inferences =
            Dict.empty
                |> addInference
                    nameOfRecord
                    (Annotation.GenericRecord (nodify nameOfRecord)
                        (nodify
                            [ nodify
                                ( nodify fieldName
                                , nodify fieldType
                                )
                            ]
                        )
                    )
        }


protectInference : Index -> Result (List InferenceError) Inference -> Result (List InferenceError) Inference
protectInference index infResult =
    case infResult of
        Ok inf ->
            Ok
                { type_ =
                    protectAnnotation index inf.type_
                , inferences = Dict.empty
                , aliases = emptyAliases
                }

        Err err ->
            Err err


protectAnnotation : Index -> Annotation.TypeAnnotation -> Annotation.TypeAnnotation
protectAnnotation index ann =
    case ann of
        Annotation.GenericType str ->
            Annotation.GenericType
                (str ++ Index.indexToString index)

        Annotation.Typed modName anns ->
            Annotation.Typed
                modName
                (List.map (mapNode (protectAnnotation index))
                    anns
                )

        Annotation.Unit ->
            Annotation.Unit

        Annotation.Tupled tupled ->
            Annotation.Tupled (List.map (mapNode (protectAnnotation index)) tupled)

        Annotation.Record recordDefinition ->
            Annotation.Record
                (List.map (protectField index) recordDefinition)

        Annotation.GenericRecord recordName (Node.Node recordRange recordDefinition) ->
            Annotation.GenericRecord
                (mapNode (\n -> n ++ Index.indexToString index) recordName)
                (Node.Node recordRange
                    (List.map (protectField index) recordDefinition)
                )

        Annotation.FunctionTypeAnnotation one two ->
            Annotation.FunctionTypeAnnotation
                (mapNode (protectAnnotation index) one)
                (mapNode (protectAnnotation index) two)


protectField : Index -> Node ( a, Node Annotation.TypeAnnotation ) -> Node ( a, Node Annotation.TypeAnnotation )
protectField index (Node.Node nodeRange ( nodedName, nodedType )) =
    Node.Node nodeRange
        ( nodedName
        , mapNode (protectAnnotation index) nodedType
        )
