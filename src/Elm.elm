module Elm exposing
    ( File, file
    , Expression, toString
    , bool, int, float, char, string, hex, unit
    , maybe, just, nothing
    , list, tuple, triple
    , withType
    , record, get, updateRecord
    , ifThen
    , Declaration
    , comment, declaration
    , withDocumentation, group
    , expose, exposeConstructor
    , fileWith, docs
    , fnBuilder, fnArg, fnDone, body, Fn
    , fn, fn2, fn3, function, functionReduced
    , customType, customTypeWith, Variant, variant, variantWith
    , alias, aliasWith
    , portIncoming, portOutgoing
    , parse, unsafe
    , apply, val, value
    , unwrap, unwrapper
    )

{-|

@docs File, file


## Basics

@docs Expression, toString

@docs bool, int, float, char, string, hex, unit

@docs maybe, just, nothing

@docs list, tuple, triple

@docs withType


## Records

@docs record, get, updateRecord


## Flow control

@docs ifThen

**Note** If you need `let` or `case` expressions, check out the docs for [`Elm.Let`](./Elm-Let) or [`Elm.Case`](./Elm-Case)!


## Declarations

A `Declaration` is anything that is at the "top level" of your file, meaning all values with no indentation.

@docs Declaration

@docs comment, declaration

@docs withDocumentation, group

@docs expose, exposeConstructor

@docs fileWith, docs


## Functions

@docs fnBuilder, fnArg, fnDone, body, Fn

@docs fn, fn2, fn3, function, functionReduced


## Custom Types

@docs customType, customTypeWith, Variant, variant, variantWith

@docs alias, aliasWith


# Ports

@docs portIncoming, portOutgoing


# Parsing existing Elm

@docs parse, unsafe


# Low-level

@docs apply, val, value

@docs unwrap, unwrapper

-}

import Dict
import Elm.Annotation
import Elm.Arg
import Elm.Parser
import Elm.Processing
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.File
import Elm.Syntax.Module
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Arg
import Internal.Clean as Clean
import Internal.Compiler as Compiler
import Internal.Dependencies
import Internal.Format as Format
import Internal.Index as Index
import Internal.Render as Render
import Internal.Types
import Internal.Write
import Set


{-| -}
type alias Expression =
    Compiler.Expression


{-| -}
type Fn value
    = Fn
        (Index.Index
         ->
            { args : List Internal.Arg.ArgDetails
            , body : value
            , imports : List Compiler.Module
            }
        )


{-| -}
fnBuilder : value -> Fn value
fnBuilder innerValue =
    Fn
        (\_ ->
            { args = []
            , body = innerValue
            , imports = []
            }
        )


{-| -}
fnArg : Elm.Arg.Arg arg -> Fn (arg -> value) -> Fn value
fnArg argument (Fn toFnDetails) =
    Fn
        (\index ->
            let
                argDetails =
                    Internal.Arg.toDetails index argument

                fnDetails =
                    toFnDetails argDetails.index
            in
            { args = fnDetails.args ++ [ argDetails.details ]
            , body = fnDetails.body argDetails.value
            , imports = fnDetails.imports ++ argDetails.details.imports
            }
        )


{-| -}
fnDone : Fn Expression -> Expression
fnDone (Fn toFnDetails) =
    Compiler.Expression
        (\index ->
            let
                fnDetails =
                    toFnDetails index

                ( _, return ) =
                    Compiler.toExpressionDetails (Index.next index) fnDetails.body
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        List.map
                            .pattern
                            fnDetails.args
                    , expression =
                        Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err _ ->
                        return.annotation

                    Ok _ ->
                        List.foldr
                            (\argDetails result ->
                                case result of
                                    Err err ->
                                        Err err

                                    Ok resultAnnotation ->
                                        case argDetails.annotation of
                                            Err err ->
                                                Err err

                                            Ok argAnnotation ->
                                                Ok
                                                    { type_ =
                                                        Annotation.FunctionTypeAnnotation
                                                            (Compiler.nodify argAnnotation.type_)
                                                            (Compiler.nodify resultAnnotation.type_)
                                                    , inferences =
                                                        argAnnotation.inferences
                                                            |> Compiler.mergeInferences resultAnnotation.inferences
                                                    , aliases =
                                                        argAnnotation.aliases
                                                            |> Compiler.mergeAliases resultAnnotation.aliases
                                                    }
                            )
                            return.annotation
                            fnDetails.args
            , imports =
                fnDetails.imports ++ return.imports
            }
        )


{-| -}
body : (args -> Expression) -> Fn args -> Expression
body toBody (Fn toFnDetails) =
    Compiler.Expression
        (\index ->
            let
                fnDetails =
                    toFnDetails index
            in
            toBody fnDetails.body
                |> Compiler.toExpressionDetails index
                |> Tuple.second
        )


{-| See what code this expression would generate!

**Note** - Check out the `Elm.ToString` module if this doesn't quite meet your needs!

-}
toString : Expression -> String
toString (Compiler.Expression toExp) =
    let
        expresh : Compiler.ExpressionDetails
        expresh =
            toExp (Index.startIndex Nothing)
    in
    Internal.Write.writeExpression expresh.expression


{-| Build a file!

    Elm.file [ "My", "Module" ]
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

-}
file : List String -> List Declaration -> File
file mod decs =
    Render.render renderStandardComment
        { moduleName = mod
        , declarations = decs
        , aliases = []
        , index = Index.startIndex (Just mod)
        }


renderStandardComment :
    List
        { group : Maybe String
        , members : List String
        }
    -> List String
renderStandardComment groups =
    if List.isEmpty groups then
        []

    else
        List.map docs groups


{-| Render a standard docstring.

    @docs one, two, three

If a `group` has been given, it will be rendered as a second level header.

```markdown
## Group name

@docs one, two, three
```

-}
docs :
    { group : Maybe String
    , members : List String
    }
    -> String
docs groups =
    case groups.group of
        Nothing ->
            "@docs " ++ String.join ", " groups.members

        Just groupName ->
            "## " ++ groupName ++ "\n\n@docs " ++ String.join ", " groups.members


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@docs` comment.

Each exposed item is grouped based on the string used in [exposeWith](#exposeWith).

**aliases** allow you to specify a module alias to be used.

    Elm.fileWith [ "MyModule" ]
        { docs = List.map Elm.docs
        , aliases =
            [ ( [ "Json", "Encode" ], "Encode" )
            ]
        }
        [-- whatever declarations you desire.
        ]

would make an import statement like

    import Json.Encode as Encode

All values rendered in this file that are from this module would also automatically respect this alias as well.

-}
fileWith :
    List String
    ->
        { docs :
            List
                { group : Maybe String
                , members : List String
                }
            -> List String
        , aliases : List ( List String, String )
        }
    -> List Declaration
    -> File
fileWith mod options decs =
    Render.render options.docs
        { moduleName = mod
        , aliases = options.aliases
        , declarations = decs
        , index = Index.startChecked (Just mod) True
        }


{-| -}
type alias File =
    { path : String
    , contents : String
    , warnings :
        List
            { declaration : String
            , warning : String
            }
    }


{-| -}
val : String -> Expression
val name =
    value
        { importFrom = []
        , name = name
        , annotation = Nothing
        }


{-| -}
value :
    { importFrom : List String
    , name : String
    , annotation : Maybe Elm.Annotation.Annotation
    }
    -> Expression
value details =
    Compiler.Expression <|
        \index ->
            let
                importFrom =
                    Index.getImport index details.importFrom
            in
            { expression =
                -- This *must* be an un-protected name, where we only use
                -- literally what the dev gives us, because we are trying
                -- to refer to something that already exists.
                Exp.FunctionOrValue importFrom
                    (Format.sanitize details.name)
            , annotation =
                case details.annotation of
                    Nothing ->
                        let
                            typename : String
                            typename =
                                Index.protectTypeName details.name index
                        in
                        Ok
                            { type_ = Annotation.GenericType typename
                            , inferences = Dict.empty
                            , aliases = Compiler.emptyAliases
                            }

                    Just ann ->
                        Ok (Compiler.getInnerInference index ann)
            , imports =
                case details.annotation of
                    Nothing ->
                        case importFrom of
                            [] ->
                                []

                            _ ->
                                [ importFrom ]

                    Just ann ->
                        case importFrom of
                            [] ->
                                Compiler.getAnnotationImports ann

                            _ ->
                                importFrom :: Compiler.getAnnotationImports ann
            }


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value
        { importFrom = []
        , name = "myString"
        , annotation = Nothing
        }
        |> Elm.withType Type.string

Though be sure `elm-codegen` isn't already doing this automatically for you!

-}
withType : Elm.Annotation.Annotation -> Expression -> Expression
withType ((Compiler.Annotation annDetails) as ann) (Compiler.Expression toExp) =
    Compiler.Expression <|
        \index ->
            let
                exp : Compiler.ExpressionDetails
                exp =
                    toExp index
            in
            { exp
                | annotation =
                    case Compiler.unifyOn ann exp.annotation of
                        Ok unified ->
                            Ok unified

                        Err _ ->
                            case exp.annotation of
                                Ok expressionAnnotation ->
                                    Ok
                                        { type_ = annDetails.annotation
                                        , inferences = expressionAnnotation.inferences
                                        , aliases = expressionAnnotation.aliases
                                        }

                                Err _ ->
                                    Ok
                                        { type_ = annDetails.annotation
                                        , inferences = Dict.empty
                                        , aliases = Compiler.emptyAliases
                                        }
                , imports = exp.imports ++ annDetails.imports
            }


{-| Generate a lambda which unwraps a single-variant type.

    Elm.unwrapper [ "MyModule" ] "MyType"

Results in the following lambda

    \(MyModule.MyType val) -> val

-}
unwrapper : List String -> String -> Expression
unwrapper modName typename =
    Compiler.Expression <|
        \index ->
            let
                argVal : { name : String, typename : String, val : Compiler.Expression, index : Index.Index }
                argVal =
                    Compiler.toVar index "val"

                return : { name : String, typename : String, val : Compiler.Expression, index : Index.Index }
                return =
                    Compiler.toVar argVal.index "unwrapped"
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify
                            (Pattern.NamedPattern
                                { moduleName = modName
                                , name = typename
                                }
                                [ Pattern.VarPattern argVal.name
                                    |> Compiler.nodify
                                ]
                            )
                        ]
                    , expression =
                        Compiler.nodify
                            (Exp.FunctionOrValue []
                                argVal.name
                            )
                    }
            , annotation =
                Ok
                    { type_ =
                        Annotation.FunctionTypeAnnotation
                            (Compiler.nodify (Annotation.GenericType argVal.typename))
                            (Compiler.nodify (Annotation.GenericType return.typename))
                    , inferences = Dict.empty
                    , aliases = Compiler.emptyAliases
                    }
            , imports =
                case modName of
                    [] ->
                        []

                    _ ->
                        [ modName ]
            }


{-| Unwraps a single-variant type

    Elm.declaration "myFunction" <|
        Elm.fn "val"
            (\val ->
                Elm.unwrap "MyType" val
            )

Results in the following lambda

    myFunction val =
        (\(MyType val) -> val) val

-}
unwrap : List String -> String -> Expression -> Expression
unwrap modName typename exp =
    apply (unwrapper modName typename) [ exp ]


{-| -}
unit : Expression
unit =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.UnitExpr
            , annotation = Ok (Compiler.inference Annotation.Unit)
            , imports = []
            }


{-| -}
bool : Bool -> Expression
bool on =
    Compiler.Expression <|
        \_ ->
            { expression =
                Exp.FunctionOrValue []
                    (if on then
                        "True"

                     else
                        "False"
                    )
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.bool
                    , aliases = Compiler.emptyAliases
                    }
            , imports = []
            }


{-| -}
int : Int -> Expression
int intVal =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.Integer intVal
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.int
                    , aliases = Compiler.emptyAliases
                    }
            , imports = []
            }


{-| -}
hex : Int -> Expression
hex hexVal =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.Hex hexVal
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.int
                    , aliases = Compiler.emptyAliases
                    }
            , imports = []
            }


{-| -}
float : Float -> Expression
float floatVal =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.Floatable floatVal
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.float
                    , aliases = Compiler.emptyAliases
                    }
            , imports = []
            }


{-| -}
string : String -> Expression
string literal =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.Literal literal
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.string
                    , aliases = Compiler.emptyAliases
                    }
            , imports = []
            }


{-| -}
char : Char -> Expression
char charVal =
    Compiler.Expression <|
        \_ ->
            { expression = Exp.CharLiteral charVal
            , annotation =
                Ok
                    { inferences = Dict.empty
                    , type_ = Internal.Types.char
                    , aliases = Compiler.emptyAliases
                    }
            , imports = [ [ "Char" ] ]
            }



-- {-|
-- -}
-- glsl : String -> Expression
-- glsl expr =
--     Exp.GLSLExpression expr


{-| -}
tuple : Expression -> Expression -> Expression
tuple oneExp twoExp =
    Compiler.Expression <|
        \index ->
            let
                ( oneIndex, one ) =
                    Compiler.toExpressionDetails index oneExp

                ( _, two ) =
                    Compiler.toExpressionDetails oneIndex twoExp
            in
            { expression =
                Exp.TupledExpression
                    [ Compiler.nodify one.expression
                    , Compiler.nodify two.expression
                    ]
            , annotation =
                Result.map2
                    (\oneA twoA ->
                        { type_ =
                            Annotation.Tupled
                                [ Compiler.nodify oneA.type_
                                , Compiler.nodify twoA.type_
                                ]
                        , inferences =
                            oneA.inferences
                                |> Compiler.mergeInferences twoA.inferences
                        , aliases =
                            oneA.aliases
                                |> Compiler.mergeAliases twoA.aliases
                        }
                    )
                    one.annotation
                    two.annotation
            , imports = one.imports ++ two.imports
            }


{-| -}
triple : Expression -> Expression -> Expression -> Expression
triple oneExp twoExp threeExp =
    Compiler.Expression <|
        \index ->
            let
                ( oneIndex, one ) =
                    Compiler.toExpressionDetails index oneExp

                ( twoIndex, two ) =
                    Compiler.toExpressionDetails oneIndex twoExp

                ( _, three ) =
                    Compiler.toExpressionDetails twoIndex threeExp
            in
            { expression =
                Exp.TupledExpression
                    (Compiler.nodifyAll
                        [ one.expression, two.expression, three.expression ]
                    )
            , annotation =
                Result.map3
                    (\oneA twoA threeA ->
                        { type_ =
                            Elm.Annotation.triple
                                (Compiler.noImports oneA.type_)
                                (Compiler.noImports twoA.type_)
                                (Compiler.noImports threeA.type_)
                                |> Compiler.getInnerAnnotation
                        , inferences =
                            oneA.inferences
                                |> Compiler.mergeInferences twoA.inferences
                                |> Compiler.mergeInferences threeA.inferences
                        , aliases =
                            oneA.aliases
                                |> Compiler.mergeAliases twoA.aliases
                                |> Compiler.mergeAliases threeA.aliases
                        }
                    )
                    one.annotation
                    two.annotation
                    three.annotation
            , imports = one.imports ++ two.imports ++ three.imports
            }


{-| -}
just : Expression -> Expression
just content =
    maybe (Just content)


{-| -}
nothing : Expression
nothing =
    maybe Nothing


{-| -}
maybe : Maybe Expression -> Expression
maybe maybeContent =
    Compiler.Expression <|
        \index ->
            case maybeContent of
                Nothing ->
                    { expression =
                        Exp.FunctionOrValue []
                            "Nothing"
                    , annotation =
                        Ok
                            (Compiler.getInnerInference index
                                (Elm.Annotation.maybe (Elm.Annotation.var "a"))
                            )
                    , imports =
                        []
                    }

                Just contentExp ->
                    let
                        ( _, content ) =
                            Compiler.toExpressionDetails index contentExp
                    in
                    { expression =
                        Exp.Application
                            [ Exp.FunctionOrValue []
                                "Just"
                                |> Compiler.nodify
                            , Exp.ParenthesizedExpression
                                (Compiler.nodify content.expression)
                                |> Compiler.nodify
                            ]
                    , annotation =
                        Result.map
                            (\ann ->
                                { type_ =
                                    Annotation.Typed
                                        (Compiler.nodify ( [], "Maybe" ))
                                        [ Compiler.nodify ann.type_ ]
                                , inferences =
                                    ann.inferences
                                , aliases =
                                    ann.aliases
                                }
                            )
                            (Compiler.getAnnotation content)
                    , imports =
                        Compiler.getImports content
                    }


{-| -}
list : List Expression -> Expression
list exprs =
    Compiler.expression <|
        \index ->
            let
                exprDetails : List Compiler.ExpressionDetails
                exprDetails =
                    Compiler.thread index exprs
            in
            { expression = Exp.ListExpr (List.map (.expression >> Compiler.nodify) exprDetails)
            , annotation =
                Compiler.unify exprDetails
                    |> Result.map
                        (\inner ->
                            { type_ =
                                Annotation.Typed
                                    (Compiler.nodify ( [], "List" ))
                                    [ Compiler.nodify inner.type_ ]
                            , inferences =
                                inner.inferences
                            , aliases = inner.aliases
                            }
                        )
            , imports = List.concatMap Compiler.getImports exprDetails
            }


{-|

    myRecord
        |> updateRecord
            [ ( "designation", Elm.string "Pretty fabulous" )
            ]

Results in

    { myRecord | designation = "Pretty fabulous" }

-}
updateRecord : List ( String, Expression ) -> Expression -> Expression
updateRecord fields recordExpression =
    Compiler.expression <|
        \index ->
            let
                ( recordIndex, recordExp ) =
                    Compiler.toExpressionDetails index recordExpression

                ( fieldIndex, fieldAnnotationsGathered, fieldDetails ) =
                    fields
                        |> List.foldl
                            (\( fieldNameUnformatted, fieldExp ) ( currentIndex, fieldAnnotationResult, items ) ->
                                let
                                    fieldName : String
                                    fieldName =
                                        Format.formatValue fieldNameUnformatted

                                    ( newIndex, exp ) =
                                        Compiler.toExpressionDetails currentIndex fieldExp

                                    currentFieldAnnotations : Result (List Compiler.InferenceError) (List ( String, Compiler.Inference ))
                                    currentFieldAnnotations =
                                        case fieldAnnotationResult of
                                            Ok fieldAnns ->
                                                case exp.annotation of
                                                    Ok fs ->
                                                        Ok (( fieldName, fs ) :: fieldAnns)

                                                    Err newErr ->
                                                        Err newErr

                                            Err err ->
                                                case exp.annotation of
                                                    Ok _ ->
                                                        fieldAnnotationResult

                                                    Err newErr ->
                                                        Err (err ++ newErr)
                                in
                                ( newIndex
                                , currentFieldAnnotations
                                , ( fieldName, exp ) :: items
                                )
                            )
                            ( recordIndex, Ok [], [] )
            in
            { expression =
                case recordExp.expression of
                    Exp.FunctionOrValue _ name ->
                        fieldDetails
                            |> List.reverse
                            |> List.map
                                (\( fieldName, expDetails ) ->
                                    Compiler.nodify
                                        ( Compiler.nodify fieldName
                                        , Compiler.nodify expDetails.expression
                                        )
                                )
                            |> Exp.RecordUpdateExpression (Compiler.nodify name)

                    _ ->
                        let
                            name : String
                            name =
                                "record" ++ Index.indexToString fieldIndex
                        in
                        Exp.LetExpression
                            { declarations =
                                [ Compiler.nodify
                                    (Exp.LetDestructuring
                                        (Compiler.nodify
                                            (Pattern.VarPattern name)
                                        )
                                        (Compiler.nodify recordExp.expression)
                                    )
                                ]
                            , expression =
                                Compiler.nodify
                                    (fieldDetails
                                        |> List.map
                                            (\( fieldName, expDetails ) ->
                                                Compiler.nodify
                                                    ( Compiler.nodify fieldName
                                                    , Compiler.nodify expDetails.expression
                                                    )
                                            )
                                        |> Exp.RecordUpdateExpression (Compiler.nodify name)
                                    )
                            }
            , annotation =
                case fieldAnnotationsGathered of
                    Err fieldErrors ->
                        -- Add in existing errors
                        Err fieldErrors

                    Ok verifiedFieldAnnotations ->
                        case recordExp.annotation of
                            Ok recordAnn ->
                                case recordAnn.type_ of
                                    Annotation.Record existingFields ->
                                        -- must match all existing fields
                                        case verifyFields verifiedFieldAnnotations existingFields of
                                            Nothing ->
                                                recordExp.annotation

                                            Just err ->
                                                Err [ err ]

                                    Annotation.GenericType nameOfRecord ->
                                        -- We can attempt to infer that his is a record
                                        Ok
                                            { type_ = recordAnn.type_
                                            , aliases = recordAnn.aliases
                                            , inferences =
                                                recordAnn.inferences
                                                    |> Compiler.addInference
                                                        nameOfRecord
                                                        (Annotation.GenericRecord (Compiler.nodify nameOfRecord)
                                                            (Compiler.nodify
                                                                (List.map
                                                                    (\( fieldName, inference ) ->
                                                                        Compiler.nodify
                                                                            ( Compiler.nodify fieldName
                                                                            , Compiler.nodify inference.type_
                                                                            )
                                                                    )
                                                                    verifiedFieldAnnotations
                                                                )
                                                            )
                                                        )
                                            }

                                    _ ->
                                        recordExp.annotation

                            otherwise ->
                                otherwise
            , imports =
                List.concatMap
                    (Tuple.second >> Compiler.getImports)
                    fieldDetails
            }


{-|

    Elm.record
        [ ( "name", Elm.string "Elm" )
        , ( "designation", Elm.string "Pretty fabulous" )
        ]

-}
record : List ( String, Expression ) -> Expression
record fields =
    Compiler.expression <|
        \index ->
            let
                unified : { index : Index.Index, fields : List ( Node String, Node Exp.Expression ), passed : Set.Set String, errors : List Compiler.InferenceError, fieldAnnotations : List ( String, Compiler.Inference ), imports : List Compiler.Module }
                unified =
                    fields
                        |> List.foldl
                            (\( unformattedFieldName, fieldExpression ) found ->
                                let
                                    ( newIndex, exp ) =
                                        Compiler.toExpressionDetails found.index fieldExpression

                                    fieldName : String
                                    fieldName =
                                        Format.formatValue unformattedFieldName
                                in
                                { index = newIndex
                                , fields =
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
                                                found.errors

                                            Err errs ->
                                                errs ++ found.errors

                                            Ok _ ->
                                                found.errors
                                , fieldAnnotations =
                                    case exp.annotation of
                                        Err _ ->
                                            found.fieldAnnotations

                                        Ok ann ->
                                            ( Format.formatValue fieldName
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
                            , index = index
                            }
            in
            { expression =
                unified.fields
                    |> List.reverse
                    |> Compiler.nodifyAll
                    |> Exp.RecordExpr
            , annotation =
                case unified.errors of
                    [] ->
                        Ok
                            { type_ =
                                List.reverse unified.fieldAnnotations
                                    |> List.map
                                        (\( name, ann ) ->
                                            ( Compiler.nodify name
                                            , Compiler.nodify ann.type_
                                            )
                                        )
                                    |> Compiler.nodifyAll
                                    |> Annotation.Record
                            , inferences =
                                List.foldl
                                    (\( _, ann ) gathered ->
                                        Compiler.mergeInferences ann.inferences gathered
                                    )
                                    Dict.empty
                                    unified.fieldAnnotations
                            , aliases =
                                List.foldl
                                    (\( _, ann ) gathered ->
                                        Compiler.mergeAliases ann.aliases gathered
                                    )
                                    Compiler.emptyAliases
                                    unified.fieldAnnotations
                            }

                    errs ->
                        Err errs
            , imports =
                unified.imports
            }


{-|

    ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

Will generate

    if True then
        "yes"

    else
        "no"

If you need more than one branch, then chain them together!

     Elm.ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.ifThen (Elm.bool True)
            (Elm.string "maybe")
            (Elm.string "no")
        )

Will generate

    if True then
        "yes"

    else if True then
        "maybe"

    else
        "no"

-}
ifThen : Expression -> Expression -> Expression -> Expression
ifThen condition thenBranch elseBranch =
    Compiler.Expression <|
        \index ->
            let
                ( condIndex, cond ) =
                    Compiler.toExpressionDetails index condition

                ( thenIndex, thenB ) =
                    Compiler.toExpressionDetails condIndex thenBranch

                ( _, elseB ) =
                    Compiler.toExpressionDetails thenIndex elseBranch
            in
            { expression =
                Exp.IfBlock
                    (Compiler.nodify cond.expression)
                    (Compiler.nodify thenB.expression)
                    (Compiler.nodify elseB.expression)
            , annotation =
                thenB.annotation
            , imports = cond.imports ++ thenB.imports ++ elseB.imports
            }


{-|

    record
        |> Elm.get "field"

results in

    record.field

-}
get : String -> Expression -> Expression
get unformattedFieldName recordExpression =
    Compiler.Expression <|
        \index ->
            let
                fieldName : String
                fieldName =
                    Format.formatValue unformattedFieldName

                ( _, expr ) =
                    Compiler.toExpressionDetails index recordExpression
            in
            { expression =
                Exp.RecordAccess
                    (Compiler.nodify expr.expression)
                    (Compiler.nodify fieldName)
            , annotation =
                case expr.annotation of
                    Ok recordAnn ->
                        Compiler.resolveField index recordAnn.type_ recordAnn.aliases recordAnn.inferences fieldName

                    otherwise ->
                        otherwise
            , imports = expr.imports
            }


verifyFields :
    List ( String, Compiler.Inference )
    -> List (Node.Node Annotation.RecordField)
    -> Maybe Compiler.InferenceError
verifyFields updatedFields existingFields =
    if verifyFieldsHelper existingFields updatedFields then
        Nothing

    else
        Just
            (Compiler.RecordUpdateIncorrectFields
                { existingFields =
                    List.map
                        (\(Node.Node _ ( Node.Node _ fieldName, Node.Node _ fieldInference )) ->
                            ( fieldName, fieldInference )
                        )
                        existingFields
                , attemptingToUpdate =
                    List.map
                        (\( fieldName, fieldInference ) ->
                            ( fieldName, fieldInference.type_ )
                        )
                        updatedFields
                }
            )


verifyFieldsHelper :
    List (Node.Node Annotation.RecordField)
    -> List ( String, Compiler.Inference )
    -> Bool
verifyFieldsHelper existingFields updatedFields =
    case updatedFields of
        [] ->
            True

        ( fieldName, fieldInference ) :: remain ->
            presentAndMatching fieldName fieldInference existingFields
                && verifyFieldsHelper existingFields remain


presentAndMatching : String -> Compiler.Inference -> List (Node Annotation.RecordField) -> Bool
presentAndMatching fieldName _ existingFields =
    List.any
        (\(Node.Node _ ( Node.Node _ existingFieldName, _ )) ->
            fieldName == existingFieldName
        )
        existingFields


{-| A custom type declaration.

    Elm.customType "MyType"
        [ Elm.variant "One"
        , Elm.variantWith "Two"
            [ Elm.Annotation.list Elm.Annotation.string ]
        ]

Will result in

    type MyType
        = One
        | Two (List String)

-}
customType : String -> List Variant -> Declaration
customType name variants =
    customTypeWith name [] variants


{-| A custom type declaration, with the ability to specify in which order to put the type variables.

    Elm.customTypeWith "MyType"
        [ "addVar", "twoVar" ]
        [ Elm.variantWith "One"
            [ Elm.Annotation.var "oneVar" ]
        , Elm.variantWith "Two"
            [ Elm.Annotation.var "twoVar" ]
        ]

Will result in

    type MyType addVar twoVar oneVar
        = One oneVar
        | Two twoVar

Notice how nonexisting variables (as used in phantom types) are included, and missing variable are automatically added.

-}
customTypeWith : String -> List String -> List Variant -> Declaration
customTypeWith name generics variants =
    Compiler.Declaration
        { name = name
        , exposed = Compiler.NotExposed
        , imports =
            List.concatMap
                (\(Variant _ listAnn) ->
                    List.concatMap Compiler.getAnnotationImports listAnn
                )
                variants
        , docs = Nothing
        , toBody =
            \_ ->
                { warning = Nothing
                , additionalImports = []
                , declaration =
                    Declaration.CustomTypeDeclaration
                        { documentation = Nothing
                        , name = Compiler.nodify (Format.formatType name)
                        , generics =
                            getGenerics
                                { keepExtra = True
                                , requested = generics
                                , needed =
                                    List.concatMap
                                        (\(Variant _ listAnn) ->
                                            listAnn
                                                |> List.concatMap
                                                    Compiler.getGenerics
                                        )
                                        variants
                                }
                        , constructors =
                            List.map
                                (\(Variant varName vars) ->
                                    Compiler.nodify
                                        { name = Compiler.nodify (Format.formatType varName)
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
                }
        }


deduplicate : List comparable -> List comparable
deduplicate listToDeduplicate =
    List.foldl
        (\item (( set, innerList ) as untouched) ->
            if Set.member item set then
                untouched

            else
                ( Set.insert item set
                , item :: innerList
                )
        )
        ( Set.empty
        , []
        )
        listToDeduplicate
        |> Tuple.second
        |> List.reverse


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


{-| A type alias declaration.

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
    aliasWith name [] innerAnnotation


{-| A type alias declaration, with the ability to specify in which order to put the type variables.

    import Elm.Annotation as Type

    Elm.aliasWith "MyAlias" [ "twoVar", "nonexistingVar", "oneVar" ]
        (Type.record
            [ ( "one", Type.var "oneVar" )
            , ( "two", Type.var "twoVar" )
            , ( "three", Type.var "threeVar" )
            ]
        )

Should result in

    type alias MyAlias twoVar oneVar threeVar =
        { one : oneVar
        , two : twoVar
        , three : threeVar
        }

Notice how nonexisting variables are omitted, and missing variable are automatically added.

-}
aliasWith : String -> List String -> Elm.Annotation.Annotation -> Declaration
aliasWith name generics innerAnnotation =
    Compiler.Declaration
        { name = name
        , exposed = Compiler.NotExposed
        , imports =
            Compiler.getAnnotationImports innerAnnotation
        , docs = Nothing
        , toBody =
            \_ ->
                { warning = Nothing
                , additionalImports = []
                , declaration =
                    Declaration.AliasDeclaration
                        { documentation = Nothing
                        , name = Compiler.nodify (Format.formatType name)
                        , generics =
                            getGenerics
                                { keepExtra = False
                                , requested = generics
                                , needed = Compiler.getGenerics innerAnnotation
                                }
                        , typeAnnotation = Compiler.nodify (Compiler.getInnerAnnotation innerAnnotation)
                        }
                }
        }


getGenerics :
    { keepExtra : Bool
    , requested : List String
    , needed : List String
    }
    -> List (Node String)
getGenerics { keepExtra, requested, needed } =
    let
        requestedList : List String
        requestedList =
            if keepExtra then
                List.reverse <| deduplicate requested

            else
                List.foldl
                    (\generic acc ->
                        if List.member generic needed then
                            generic :: acc

                        else
                            acc
                    )
                    []
                    (deduplicate requested)
    in
    needed
        |> deduplicate
        |> List.foldl
            (\generic acc ->
                if List.member generic requestedList then
                    acc

                else
                    generic :: acc
            )
            requestedList
        |> List.reverse
        |> List.map Compiler.nodify


{-| -}
apply : Expression -> List Expression -> Expression
apply fnExp argExpressions =
    Compiler.expression
        (\index ->
            let
                ( annotationIndex, fnDetails ) =
                    Compiler.toExpressionDetails index fnExp

                args : List Compiler.ExpressionDetails
                args =
                    Compiler.thread annotationIndex argExpressions
            in
            { expression =
                Exp.Application
                    (Compiler.nodifyAll
                        (fnDetails.expression
                            :: List.map (Compiler.parens << .expression) args
                        )
                    )
            , annotation =
                Compiler.applyType index fnDetails.annotation args
            , imports = fnDetails.imports ++ List.concatMap Compiler.getImports args
            }
        )


{-| Create a function with a single argument.

This may seem a little weird the first time you encounter it, so let's break it down.

Here's what's happening for the `fn*` functions —

  - The `String` arguments are the **names of the arguments** for the generated function.
  - The attached `Maybe Annotation` is the type annotation. If you provide `Nothing`, then `elm-codegen` will infer the type for you!
  - The `(Expression -> Expression)` function is where we're providing you an `Expression` that represents an argument coming in to the generated function.

So, this

    Elm.fn ( "firstInt", Nothing )
        (\firstArgument ->
            Elm.Op.plus
                (Elm.int 42)
                firstArgument
        )

Generates

    \firstInt -> 42 + firstInt

If you want to generate a **top level** function instead of an anonymous function, use `Elm.declaration`.

    Elm.declaration "add42" <|
        Elm.fn ( "firstInt", Nothing )
            (\firstArgument ->
                Elm.Op.plus
                    (Elm.int 42)
                    firstArgument
            )

Results in

    add42 : Int -> Int
    add42 firstInt =
        42 + firstInt

**Note** — Elm CodeGen will protect variable names if they're used in a nested `fn*` by adding a string of numbers to the end of the name. So, you may see a variable name be something like `myVariable_0_1`.

If you absolutely don't want this behavior, you'll need to use [`functionAdvanced`](#functionAdvanced).

-}
fn : Elm.Arg.Arg arg -> (arg -> Expression) -> Expression
fn arg1 toExpression =
    fnBuilder toExpression
        |> fnArg arg1
        |> fnDone


{-| This is a special case of function declaration which will _reduce_ itself if possible.

Meaning, if this would generate the following code

    \myArg -> someOtherFunction myArg

Then it will replace itself with just

    someOtherFunction

**Note** you likely won't need this! It's generally used by the package-helper generator, but that might be a relatively special case.

-}
functionReduced : String -> (Expression -> Expression) -> Expression
functionReduced argBaseName toExpression =
    Compiler.expression <|
        \index ->
            let
                ( arg1Name, newIndex ) =
                    Index.getName argBaseName index

                argType : Elm.Annotation.Annotation
                argType =
                    Elm.Annotation.var arg1Name

                arg1 : Expression
                arg1 =
                    value
                        { importFrom = []
                        , name = arg1Name
                        , annotation = Just argType
                        }

                (Compiler.Expression toExpr) =
                    toExpression arg1

                return : Compiler.ExpressionDetails
                return =
                    toExpr newIndex
            in
            { expression =
                betaReduce <|
                    Exp.LambdaExpression
                        { args = [ Compiler.nodify (Pattern.VarPattern arg1Name) ]
                        , expression = Compiler.nodify return.expression
                        }
            , annotation =
                case return.annotation of
                    Err _ ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify (Annotation.GenericType arg1Name))
                                    (Compiler.nodify
                                        returnAnnotation.type_
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }



-- -- If the list is nonempty, returns a tuple with the beginning of the list and the last element (denoded).


popLastAndDenodeLast : List (Node.Node a) -> Maybe ( List (Node.Node a), a )
popLastAndDenodeLast lst =
    case List.reverse lst of
        [] ->
            Nothing

        (Node _ last) :: initReverse ->
            Just ( List.reverse initReverse, last )


betaReduce : Exp.Expression -> Exp.Expression
betaReduce e =
    let
        extractLastArg : Exp.Expression -> Maybe String
        extractLastArg argExpression =
            case argExpression of
                Exp.FunctionOrValue [] n ->
                    Just n

                Exp.ParenthesizedExpression (Node _ p) ->
                    extractLastArg p

                _ ->
                    Nothing
    in
    case e of
        Exp.LambdaExpression { args, expression } ->
            case popLastAndDenodeLast args of
                Just ( initLambdaArgs, Pattern.VarPattern lastLambdaArg ) ->
                    case Compiler.denode expression of
                        Exp.RecordAccess (Node _ argVal) (Node.Node _ fieldName) ->
                            case argVal of
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
                                                [ Node _ s ] ->
                                                    betaReduce s

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
fn2 :
    Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> (one -> two -> Expression)
    -> Expression
fn2 arg1 arg2 toExpression =
    fnBuilder toExpression
        |> fnArg arg1
        |> fnArg arg2
        |> fnDone


{-| -}
fn3 :
    Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> (one -> two -> three -> Expression)
    -> Expression
fn3 arg1 arg2 arg3 toExpression =
    fnBuilder toExpression
        |> fnArg arg1
        |> fnArg arg2
        |> fnArg arg3
        |> fnDone


{-| -}
type alias Declaration =
    Compiler.Declaration


{-| Renders a multiline comment.

    Elm.comment """Here is my comment!"""

Will generate



    {- Here is my comment! -}

-}
comment : String -> Declaration
comment content =
    Compiler.Comment ("{- " ++ content ++ " -}")


renderError : List Compiler.InferenceError -> String
renderError err =
    case err of
        [] ->
            ""

        _ ->
            err
                |> List.map Compiler.inferenceErrorToString
                |> String.join "\n\n"


{-| -}
declaration : String -> Expression -> Declaration
declaration nameStr (Compiler.Expression toBody) =
    let
        name : String
        name =
            Format.formatDeclarationName nameStr
    in
    Compiler.Declaration
        { name = name
        , exposed = Compiler.NotExposed
        , imports =
            []
        , docs = Nothing
        , toBody =
            \index ->
                let
                    declBody : Compiler.ExpressionDetails
                    declBody =
                        toBody index

                    resolvedType : Result String Annotation.TypeAnnotation
                    resolvedType =
                        declBody.annotation
                            |> Result.mapError renderError
                            |> Result.andThen
                                (\sig -> Compiler.resolve index sig.inferences sig.type_)

                    maybeWarning : Maybe { declaration : String, warning : String }
                    maybeWarning =
                        case resolvedType of
                            Ok _ ->
                                case declBody.annotation of
                                    Ok _ ->
                                        Nothing

                                    Err [] ->
                                        Nothing

                                    Err err ->
                                        Just
                                            { declaration = name
                                            , warning = renderError err
                                            }

                            Err "" ->
                                Nothing

                            Err err ->
                                Just
                                    { declaration = name
                                    , warning = err
                                    }
                in
                { warning = maybeWarning
                , additionalImports = declBody.imports
                , declaration =
                    Declaration.FunctionDeclaration
                        { documentation =
                            Nothing
                        , signature =
                            case ( declBody.annotation, resolvedType ) of
                                ( Ok _, Ok (Annotation.GenericType _) ) ->
                                    -- Top level values can't be lonely generic types.
                                    Nothing

                                ( Ok _, Ok finalType ) ->
                                    Just
                                        (Compiler.nodify
                                            { name = Compiler.nodify name
                                            , typeAnnotation =
                                                Compiler.nodify (Clean.clean index finalType)
                                            }
                                        )

                                _ ->
                                    Nothing
                        , declaration =
                            case declBody.expression of
                                Exp.LambdaExpression lam ->
                                    Compiler.nodify
                                        { name = Compiler.nodify name
                                        , arguments = lam.args
                                        , expression = lam.expression
                                        }

                                _ ->
                                    Compiler.nodify
                                        { name = Compiler.nodify name
                                        , arguments = []
                                        , expression = Compiler.nodify declBody.expression
                                        }
                        }
                }
        }


{-| For when you want the most control over a function being generated.

This is for when:

1.  You want your variable names to be exactly as provided
    (i.e. you don't want the variable name collision protection)
2.  You know exactly what type each variable should be.

-}
functionAdvanced : List ( String, Elm.Annotation.Annotation ) -> Expression -> Expression
functionAdvanced args fullExpression =
    case args of
        [] ->
            fullExpression

        _ ->
            Compiler.expression <|
                \index ->
                    let
                        expr : Compiler.ExpressionDetails
                        expr =
                            case fullExpression of
                                Compiler.Expression toExpr ->
                                    toExpr index
                    in
                    { expression =
                        Exp.LambdaExpression
                            { args =
                                List.map
                                    (\( name, _ ) -> Compiler.nodify (Pattern.VarPattern name))
                                    args
                            , expression = Compiler.nodify expr.expression
                            }
                    , annotation =
                        case expr.annotation of
                            Err err ->
                                Err err

                            Ok return ->
                                Ok
                                    { type_ =
                                        List.foldr
                                            (\( _, Compiler.Annotation ann ) fnbody ->
                                                Annotation.FunctionTypeAnnotation
                                                    (Compiler.nodify ann.annotation)
                                                    (Compiler.nodify fnbody)
                                            )
                                            return.type_
                                            args
                                    , inferences = return.inferences
                                    , aliases =
                                        List.foldl
                                            (\( _, ann ) gathered ->
                                                Compiler.mergeAliases (Compiler.getAliases ann) gathered
                                            )
                                            return.aliases
                                            args
                                    }
                    , imports = expr.imports
                    }


{-| You may run into situations where you don't know the number of arguments for a function at compile-time.

In that case you can use `function`. It follows the same pattern as the `fn*` functions.

Provide it with —

  - A list of argument names and an optional type
  - A function which will be given all the input arguments as `Expression`s.

-}
function : List ( String, Maybe Elm.Annotation.Annotation ) -> (List Expression -> Expression) -> Expression
function initialArgList toFullExpression =
    case initialArgList of
        [] ->
            toFullExpression []

        _ ->
            Compiler.expression <|
                \index ->
                    let
                        args : { index : Index.Index, args : List Expression, names : List String, types : List Annotation.TypeAnnotation }
                        args =
                            List.foldl
                                (\( nameBase, maybeType ) found ->
                                    let
                                        ( name, newIndex ) =
                                            Index.getName nameBase found.index

                                        argType : Compiler.Annotation
                                        argType =
                                            Maybe.withDefault
                                                (Compiler.Annotation
                                                    { imports = []
                                                    , aliases = Compiler.emptyAliases
                                                    , annotation =
                                                        Annotation.GenericType
                                                            (Index.protectTypeName
                                                                nameBase
                                                                found.index
                                                            )
                                                    }
                                                )
                                                maybeType

                                        argExpression : Expression
                                        argExpression =
                                            value
                                                { importFrom = []
                                                , name = name
                                                , annotation = Just argType
                                                }
                                    in
                                    { index = newIndex
                                    , args = argExpression :: found.args
                                    , names = name :: found.names
                                    , types = Compiler.getInnerAnnotation argType :: found.types
                                    }
                                )
                                { args = []
                                , index = index
                                , names = []
                                , types = []
                                }
                                initialArgList

                        fullExpression : Expression
                        fullExpression =
                            toFullExpression (List.reverse args.args)

                        expr : Compiler.ExpressionDetails
                        expr =
                            case fullExpression of
                                Compiler.Expression toExpr ->
                                    toExpr index
                    in
                    { expression =
                        Exp.LambdaExpression
                            { args =
                                -- doing this to reverse things while building the patternlist
                                List.foldl
                                    (\n names -> Compiler.nodify (Pattern.VarPattern n) :: names)
                                    []
                                    args.names
                            , expression = Compiler.nodify expr.expression
                            }
                    , annotation =
                        case expr.annotation of
                            Err err ->
                                Err err

                            Ok return ->
                                -- args.types is already backwards, so this should work out ok
                                { type_ =
                                    List.foldl
                                        (\ann fnbody ->
                                            Annotation.FunctionTypeAnnotation
                                                (Compiler.nodify ann)
                                                (Compiler.nodify fnbody)
                                        )
                                        return.type_
                                        args.types
                                , inferences = return.inferences
                                , aliases =
                                    List.foldl
                                        (\( _, maybeAnn ) aliases ->
                                            case maybeAnn of
                                                Nothing ->
                                                    aliases

                                                Just ann ->
                                                    aliases
                                                        |> Compiler.mergeAliases
                                                            (Compiler.getAliases ann)
                                        )
                                        return.aliases
                                        initialArgList
                                }
                                    |> Ok
                    , imports = expr.imports
                    }


{-| Add a documentation comment to a declaration!
-}
withDocumentation : String -> Declaration -> Declaration
withDocumentation =
    Compiler.documentation


{-| By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

-}
expose : Declaration -> Declaration
expose =
    Compiler.expose


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor =
    Compiler.exposeWith { exposeConstructor = True, group = Nothing }


{-| -}
group : { title : String, docs : String } -> List Declaration -> Declaration
group options decls =
    Compiler.Group
        { title = options.title
        , docs = options.docs
        , decls = decls
        }


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

**Another note** - You may need to expose your port explicitly using [`Elm.expose`](#expose).

-}
portIncoming : String -> List Elm.Annotation.Annotation -> Declaration
portIncoming nameStr args =
    let
        name : String
        name =
            Format.formatDeclarationName nameStr
    in
    Compiler.Declaration
        { name = name
        , exposed = Compiler.NotExposed
        , imports =
            List.concatMap Compiler.getAnnotationImports args
        , docs = Nothing
        , toBody =
            \_ ->
                { warning = Nothing
                , additionalImports = []
                , declaration =
                    Declaration.PortDeclaration
                        { name = Compiler.nodify name
                        , typeAnnotation =
                            Compiler.nodify
                                (case args of
                                    [] ->
                                        Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify (Annotation.GenericType "msg"))
                                            (Compiler.nodify sub)

                                    _ :: _ ->
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
                }
        }


groupAnn : Node Annotation.TypeAnnotation -> Node Annotation.TypeAnnotation
groupAnn ann =
    Annotation.Tupled
        [ ann ]
        |> Compiler.nodify


sub : Annotation.TypeAnnotation
sub =
    Annotation.Typed
        (Compiler.nodify ( [], "Sub" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : String -> Elm.Annotation.Annotation -> Declaration
portOutgoing nameStr ann =
    let
        name : String
        name =
            Format.formatDeclarationName nameStr
    in
    Compiler.Declaration
        { name = name
        , exposed = Compiler.NotExposed
        , imports =
            Compiler.getAnnotationImports ann
        , docs = Nothing
        , toBody =
            \_ ->
                { warning = Nothing
                , additionalImports = []
                , declaration =
                    Declaration.PortDeclaration
                        { name = Compiler.nodify name
                        , typeAnnotation =
                            Compiler.nodify
                                (Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify (Compiler.getInnerAnnotation ann))
                                    (Compiler.nodify cmd)
                                )
                        }
                }
        }


cmd : Annotation.TypeAnnotation
cmd =
    Annotation.Typed
        (Compiler.nodify ( [], "Cmd" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]


{-| This will insert the given string into your generated file.

Check out the [using packages/helpers guide](https://github.com/mdgriffith/elm-codegen/tree/main/guide/UsingHelpers.md). If you're reaching for this, it's likely you'd be better off using a local helper file!

-}
unsafe : String -> Declaration
unsafe source =
    Compiler.Block (String.trim source)


{-| -}
parse : String -> Result String { declarations : List Declaration }
parse source =
    case Elm.Parser.parse source of
        Err _ ->
            Err "Uh oh"

        Ok raw ->
            let
                parsedFile : Elm.Syntax.File.File
                parsedFile =
                    Elm.Processing.process elmProcessContext
                        raw

                exposedList : Expose.Exposing
                exposedList =
                    Compiler.denode parsedFile.moduleDefinition
                        |> Elm.Syntax.Module.exposingList

                declarations : List ( Int, Compiler.Declaration )
                declarations =
                    List.map
                        (\(Node range declar) ->
                            ( range.start.row
                            , Compiler.Declaration
                                { name = Maybe.withDefault "parsed" (decName declar)
                                , exposed = determineExposure declar exposedList
                                , imports =
                                    []
                                , docs = Nothing
                                , toBody =
                                    \_ ->
                                        { warning = Nothing
                                        , additionalImports = []
                                        , declaration =
                                            declar
                                        }
                                }
                            )
                        )
                        parsedFile.declarations

                comments : List ( Int, Compiler.Declaration )
                comments =
                    List.map
                        (\(Node range nodedComment) ->
                            ( range.start.row
                            , Compiler.Comment nodedComment
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


decName : Declaration.Declaration -> Maybe String
decName decBody =
    case decBody of
        Declaration.FunctionDeclaration func ->
            Compiler.denode (.name (Compiler.denode func.declaration))
                |> Just

        Declaration.AliasDeclaration synonym ->
            Compiler.denode synonym.name
                |> Just

        Declaration.CustomTypeDeclaration myType ->
            Compiler.denode myType.name
                |> Just

        Declaration.PortDeclaration myPort ->
            Compiler.denode myPort.name
                |> Just

        Declaration.InfixDeclaration _ ->
            Nothing

        Declaration.Destructuring _ _ ->
            Nothing


elmProcessContext : Elm.Processing.ProcessContext
elmProcessContext =
    Elm.Processing.init
        |> Elm.Processing.addDependency Internal.Dependencies.elmCore
        |> Elm.Processing.addDependency Internal.Dependencies.elmUrl
        |> Elm.Processing.addDependency Internal.Dependencies.elmParser


determineExposure : Declaration.Declaration -> Expose.Exposing -> Compiler.Expose
determineExposure dec exposedDec =
    case exposedDec of
        Expose.All _ ->
            Compiler.Exposed { group = Nothing, exposeConstructor = True }

        Expose.Explicit nodes ->
            case dec of
                Declaration.FunctionDeclaration myFn ->
                    let
                        implementation : Exp.FunctionImplementation
                        implementation =
                            Compiler.denode myFn.declaration

                        name : String
                        name =
                            Compiler.denode implementation.name
                    in
                    if List.any (valueIsExposed name) nodes then
                        Compiler.Exposed { group = Nothing, exposeConstructor = False }

                    else
                        Compiler.NotExposed

                Declaration.AliasDeclaration typeAlias ->
                    let
                        name : String
                        name =
                            Compiler.denode typeAlias.name
                    in
                    if List.any (typeIsExposed name) nodes then
                        Compiler.Exposed { group = Nothing, exposeConstructor = False }

                    else
                        Compiler.NotExposed

                Declaration.CustomTypeDeclaration type_ ->
                    let
                        name : String
                        name =
                            Compiler.denode type_.name
                    in
                    if List.any (typeIsExposed name) nodes then
                        Compiler.Exposed { group = Nothing, exposeConstructor = False }

                    else if List.any (typeConstructorIsExposed name) nodes then
                        Compiler.Exposed { group = Nothing, exposeConstructor = True }

                    else
                        Compiler.NotExposed

                Declaration.PortDeclaration _ ->
                    Compiler.NotExposed

                Declaration.InfixDeclaration _ ->
                    Compiler.NotExposed

                Declaration.Destructuring _ _ ->
                    Compiler.NotExposed


valueIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
valueIsExposed name (Node _ node) =
    case node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose fnName ->
            fnName == name

        Expose.TypeOrAliasExpose _ ->
            False

        Expose.TypeExpose _ ->
            False


typeIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
typeIsExposed name (Node _ node) =
    case node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose _ ->
            False

        Expose.TypeOrAliasExpose typeName ->
            name == typeName

        Expose.TypeExpose _ ->
            False


typeConstructorIsExposed : String -> Node.Node Expose.TopLevelExpose -> Bool
typeConstructorIsExposed name (Node _ node) =
    case node of
        Expose.InfixExpose _ ->
            False

        Expose.FunctionExpose _ ->
            False

        Expose.TypeOrAliasExpose typeName ->
            name == typeName

        Expose.TypeExpose myType ->
            name == myType.name
