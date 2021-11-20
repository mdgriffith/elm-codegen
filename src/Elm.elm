module Elm exposing
    ( File, file
    , Expression
    , bool, int, float, char, string, hex, unit
    , maybe, list, tuple, triple
    , value, valueFrom, valueWith
    , withType
    , record, field, Field, get, updateRecord
    , caseOf, letIn, ifThen
    , apply
    , lambda, lambda2, lambda3, lambda4, lambda5, lambdaWith, lambdaBetaReduced
    , Declaration
    , comment, declaration
    , withDocumentation
    , fn, fn2, fn3, fn4, fn5, fn6, functionWith
    , customType, Variant, variant, variantWith
    , alias
    , expose, exposeConstructor
    , exposeAndGroup, exposeConstructorAndGroup
    , fileWith
    , equal, notEqual
    , append, cons
    , plus, minus, multiply, divide, intDivide, power
    , lt, gt, lte, gte, and, or
    , keep, skip
    , slash, question
    , portIncoming, portOutgoing
    , parse
    , toString, expressionImports
    , declarationToString, declarationImports
    , pass, unsafe
    )

{-|

@docs File, file


## Basics

@docs Expression

@docs bool, int, float, char, string, hex, unit

@docs maybe, list, tuple, triple

@docs value, valueFrom, valueWith

@docs withType


## Records

@docs record, field, Field, get, updateRecord


## Flow control

@docs caseOf, letIn, ifThen

@docs apply

@docs lambda, lambda2, lambda3, lambda4, lambda5, lambdaWith, lambdaBetaReduced


## Top level

@docs Declaration

@docs comment, declaration

@docs withDocumentation

@docs fn, fn2, fn3, fn4, fn5, fn6, functionWith


## Custom Types

@docs customType, Variant, variant, variantWith

@docs alias


## Exposing values

By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

@docs expose, exposeConstructor


## Grouping exposed values in the module comment

You can also add a group tag to an exposed value. This will automatically group the `docs` statements in the module docs.

For precise control over what is rendered for the module comment, use [fileWith](#fileWith)

@docs exposeAndGroup, exposeConstructorAndGroup

@docs fileWith


# Operators

@docs equal, notEqual

@docs append, cons

@docs plus, minus, multiply, divide, intDivide, power

@docs lt, gt, lte, gte, and, or


## Parsing

@docs keep, skip


## Url parsing

@docs slash, question


# Ports

@docs portIncoming, portOutgoing


# Parsing existing Elm

@docs parse


# Rendering to string

@docs toString, expressionImports

@docs declarationToString, declarationImports

-}

import Elm.Annotation
import Elm.Let as Let
import Elm.Parser
import Elm.Processing
import Elm.Syntax.Declaration as Declaration exposing (Declaration(..))
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Module
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Comments
import Internal.Compiler as Compiler
import Internal.Write
import Set


{-| -}
type alias Expression =
    Compiler.Expression


{-| -}
expressionImports : Expression -> String
expressionImports (Compiler.Expression exp) =
    List.filterMap (Compiler.makeImport []) exp.imports
        |> Internal.Write.writeImports


{-| -}
toString : Expression -> String
toString (Compiler.Expression exp) =
    Internal.Write.writeExpression exp.expression


{-| -}
declarationImports : Declaration -> String
declarationImports decl =
    case decl of
        Compiler.Declaration _ imps _ ->
            List.filterMap (Compiler.makeImport []) imps
                |> Internal.Write.writeImports

        Compiler.Comment _ ->
            ""

        Compiler.Block _ ->
            ""


{-| -}
declarationToString : Declaration -> String
declarationToString dec =
    Internal.Write.writeDeclaration dec


{-| Build a file!

    Elm.file [ "My", "Module" ]
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

-}
file : List String -> List Declaration -> File
file mod decs =
    render renderStandardComment
        { moduleDefinition = mod
        , imports =
            reduceDeclarationImports mod decs ( Set.empty, [] )
                |> Tuple.second
        , body = decs
        , aliases = []
        , moduleComment = ""
        }


renderStandardComment :
    List
        { group : Maybe String
        , members : List String
        }
    -> String
renderStandardComment groups =
    if List.isEmpty groups then
        ""

    else
        List.foldl
            (\grouped str ->
                str ++ "@docs " ++ String.join ", " grouped.members ++ "\n\n"
            )
            "\n\n"
            groups


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@doc` comment.

Each exposed item is grouped based on the string used in [exposeAndGroup](#exposeAndGroup)

-}
fileWith :
    List String
    ->
        { docs :
            List
                { group : Maybe String
                , members : List String
                }
            -> String
        , aliases : List ( List String, String )
        }
    -> List Declaration
    -> File
fileWith mod options decs =
    render options.docs
        { moduleDefinition = mod
        , imports =
            reduceDeclarationImports mod decs ( Set.empty, [] )
                |> Tuple.second
        , aliases = options.aliases
        , body = decs
        , moduleComment = ""
        }


{-| -}
render :
    (List
        { group : Maybe String
        , members : List String
        }
     -> String
    )
    -> FileDetails
    -> File
render toDocComment fileDetails =
    let
        mod =
            fileDetails.moduleDefinition

        exposed =
            Compiler.getExposed fileDetails.body

        exposedGroups =
            Compiler.getExposedGroups fileDetails.body

        body =
            Internal.Write.write
                { moduleDefinition =
                    (if Compiler.hasPorts fileDetails.body then
                        Elm.Syntax.Module.PortModule

                     else
                        Elm.Syntax.Module.NormalModule
                    )
                        { moduleName = Compiler.nodify mod
                        , exposingList =
                            case exposed of
                                [] ->
                                    Compiler.nodify
                                        (Expose.All Range.emptyRange)

                                _ ->
                                    Compiler.nodify
                                        (Expose.Explicit
                                            (Compiler.nodifyAll exposed)
                                        )
                        }
                , aliases = fileDetails.aliases
                , imports =
                    List.filterMap (Compiler.makeImport fileDetails.aliases) fileDetails.imports
                , declarations = fileDetails.body
                , comments =
                    Just
                        (Internal.Comments.addPart
                            Internal.Comments.emptyComment
                            (Internal.Comments.Markdown
                                (toDocComment exposedGroups)
                            )
                        )
                }
    in
    { path =
        String.join "/" mod ++ ".elm"
    , contents = body
    }


type alias Module =
    List String


reduceDeclarationImports : Module -> List Declaration -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
reduceDeclarationImports self decs imports =
    case decs of
        [] ->
            imports

        (Compiler.Comment _) :: remain ->
            reduceDeclarationImports self
                remain
                imports

        (Compiler.Block _) :: remain ->
            reduceDeclarationImports self
                remain
                imports

        (Compiler.Declaration _ newImports body) :: remain ->
            reduceDeclarationImports self
                remain
                (addImports self newImports imports)


addImports : Module -> List Module -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
addImports self newImports ( set, deduped ) =
    case newImports of
        [] ->
            ( set, deduped )

        new :: remain ->
            let
                full =
                    Compiler.fullModName new
            in
            if Set.member full set || full == Compiler.fullModName self then
                -- skip
                addImports self remain ( set, deduped )

            else
                addImports self
                    remain
                    ( Set.insert full set, new :: deduped )


{-| -}
type alias File =
    { path : String
    , contents : String
    }


{-| -}
type InternalFile
    = InternalFile FileDetails


type alias FileDetails =
    { moduleDefinition : Module
    , imports : List Module
    , aliases : List ( Module, String )
    , body : List Declaration
    , moduleComment : String
    }


{-| -}
value : String -> Expression
value =
    valueFrom []


{-| -}
valueFrom : List String -> String -> Expression
valueFrom mod name =
    Compiler.Expression
        { expression =
            Exp.FunctionOrValue mod
                (Compiler.sanitize name)
        , annotation = Err []
        , imports = [ mod ]
        , skip = False
        }


{-| Add an annotation to a value.

**Note** this may not _literally_ add an annotation to the code, but will inform `elm-prefab`s type inference so that top level values can be auto-annotated.

So, for example, if we have.

    Elm.list
        [ Elm.valueWith myModule "myString" Elm.Annotation.string
        , Elm.valueWith myModule "myOtherString" Elm.Annotation.string
        ]

Then, when that list is generated, it will automatically have the type signature `List String`

-}
valueWith : List String -> String -> Elm.Annotation.Annotation -> Expression
valueWith mod name ann =
    Compiler.Expression
        { expression = Exp.FunctionOrValue mod (Compiler.sanitize name)
        , annotation = Ok (Compiler.getInnerAnnotation ann)
        , imports = mod :: Compiler.getAnnotationImports ann
        , skip = False
        }


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType (Type.string)

Though be sure elm-prefab isn't already doing this automatically for you!

-}
withType : Elm.Annotation.Annotation -> Expression -> Expression
withType ann (Compiler.Expression exp) =
    Compiler.Expression
        { exp
            | annotation = Ok (Compiler.getInnerAnnotation ann)
            , imports = exp.imports ++ Compiler.getAnnotationImports ann
        }


{-| -}
unit : Expression
unit =
    Compiler.Expression
        { expression = Exp.UnitExpr
        , annotation = Ok Annotation.Unit
        , imports = []
        , skip = False
        }


{-| -}
bool : Bool -> Expression
bool on =
    valueWith []
        (if on then
            "True"

         else
            "False"
        )
        Elm.Annotation.bool


{-| -}
int : Int -> Expression
int intVal =
    Compiler.Expression
        { expression = Exp.Integer intVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.int)
        , imports = []
        , skip = False
        }


{-| -}
hex : Int -> Expression
hex hexVal =
    Compiler.Expression
        { expression = Exp.Hex hexVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.int)
        , imports = []
        , skip = False
        }


{-| -}
float : Float -> Expression
float floatVal =
    Compiler.Expression
        { expression = Exp.Floatable floatVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.float)
        , imports = []
        , skip = False
        }


{-| -}
string : String -> Expression
string literal =
    Compiler.Expression
        { expression = Exp.Literal literal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.string)
        , imports = []
        , skip = False
        }


{-| -}
char : Char -> Expression
char charVal =
    Compiler.Expression
        { expression = Exp.CharLiteral charVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.char)
        , imports = []
        , skip = False
        }



-- {-|
-- -}
-- glsl : String -> Expression
-- glsl expr =
--     Exp.GLSLExpression expr


{-| -}
tuple : Expression -> Expression -> Expression
tuple (Compiler.Expression one) (Compiler.Expression two) =
    Compiler.Expression
        { expression = Exp.TupledExpression (Compiler.nodifyAll [ one.expression, two.expression ])
        , annotation =
            Result.map2
                (\oneA twoA ->
                    Elm.Annotation.tuple
                        (Compiler.noImports oneA)
                        (Compiler.noImports twoA)
                        |> Compiler.getInnerAnnotation
                )
                one.annotation
                two.annotation
        , imports = one.imports ++ two.imports
        , skip = False
        }


{-| -}
triple : Expression -> Expression -> Expression -> Expression
triple (Compiler.Expression one) (Compiler.Expression two) (Compiler.Expression three) =
    Compiler.Expression
        { expression =
            Exp.TupledExpression
                (Compiler.nodifyAll
                    [ one.expression, two.expression, three.expression ]
                )
        , annotation =
            Result.map3
                (\oneA twoA threeA ->
                    Elm.Annotation.triple
                        (Compiler.noImports oneA)
                        (Compiler.noImports twoA)
                        (Compiler.noImports threeA)
                        |> Compiler.getInnerAnnotation
                )
                one.annotation
                two.annotation
                three.annotation
        , imports = one.imports ++ two.imports ++ three.imports
        , skip = False
        }


{-| -}
maybe : Maybe Expression -> Expression
maybe content =
    Compiler.Expression
        { expression =
            case content of
                Nothing ->
                    Exp.FunctionOrValue []
                        "Nothing"

                Just inner ->
                    Exp.Application
                        [ Exp.FunctionOrValue []
                            "Just"
                            |> Compiler.nodify
                        , Exp.ParenthesizedExpression
                            (Compiler.nodify (Compiler.getInnerExpression inner))
                            |> Compiler.nodify
                        ]
        , annotation =
            case content of
                Nothing ->
                    Ok
                        (Compiler.getInnerAnnotation
                            (Elm.Annotation.maybe (Elm.Annotation.var "a"))
                        )

                Just inner ->
                    Result.map
                        (\ann ->
                            Annotation.Typed
                                (Compiler.nodify ( [], "Maybe" ))
                                [ Compiler.nodify ann ]
                        )
                        (Compiler.getAnnotation inner)
        , imports =
            Maybe.map getImports content
                |> Maybe.withDefault []
        , skip = False
        }


{-| -}
list : List Expression -> Expression
list exprs =
    Compiler.Expression
        { expression = Exp.ListExpr (List.map toList exprs)
        , annotation =
            Compiler.unify exprs
                |> Result.map
                    (\inner ->
                        Annotation.Typed
                            (Compiler.nodify ( [], "List" ))
                            [ Compiler.nodify inner ]
                    )
        , imports = List.concatMap getImports exprs
        , skip = False
        }


toList : Expression -> Node.Node Exp.Expression
toList (Compiler.Expression exp) =
    Compiler.nodify exp.expression


{-| -}
updateRecord : String -> List ( String, Expression ) -> Expression
updateRecord name fields =
    Compiler.Expression
        { expression =
            fields
                |> List.map
                    (\( fieldName, fieldExp ) ->
                        Compiler.nodify
                            ( Compiler.nodify fieldName
                            , Compiler.nodify (Compiler.getInnerExpression fieldExp)
                            )
                    )
                |> Exp.RecordUpdateExpression (Compiler.nodify name)
        , annotation =
            Err []
        , imports =
            List.concatMap
                (Tuple.second >> Compiler.getImports)
                fields
        , skip = False
        }


{-| -}
record : List Field -> Expression
record fields =
    let
        unified =
            fields
                |> List.foldl
                    (\(Field unformattedFieldName (Compiler.Expression exp)) found ->
                        let
                            fieldName =
                                Compiler.formatValue unformattedFieldName
                        in
                        { fields =
                            ( Compiler.nodify fieldName
                            , Compiler.nodify exp.expression
                            )
                                :: found.fields
                        , errors =
                            if Set.member fieldName found.passed then
                                Compiler.DuplicateFieldInRecord fieldName :: found.errors

                            else
                                case exp.annotation of
                                    Err [] ->
                                        Compiler.SomeOtherIssue :: found.errors

                                    Err errs ->
                                        errs ++ found.errors

                                    Ok ann ->
                                        found.errors
                        , fieldAnnotations =
                            case exp.annotation of
                                Err err ->
                                    found.fieldAnnotations

                                Ok ann ->
                                    ( Compiler.formatValue fieldName
                                    , ann
                                    )
                                        :: found.fieldAnnotations
                        , passed = Set.insert fieldName found.passed
                        , imports = exp.imports ++ found.imports
                        }
                    )
                    { fields = []
                    , errors = []
                    , fieldAnnotations = []
                    , passed = Set.empty
                    , imports = []
                    }
    in
    Compiler.Expression
        { expression =
            unified.fields
                |> List.reverse
                |> Compiler.nodifyAll
                |> Exp.RecordExpr
        , annotation =
            case unified.errors of
                [] ->
                    List.reverse unified.fieldAnnotations
                        |> List.map
                            (\( name, ann ) ->
                                ( Compiler.nodify name
                                , Compiler.nodify ann
                                )
                            )
                        |> Compiler.nodifyAll
                        |> Annotation.Record
                        |> Ok

                errs ->
                    Err errs
        , imports =
            unified.imports
        , skip = False
        }


{-| -}
type Field
    = Field String Expression


{-| -}
field : String -> Expression -> Field
field =
    Field


{-| A let block.

Check out `Elm.Let` to add things to it.

    import Elm.Let as Let

    Elm.letIn
        [ Let.value "one" (Elm.int 5)
        , Let.value "two" (Elm.int 10)
        ]
        (Elm.add (Elm.value "one") (Elm.value "two"))

-}
letIn : List Let.Declaration -> Expression -> Expression
letIn decls (Compiler.Expression within) =
    let
        gathered =
            List.foldr
                (\(Compiler.LetDeclaration mods dec) accum ->
                    { declarations =
                        dec :: accum.declarations
                    , imports = accum.imports ++ mods
                    }
                )
                { declarations = []
                , imports = []
                }
                decls
    in
    Compiler.Expression
        { expression =
            Exp.LetExpression
                { declarations = Compiler.nodifyAll gathered.declarations
                , expression = Compiler.nodify within.expression
                }
        , imports = gathered.imports
        , annotation =
            within.annotation
        , skip = False
        }


{-|

    ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

    if True then
        "yes"

    else
        "no"

-}
ifThen : Expression -> Expression -> Expression -> Expression
ifThen (Compiler.Expression condition) (Compiler.Expression thenBranch) (Compiler.Expression elseBranch) =
    Compiler.Expression
        { expression =
            Exp.IfBlock
                (Compiler.nodify condition.expression)
                (Compiler.nodify thenBranch.expression)
                (Compiler.nodify elseBranch.expression)
        , annotation =
            thenBranch.annotation
        , imports = condition.imports ++ thenBranch.imports ++ elseBranch.imports
        , skip = False
        }


{-| -}
caseOf : Expression -> List ( Pattern, Expression ) -> Expression
caseOf (Compiler.Expression expr) cases =
    let
        gathered =
            List.foldl
                (\( pattern, Compiler.Expression exp ) accum ->
                    { cases = ( Compiler.nodify pattern, Compiler.nodify exp.expression ) :: accum.cases
                    , imports = accum.imports ++ exp.imports
                    , annotation =
                        case accum.annotation of
                            Nothing ->
                                Just exp.annotation

                            Just exist ->
                                if exist == exp.annotation then
                                    accum.annotation

                                else
                                    Just (Err [ Compiler.CaseBranchesReturnDifferentTypes ])
                    }
                )
                { cases = []
                , imports = []
                , annotation = Nothing
                }
                cases
    in
    Compiler.Expression
        { expression =
            Exp.CaseExpression
                { expression = Compiler.nodify expr.expression
                , cases = List.reverse gathered.cases
                }
        , annotation =
            case gathered.annotation of
                Nothing ->
                    Err [ Compiler.EmptyCaseStatement ]

                Just ann ->
                    ann
        , imports = expr.imports ++ gathered.imports
        , skip = False
        }


{-|

    record
        |> Elm.get "field"

results in

    record.field

-}
get : String -> Expression -> Expression
get selector (Compiler.Expression expr) =
    Compiler.Expression
        { expression =
            Exp.RecordAccess (Compiler.nodify expr.expression) (Compiler.nodify (Compiler.formatValue selector))
        , annotation =
            case expr.annotation of
                Ok (Annotation.Record fields) ->
                    case getField (Compiler.formatValue selector) fields of
                        Just ann ->
                            Ok ann

                        Nothing ->
                            Err [ Compiler.CouldNotFindField selector ]

                Ok (Annotation.GenericRecord name fields) ->
                    case getField (Compiler.formatValue selector) (Compiler.denode fields) of
                        Just ann ->
                            Ok ann

                        Nothing ->
                            Err [ Compiler.CouldNotFindField selector ]

                otherwise ->
                    otherwise
        , imports = expr.imports
        , skip = False
        }


getField :
    String
    -> List (Node.Node ( Node.Node String, Node.Node b ))
    -> Maybe b
getField selector fields =
    case fields of
        [] ->
            Nothing

        nodifiedTop :: remain ->
            case Compiler.denode nodifiedTop of
                ( fieldname, contents ) ->
                    if Compiler.denode fieldname == selector then
                        Just (Compiler.denode contents)

                    else
                        getField selector remain


{-| A custom type declaration.

    Elm.customType "MyType"
        [ Elm.variant "One"
        , Elm.variantWith "Two" [ Elm.Annotation.list Elm.Annotation.string ]
        ]

Will result in

    type MyType
        = One
        | Two (List String)

-}
customType : String -> List Variant -> Declaration
customType name variants =
    Compiler.Declaration Compiler.NotExposed
        (List.concatMap
            (\(Variant _ listAnn) ->
                List.concatMap Compiler.getAnnotationImports listAnn
            )
            variants
        )
        (Declaration.CustomTypeDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics =
                List.concatMap
                    (\(Variant _ listAnn) ->
                        listAnn
                            |> List.concatMap
                                Compiler.getGenerics
                    )
                    variants
            , constructors =
                List.map
                    (\(Variant varName vars) ->
                        Compiler.nodify
                            { name = Compiler.nodify (Compiler.formatType varName)
                            , arguments =
                                List.map
                                    (Compiler.getInnerAnnotation
                                        >> Compiler.nodify
                                    )
                                    vars
                            }
                    )
                    variants
            }
        )


{-| -}
type Variant
    = Variant String (List Elm.Annotation.Annotation)


{-| -}
variant : String -> Variant
variant name =
    Variant name []


{-| -}
variantWith : String -> List Elm.Annotation.Annotation -> Variant
variantWith =
    Variant


{-| A custom type declaration.

    import Elm.Annotation as Type

    Elm.alias "MyAlias"
        (Type.record
            [ ( "one", Type.string )
            , ( "two", Type.int )
            , ( "three", Type.var "content" )
            ]
        )

Should result in

    type alias MyAlias content =
        { one : String
        , two : Int
        , three : content
        }

-}
alias : String -> Elm.Annotation.Annotation -> Declaration
alias name innerAnnotation =
    Compiler.Declaration Compiler.NotExposed
        (Compiler.getAnnotationImports innerAnnotation)
        (Declaration.AliasDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics =
                Compiler.getGenerics innerAnnotation
            , typeAnnotation = Compiler.nodify (Compiler.getInnerAnnotation innerAnnotation)
            }
        )


{-| Not exposed, this should be done automatically!
-}
parens : Exp.Expression -> Exp.Expression
parens expr =
    case expr of
        Exp.UnitExpr ->
            expr

        Exp.Integer i ->
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

        _ ->
            Exp.ParenthesizedExpression (Compiler.nodify expr)


getExpression : Expression -> Exp.Expression
getExpression (Compiler.Expression exp) =
    exp.expression


getImports : Expression -> List Compiler.Module
getImports (Compiler.Expression exp) =
    exp.imports


{-| -}
apply : Expression -> List Expression -> Expression
apply ((Compiler.Expression exp) as top) allArgs =
    let
        args =
            List.filter (\(Compiler.Expression arg) -> not arg.skip) allArgs
    in
    Compiler.Expression
        { expression =
            -- Disabling autopipe for now.
            -- There seems to be some edge cases where it generates invalid code.
            -- autopipe False exp.expression (List.map getExpression args)
            Exp.Application (Compiler.nodifyAll (exp.expression :: List.map (parens << getExpression) args))
        , annotation =
            Compiler.applyType top args
        , imports = exp.imports ++ List.concatMap getImports args
        , skip = False
        }


popLast : List a -> Maybe ( List a, a )
popLast lst =
    case List.reverse lst of
        [] ->
            Nothing

        last :: initReverse ->
            Just ( List.reverse initReverse, last )


{-|

    String.append "world2" (String.append "world" "Hello")

    Apply [ String.append, "world2", Apply [ String.append, "world", "hello" ] ]

    Elm.string "Hello"
        |> Elm.Gen.String.append (Elm.string "world")
        |> Elm.Gen.String.append (Elm.string "world2")

    OpApply "|>"
        (OpApply "|>"
            ()
            (Apply [ String.append, "world" ])
        )
        String.append

-}
autopipe : Bool -> Exp.Expression -> List Exp.Expression -> Exp.Expression
autopipe committed topFn expressions =
    if committed then
        case popLast expressions of
            Nothing ->
                topFn

            Just ( init, last ) ->
                Exp.OperatorApplication "|>"
                    Infix.Left
                    (Compiler.nodify last)
                    (Compiler.nodify
                        (Exp.Application
                            (Compiler.nodify topFn :: List.map (Compiler.nodify << parens) init)
                        )
                    )

    else
        case popLast expressions of
            Nothing ->
                topFn

            Just ( init, last ) ->
                case last of
                    Exp.Application lastArgs ->
                        Exp.OperatorApplication "|>"
                            Infix.Left
                            (Compiler.nodify
                                (case lastArgs of
                                    [] ->
                                        Exp.Application []

                                    innerFn :: remain ->
                                        autopipe True (Compiler.denode innerFn) (List.map Compiler.denode remain)
                                )
                            )
                            (Compiler.nodify
                                (Exp.Application
                                    (Compiler.nodify topFn :: List.map (Compiler.nodify << parens) init)
                                )
                            )

                    _ ->
                        Exp.Application
                            (List.map (Compiler.nodify << parens) (topFn :: expressions))


{-| -}
type alias Pattern =
    Pattern.Pattern


{-| -}
lambdaWith : List ( Pattern, Elm.Annotation.Annotation ) -> Expression -> Expression
lambdaWith args (Compiler.Expression expr) =
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args = Compiler.nodifyAll (List.map Tuple.first args)
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        (List.map (Compiler.getInnerAnnotation << Tuple.second) args)
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda : String -> Elm.Annotation.Annotation -> (Expression -> Expression) -> Expression
lambda argBaseName argType toExpression =
    let
        arg1 =
            valueWith [] argBaseName argType

        (Compiler.Expression expr) =
            toExpression arg1
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args = [ Compiler.nodify (Pattern.VarPattern argBaseName) ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation argType ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambdaBetaReduced : String -> Elm.Annotation.Annotation -> (Expression -> Expression) -> Expression
lambdaBetaReduced argBaseName argType toExpression =
    let
        arg1 =
            valueWith [] argBaseName argType

        (Compiler.Expression expr) =
            toExpression arg1
    in
    Compiler.Expression
        { expression =
            betaReduce <|
                Exp.LambdaExpression
                    { args = [ Compiler.nodify (Pattern.VarPattern argBaseName) ]
                    , expression = Compiler.nodify expr.expression
                    }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation argType ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }



-- -- If the list is nonempty, returns a tuple with the beginning of the list and the last element (denoded).


popLastAndDenodeLast : List (Node.Node a) -> Maybe ( List (Node.Node a), a )
popLastAndDenodeLast lst =
    case List.reverse lst of
        [] ->
            Nothing

        last :: initReverse ->
            Just ( List.reverse initReverse, Compiler.denode last )


betaReduce : Exp.Expression -> Exp.Expression
betaReduce e =
    let
        extractLastArg arg =
            case arg of
                Exp.FunctionOrValue [] n ->
                    Just n

                Exp.ParenthesizedExpression p ->
                    extractLastArg <| Compiler.denode p

                _ ->
                    Nothing
    in
    case e of
        Exp.LambdaExpression { args, expression } ->
            case popLastAndDenodeLast args of
                Just ( initLambdaArgs, Pattern.VarPattern lastLambdaArg ) ->
                    case Compiler.denode expression of
                        Exp.RecordAccess argNode fieldNode ->
                            let
                                fieldName =
                                    Compiler.denode fieldNode

                                arg =
                                    Compiler.denode argNode
                            in
                            case arg of
                                Exp.FunctionOrValue [] argName ->
                                    if argName == lastLambdaArg then
                                        Exp.RecordAccessFunction <| "." ++ fieldName

                                    else
                                        e

                                _ ->
                                    e

                        Exp.Application applicationArgs ->
                            case popLastAndDenodeLast applicationArgs of
                                Just ( [], uniqueApplicationArg ) ->
                                    if extractLastArg uniqueApplicationArg == Just lastLambdaArg then
                                        Exp.FunctionOrValue [] "identity"

                                    else
                                        e

                                Just ( initApplicationArgs, lastApplicationArg ) ->
                                    if extractLastArg lastApplicationArg == Just lastLambdaArg then
                                        if List.isEmpty initLambdaArgs then
                                            case initApplicationArgs of
                                                [ s ] ->
                                                    betaReduce <| Compiler.denode s

                                                _ ->
                                                    Exp.Application initApplicationArgs

                                        else
                                            betaReduce <|
                                                Exp.LambdaExpression
                                                    { args = initLambdaArgs
                                                    , expression =
                                                        Compiler.nodify <|
                                                            Exp.Application initApplicationArgs
                                                    }

                                    else
                                        e

                                _ ->
                                    e

                        _ ->
                            e

                _ ->
                    e

        _ ->
            e


{-| -}
lambda2 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression)
    -> Expression
lambda2 argBaseName oneType twoType toExpression =
    let
        arg1 =
            valueWith [] argBaseName oneType

        arg2 =
            valueWith [] (argBaseName ++ "2") twoType

        (Compiler.Expression expr) =
            toExpression arg1 arg2
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda3 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda3 argBaseName oneType twoType threeType toExpression =
    let
        arg1 =
            valueWith [] argBaseName oneType

        arg2 =
            valueWith [] (argBaseName ++ "2") twoType

        arg3 =
            valueWith [] (argBaseName ++ "3") threeType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda4 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda4 argBaseName oneType twoType threeType fourType toExpression =
    let
        arg1 =
            valueWith [] argBaseName oneType

        arg2 =
            valueWith [] (argBaseName ++ "2") twoType

        arg3 =
            valueWith [] (argBaseName ++ "3") threeType

        arg4 =
            valueWith [] (argBaseName ++ "4") fourType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3 arg4
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "4"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        , Compiler.getInnerAnnotation fourType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda5 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda5 argBaseName oneType twoType threeType fourType fiveType toExpression =
    let
        arg1 =
            valueWith [] argBaseName oneType

        arg2 =
            valueWith [] (argBaseName ++ "2") twoType

        arg3 =
            valueWith [] (argBaseName ++ "3") threeType

        arg4 =
            valueWith [] (argBaseName ++ "4") fourType

        arg5 =
            valueWith [] (argBaseName ++ "5") fiveType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3 arg4 arg5
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "4"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "5"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        , Compiler.getInnerAnnotation fourType
                        , Compiler.getInnerAnnotation fiveType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
type alias Declaration =
    Compiler.Declaration


{-| -}
comment : String -> Declaration
comment content =
    Compiler.Comment ("{- " ++ content ++ " -}")


{-| -}
declaration : String -> Expression -> Declaration
declaration name (Compiler.Expression body) =
    --function name [] body
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok sig ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify sig
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments = []
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed body.imports


{-| -}
functionWith : String -> List ( Elm.Annotation.Annotation, Pattern ) -> Expression -> Declaration
functionWith name args (Compiler.Expression body) =
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        (List.map Tuple.first args)
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments = Compiler.nodifyAll (List.map Tuple.second args)
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (List.concatMap
                (Tuple.first
                    >> Compiler.getAnnotationImports
                )
                args
                ++ body.imports
            )


{-| -}
fn : String -> ( String, Elm.Annotation.Annotation ) -> (Expression -> Expression) -> Declaration
fn name ( oneName, oneType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        (Compiler.Expression body) =
            toBody arg1
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ body.imports
            )


{-| -}
fn2 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression)
    -> Declaration
fn2 name ( oneName, oneType ) ( twoName, twoType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        arg2 =
            valueWith [] twoName twoType

        (Compiler.Expression body) =
            toBody arg1 arg2
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ body.imports
            )


{-| -}
fn3 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn3 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        arg2 =
            valueWith [] twoName twoType

        arg3 =
            valueWith [] threeName threeType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ body.imports
            )


{-| -}
fn4 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn4 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        arg2 =
            valueWith [] twoName twoType

        arg3 =
            valueWith [] threeName threeType

        arg4 =
            valueWith [] fourName fourType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3 arg4
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType, fourType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ Compiler.getAnnotationImports fourType
                ++ body.imports
            )


{-| -}
fn5 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn5 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) ( fiveName, fiveType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        arg2 =
            valueWith [] twoName twoType

        arg3 =
            valueWith [] threeName threeType

        arg4 =
            valueWith [] fourName fourType

        arg5 =
            valueWith [] fiveName fiveType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3 arg4 arg5
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType, fourType, fiveType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                , Compiler.nodify (Pattern.VarPattern fiveName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ Compiler.getAnnotationImports fourType
                ++ Compiler.getAnnotationImports fiveType
                ++ body.imports
            )


{-| -}
fn6 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn6 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) ( fiveName, fiveType ) ( sixName, sixType ) toBody =
    let
        arg1 =
            valueWith [] oneName oneType

        arg2 =
            valueWith [] twoName twoType

        arg3 =
            valueWith [] threeName threeType

        arg4 =
            valueWith [] fourName fourType

        arg5 =
            valueWith [] fiveName fiveType

        arg6 =
            valueWith [] sixName sixType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3 arg4 arg5 arg6
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType, fourType, fiveType, sixType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                , Compiler.nodify (Pattern.VarPattern fiveName)
                , Compiler.nodify (Pattern.VarPattern sixName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ Compiler.getAnnotationImports fourType
                ++ Compiler.getAnnotationImports fiveType
                ++ Compiler.getAnnotationImports sixType
                ++ body.imports
            )


{-| Add documentation to a declaration!
-}
withDocumentation : String -> Declaration -> Declaration
withDocumentation =
    Compiler.documentation


{-| -}
expose : Declaration -> Declaration
expose =
    Compiler.expose


{-| -}
exposeAndGroup : String -> Declaration -> Declaration
exposeAndGroup =
    Compiler.exposeAndGroup


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor =
    Compiler.exposeConstructor


{-| -}
exposeConstructorAndGroup : String -> Declaration -> Declaration
exposeConstructorAndGroup =
    Compiler.exposeConstructorAndGroup


{-|

    import Elm.Annotation as Type

    Elm.portIncoming "receiveMessageFromTheWorld"
        [ Type.string
        , Type.int
        ]

Results in

    port receiveMessageFromTheWorld :
        (String -> Int -> msg)
        -> Sub msg

**Note** You generally only need one incoming and one outgoing port!

If you want to vary the messages going in and out of your app, don't use a huge number of ports, instead write Json encoders and decoders.

This will give you more flexibility in the future and save you having to wire up a bunch of stuff.

**Another note** - You may need to expose your port explicitly using `Elm.expose`

-}
portIncoming : String -> List Elm.Annotation.Annotation -> Declaration
portIncoming name args =
    { name = Compiler.nodify name
    , typeAnnotation =
        Compiler.nodify
            (case args of
                [] ->
                    Annotation.FunctionTypeAnnotation
                        (Compiler.nodify (Annotation.GenericType "msg"))
                        (Compiler.nodify sub)

                start :: remain ->
                    Annotation.FunctionTypeAnnotation
                        (groupAnn
                            (Compiler.nodify
                                (Compiler.getInnerAnnotation
                                    (Elm.Annotation.function
                                        args
                                        (Elm.Annotation.var "msg")
                                    )
                                )
                            )
                        )
                        (Compiler.nodify sub)
            )
    }
        |> Declaration.PortDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (List.concatMap Compiler.getAnnotationImports args)


groupAnn ann =
    Annotation.Tupled
        [ ann ]
        |> Compiler.nodify


sub : Annotation.TypeAnnotation
sub =
    Annotation.Typed
        (Compiler.nodify ( [ "Platform", "Sub" ], "Sub" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : String -> Elm.Annotation.Annotation -> Declaration
portOutgoing name arg =
    { name = Compiler.nodify name
    , typeAnnotation =
        Compiler.nodify
            (Annotation.FunctionTypeAnnotation
                (Compiler.nodify (Compiler.getInnerAnnotation arg))
                (Compiler.nodify cmd)
            )
    }
        |> Declaration.PortDeclaration
        |> Compiler.Declaration Compiler.NotExposed (Compiler.getAnnotationImports arg)


cmd : Annotation.TypeAnnotation
cmd =
    Annotation.Typed
        (Compiler.nodify ( [ "Platform", "Cmd" ], "Cmd" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]



{- Infix operators!

   The goal is to make the following work


       one
           |> Elm.or two
           |> Elm.or three


       Elm.or one two




   We're not really worried about allowing operators to be partially applied in a way that results in the following code.

       (<=) 5

   I mean, come on, we're generating code.  Let's make it clearer.


   We're also not worried about recreating infix notation in this lib.  So no need to do:

       applyBinOp (int 2) plus (int 3)




-}


{-| Represents all of the binary operators allowed in Elm.
-}
type BinOp
    = BinOp String Infix.InfixDirection Int


{-| `>>`
-}
compose : Expression -> Expression -> Expression
compose =
    applyBinOp (BinOp ">>" Infix.Left 9)


{-| `<<`
-}
composeLeft : Expression -> Expression -> Expression
composeLeft =
    applyBinOp (BinOp "<<" Infix.Right 9)


{-| The to-the-power-of operator `^`
-}
power : Expression -> Expression -> Expression
power =
    applyInfix (BinOp "^" Infix.Right 8)
        (valueWith
            []
            "^"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `*`
-}
multiply : Expression -> Expression -> Expression
multiply =
    applyInfix (BinOp "*" Infix.Left 7)
        (valueWith
            []
            "*"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `/`
-}
divide : Expression -> Expression -> Expression
divide =
    applyInfix (BinOp "/" Infix.Left 7)
        (valueWith
            []
            "/"
            (Elm.Annotation.function
                [ Elm.Annotation.float, Elm.Annotation.float ]
                Elm.Annotation.float
            )
        )


{-| `//`
-}
intDivide : Expression -> Expression -> Expression
intDivide =
    applyInfix (BinOp "//" Infix.Left 7)
        (valueWith
            []
            "/"
            (Elm.Annotation.function
                [ Elm.Annotation.int, Elm.Annotation.int ]
                Elm.Annotation.int
            )
        )


{-| `+`
-}
plus : Expression -> Expression -> Expression
plus =
    applyInfix (BinOp "+" Infix.Left 6)
        (valueWith
            []
            "max"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `-`
-}
minus : Expression -> Expression -> Expression
minus =
    applyInfix (BinOp "-" Infix.Left 6)
        (valueWith
            []
            "max"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `++`
-}
append : Expression -> Expression -> Expression
append =
    applyInfix
        (BinOp "++" Infix.Right 5)
        (valueWith
            []
            "append"
            (Elm.Annotation.function
                [ Elm.Annotation.namedWith
                    []
                    "List"
                    [ Elm.Annotation.var "a" ]
                , Elm.Annotation.namedWith
                    []
                    "List"
                    [ Elm.Annotation.var "a" ]
                ]
                (Elm.Annotation.namedWith
                    []
                    "List"
                    [ Elm.Annotation.var "a" ]
                )
            )
        )


{-| `::`
-}
cons : Expression -> Expression -> Expression
cons =
    applyInfix (BinOp "::" Infix.Right 5)
        (valueWith
            []
            "cons"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a"
                , Elm.Annotation.list (Elm.Annotation.var "a")
                ]
                (Elm.Annotation.list (Elm.Annotation.var "a"))
            )
        )


{-| `==`
-}
equal : Expression -> Expression -> Expression
equal =
    applyInfix (BinOp "==" Infix.Left 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a"
                , Elm.Annotation.var "a"
                ]
                Elm.Annotation.bool
            )
        )


{-| `/=`
-}
notEqual : Expression -> Expression -> Expression
notEqual =
    applyInfix (BinOp "/=" Infix.Left 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a", Elm.Annotation.var "a" ]
                Elm.Annotation.bool
            )
        )


{-| `<`
-}
lt : Expression -> Expression -> Expression
lt =
    applyInfix (BinOp "<" Infix.Non 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `>`
-}
gt : Expression -> Expression -> Expression
gt =
    applyInfix (BinOp ">" Infix.Non 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `<=`
-}
lte : Expression -> Expression -> Expression
lte =
    applyInfix (BinOp "<=" Infix.Non 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `>=`
-}
gte : Expression -> Expression -> Expression
gte =
    applyInfix (BinOp ">=" Infix.Non 4)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `&&`
-}
and : Expression -> Expression -> Expression
and =
    applyInfix (BinOp "&&" Infix.Right 3)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.bool, Elm.Annotation.bool ]
                Elm.Annotation.bool
            )
        )


{-| `||`
-}
or : Expression -> Expression -> Expression
or =
    applyInfix (BinOp "||" Infix.Right 2)
        (valueWith
            []
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.bool, Elm.Annotation.bool ]
                Elm.Annotation.bool
            )
        )


{-| used in the `elm/parser` library

`|=`

-}
keep : Expression -> Expression -> Expression
keep =
    applyBinOp (BinOp "|=" Infix.Left 5)


{-| `|.`
-}
skip : Expression -> Expression -> Expression
skip =
    applyBinOp (BinOp "|." Infix.Left 6)


{-| `</>` used in url parsing
-}
slash : Expression -> Expression -> Expression
slash =
    applyBinOp (BinOp "</>" Infix.Right 7)


{-| `<?>` used in url parsing
-}
question : Expression -> Expression -> Expression
question =
    applyBinOp (BinOp "<?>" Infix.Left 8)


{-| `|>`

    Elm.value "thang"
        |> Elm.pipe (Elm.value "thang2")
        |> Elm.pipe (Elm.value "thang3")

Results in

    thang
        |> thang2
        |> thang3

-}
pipe : Expression -> Expression -> Expression
pipe r l =
    applyBinOp (BinOp "|>" Infix.Left 0) l r


{-| `<|`
-}
pipeLeft : Expression -> Expression -> Expression
pipeLeft =
    applyBinOp (BinOp "<|" Infix.Right 0)


applyBinOp : BinOp -> Expression -> Expression -> Expression
applyBinOp (BinOp symbol dir _) (Compiler.Expression exprl) (Compiler.Expression exprr) =
    Compiler.Expression
        { expression =
            Exp.OperatorApplication symbol dir (Compiler.nodify exprl.expression) (Compiler.nodify exprr.expression)
        , annotation = Err [ Compiler.SomeOtherIssue ]
        , imports = exprl.imports ++ exprr.imports
        , skip = False
        }


applyInfix : BinOp -> Expression -> Expression -> Expression -> Expression
applyInfix (BinOp symbol dir _) fnAnnotation (Compiler.Expression left) (Compiler.Expression right) =
    Compiler.Expression
        { expression =
            Exp.OperatorApplication symbol dir (Compiler.nodify left.expression) (Compiler.nodify right.expression)
        , annotation =
            Compiler.applyType fnAnnotation
                [ Compiler.Expression left
                , Compiler.Expression right
                ]
        , imports = left.imports ++ right.imports
        , skip = False
        }


{-| -}
pass : Expression
pass =
    Compiler.skip


{-| -}
unsafe : String -> Declaration
unsafe source =
    Compiler.Block (String.trim source)


{-| -}
parse : String -> Result String { declarations : List Declaration }
parse source =
    case Elm.Parser.parse source of
        Err deadends ->
            Err "Uh oh"

        Ok raw ->
            let
                parsedFile =
                    Elm.Processing.process Elm.Processing.init
                        raw

                exposedList =
                    Compiler.denode parsedFile.moduleDefinition
                        |> Elm.Syntax.Module.exposingList

                declarations =
                    List.map
                        (\dec ->
                            let
                                declar =
                                    Compiler.denode dec
                            in
                            ( Node.range dec
                                |> (.start >> .row)
                            , Compiler.Declaration
                                (determineExposure declar exposedList)
                                []
                                declar
                            )
                        )
                        parsedFile.declarations

                comments =
                    List.map
                        (\nodedComment ->
                            ( Node.range nodedComment
                                |> (.start >> .row)
                            , Compiler.Comment
                                (Compiler.denode nodedComment)
                            )
                        )
                        parsedFile.comments
            in
            Ok
                { declarations =
                    List.sortBy
                        Tuple.first
                        (declarations ++ comments)
                        |> List.map Tuple.second
                }


determineExposure : Declaration.Declaration -> Expose.Exposing -> Compiler.Expose
determineExposure dec exposedDec =
    case exposedDec of
        Expose.All _ ->
            Compiler.Exposed { group = Nothing, exposeConstructor = True }

        Expose.Explicit nodes ->
            case dec of
                Declaration.FunctionDeclaration myFn ->
                    case Compiler.denode myFn.declaration of
                        implementation ->
                            case Compiler.denode implementation.name of
                                name ->
                                    if List.any (valueIsExposed name) nodes then
                                        Compiler.Exposed { group = Nothing, exposeConstructor = False }

                                    else
                                        Compiler.NotExposed

                Declaration.AliasDeclaration typeAlias ->
                    case Compiler.denode typeAlias.name of
                        name ->
                            if List.any (typeIsExposed name) nodes then
                                Compiler.Exposed { group = Nothing, exposeConstructor = False }

                            else
                                Compiler.NotExposed

                Declaration.CustomTypeDeclaration type_ ->
                    case Compiler.denode type_.name of
                        name ->
                            if List.any (typeIsExposed name) nodes then
                                Compiler.Exposed { group = Nothing, exposeConstructor = False }

                            else if List.any (typeConstructorIsExposed name) nodes then
                                Compiler.Exposed { group = Nothing, exposeConstructor = True }

                            else
                                Compiler.NotExposed

                Declaration.PortDeclaration sig ->
                    Compiler.NotExposed

                Declaration.InfixDeclaration infixDec ->
                    Compiler.NotExposed

                Declaration.Destructuring pattern exp ->
                    Compiler.NotExposed


valueIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
valueIsExposed name node =
    case Compiler.denode node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose fnName ->
            fnName == name

        Expose.TypeOrAliasExpose _ ->
            False

        Expose.TypeExpose _ ->
            False


typeIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
typeIsExposed name node =
    case Compiler.denode node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose fnName ->
            False

        Expose.TypeOrAliasExpose typeName ->
            name == typeName

        Expose.TypeExpose _ ->
            False


typeConstructorIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
typeConstructorIsExposed name node =
    case Compiler.denode node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose fnName ->
            False

        Expose.TypeOrAliasExpose typeName ->
            name == typeName

        Expose.TypeExpose myType ->
            name == myType.name
