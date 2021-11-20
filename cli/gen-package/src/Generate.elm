module Generate exposing (main)

{-| -}

import DocsFromSource
import Elm
import Elm.Annotation as Annotation
import Elm.Docs
import Elm.Gen
import Elm.Gen.Elm as ElmGen
import Elm.Gen.Elm.Annotation as GenType
import Elm.Type
import Json.Decode as Json


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
            "Elm" :: "Gen" :: sourceModName

        modNameBlock =
            Elm.declaration "moduleName_"
                (Elm.list (List.map Elm.string sourceModName))
                |> Elm.withDocumentation " The name of this module. "
                |> Elm.expose

        ids =
            Elm.declaration "id_"
                (Elm.record
                    (List.filterMap blockToIdField blocks)
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
            :: generateTypeRecord blocks
            :: generateTypeBuilderRecord blocks
            :: List.concatMap generateBlocks blocks
            ++ [ ids ]
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
    Elm.valueWith local "moduleName_" (Annotation.list Annotation.string)


expressionType : Annotation.Annotation
expressionType =
    Annotation.named elm "Expression"


annotationNamed : String -> List String -> Elm.Expression
annotationNamed name tags =
    case tags of
        [] ->
            GenType.named thisModuleName
                (Elm.string name)

        nonEmpty ->
            Elm.lambdaWith
                (List.indexedMap
                    (\i arg ->
                        ( "arg" ++ String.fromInt i
                        , Annotation.named elmAnnotation "Annotation"
                        )
                    )
                    nonEmpty
                )
                (GenType.namedWith
                    thisModuleName
                    (Elm.string name)
                    (Elm.list
                        (List.indexedMap
                            (\i arg ->
                                Elm.value ("arg" ++ String.fromInt i)
                                    |> Elm.withType
                                        (Annotation.named elmAnnotation "Annotation")
                            )
                            nonEmpty
                        )
                    )
                )


valueWith : Elm.Expression -> Elm.Expression -> Elm.Type.Type -> Elm.Expression
valueWith mod name annotation =
    ElmGen.valueWith
        mod
        name
        (typeToExpression annotation)


apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply fn args =
    ElmGen.apply fn (Elm.list args)


blockToIdField : Elm.Docs.Block -> Maybe Elm.Field
blockToIdField block =
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
                    (valueWith thisModuleName
                        (Elm.string value.name)
                        value.tipe
                    )
                )

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
generateTypeBuilderRecord : List Elm.Docs.Block -> Elm.Declaration
generateTypeBuilderRecord blocks =
    blocks
        |> List.filterMap generateTypeBuilderRecordHelper
        |> Elm.record
        |> Elm.declaration "make_"
        |> Elm.expose


generateTypeBuilderRecordHelper : Elm.Docs.Block -> Maybe Elm.Field
generateTypeBuilderRecordHelper block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            case union.tags of
                [] ->
                    -- This type has not been exposed and can't be constructed
                    Nothing

                _ ->
                    Elm.field union.name
                        (Elm.record
                            (List.map
                                (\( name, tags ) ->
                                    case tags of
                                        [] ->
                                            Elm.field name
                                                (valueWith thisModuleName
                                                    (Elm.string name)
                                                    (Elm.Type.Type union.name
                                                        (List.map Elm.Type.Var union.args)
                                                    )
                                                )

                                        _ ->
                                            Elm.field name
                                                (Elm.lambdaWith
                                                    (List.indexedMap
                                                        (\i tag ->
                                                            ( "ar" ++ String.fromInt i
                                                            , expressionType
                                                            )
                                                        )
                                                        tags
                                                    )
                                                    (apply
                                                        (valueWith thisModuleName
                                                            (Elm.string name)
                                                            (Elm.Type.Type union.name
                                                                (List.map Elm.Type.Var union.args)
                                                            )
                                                        )
                                                        (List.indexedMap
                                                            (\i tag ->
                                                                Elm.value ("ar" ++ String.fromInt i)
                                                                    |> Elm.withType expressionType
                                                            )
                                                            tags
                                                        )
                                                    )
                                                )
                                )
                                union.tags
                            )
                        )
                        |> Just

        Elm.Docs.AliasBlock { name, tipe } ->
            case tipe of
                Elm.Type.Record fields Nothing ->
                    let
                        lambdaArgType =
                            fields
                                |> List.map (\( fieldName, _ ) -> ( fieldName, expressionType ))
                                |> Annotation.record

                        lambdaValue arg =
                            fields
                                |> List.map
                                    (\( fieldName, _ ) ->
                                        ElmGen.field (Elm.string fieldName) (Elm.get fieldName arg)
                                    )
                                |> Elm.list
                                |> ElmGen.record
                    in
                    Elm.field name (Elm.lambda "arg" lambdaArgType lambdaValue)
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
generateTypeRecord : List Elm.Docs.Block -> Elm.Declaration
generateTypeRecord blocks =
    blocks
        |> List.filterMap generateTypeRecordHelper
        |> Elm.record
        |> Elm.declaration "types_"
        |> Elm.expose


generateTypeRecordHelper : Elm.Docs.Block -> Maybe Elm.Field
generateTypeRecordHelper block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            Nothing

        Elm.Docs.UnionBlock union ->
            Elm.field union.name (annotationNamed union.name union.args)
                |> Just

        Elm.Docs.AliasBlock alias ->
            Elm.field alias.name
                (annotationNamed alias.name alias.args)
                |> Just

        Elm.Docs.ValueBlock value ->
            Nothing

        Elm.Docs.BinopBlock binop ->
            Nothing

        Elm.Docs.UnknownBlock str ->
            Nothing


generateBlocks : Elm.Docs.Block -> List Elm.Declaration
generateBlocks block =
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
                    [ Elm.functionWith value.name
                        (List.reverse (List.drop 1 captured.arguments))
                        (apply
                            (valueWith
                                thisModuleName
                                (Elm.string value.name)
                                value.tipe
                            )
                            (List.reverse (List.drop 1 captured.values))
                            |> Elm.withType expressionType
                        )
                        |> Elm.withDocumentation value.comment
                        |> Elm.expose
                    ]

                _ ->
                    [ Elm.declaration value.name
                        (valueWith
                            thisModuleName
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
                (Elm.apply (Elm.valueWith elm "moduleName")
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
        , arguments : List ( String, Annotation.Annotation )
        , values : List Elm.Expression
        }
    ->
        { index : Int
        , arguments : List ( String, Annotation.Annotation )
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


asArgument : Int -> Elm.Type.Type -> ( String, Annotation.Annotation )
asArgument index tipe =
    ( argName index
    , asArgumentTypeHelper tipe
    )


asArgumentTypeHelper : Elm.Type.Type -> Annotation.Annotation
asArgumentTypeHelper tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            Annotation.function
                [ asArgumentTypeHelper one ]
                (asArgumentTypeHelper two)

        Elm.Type.Type "List.List" [ inner ] ->
            Annotation.list <| asArgumentTypeHelper inner

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

        _ ->
            expressionType


{-| -}
asValue : Int -> Elm.Type.Type -> Elm.Expression
asValue index tipe =
    getArgumentUnpacker 0 tipe <|
        Elm.valueFrom
            local
            (argName index)


getArgumentUnpacker : Int -> Elm.Type.Type -> Elm.Expression -> Elm.Expression
getArgumentUnpacker freshCount tipe value =
    case tipe of
        Elm.Type.Lambda one two ->
            let
                f =
                    getArgumentUnpacker (freshCount + 1)
                        two
                        (Elm.apply value [ Elm.value varName ])

                varName =
                    "lambdaArg" ++ String.fromInt freshCount
            in
            ElmGen.lambdaBetaReduced (Elm.string varName)
                (typeToExpression one)
                (\_ ->
                    Elm.lambdaBetaReduced varName
                        (typeToAnnotation one)
                        (\_ -> f)
                )

        Elm.Type.Type "List.List" [ inner ] ->
            let
                varName =
                    "lambdaArg" ++ String.fromInt freshCount

                f =
                    Elm.apply (Elm.valueFrom [ "List" ] "map")
                        [ Elm.lambdaBetaReduced varName
                            (typeToAnnotation inner)
                            (getArgumentUnpacker (freshCount + 1) inner)
                        , value
                        ]
            in
            ElmGen.list f

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
                |> Elm.list
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

        Elm.Type.Type name types ->
            Annotation.namedWith [] name (List.map typeToAnnotation types)

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Annotation.record (List.map (Tuple.mapSecond typeToAnnotation) fields)

                Just base ->
                    Annotation.extensible base (List.map (Tuple.mapSecond typeToAnnotation) fields)


chompLambdas : List Elm.Expression -> Elm.Type.Type -> Elm.Expression
chompLambdas exps tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            chompLambdas
                (typeToExpression one :: exps)
                two

        _ ->
            GenType.function
                (Elm.list (List.reverse exps))
                (typeToExpression tipe)


typeToExpression : Elm.Type.Type -> Elm.Expression
typeToExpression elmType =
    case elmType of
        Elm.Type.Var string ->
            GenType.var (Elm.string string)

        Elm.Type.Lambda one two ->
            chompLambdas
                [ typeToExpression one
                ]
                two

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    GenType.unit

                [ one, two ] ->
                    GenType.tuple
                        (typeToExpression one)
                        (typeToExpression two)

                [ one, two, three ] ->
                    GenType.triple
                        (typeToExpression one)
                        (typeToExpression two)
                        (typeToExpression three)

                _ ->
                    -- this should never happen :/
                    Elm.valueWith elmAnnotation "unit" annotationType

        Elm.Type.Type name types ->
            namedWithType name types

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    GenType.record
                        (Elm.list
                            (List.map
                                (\( fieldName, fieldType ) ->
                                    Elm.tuple
                                        (Elm.string fieldName)
                                        (typeToExpression fieldType)
                                )
                                fields
                            )
                        )

                Just base ->
                    GenType.extensible
                        (Elm.string base)
                        (Elm.list
                            (List.map
                                (\( fieldName, fieldType ) ->
                                    Elm.tuple
                                        (Elm.string fieldName)
                                        (typeToExpression fieldType)
                                )
                                fields
                            )
                        )


namedWithType : String -> List Elm.Type.Type -> Elm.Expression
namedWithType name types =
    let
        frags =
            String.split "." name
    in
    case frags of
        [ "List", "List" ] ->
            case types of
                [ inner ] ->
                    GenType.list (typeToExpression inner)

                _ ->
                    GenType.unit

        [ "Maybe", "Maybe" ] ->
            case types of
                [ inner ] ->
                    GenType.maybe (typeToExpression inner)

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
                (Elm.list (List.map Elm.string (List.take (fragsLength - 1) frags)))
                (Elm.string typeName)
                (Elm.list (List.map typeToExpression types))
