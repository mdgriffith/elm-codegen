module Elm exposing
    ( File, file
    , Expression, toString
    , bool, int, float, char, string, hex, unit
    , maybe, just, nothing
    , list, tuple, triple
    , withType
    , record, get, updateRecord
    , letIn, ifThen
    , Declaration
    , comment, declaration
    , withDocumentation
    , expose, exposeWith
    , fileWith, docs
    , fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced
    , customType, Variant, variant, variantWith
    , alias
    , portIncoming, portOutgoing
    , parse, unsafe
    , apply, value
    , unwrap, unwrapper
    , facts
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

@docs letIn, ifThen


## Top level

@docs Declaration

@docs comment, declaration

@docs withDocumentation

@docs expose, exposeWith

@docs fileWith, docs


## Functions

@docs fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced


## Custom Types

@docs customType, Variant, variant, variantWith

@docs alias


# Ports

@docs portIncoming, portOutgoing


# Parsing existing Elm

@docs parse, unsafe


# Low-level

@docs apply, value

@docs unwrap, unwrapper

-}

import Dict
import Elm.Annotation
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
import Internal.Debug
import Internal.Types
import Internal.Write
import Set


{-| -}
type alias Expression =
    Compiler.Expression


{-| See what code this expression would generate!

**Note** - Check out the `Elm.ToString` module if this doesn't quite meet your needs!

-}
toString : Expression -> String
toString (Compiler.Expression toExp) =
    let
        expresh =
            toExp Compiler.startIndex
    in
    Internal.Write.writeExpression expresh.expression


{-| -}
facts : Expression -> Result String (List ( String, String ))
facts (Compiler.Expression exp) =
    let
        expresh =
            exp Compiler.startIndex
    in
    case expresh.annotation of
        Ok sig ->
            sig.inferences
                |> Dict.toList
                |> List.map
                    (\( key, type_ ) ->
                        ( key, Internal.Write.writeAnnotation type_ )
                    )
                |> Ok

        Err inferenceError ->
            List.foldl
                (\err str ->
                    case str of
                        "" ->
                            Compiler.inferenceErrorToString err

                        _ ->
                            str ++ "\n\n" ++ Compiler.inferenceErrorToString err
                )
                ""
                inferenceError
                |> Err


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
docs group =
    case group.group of
        Nothing ->
            "@docs " ++ String.join ", " group.members

        Just groupName ->
            "## " ++ groupName ++ "\n\n@docs " ++ String.join ", " group.members


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@doc` comment.

Each exposed item is grouped based on the string used in [exposeWith](#exposeWith).

**aliases** allow you to specify a module alias to be used.

    aliases =
        [ (["Json", "Encode"), "Encode")
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
     -> List String
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
                                (case exposedGroups of
                                    [] ->
                                        ""

                                    _ ->
                                        "\n"
                                            ++ (toDocComment exposedGroups
                                                    |> String.join "\n\n"
                                               )
                                )
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


type alias FileDetails =
    { moduleDefinition : Module
    , imports : List Module
    , aliases : List ( Module, String )
    , body : List Declaration
    , moduleComment : String
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
            { expression =
                -- This *must* be an un-protected name, where we only use
                -- literally what the dev gives us, because we are trying
                -- to refer to something that already exists.
                Exp.FunctionOrValue details.importFrom
                    (Compiler.sanitize details.name)
            , annotation =
                case details.annotation of
                    Nothing ->
                        let
                            typename =
                                Compiler.protectTypeName details.name index
                        in
                        Ok
                            { type_ =
                                Annotation.GenericType
                                    typename
                            , inferences = Dict.empty
                            , aliases = Compiler.emptyAliases
                            }

                    Just ann ->
                        Ok (Compiler.getInnerInference index ann)
            , imports =
                case details.annotation of
                    Nothing ->
                        case details.importFrom of
                            [] ->
                                []

                            _ ->
                                [ details.importFrom ]

                    Just ann ->
                        case details.importFrom of
                            [] ->
                                Compiler.getAnnotationImports ann

                            _ ->
                                details.importFrom :: Compiler.getAnnotationImports ann
            }


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType Type.string

Though be sure `elm-codegen` isn't already doing this automatically for you!

-}
withType : Elm.Annotation.Annotation -> Expression -> Expression
withType ann (Compiler.Expression toExp) =
    Compiler.Expression <|
        \index ->
            let
                exp =
                    toExp index
            in
            { exp
                | annotation =
                    Compiler.unifyOn ann exp.annotation
                , imports = exp.imports ++ Compiler.getAnnotationImports ann
            }


{-| Generate a lambda which unwraps a single-variant type.

    Elm.unwrapper [ "MyModule" ] "MyType"

Results in the following lambda

    \(MyModule.MyType val) -> val

**Note** This needs to be a type with only a single variant

-}
unwrapper : List String -> String -> Expression
unwrapper modName typename =
    Compiler.Expression <|
        \index ->
            let
                arg =
                    Compiler.toVar index "val"

                return =
                    Compiler.toVar arg.index "unwrapped"
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify
                            (Pattern.NamedPattern
                                { moduleName = modName
                                , name = typename
                                }
                                [ Pattern.VarPattern arg.name
                                    |> Compiler.nodify
                                ]
                            )
                        ]
                    , expression =
                        Compiler.nodify
                            (Exp.FunctionOrValue []
                                arg.name
                            )
                    }
            , annotation =
                Ok
                    { type_ =
                        Annotation.FunctionTypeAnnotation
                            (Compiler.nodify (Annotation.GenericType arg.typename))
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
            (\\val ->
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

                ( twoIndex, two ) =
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

                ( threeIndex, three ) =
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
    Compiler.Expression <|
        \sourceIndex ->
            let
                index =
                    Compiler.dive sourceIndex

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


{-| -}
updateRecord : Expression -> List ( String, Expression ) -> Expression
updateRecord recordExpression fields =
    Compiler.Expression <|
        \index ->
            let
                ( recordIndex, recordExp ) =
                    Compiler.toExpressionDetails (Compiler.dive index) recordExpression

                ( fieldIndex, fieldAnnotationsGathered, fieldDetails ) =
                    fields
                        |> List.foldl
                            (\( fieldNameUnformatted, fieldExp ) ( currentIndex, fieldAnnotationResult, items ) ->
                                let
                                    fieldName =
                                        Compiler.formatValue fieldNameUnformatted

                                    ( newIndex, exp ) =
                                        Compiler.toExpressionDetails currentIndex fieldExp

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
                            name =
                                "record" ++ Compiler.indexToString fieldIndex
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

                                    otherwise ->
                                        recordExp.annotation

                            otherwise ->
                                otherwise
            , imports =
                List.concatMap
                    (Tuple.second >> Compiler.getImports)
                    fieldDetails
            }


{-| -}
field : String -> Expression -> ( String, Expression )
field =
    Tuple.pair


{-|

    Elm.record
        [ ( "name", Elm.string "Elm" )
        , ( "designation", Elm.string "Pretty fabulous" )
        ]

-}
record : List ( String, Expression ) -> Expression
record fields =
    Compiler.Expression <|
        \sourceIndex ->
            let
                unified =
                    fields
                        |> List.foldl
                            (\( unformattedFieldName, fieldExpression ) found ->
                                let
                                    ( newIndex, exp ) =
                                        Compiler.toExpressionDetails found.index fieldExpression

                                    fieldName =
                                        Compiler.formatValue unformattedFieldName
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
                            , index = Compiler.dive sourceIndex
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
                                    (\( name, ann ) gathered ->
                                        Compiler.mergeInferences ann.inferences gathered
                                    )
                                    Dict.empty
                                    unified.fieldAnnotations
                            , aliases =
                                List.foldl
                                    (\( name, ann ) gathered ->
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


{-| A let block.

    import Elm


    Elm.letIn
        [ ("one", (Elm.int 5))
        , ("two", (Elm.int 10))
        ]
        (Elm.add (Elm.value "one") (Elm.value "two"))

-}
letIn : List ( String, Expression ) -> Expression -> Expression
letIn decls resultExpr =
    Compiler.Expression <|
        \index ->
            let
                ( firstIndex, within ) =
                    Compiler.toExpressionDetails index resultExpr

                gathered =
                    List.foldr
                        (\( name, body ) accum ->
                            let
                                ( new, newExpr ) =
                                    Compiler.toExpressionDetails accum.index body
                            in
                            { index = new
                            , declarations =
                                Compiler.nodify
                                    (Exp.LetDestructuring
                                        (Compiler.nodify
                                            (Pattern.VarPattern name)
                                        )
                                        (Compiler.nodify newExpr.expression)
                                    )
                                    :: accum.declarations
                            , imports = accum.imports ++ newExpr.imports
                            }
                        )
                        { index = firstIndex
                        , declarations = []
                        , imports = []
                        }
                        decls
            in
            { expression =
                Exp.LetExpression
                    { declarations = gathered.declarations
                    , expression = Compiler.nodify within.expression
                    }
            , imports = gathered.imports
            , annotation =
                within.annotation
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

                ( finalIndex, elseB ) =
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
                fieldName =
                    Compiler.formatValue unformattedFieldName

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
            if presentAndMatching fieldName fieldInference existingFields then
                verifyFieldsHelper existingFields remain

            else
                False


presentAndMatching fieldName fieldInference existingFields =
    List.foldl
        (\(Node.Node _ ( Node.Node _ existingFieldName, Node.Node _ existingFieldType )) gathered ->
            if gathered then
                gathered

            else if fieldName == existingFieldName then
                True

            else
                False
        )
        False
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


{-| -}
apply : Expression -> List Expression -> Expression
apply fnExp argExpressions =
    Compiler.Expression
        (\index ->
            let
                ( annotationIndex, fnDetails ) =
                    Compiler.toExpressionDetails index fnExp

                nextIndex =
                    Compiler.dive annotationIndex

                args =
                    Compiler.thread nextIndex argExpressions
            in
            { expression =
                Exp.Application
                    (Compiler.nodifyAll
                        (fnDetails.expression
                            :: List.map (Compiler.parens << .expression) args
                        )
                    )
            , annotation =
                Compiler.applyType fnDetails.annotation args
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
            Elm.plus
                (Elm.int 42)
                firstArgument
        )

Generates

    \firstInt -> 42 + firstInt

If you want to generate a **top level** function instead of an anonymous function, use `Elm.declaration`.

    Elm.declaration "add42" <|
        Elm.fn ( "firstInt", Nothing )
            (\firstArgument ->
                Elm.plus
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
fn : ( String, Maybe Elm.Annotation.Annotation ) -> (Expression -> Expression) -> Expression
fn ( oneBaseName, maybeAnnotation ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                one =
                    Compiler.toVarMaybeType index oneBaseName maybeAnnotation

                (Compiler.Expression toExpr) =
                    toExpression one.val

                return =
                    toExpr (Compiler.dive one.index)
            in
            { expression =
                Exp.LambdaExpression
                    { args = [ Compiler.nodify (Pattern.VarPattern one.name) ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        returnAnnotation.type_
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| This is a special case of function declaration which will _reduce_ itself if possible.

Meaning, if this would generate the following code

    \myArg -> someOtherFunction myArg

Then it will replace itself with just

    someOtherFunction

**Note** you likely won't need this! It's generally used by the package-helper generator, but that might be a relatively special case.

-}
functionReduced : String -> (Expression -> Expression) -> Expression
functionReduced argBaseName toExpression =
    Compiler.Expression <|
        \index ->
            let
                childIndex =
                    Compiler.dive index

                ( arg1Name, newIndex ) =
                    Compiler.getName argBaseName childIndex

                argType =
                    Elm.Annotation.var arg1Name

                arg1 =
                    value
                        { importFrom = []
                        , name = arg1Name
                        , annotation = Just argType
                        }

                (Compiler.Expression toExpr) =
                    toExpression arg1

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
                    Err err ->
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
fn2 :
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression)
    -> Expression
fn2 ( oneBaseName, maybeOneType ) ( twoBaseName, maybeTwoType ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                childIndex =
                    index

                one =
                    Compiler.toVarMaybeType childIndex oneBaseName maybeOneType

                two =
                    Compiler.toVarMaybeType one.index twoBaseName maybeTwoType

                ( newIndex_, return ) =
                    Compiler.toExpressionDetails (Compiler.dive two.index) (toExpression one.val two.val)
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify (Pattern.VarPattern one.name)
                        , Compiler.nodify (Pattern.VarPattern two.name)
                        ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        (Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify two.type_)
                                            (Compiler.nodify
                                                returnAnnotation.type_
                                            )
                                        )
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| -}
fn3 :
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression)
    -> Expression
fn3 ( oneBaseName, maybeOneType ) ( twoBaseName, maybeTwoType ) ( threeBaseName, maybeThreeType ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                one =
                    Compiler.toVarMaybeType index oneBaseName maybeOneType

                two =
                    Compiler.toVarMaybeType one.index twoBaseName maybeTwoType

                three =
                    Compiler.toVarMaybeType two.index threeBaseName maybeThreeType

                ( newIndex, return ) =
                    Compiler.toExpressionDetails (Compiler.dive three.index) (toExpression one.val two.val three.val)
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify (Pattern.VarPattern one.name)
                        , Compiler.nodify (Pattern.VarPattern two.name)
                        , Compiler.nodify (Pattern.VarPattern three.name)
                        ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        (Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify two.type_)
                                            (Compiler.nodify
                                                (Annotation.FunctionTypeAnnotation
                                                    (Compiler.nodify three.type_)
                                                    (Compiler.nodify
                                                        returnAnnotation.type_
                                                    )
                                                )
                                            )
                                        )
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| -}
fn4 :
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
fn4 ( oneBaseName, maybeOneType ) ( twoBaseName, maybeTwoType ) ( threeBaseName, maybeThreeType ) ( fourBaseName, maybeFourType ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                one =
                    Compiler.toVarMaybeType index oneBaseName maybeOneType

                two =
                    Compiler.toVarMaybeType one.index twoBaseName maybeTwoType

                three =
                    Compiler.toVarMaybeType two.index threeBaseName maybeThreeType

                four =
                    Compiler.toVarMaybeType three.index fourBaseName maybeFourType

                ( newIndex, return ) =
                    Compiler.toExpressionDetails (Compiler.dive four.index) (toExpression one.val two.val three.val four.val)
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify (Pattern.VarPattern one.name)
                        , Compiler.nodify (Pattern.VarPattern two.name)
                        , Compiler.nodify (Pattern.VarPattern three.name)
                        , Compiler.nodify (Pattern.VarPattern four.name)
                        ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        (Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify two.type_)
                                            (Compiler.nodify
                                                (Annotation.FunctionTypeAnnotation
                                                    (Compiler.nodify three.type_)
                                                    (Compiler.nodify
                                                        (Annotation.FunctionTypeAnnotation
                                                            (Compiler.nodify four.type_)
                                                            (Compiler.nodify
                                                                returnAnnotation.type_
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| -}
fn5 :
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
fn5 ( oneBaseName, maybeOneType ) ( twoBaseName, maybeTwoType ) ( threeBaseName, maybeThreeType ) ( fourBaseName, maybeFourType ) ( fiveBaseName, maybeFiveType ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                one =
                    Compiler.toVarMaybeType index oneBaseName maybeOneType

                two =
                    Compiler.toVarMaybeType one.index twoBaseName maybeTwoType

                three =
                    Compiler.toVarMaybeType two.index threeBaseName maybeThreeType

                four =
                    Compiler.toVarMaybeType three.index fourBaseName maybeFourType

                five =
                    Compiler.toVarMaybeType four.index fiveBaseName maybeFiveType

                ( newIndex, return ) =
                    Compiler.toExpressionDetails (Compiler.dive five.index) (toExpression one.val two.val three.val four.val five.val)
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify (Pattern.VarPattern one.name)
                        , Compiler.nodify (Pattern.VarPattern two.name)
                        , Compiler.nodify (Pattern.VarPattern three.name)
                        , Compiler.nodify (Pattern.VarPattern four.name)
                        , Compiler.nodify (Pattern.VarPattern five.name)
                        ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        (Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify two.type_)
                                            (Compiler.nodify
                                                (Annotation.FunctionTypeAnnotation
                                                    (Compiler.nodify three.type_)
                                                    (Compiler.nodify
                                                        (Annotation.FunctionTypeAnnotation
                                                            (Compiler.nodify four.type_)
                                                            (Compiler.nodify
                                                                (Annotation.FunctionTypeAnnotation
                                                                    (Compiler.nodify five.type_)
                                                                    (Compiler.nodify
                                                                        returnAnnotation.type_
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| -}
fn6 :
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
fn6 ( oneBaseName, maybeOneType ) ( twoBaseName, maybeTwoType ) ( threeBaseName, maybeThreeType ) ( fourBaseName, maybeFourType ) ( fiveBaseName, maybeFiveType ) ( sixBaseName, maybeSixType ) toExpression =
    Compiler.Expression <|
        \index ->
            let
                one =
                    Compiler.toVarMaybeType index oneBaseName maybeOneType

                two =
                    Compiler.toVarMaybeType one.index twoBaseName maybeTwoType

                three =
                    Compiler.toVarMaybeType two.index threeBaseName maybeThreeType

                four =
                    Compiler.toVarMaybeType three.index fourBaseName maybeFourType

                five =
                    Compiler.toVarMaybeType four.index fiveBaseName maybeFiveType

                six =
                    Compiler.toVarMaybeType five.index sixBaseName maybeSixType

                ( newIndex, return ) =
                    Compiler.toExpressionDetails (Compiler.dive five.index) (toExpression one.val two.val three.val four.val five.val six.val)
            in
            { expression =
                Exp.LambdaExpression
                    { args =
                        [ Compiler.nodify (Pattern.VarPattern one.name)
                        , Compiler.nodify (Pattern.VarPattern two.name)
                        , Compiler.nodify (Pattern.VarPattern three.name)
                        , Compiler.nodify (Pattern.VarPattern four.name)
                        , Compiler.nodify (Pattern.VarPattern five.name)
                        , Compiler.nodify (Pattern.VarPattern six.name)
                        ]
                    , expression = Compiler.nodify return.expression
                    }
            , annotation =
                case return.annotation of
                    Err err ->
                        return.annotation

                    Ok returnAnnotation ->
                        Ok
                            { type_ =
                                Annotation.FunctionTypeAnnotation
                                    (Compiler.nodify one.type_)
                                    (Compiler.nodify
                                        (Annotation.FunctionTypeAnnotation
                                            (Compiler.nodify two.type_)
                                            (Compiler.nodify
                                                (Annotation.FunctionTypeAnnotation
                                                    (Compiler.nodify three.type_)
                                                    (Compiler.nodify
                                                        (Annotation.FunctionTypeAnnotation
                                                            (Compiler.nodify four.type_)
                                                            (Compiler.nodify
                                                                (Annotation.FunctionTypeAnnotation
                                                                    (Compiler.nodify five.type_)
                                                                    (Compiler.nodify
                                                                        (Annotation.FunctionTypeAnnotation
                                                                            (Compiler.nodify six.type_)
                                                                            (Compiler.nodify
                                                                                returnAnnotation.type_
                                                                            )
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                            , inferences = returnAnnotation.inferences
                            , aliases = returnAnnotation.aliases
                            }
            , imports = return.imports
            }


{-| -}
type alias Declaration =
    Compiler.Declaration


{-| -}
comment : String -> Declaration
comment content =
    Compiler.Comment ("{- " ++ content ++ " -}")


renderDocumentation :
    Result String value1
    -> Result (List Compiler.InferenceError) Compiler.Inference
    -> Maybe String
renderDocumentation resolvedType bodyAnnotation =
    case resolvedType of
        Ok sig ->
            case bodyAnnotation of
                Ok inference ->
                    Nothing

                Err err ->
                    Just
                        (renderError err)

        Err err ->
            Just
                err


sep : String
sep =
    "\n----\n"


renderDebugDocumentation resolvedType bodyAnnotation =
    case resolvedType of
        Ok sig ->
            case bodyAnnotation of
                Ok inference ->
                    Just (Internal.Write.writeInference inference)

                Err err ->
                    Just
                        (renderError err)

        Err err ->
            case bodyAnnotation of
                Ok inference ->
                    Just
                        (Internal.Write.writeInference inference
                            ++ sep
                            ++ err
                        )

                Err _ ->
                    Just err


renderError : List Compiler.InferenceError -> String
renderError err =
    "-- ELM-CODEGEN ERROR --\n\n"
        ++ (err
                |> List.map Compiler.inferenceErrorToString
                |> String.join "\n\n"
           )
        ++ "\n\n"


{-| -}
declaration : String -> Expression -> Declaration
declaration name (Compiler.Expression toBody) =
    let
        body =
            toBody Compiler.startIndex

        resolvedType =
            body.annotation
                |> Result.mapError
                    renderError
                |> Result.andThen
                    (\sig -> Compiler.resolve sig.inferences sig.type_)
    in
    { documentation =
        Compiler.nodifyMaybe
            (renderDocumentation resolvedType body.annotation)

    -- (renderDebugDocumentation resolvedType body.annotation)
    , signature =
        case body.annotation of
            Ok sig ->
                case resolvedType of
                    Ok finalType ->
                        Just
                            (Compiler.nodify
                                { name = Compiler.nodify (Compiler.formatValue name)
                                , typeAnnotation =
                                    Compiler.nodify finalType
                                }
                            )

                    Err errMsg ->
                        Nothing

            Err _ ->
                Nothing
    , declaration =
        case body.expression of
            Exp.LambdaExpression lam ->
                Compiler.nodify
                    { name = Compiler.nodify (Compiler.formatValue name)
                    , arguments = lam.args
                    , expression = lam.expression
                    }

            _ ->
                Compiler.nodify
                    { name = Compiler.nodify (Compiler.formatValue name)
                    , arguments = []
                    , expression = Compiler.nodify body.expression
                    }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed body.imports


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
            Compiler.Expression <|
                \index ->
                    let
                        expr =
                            case fullExpression of
                                Compiler.Expression toExpr ->
                                    toExpr (Compiler.dive index)
                    in
                    { expression =
                        Exp.LambdaExpression
                            { args =
                                List.map
                                    (\( name, ann ) -> Compiler.nodify (Pattern.VarPattern name))
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
                                            (\( name, Compiler.Annotation ann ) fnbody ->
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
            Compiler.Expression <|
                \index ->
                    let
                        args =
                            List.foldl
                                (\( nameBase, maybeType ) found ->
                                    let
                                        ( name, newIndex ) =
                                            Compiler.getName nameBase found.index

                                        argType =
                                            Maybe.withDefault
                                                (Compiler.Annotation
                                                    { imports = []
                                                    , aliases = Compiler.emptyAliases
                                                    , annotation =
                                                        Annotation.GenericType
                                                            (Compiler.protectTypeName
                                                                nameBase
                                                                found.index
                                                            )
                                                    }
                                                )
                                                maybeType

                                        arg =
                                            value
                                                { importFrom = []
                                                , name = name
                                                , annotation = Just argType
                                                }
                                    in
                                    { index = newIndex
                                    , args = arg :: found.args
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

                        fullExpression =
                            toFullExpression (List.reverse args.args)

                        expr =
                            case fullExpression of
                                Compiler.Expression toExpr ->
                                    toExpr (Compiler.dive index)
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


{-| You can also add a group tag to an exposed value. This will automatically group the `docs` statements in the module docs.

For precise control over what is rendered for the module comment, use [fileWith](#fileWith)

-}
exposeWith : { exposeConstructor : Bool, group : Maybe String } -> Declaration -> Declaration
exposeWith =
    Compiler.exposeWith


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
