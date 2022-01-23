module Generate exposing (main)

{-| -}

import DocsFromSource
import Elm
import Elm.Annotation as Annotation
import Elm.Docs
import Elm.Gen
import Gen.Elm as ElmGen
import Gen.Elm.Case
import Gen.Elm.Annotation as GenType
import Elm.Type
import Json.Decode as Json
import Internal.Compiler as Compiler
import Elm.Case


main : Program Json.Value () ()
main =
    Platform.worker
        { init =
            \json ->
                case Json.decodeValue flagsDecoder json of
                    Err err ->
                        ( ()
                        , Elm.Gen.error
                            { title = "Invalid docs"
                            , description =
                                Json.errorToString err
                            }
                        )

                    Ok (Docs docs) ->
                        ( ()
                        , Elm.Gen.files
                            (List.map moduleToFile docs)
                        )

                    Ok (ElmSource srcs) ->
                        case parseSources srcs [] of
                            Ok docs ->
                                ( ()
                                , Elm.Gen.files
                                    (List.map moduleToFile docs)
                                )

                            Err err ->
                                ( ()
                                , Elm.Gen.error
                                    { title = "Error generating docs"
                                    , description =
                                        err
                                    }
                                )
        , update =
            \msg model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


parseSources : List String -> List Elm.Docs.Module -> Result String (List Elm.Docs.Module)
parseSources srcs parsed =
    case srcs of
        [] ->
            Ok parsed

        top :: remain ->
            case DocsFromSource.fromSource top of
                Err err ->
                    Err err

                Ok topParsed ->
                    parseSources remain (topParsed :: parsed)


type Flags
    = Docs (List Elm.Docs.Module)
    | ElmSource (List String)


flagsDecoder : Json.Decoder Flags
flagsDecoder =
    Json.oneOf
        [ Json.field "docs"
            (Json.list Elm.Docs.decoder)
            |> Json.map Docs
        , Json.field "elmSource" (Json.list Json.string)
            |> Json.map ElmSource
        ]


moduleToFile : Elm.Docs.Module -> Elm.File
moduleToFile docs =
    let
        blocks =
            Elm.Docs.toBlocks docs

        sourceModName =
            String.split "." docs.name

        modName =
            "Gen" :: sourceModName

        modNameBlock =
            Elm.declaration "moduleName_"
                (Elm.list (List.map Elm.string sourceModName))
                |> Elm.withDocumentation " The name of this module. "
                |> Elm.expose

        values =
            Elm.declaration "values_"
                (Elm.record
                    (List.filterMap (blockToIdField sourceModName) blocks)
                )

                |> Elm.withDocumentation " Every value/function in this module in case you need to refer to it directly. "
                |> Elm.expose

        call =
            Elm.declaration "call_"
                (Elm.record
                    (List.filterMap (blockToCall sourceModName) blocks)
                )

                |> Elm.withDocumentation " Every value/function in this module in case you need to refer to it directly. "
                |> Elm.expose
    in
    Elm.fileWith modName
        { docs =
            List.map Elm.docs
        , aliases =
            [ ( [ "Elm", "Annotation" ], "Type" )
            ]
        }
        (modNameBlock
            :: List.concatMap (generateBlocks sourceModName) blocks
            ++ [ generateTypeRecord sourceModName blocks
               , values
               , call
               ]
        )


elmAnnotation : List String
elmAnnotation =
    [ "Elm", "Annotation" ]


annotationType : Annotation.Annotation
annotationType =
    Annotation.named elmAnnotation "Annotation"


elm : List String
elm =
    [ "Elm" ]


local : List String
local =
    []


thisModuleName : Elm.Expression
thisModuleName =
    Elm.valueWith
        { importFrom = local
        , name = "moduleName_"
        , annotation =
            Just (Annotation.list Annotation.string)
        }


valueWith : List String -> Elm.Expression -> Elm.Type.Type -> Elm.Expression
valueWith thisModule name annotation =
    ElmGen.valueWith
        { importFrom = List.map Elm.string thisModule
        , name = name
        , annotation =
            typeToExpression thisModule annotation
                |> Just
                |> Elm.maybe

        }

apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply fn args =
    ElmGen.apply fn args


expressionType : Annotation.Annotation
expressionType =
    Annotation.named elm "Expression"


annotationNamed : String -> List String -> Elm.Expression
annotationNamed name tags =
    case tags of
        [] ->
            localType name []

        nonEmpty ->
            Elm.function
                (List.indexedMap
                    (\i arg ->
                        ( "arg" ++ String.fromInt i
                        , Just (Annotation.named elmAnnotation "Annotation")
                        )
                    )
                    nonEmpty
                )
                (\args ->
                    localType name args

                )


localType : String -> List Elm.Expression -> Elm.Expression
localType name args =
    Elm.apply
        (Elm.valueFrom
            [ "Elm", "Annotation" ]
            "namedWith"
            |> Elm.withType
                (Annotation.function
                    [ Annotation.list Annotation.string
                    , Annotation.string
                    , Annotation.list
                        (Annotation.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    ]
                    (Annotation.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                )
        )
        [ thisModuleName
        , Elm.string name
        , Elm.list args
        ]


blockToCall : List String -> Elm.Docs.Block -> Maybe Elm.Field
blockToCall thisModule block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            Nothing

        Elm.Docs.AliasBlock alias ->
            Nothing

        Elm.Docs.ValueBlock value ->
             case value.tipe of
                Elm.Type.Lambda one two ->
                    let
                        captured =
                            captureFunction two
                                { index = 2
                                , arguments =
                                    [ asArgument 1 one
                                    ]
                                , values =
                                    [ asValue 1 one
                                    ]
                                }

                        arguments =
                            List.drop 1 captured.arguments
                                |> List.foldl
                                    (\(name, _) args ->
                                        (name, Just expressionType) :: args
                                    )
                                    []

                        vals =
                            List.drop 1 captured.arguments
                                |> List.foldl
                                    (\(name, _) args ->
                                        Elm.valueWith
                                            { importFrom = []
                                            , name = name
                                            , annotation =
                                                Just expressionType
                                            }
                                                :: args
                                    )
                                    []

                    in
                    Elm.function arguments
                        (
                            ElmGen.apply
                                (ElmGen.valueWith
                                    { importFrom = List.map Elm.string thisModule
                                    , name = Elm.string value.name
                                    , annotation =
                                        typeToExpression thisModule value.tipe
                                            |> Just
                                            |> Elm.maybe
                                    }
                                )

                        )
                        |> Elm.field value.name
                        |> Just



                _ ->
                    Nothing

        Elm.Docs.BinopBlock binop ->
            Nothing

        Elm.Docs.UnknownBlock str ->
            Nothing




blockToIdField : List String -> Elm.Docs.Block -> Maybe Elm.Field
blockToIdField thisModule block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            Nothing

        Elm.Docs.AliasBlock alias ->
            Nothing

        Elm.Docs.ValueBlock value ->
            Just
                (Elm.field
                    value.name
                    (valueWith thisModule
                        (Elm.string value.name)
                        value.tipe
                    )
                )

        Elm.Docs.BinopBlock binop ->
            Nothing

        Elm.Docs.UnknownBlock str ->
            Nothing


{-|



-}
block2Case : List String -> Elm.Docs.Union -> Maybe Elm.Expression
block2Case thisModule union =
    case union.tags of
        [] ->
            -- This type has not been exposed and can't be constructed
            Nothing

        _ ->
                Just
                    (Elm.fn2 "expresssion" "tags"
                        (\express tagRecord ->
                            Gen.Elm.Case.custom express
                                (List.filterMap
                                    (\(tagname, subtypes) ->
                                        let
                                            moduleName = Elm.list (List.map Elm.string thisModule)

                                            tagString = Elm.string tagname


                                        in
                                        case subtypes of
                                            [] ->
                                                Gen.Elm.Case.call_.branch0
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just

                                            [ _ ] ->
                                                Gen.Elm.Case.call_.branch1
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just

                                            [ _, _ ] ->
                                                Gen.Elm.Case.call_.branch2
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just

                                            [ _, _, _] ->
                                                Gen.Elm.Case.call_.branch3
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just


                                            [ _, _, _, _] ->
                                                Gen.Elm.Case.call_.branch4
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just

                                            [ _, _, _, _, _] ->
                                                Gen.Elm.Case.call_.branch5
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just

                                            [ _, _, _, _, _, _] ->
                                                Gen.Elm.Case.call_.branch6
                                                    moduleName
                                                    tagString
                                                    (Elm.get tagname tagRecord)
                                                    |> Just


                                            _ ->
                                               Nothing


                                    )
                                    union.tags
                                )

                        )
                    )





block2Maker : List String -> Elm.Docs.Block -> Maybe Elm.Expression
block2Maker thisModule block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            case union.tags of
                [] ->
                    -- This type has not been exposed and can't be constructed
                    Nothing

                _ ->
                    Just
                        (Elm.record
                            (List.map
                                (\( name, tags ) ->
                                    case tags of
                                        [] ->
                                            Elm.field name
                                                (valueWith thisModule
                                                    (Elm.string name)
                                                    (Elm.Type.Type union.name
                                                        (List.map Elm.Type.Var union.args)
                                                    )
                                                )

                                        _ ->
                                            Elm.field name
                                                (Elm.function
                                                    (List.indexedMap
                                                        (\i tag ->
                                                            ( "ar" ++ String.fromInt i
                                                            , Just expressionType
                                                            )
                                                        )
                                                        tags
                                                    )
                                                    (\vars ->
                                                        apply
                                                            (valueWith thisModule
                                                                (Elm.string name)
                                                                (Elm.Type.Type union.name
                                                                    (List.map Elm.Type.Var union.args)
                                                                )
                                                            )
                                                            vars
                                                    )
                                                )
                                )
                                union.tags
                            )
                        )

        Elm.Docs.AliasBlock { name, tipe } ->
            case tipe of
                Elm.Type.Record fields Nothing ->
                    let
                        lambdaArgType =
                            fields
                                |> List.map (\( fieldName, _ ) -> ( fieldName, expressionType ))
                                |> Annotation.record

                        lambdaValue val =
                            let
                                arg =
                                    val
                                        |> Elm.withType lambdaArgType

                            in
                            fields
                                |> List.map
                                    (\( fieldName, _ ) ->
                                        ElmGen.field (Elm.string fieldName)
                                            (Elm.get fieldName arg
                                            )
                                    )
                                |> ElmGen.record

                    in
                    Elm.fn "arg" lambdaValue
                        |> Just

                _ ->
                    Nothing

        Elm.Docs.ValueBlock value ->
            Nothing

        Elm.Docs.BinopBlock binop ->
            Nothing

        Elm.Docs.UnknownBlock str ->
            Nothing


{-| Types are referenced via a big record.

    types =
        { mutation :
            { annotation: arg1 -> Elm.Annotation }
        , make :
            { ...variants that can be made
            }

        }

This creates that record

-}
generateTypeRecord : List String -> List Elm.Docs.Block -> Elm.Declaration
generateTypeRecord thisModule blocks =
    blocks
        |> List.filterMap (generateTypeRecordHelper thisModule)
        |> Elm.record
        |> Elm.declaration "types_"
        |> Elm.expose


generateTypeRecordHelper : List String -> Elm.Docs.Block -> Maybe Elm.Field
generateTypeRecordHelper thisModule block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            Elm.field union.name
                (Elm.record
                    (List.filterMap identity
                        [ Elm.field "annotation"
                            (annotationNamed union.name union.args)
                            |> Just
                        , Maybe.map
                            (Elm.field "create")
                            (block2Maker thisModule block)
                        , Maybe.map
                            (Elm.field "caseOf")
                            (block2Case thisModule union)
                        ]
                    )
                )
                |> Just

        Elm.Docs.AliasBlock alias ->
            Elm.field alias.name
                (Elm.record
                    (List.filterMap identity
                        [ Elm.field "annotation"
                            (annotationNamed alias.name alias.args)
                            |> Just
                        , Maybe.map
                            (Elm.field "create")
                            (block2Maker thisModule block)

                        ]
                    )
                )
                |> Just

        Elm.Docs.ValueBlock value ->
            Nothing

        Elm.Docs.BinopBlock binop ->
            Nothing

        Elm.Docs.UnknownBlock str ->
            Nothing


generateBlocks : List String -> Elm.Docs.Block -> List Elm.Declaration
generateBlocks thisModule block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            []

        Elm.Docs.UnionBlock union ->
            -- we need a way to expose both the constructors and
            -- the annotation
            -- It's also possible no contructors are exposed.
            []

        Elm.Docs.AliasBlock alias ->
            []

        Elm.Docs.ValueBlock value ->
            case value.tipe of
                Elm.Type.Lambda one two ->
                    let
                        captured =
                            captureFunction two
                                { index = 2
                                , arguments =
                                    [ asArgument 1 one
                                    ]
                                , values =
                                    [ asValue 1 one
                                    ]
                                }

                    in
                    [ Elm.function
                        ( (List.reverse (List.drop 1 captured.arguments)))
                        (\vars ->
                            (ElmGen.apply
                                (ElmGen.valueWith
                                    { importFrom = List.map Elm.string thisModule
                                    , name = Elm.string value.name
                                    , annotation =
                                        typeToExpression thisModule  value.tipe
                                            |> Just
                                            |> Elm.maybe
                                    }
                                )
                                (List.reverse (List.drop 1 captured.values))
                            )
                        )

                        |> Elm.declaration value.name
                        |> Elm.withDocumentation value.comment
                        |> Elm.expose
                    ]

                _ ->
                    [ Elm.declaration value.name
                        (valueWith thisModule
                            (Elm.string value.name)
                            value.tipe
                            |> Elm.withType expressionType
                        )
                        |> Elm.withDocumentation value.comment
                        |> Elm.expose
                    ]

        Elm.Docs.BinopBlock binop ->
            --All binops are defined in the top level `Elm` library
            []

        Elm.Docs.UnknownBlock str ->
            []


{-| Ultimately we want to capture

    { arguments =
        [ ( expressionType, Elm.Pattern.var "one" )
        , ( expressionType, Elm.Pattern.var "two" )
        , ( expressionType, Elm.Pattern.car "three" )
        ]
    , body =
        Elm.apply
            (valueWith
                (Elm.apply (Elm.valueFrom elm "moduleName")
                    [ Elm.list (List.map Elm.string mod)
                    ]
                )
                (Elm.string value.name)
            )
            [ Elm.value "one"
            , Elm.value "two"
            , Elm.value "three"
            ]
    }

-}
captureFunction :
    Elm.Type.Type
    ->
        { index : Int
        , arguments : List ( String, Maybe Annotation.Annotation )
        , values : List Elm.Expression
        }
    ->
        { index : Int
        , arguments : List ( String, Maybe Annotation.Annotation )
        , values : List Elm.Expression
        }
captureFunction tipe captured =
    case tipe of
        Elm.Type.Lambda one two ->
            captureFunction two
                { index = captured.index + 1
                , arguments = asArgument captured.index one :: captured.arguments
                , values = asValue captured.index one :: captured.values
                }

        _ ->
            { index = captured.index + 1
            , arguments = asArgument captured.index tipe :: captured.arguments
            , values = asValue captured.index tipe :: captured.values
            }


argName : Int -> String
argName index =
    "arg" ++ String.fromInt index


asArgument : Int -> Elm.Type.Type -> ( String, Maybe Annotation.Annotation )
asArgument index tipe =
    ( argName index
    , Just (asArgumentTypeHelper tipe)
    )


asArgumentTypeHelper : Elm.Type.Type -> Annotation.Annotation
asArgumentTypeHelper tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            Annotation.function
                [ expressionType
                ]
                (asArgumentTypeHelperForLambdas two)

        Elm.Type.Type "List.List" [ inner ] ->
            Annotation.list <| asArgumentTypeHelper inner

        Elm.Type.Type modAndName typeVars ->
            expressionType

        Elm.Type.Record fields Nothing ->
            Annotation.record <|
                List.map
                    (\( fieldName, fieldType ) ->
                        let
                            fieldAnnotation =
                                asArgumentTypeHelper fieldType
                        in
                        ( fieldName, fieldAnnotation )
                    )
                    fields

        Elm.Type.Record fields (Just genName) ->
            Annotation.extensible genName <|
                List.map
                    (\( fieldName, fieldType ) ->
                        let
                            fieldAnnotation =
                                asArgumentTypeHelper fieldType
                        in
                        ( fieldName, fieldAnnotation )
                    )
                    fields

        Elm.Type.Tuple tuples ->
            expressionType

        Elm.Type.Var name ->
            expressionType



asArgumentTypeHelperForLambdas : Elm.Type.Type -> Annotation.Annotation
asArgumentTypeHelperForLambdas tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            Annotation.function
                [ expressionType
                ]
                (asArgumentTypeHelperForLambdas two)

        _ ->
            expressionType


{-| -}
asValue : Int -> Elm.Type.Type -> Elm.Expression
asValue index tipe =
    getArgumentUnpacker 0 tipe <|
        (Elm.valueWith
            { importFrom = []
            , name = (argName index)
            , annotation =
                Just
                    (typeToGeneratedAnnotation tipe)

            }
        )


needsUnpacking : Elm.Type.Type -> Bool
needsUnpacking tipe =
    case tipe of
        Elm.Type.Type "List.List" [ _ ] ->
            True

        Elm.Type.Record _ _ ->
            True

        _ ->
            False


getArity : Int -> Elm.Type.Type -> Int
getArity i tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            getArity (i + 1) two

        _ ->
            i


functionArgTypes : Elm.Type.Type -> List Elm.Type.Type -> { args : List Elm.Type.Type, return : Elm.Type.Type}
functionArgTypes fnType args =
    case fnType of
        Elm.Type.Lambda one two ->
            functionArgTypes two (one :: args)

        _ ->
            { args = List.reverse args
            , return = fnType
            }




getArgumentUnpacker : Int -> Elm.Type.Type -> Elm.Expression -> Elm.Expression
getArgumentUnpacker freshCount tipe value =
    case tipe of
        Elm.Type.Lambda one two ->
            let
                argCount =
                    getArity 1 two

                args = functionArgTypes tipe []
            in
            ElmGen.functionAdvanced
            --     (List.map
            --         (\i ->
                        -- Elm.tuple
                        --     (Elm.string ("ar" ++ String.fromInt i))
                        --     (GenType.named
                        --         [ Elm.string "Elm" ]
                        --             (Elm.string "Expression")
                        --     )
            --         )
            --         (List.range 1 argCount)
            --     )
                (List.indexedMap
                    (\i argType ->
                        Elm.tuple
                            (Elm.string ("ar" ++ String.fromInt i))
                            -- (GenType.named
                            --     [ Elm.string "Elm" ]
                            --         (Elm.string "Expression")
                            -- )
                            (typeToExpression [] argType)
                            -- (typeToGeneratedAnnotation argType)
                    )
                    args.args

                )
                ( Elm.apply value
                    -- (List.map
                    --     (\i ->
                    --         ElmGen.valueWith
                    --             { importFrom = []
                    --             , name = (Elm.string ("ar" ++ String.fromInt i))
                    --             , annotation =
                    --                 Elm.maybe
                    --                     (Just
                    --                         (GenType.named
                    --                             [ Elm.string "Elm" ]
                    --                             (Elm.string "Expression")
                    --                         )
                    --                     )

                    --             }
                    --     )
                    --     (List.range 1 argCount)
                    -- )
                    (List.indexedMap
                        (\i argType ->
                            ElmGen.valueWith
                                { importFrom = []
                                , name = (Elm.string ("ar" ++ String.fromInt i))
                                , annotation =
                                    Elm.maybe
                                        -- (Just
                                        --     (GenType.named
                                        --         [ Elm.string "Elm" ]
                                        --         (Elm.string "Expression")
                                        --     )
                                        -- )
                                        (Just (typeToExpression [] argType))

                                }
                        )
                        args.args
                    )
                )


        Elm.Type.Type "List.List" [ inner ] ->
            let
                varName =
                    "lambdaArg" ++ String.fromInt freshCount

                unpackedInner =
                    if needsUnpacking inner then
                        Elm.apply
                            (Elm.valueWith
                                { importFrom = [ "List" ]
                                , name = "map"
                                , annotation =
                                    Just
                                        (Annotation.function
                                            [ Annotation.function [ Annotation.var "thing" ] (Annotation.var "b")
                                            , Annotation.list (Annotation.var "thing")
                                            ]
                                            (Annotation.list (Annotation.var "b"))
                                        )
                                }
                            )
                            [ Elm.functionReduced varName
                                (typeToAnnotation inner)
                                (getArgumentUnpacker (freshCount + 1) inner)
                            , value
                            ]

                    else
                        value
            in
            Elm.apply ElmGen.values_.list
                [ unpackedInner
                ]


        Elm.Type.Record fields Nothing ->
            fields
                |> List.map
                    (\( fieldName, fieldType ) ->
                        ElmGen.field
                            (Elm.string fieldName)
                            (getArgumentUnpacker freshCount fieldType <|
                                Elm.get fieldName value
                            )
                    )
                |> ElmGen.record

        _ ->
            value



{-|

    type Type
        = Var String
        | Lambda Type Type
        | Tuple (List Type)
        | Type String (List Type)
        | Record (List ( String, Type )) (Maybe String)

-}
typeToAnnotation : Elm.Type.Type -> Annotation.Annotation
typeToAnnotation elmType =
    case elmType of
        Elm.Type.Var string ->
            Annotation.var string

        Elm.Type.Lambda one two ->
            Annotation.function
                [ typeToAnnotation one ]
                (typeToAnnotation two)

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    Annotation.unit

                [ one, two ] ->
                    Annotation.tuple (typeToAnnotation one) (typeToAnnotation two)

                [ one, two, three ] ->
                    Annotation.triple (typeToAnnotation one) (typeToAnnotation two) (typeToAnnotation three)

                _ ->
                    -- this should never happen :/
                    Annotation.unit

        Elm.Type.Type "List.List" types ->
            case types of
                [innerName] ->
                    Annotation.list (typeToAnnotation innerName)

                _ ->
                    Annotation.list Annotation.unit


        Elm.Type.Type name types ->
            case List.reverse (String.split "." name) of
                [] ->
                    Annotation.namedWith [] name (List.map typeToAnnotation types)
                [innerName] ->
                    Annotation.namedWith [] name (List.map typeToAnnotation types)

                (valName :: importedFrom) ->
                    Annotation.namedWith (List.reverse importedFrom) valName
                        (List.map typeToAnnotation types)

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Annotation.record (List.map (Tuple.mapSecond typeToAnnotation) fields)

                Just base ->
                    Annotation.extensible base (List.map (Tuple.mapSecond typeToAnnotation) fields)



{-|

    type Type
        = Var String
        | Lambda Type Type
        | Tuple (List Type)
        | Type String (List Type)
        | Record (List ( String, Type )) (Maybe String)


    This is the *generated* type annotation.

    So, normally, the type for a Type "String" []
    would be a `String`

    This function would list that as an `Expression`

-}
typeToGeneratedAnnotation : Elm.Type.Type -> Annotation.Annotation
typeToGeneratedAnnotation elmType =
    case elmType of
        Elm.Type.Var string ->
            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Lambda one two ->
            Annotation.function
                [ Annotation.namedWith [ "Elm" ] "Expression" []
                ]
                (typeToGeneratedAnnotationExpression two)

        Elm.Type.Tuple types ->

            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Type "List.List" [ inner ] ->
            Annotation.list (typeToGeneratedAnnotation inner)

        Elm.Type.Type name types ->
            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Annotation.record (List.map (Tuple.mapSecond typeToGeneratedAnnotation) fields)

                Just base ->
                    Annotation.extensible base (List.map (Tuple.mapSecond typeToGeneratedAnnotation) fields)


typeToGeneratedAnnotationExpression : Elm.Type.Type -> Annotation.Annotation
typeToGeneratedAnnotationExpression elmType =
    case elmType of
        Elm.Type.Var string ->
            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Lambda one two ->
            Annotation.function
                [ typeToGeneratedAnnotationExpression one ]
                (typeToGeneratedAnnotationExpression two)

        Elm.Type.Tuple types ->
            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Type "List.List" [ inner ] ->
             Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Type name types ->
            Annotation.namedWith [ "Elm" ] "Expression" []

        Elm.Type.Record fields maybeExtensible ->
            Annotation.namedWith [ "Elm" ] "Expression" []


chompLambdas : List String -> List Elm.Expression -> Elm.Type.Type -> Elm.Expression
chompLambdas thisModule exps tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            chompLambdas thisModule
                (typeToExpression thisModule one :: exps)
                two

        _ ->
            GenType.function
                (List.reverse exps)
                (typeToExpression thisModule tipe)


typeToExpression : List String -> Elm.Type.Type -> Elm.Expression
typeToExpression thisModule elmType =
    case elmType of
        Elm.Type.Var string ->
            GenType.var (Elm.string string)

        Elm.Type.Lambda one two ->
            chompLambdas thisModule
                [ typeToExpression thisModule one
                ]
                two

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    GenType.unit

                [ one, two ] ->
                    GenType.tuple
                        (typeToExpression thisModule one)
                        (typeToExpression thisModule two)

                [ one, two, three ] ->
                    GenType.triple
                        (typeToExpression thisModule one)
                        (typeToExpression thisModule two)
                        (typeToExpression thisModule three)

                _ ->
                    -- this should never happen :/
                    Elm.valueFrom elmAnnotation "unit"
                        |> Elm.withType annotationType

        Elm.Type.Type name types ->
            namedWithType thisModule name types

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    GenType.record
                        (List.map
                            (\( fieldName, fieldType ) ->
                                Elm.tuple
                                    (Elm.string fieldName)
                                    (typeToExpression thisModule fieldType)
                            )
                            fields
                        )

                Just base ->
                    GenType.extensible
                        (Elm.string base)
                        (List.map
                            (\( fieldName, fieldType ) ->
                                Elm.tuple
                                    (Elm.string fieldName)
                                    (typeToExpression thisModule fieldType)
                            )
                            fields
                        )



namedWithType : List String -> String -> List Elm.Type.Type -> Elm.Expression
namedWithType thisModule name types =
    let
        frags =
            String.split "." name
    in
    case frags of
        [ "List", "List" ] ->
            case types of
                [ inner ] ->
                    GenType.list (typeToExpression thisModule inner)

                _ ->
                    GenType.unit

        [ "Maybe", "Maybe" ] ->
            case types of
                [ inner ] ->
                    GenType.maybe (typeToExpression thisModule inner)

                _ ->
                    GenType.unit

        [ "Basics", "Int" ] ->
            GenType.int

        [ "Basics", "Float" ] ->
            GenType.float

        [ "Basics", "Bool" ] ->
            GenType.bool

        [ "String", "String" ] ->
            GenType.string

        [ "Char", "Char" ] ->
            GenType.char

        _ ->
            let
                fragsLength =
                    List.length frags

                typeName =
                    List.drop (fragsLength - 1) frags
                        |> List.head
                        |> Maybe.withDefault name
            in
            GenType.namedWith
                (List.map Elm.string (List.take (fragsLength - 1) frags))
                (Elm.string (typeName))
                (List.map (typeToExpression thisModule) types)


isLocal thisModule thisType =
    case thisModule of
        [] ->
            case thisType of
                [one ] ->
                    True
                _ ->
                    False
        (thisModuleTop :: remain) ->
            case thisType of
                [] ->
                    False
                (thisTypeTop :: thisTypeRemain ) ->
                    if thisModuleTop == thisTypeTop then
                        isLocal remain thisTypeRemain
                    else
                        False
