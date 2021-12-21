module Internal.Compiler exposing (..)

import Dict exposing (Dict)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer


type Annotation
    = Annotation AnnotationDetails


type alias AnnotationDetails =
    { imports : List Module
    , annotation : Annotation.TypeAnnotation
    }


type Declaration
    = Declaration Expose (List Module) Declaration.Declaration
    | Comment String
    | Block String


{-| -}
type Expression
    = Expression ExpressionDetails


type alias ExpressionDetails =
    { expression : Exp.Expression
    , annotation :
        Result
            (List InferenceError)
            Inference
    , imports : List Module
    }


type alias Inference =
    { type_ : Annotation.TypeAnnotation
    , inferences : Dict String Annotation.TypeAnnotation
    }


mergeInferences :
    Dict String Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
    -> Dict String Annotation.TypeAnnotation
mergeInferences one two =
    Dict.union one two


inference : Annotation.TypeAnnotation -> Inference
inference type_ =
    { type_ = type_
    , inferences = Dict.empty
    }


type InferenceError
    = MismatchedList Annotation.TypeAnnotation Annotation.TypeAnnotation
    | SomeOtherIssue
    | EmptyCaseStatement
    | FunctionAppliedToTooManyArgs
    | DuplicateFieldInRecord String
    | CaseBranchesReturnDifferentTypes
    | CouldNotFindField String


getGenerics : Annotation -> List (Node String)
getGenerics (Annotation details) =
    getGenericsHelper details.annotation


getGenericsHelper : Annotation.TypeAnnotation -> List (Node String)
getGenericsHelper ann =
    case ann of
        Annotation.GenericType str ->
            [ nodify str ]

        Annotation.Typed modName anns ->
            List.concatMap (getGenericsHelper << denode) anns

        Annotation.Unit ->
            []

        Annotation.Tupled tupled ->
            List.concatMap (getGenericsHelper << denode) tupled

        Annotation.Record recordDefinition ->
            List.concatMap
                (\nodedField ->
                    case denode nodedField of
                        ( name, field ) ->
                            getGenericsHelper (denode field)
                )
                recordDefinition

        Annotation.GenericRecord recordName recordDefinition ->
            List.concatMap
                (\nodedField ->
                    case denode nodedField of
                        ( name, field ) ->
                            getGenericsHelper (denode field)
                )
                (denode recordDefinition)

        Annotation.FunctionTypeAnnotation one two ->
            List.concatMap getGenericsHelper
                [ denode one
                , denode two
                ]


noImports : Annotation.TypeAnnotation -> Annotation
noImports tipe =
    Annotation
        { annotation = tipe
        , imports = []
        }


getInnerAnnotation : Annotation -> Annotation.TypeAnnotation
getInnerAnnotation (Annotation details) =
    details.annotation


getInnerInference : Annotation -> Inference
getInnerInference (Annotation details) =
    { type_ = details.annotation
    , inferences = Dict.empty
    }


getAnnotationImports : Annotation -> List Module
getAnnotationImports (Annotation details) =
    details.imports


getImports : Expression -> List Module
getImports (Expression exp) =
    exp.imports


getInnerExpression : Expression -> Exp.Expression
getInnerExpression (Expression exp) =
    exp.expression


getAnnotation : Expression -> Result (List InferenceError) Inference
getAnnotation (Expression exp) =
    exp.annotation


documentation : String -> Declaration -> Declaration
documentation doc decl =
    case decl of
        Comment _ ->
            decl

        Block source ->
            decl

        Declaration exp imports body ->
            let
                str =
                    "{-|" ++ doc ++ "-}"
            in
            case body of
                Declaration.FunctionDeclaration func ->
                    Declaration exp
                        imports
                        (Declaration.FunctionDeclaration
                            { func | documentation = Just (nodify str) }
                        )

                Declaration.AliasDeclaration typealias ->
                    Declaration exp
                        imports
                        (Declaration.AliasDeclaration
                            { typealias | documentation = Just (nodify str) }
                        )

                Declaration.CustomTypeDeclaration typeDecl ->
                    Declaration exp
                        imports
                        (Declaration.CustomTypeDeclaration
                            { typeDecl | documentation = Just (nodify str) }
                        )

                Declaration.PortDeclaration sig ->
                    decl

                Declaration.InfixDeclaration _ ->
                    decl

                Declaration.Destructuring _ _ ->
                    decl


{-| -}
expose : Declaration -> Declaration
expose decl =
    case decl of
        Comment _ ->
            decl

        Block _ ->
            decl

        Declaration _ imports body ->
            Declaration (Exposed { group = Nothing, exposeConstructor = False }) imports body


{-| -}
exposeWith : { exposeConstructor : Bool, group : Maybe String } -> Declaration -> Declaration
exposeWith opts decl =
    case decl of
        Comment _ ->
            decl

        Block _ ->
            decl

        Declaration _ imports body ->
            Declaration (Exposed opts) imports body


type alias Module =
    List String


makeImport :
    List ( Module, String )
    -> Module
    ->
        Maybe
            { moduleName : Node ModuleName.ModuleName
            , moduleAlias : Maybe (Node (List String))
            , exposingList : Maybe a
            }
makeImport aliases name =
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
                            , exposingList = Nothing
                            }

                Just alias ->
                    Just
                        { moduleName = nodify name
                        , moduleAlias =
                            Just (nodify [ alias ])
                        , exposingList = Nothing
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

        _ ->
            False


fullModName : Module -> String
fullModName name =
    String.join "." name


{-| -}
hasPorts : List Declaration -> Bool
hasPorts decls =
    List.any
        (\decl ->
            case decl of
                Comment _ ->
                    False

                Block _ ->
                    False

                Declaration exp _ decBody ->
                    case exp of
                        NotExposed ->
                            False

                        Exposed _ ->
                            case decBody of
                                Declaration.PortDeclaration myPort ->
                                    True

                                _ ->
                                    False
        )
        decls


getExposed : List Declaration -> List Expose.TopLevelExpose
getExposed decls =
    List.filterMap
        (\decl ->
            case decl of
                Comment _ ->
                    Nothing

                Block source ->
                    Nothing

                Declaration exp _ decBody ->
                    case exp of
                        NotExposed ->
                            Nothing

                        Exposed details ->
                            case decBody of
                                Declaration.FunctionDeclaration fn ->
                                    let
                                        fnName =
                                            denode (.name (denode fn.declaration))
                                    in
                                    Expose.FunctionExpose fnName
                                        |> Just

                                Declaration.AliasDeclaration synonym ->
                                    let
                                        aliasName =
                                            denode synonym.name
                                    in
                                    Expose.TypeOrAliasExpose aliasName
                                        |> Just

                                Declaration.CustomTypeDeclaration myType ->
                                    let
                                        typeName =
                                            denode myType.name
                                    in
                                    if details.exposeConstructor then
                                        Expose.TypeExpose
                                            { name = typeName
                                            , open = Just Range.emptyRange
                                            }
                                            |> Just

                                    else
                                        Expose.TypeOrAliasExpose typeName
                                            |> Just

                                Declaration.PortDeclaration myPort ->
                                    let
                                        typeName =
                                            denode myPort.name
                                    in
                                    Expose.FunctionExpose typeName
                                        |> Just

                                Declaration.InfixDeclaration infix ->
                                    Nothing

                                Declaration.Destructuring _ _ ->
                                    Nothing
        )
        decls


getExposedGroups :
    List Declaration
    -> List { group : Maybe String, members : List String }
getExposedGroups decls =
    List.filterMap
        (\decl ->
            case decl of
                Comment _ ->
                    Nothing

                Block _ ->
                    Nothing

                Declaration exp _ _ ->
                    case exp of
                        NotExposed ->
                            Nothing

                        Exposed details ->
                            case declName decl of
                                Nothing ->
                                    Nothing

                                Just name ->
                                    Just ( details.group, name )
        )
        decls
        |> List.sortBy
            (\( group, _ ) ->
                case group of
                    Nothing ->
                        "zzzzzzzzz"

                    Just name ->
                        name
            )
        |> groupExposing


matchName : Maybe a -> Maybe a -> Bool
matchName one two =
    case one of
        Nothing ->
            case two of
                Nothing ->
                    True

                _ ->
                    False

        Just oneName ->
            case two of
                Nothing ->
                    False

                Just twoName ->
                    oneName == twoName


groupExposing : List ( Maybe String, String ) -> List { group : Maybe String, members : List String }
groupExposing items =
    List.foldr
        (\( maybeGroup, name ) acc ->
            case acc of
                [] ->
                    [ { group = maybeGroup, members = [ name ] } ]

                top :: groups ->
                    if matchName maybeGroup top.group then
                        { group = top.group
                        , members = name :: top.members
                        }
                            :: groups

                    else
                        { group = maybeGroup, members = [ name ] } :: acc
        )
        []
        items


declName : Declaration -> Maybe String
declName decl =
    case decl of
        Comment _ ->
            Nothing

        Block _ ->
            Nothing

        Declaration exp _ decBody ->
            case decBody of
                Declaration.FunctionDeclaration fn ->
                    denode (.name (denode fn.declaration))
                        |> Just

                Declaration.AliasDeclaration synonym ->
                    denode synonym.name
                        |> Just

                Declaration.CustomTypeDeclaration myType ->
                    denode myType.name
                        |> Just

                Declaration.PortDeclaration myPort ->
                    denode myPort.name
                        |> Just

                Declaration.InfixDeclaration infix ->
                    Nothing

                Declaration.Destructuring _ _ ->
                    Nothing


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


{-|

    This is used as a variable or as a record field.

-}
formatValue : String -> String
formatValue str =
    let
        formatted =
            if String.toUpper str == str then
                String.toLower str

            else
                String.toLower (String.left 1 str) ++ String.dropLeft 1 str
    in
    sanitize formatted


sanitize : String -> String
sanitize str =
    case str of
        "in" ->
            "in_"

        "type" ->
            "type_"

        "case" ->
            "case_"

        "let" ->
            "let_"

        "module" ->
            "module_"

        "exposing" ->
            "exposing_"

        _ ->
            str


formatType : String -> String
formatType str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


extractListAnnotation :
    List Expression
    -> List Annotation.TypeAnnotation
    -> Result (List InferenceError) (List Annotation.TypeAnnotation)
extractListAnnotation expressions annotations =
    case expressions of
        [] ->
            Ok (List.reverse annotations)

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    extractListAnnotation remain (ann.type_ :: annotations)

                Err err ->
                    Err err



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


{-| -}
applyType : Expression -> List Expression -> Result (List InferenceError) Inference
applyType (Expression exp) args =
    case exp.annotation of
        Err err ->
            Err err

        Ok topAnnotation ->
            case extractListAnnotation args [] of
                Ok types ->
                    applyTypeHelper topAnnotation.inferences topAnnotation.type_ types

                Err err ->
                    Err err


type alias VariableCache =
    Dict.Dict String Annotation.TypeAnnotation


resolveVariables : VariableCache -> Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
resolveVariables cache annotation =
    case annotation of
        Annotation.FunctionTypeAnnotation (Node.Node oneCoords one) (Node.Node twoCoords two) ->
            Result.map2
                (\oneResolved twoResolved ->
                    Annotation.FunctionTypeAnnotation
                        (Node.Node oneCoords oneResolved)
                        (Node.Node twoCoords twoResolved)
                )
                (resolveVariables cache one)
                (resolveVariables cache two)

        Annotation.GenericType name ->
            resolveName (getRestrictions name) name cache

        Annotation.Typed nodedModuleName vars ->
            Result.map (Annotation.Typed nodedModuleName)
                (resolveVariableList cache vars [])

        Annotation.Unit ->
            Ok Annotation.Unit

        Annotation.Tupled nodes ->
            Result.map Annotation.Tupled (resolveVariableList cache nodes [])

        Annotation.Record fields ->
            Result.map (Annotation.Record << List.reverse)
                (List.foldl
                    (\(Node fieldRange ( name, Node fieldTypeRange fieldType )) found ->
                        case found of
                            Err err ->
                                Err err

                            Ok processedFields ->
                                case resolveVariables cache fieldType of
                                    Err err ->
                                        Err err

                                    Ok resolvedField ->
                                        Ok
                                            (Node fieldRange
                                                ( name, Node fieldTypeRange resolvedField )
                                                :: processedFields
                                            )
                    )
                    (Ok [])
                    fields
                )

        Annotation.GenericRecord baseName (Node recordNode fields) ->
            let
                newFieldResult =
                    List.foldl
                        (\(Node fieldRange ( name, Node fieldTypeRange fieldType )) found ->
                            case found of
                                Err err ->
                                    Err err

                                Ok processedFields ->
                                    case resolveVariables cache fieldType of
                                        Err err ->
                                            Err err

                                        Ok resolvedField ->
                                            Ok
                                                (Node fieldRange
                                                    ( name, Node fieldTypeRange resolvedField )
                                                    :: processedFields
                                                )
                        )
                        (Ok [])
                        fields
            in
            Result.map
                (\newFields ->
                    Annotation.GenericRecord baseName
                        (Node recordNode
                            (List.reverse newFields)
                        )
                )
                newFieldResult


resolveVariableList cache nodes processed =
    case nodes of
        [] ->
            Ok (List.reverse processed)

        (Node.Node coords top) :: remain ->
            case resolveVariables cache top of
                Ok resolved ->
                    resolveVariableList cache remain (Node.Node coords resolved :: remain)

                Err err ->
                    Err err


type Restrictions
    = NoRestrictions
    | IsNumber
    | IsAppendable
    | IsComparable
    | IsAppendableComparable


getRestrictions : String -> Restrictions
getRestrictions name =
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


restrictFurther : Restrictions -> Restrictions -> Result String Restrictions
restrictFurther restriction newRestriction =
    case restriction of
        NoRestrictions ->
            Ok newRestriction

        IsNumber ->
            case newRestriction of
                IsNumber ->
                    Ok newRestriction

                NoRestrictions ->
                    Ok restriction

                _ ->
                    Err ""

        IsComparable ->
            case newRestriction of
                NoRestrictions ->
                    Ok restriction

                IsAppendableComparable ->
                    Ok newRestriction

                IsComparable ->
                    Ok newRestriction

                _ ->
                    Err ""

        IsAppendable ->
            case newRestriction of
                NoRestrictions ->
                    Ok restriction

                IsAppendableComparable ->
                    Ok newRestriction

                IsComparable ->
                    Ok newRestriction

                _ ->
                    Err ""

        IsAppendableComparable ->
            case newRestriction of
                NoRestrictions ->
                    Ok restriction

                IsAppendableComparable ->
                    Ok newRestriction

                IsComparable ->
                    Ok newRestriction

                IsAppendable ->
                    Ok newRestriction

                _ ->
                    Err ""


resolveName : Restrictions -> String -> Dict String Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
resolveName restrictions name cache =
    case Dict.get name cache of
        Just (Annotation.GenericType newName) ->
            let
                desiredRestriction =
                    getRestrictions newName
            in
            case restrictFurther restrictions desiredRestriction of
                Ok newRestriction ->
                    resolveName newRestriction newName cache

                Err err ->
                    Err err

        Just newType ->
            case restrictions of
                NoRestrictions ->
                    Ok newType

                IsNumber ->
                    if isNumber newType then
                        Ok newType

                    else
                        Err
                            ((Elm.Writer.writeTypeAnnotation (nodify newType)
                                |> Elm.Writer.write
                             )
                                ++ " is not a number"
                            )

                IsComparable ->
                    if isComparable newType then
                        Ok newType

                    else
                        Err
                            ((Elm.Writer.writeTypeAnnotation (nodify newType)
                                |> Elm.Writer.write
                             )
                                ++ " is not comparable.  Only Ints, Floats, Chars, Strings and Lists and Tuples of those things are comparable."
                            )

                IsAppendable ->
                    if isAppendable newType then
                        Ok newType

                    else
                        Err
                            ((Elm.Writer.writeTypeAnnotation (nodify newType)
                                |> Elm.Writer.write
                             )
                                ++ " is not appendable.  Only Strings and Lists are appendable."
                            )

                IsAppendableComparable ->
                    if isComparable newType || isAppendable newType then
                        Ok newType

                    else
                        Err
                            ((Elm.Writer.writeTypeAnnotation (nodify newType)
                                |> Elm.Writer.write
                             )
                                ++ " is not appendable/comparable.  Only Strings and Lists are allowed here."
                            )

        Nothing ->
            Ok (Annotation.GenericType name)


{-| -}
applyTypeHelper :
    VariableCache
    -> Annotation.TypeAnnotation
    -> List Annotation.TypeAnnotation
    -> Result (List InferenceError) Inference
applyTypeHelper cache fn args =
    case fn of
        Annotation.FunctionTypeAnnotation one two ->
            case args of
                [] ->
                    Ok
                        { type_ = fn
                        , inferences = cache
                        }

                top :: rest ->
                    case unifiable cache (denode one) top of
                        ( variableCache, Ok _ ) ->
                            applyTypeHelper variableCache
                                (denode two)
                                rest

                        ( varCache, Err err ) ->
                            Err []

        final ->
            case args of
                [] ->
                    Ok
                        { type_ = fn
                        , inferences = cache
                        }

                _ ->
                    Err [ FunctionAppliedToTooManyArgs ]


unify : List Expression -> Result (List InferenceError) Inference
unify exps =
    case exps of
        [] ->
            Ok
                { type_ = Annotation.GenericType "a"
                , inferences = Dict.empty
                }

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    unifyHelper remain ann

                Err err ->
                    Err err


unifyHelper :
    List Expression
    -> Inference
    -> Result (List InferenceError) Inference
unifyHelper exps existing =
    case exps of
        [] ->
            Ok existing

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    case unifiable ann.inferences ann.type_ existing.type_ of
                        ( _, Err _ ) ->
                            Err [ MismatchedList ann.type_ existing.type_ ]

                        ( cache, Ok new ) ->
                            unifyHelper remain
                                { type_ = new
                                , inferences = cache
                                }

                Err err ->
                    Err err


{-| This is definitely not correct, but will do for now!

    type TypeAnnotation
        = GenericType String
        | Typed (Node ( ModuleName, String )) (List (Node TypeAnnotation))
        | Unit
        | Tupled (List (Node TypeAnnotation))
        | Record RecordDefinition
        | GenericRecord (Node String) (Node RecordDefinition)
        | FunctionTypeAnnotation (Node TypeAnnotation) (Node TypeAnnotation)

-}
unifiable :
    VariableCache
    -> Annotation.TypeAnnotation
    -> Annotation.TypeAnnotation
    -> ( VariableCache, Result String Annotation.TypeAnnotation )
unifiable cache one two =
    unifiableHelper cache one two


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

        Annotation.GenericType twoVarName ->
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

        Annotation.GenericType twoVarName ->
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

        Annotation.Typed (Node.Node _ ( [], "List" )) [ Node.Node _ inner ] ->
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
    -> ( VariableCache, Result String Annotation.TypeAnnotation )
unifyComparable vars comparableName two =
    if isComparable two then
        ( Dict.insert comparableName two vars
        , Err
            ((Elm.Writer.writeTypeAnnotation (nodify two)
                |> Elm.Writer.write
             )
                ++ " is not appendable.  Only Strings and Lists are appendable"
            )
        )

    else
        case two of
            Annotation.GenericType twoVarName ->
                -- We don't know how this will resolve
                -- So, for now we say this is fine
                -- and in the resolveVariables step, we need to check that everything works
                ( Dict.insert comparableName two vars
                , Ok two
                )

            _ ->
                ( Dict.insert comparableName two vars
                , Err
                    ((Elm.Writer.writeTypeAnnotation (nodify two)
                        |> Elm.Writer.write
                     )
                        ++ " is not appendable.  Only Strings and Lists are appendable"
                    )
                )



--unifiableHelper :
--    VariableCache
--    -> Annotation.TypeAnnotation
--    -> Annotation.TypeAnnotation
--    -> ( VariableCache, Result String Annotation.TypeAnnotation )


unifiableHelper vars one two =
    case one of
        Annotation.GenericType varName ->
            case Dict.get varName vars of
                Nothing ->
                    ( Dict.insert varName two vars
                    , Ok two
                    )

                Just found ->
                    case two of
                        Annotation.GenericType varNameB ->
                            case Dict.get varNameB vars of
                                Nothing ->
                                    ( Dict.insert varNameB found vars
                                    , Ok two
                                    )

                                Just foundTwo ->
                                    unifiableHelper vars found foundTwo

                        _ ->
                            unifiableHelper vars found two

        Annotation.Typed oneName oneContents ->
            case two of
                Annotation.Typed twoName twoContents ->
                    if denode oneName == denode twoName then
                        case unifiableLists vars oneContents twoContents [] of
                            ( newVars, Ok unifiedContent ) ->
                                ( newVars, Ok (Annotation.Typed twoName unifiedContent) )

                            ( newVars, Err err ) ->
                                ( newVars, Err err )

                    else
                        ( vars, Err "Unable to unify container!" )

                Annotation.GenericType b ->
                    ( vars, Ok one )

                _ ->
                    ( vars, Err "Unable to unify container!" )

        Annotation.Unit ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Unit ->
                    ( vars, Ok Annotation.Unit )

                _ ->
                    ( vars, Err "Unable to unify units!" )

        Annotation.Tupled valsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Tupled valsB ->
                    case unifiableLists vars valsA valsB [] of
                        ( newVars, Ok unified ) ->
                            ( newVars
                            , Ok
                                (Annotation.Tupled unified)
                            )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                _ ->
                    ( vars, Err "Unable to unify tuples!" )

        Annotation.Record fieldsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Record fieldsB ->
                    case unifiableFields vars fieldsA fieldsB [] of
                        ( newVars, Ok unifiedFields ) ->
                            ( newVars, Ok (Annotation.Record unifiedFields) )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                _ ->
                    ( vars, Err "Unable to unify function with non function type!" )

        Annotation.GenericRecord reVarName fieldsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Record fieldsB ->
                    ( vars, Err "Unable to unify function with non function type!" )

                _ ->
                    ( vars, Err "Unable to unify function with non function type!" )

        Annotation.FunctionTypeAnnotation oneA oneB ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.FunctionTypeAnnotation twoA twoB ->
                    case unifiableHelper vars (denode oneA) (denode twoA) of
                        ( aVars, Ok unifiedA ) ->
                            case unifiableHelper aVars (denode oneB) (denode twoB) of
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
                    ( vars, Err "Unable to unify function with non function type!" )


unifiableFields vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( oneX :: oneRemain, twoFields ) ->
            let
                ( oneFieldName, oneFieldVal ) =
                    denode oneX

                oneName =
                    denode oneFieldName

                oneVal =
                    denode oneFieldVal
            in
            case getField oneName oneVal twoFields [] of
                Ok ( matchingFieldVal, remainingTwo ) ->
                    let
                        ( newVars, unifiedField ) =
                            unifiableHelper vars oneVal matchingFieldVal
                    in
                    unifiableFields newVars oneRemain remainingTwo (unifiedField :: unified)

                Err notFound ->
                    ( vars, Err ("Could not find " ++ oneName) )

        _ ->
            ( vars, Err "Mismatched numbers of type variables" )


getField name val fields captured =
    case fields of
        [] ->
            Err ("Could not find " ++ name)

        top :: remain ->
            let
                ( topFieldName, topFieldVal ) =
                    denode top

                topName =
                    denode topFieldName

                topVal =
                    denode topFieldVal
            in
            if topName == name then
                Ok
                    ( topVal
                    , captured ++ remain
                    )

            else
                getField name val remain (top :: captured)


unifiableLists vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( [ oneX ], [ twoX ] ) ->
            case unifiableHelper vars (denode oneX) (denode twoX) of
                ( newVars, Ok un ) ->
                    ( newVars, Ok (nodifyAll (List.reverse (un :: unified))) )

                ( newVars, Err err ) ->
                    ( newVars, Err err )

        ( oneX :: oneRemain, twoX :: twoRemain ) ->
            case unifiableHelper vars (denode oneX) (denode twoX) of
                ( newVars, Ok un ) ->
                    unifiableLists newVars oneRemain twoRemain (un :: unified)

                ( newVars, Err err ) ->
                    ( vars, Err err )

        _ ->
            ( vars, Err "Mismatched numbers of type variables" )
