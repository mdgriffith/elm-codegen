module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Annotation
import Elm.Docs
import Elm.Gen
import Elm.Pattern as Pattern
import Elm.Type
import Internal.Compiler as Util
import Json.Decode as Json


main : Program Json.Value () ()
main =
    Platform.worker
        { init =
            \json ->
                case Json.decodeValue (Json.list Elm.Docs.decoder) json of
                    Err err ->
                        ( ()
                        , Elm.Gen.error "Issue decoding docs!"
                        )

                    Ok docs ->
                        ( ()
                        , Elm.Gen.files
                            (List.map (Elm.render << moduleToFile) docs)
                        )
        , update =
            \msg model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


moduleToFile : Elm.Docs.Module -> Elm.File
moduleToFile docs =
    let
        blocks =
            Elm.Docs.toBlocks docs

        sourceModName =
            String.split "." docs.name

        modName =
            "Elm" :: "Gen" :: sourceModName
    in
    Elm.file (Elm.moduleName modName)
        ((Elm.declarationWith "moduleName_"
            (Annotation.named elm "Module")
            (Elm.apply
                (Elm.valueWith elm
                    "moduleName"
                    (Annotation.function
                        [ Annotation.list Annotation.string
                        ]
                        (Annotation.named elm "Module")
                    )
                )
                [ Elm.list (List.map Elm.string sourceModName)
                ]
            )
            |> Elm.withDocumentation " The name of this module. "
            |> Elm.expose
         )
            :: (Elm.declaration "id_"
                    (Elm.record
                        (List.filterMap blockToIdField blocks)
                    )
                    |> Elm.withDocumentation " Every value/function in this module in case you need to refer to it directly. "
                    |> Elm.expose
               )
            :: List.concatMap generateBlocks blocks
        )


elmAnnotation : Elm.Module
elmAnnotation =
    Elm.moduleAs [ "Elm", "Annotation" ] "Type"


annotationType : Annotation.Annotation
annotationType =
    Annotation.named elmAnnotation "Annotation"


elm : Elm.Module
elm =
    Elm.moduleName [ "Elm" ]


local : Elm.Module
local =
    Elm.moduleName []


thisModuleName : Elm.Expression
thisModuleName =
    Elm.valueWith local "moduleName_" (Annotation.named elm "Module")


expressionType : Annotation.Annotation
expressionType =
    Annotation.named elm "Expression"


annotationNamed : String -> Elm.Expression
annotationNamed name =
    Elm.apply
        (Elm.valueWith elmAnnotation
            "named"
            (Annotation.function
                [ Annotation.named elm "Module"
                , Annotation.string
                ]
                (Annotation.named elmAnnotation "Annotation")
            )
        )
        [ thisModuleName
        , Elm.string name
        ]


skip : Elm.Expression
skip =
    Elm.valueWith elm
        "pass"
        expressionType


valueFrom : Elm.Expression -> Elm.Expression -> Elm.Type.Type -> Elm.Expression
valueFrom mod name annotation =
    Elm.apply
        (Elm.valueWith elm
            "valueWith"
            (Annotation.function
                [ Annotation.named elm "Module"
                , Annotation.string
                , Annotation.named elmAnnotation "Annotation"
                ]
                (Annotation.named elm "Expression")
            )
         --|> Debug.log "   VALUE FROM "
         --|> logAnnotation "   VALUE FROM "
        )
        [ mod
        , name
        , typeToExpression annotation
        ]



--|> logAnnotation "   VF APPLIED -> "


apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply fn args =
    Elm.apply
        (Elm.valueWith elm
            "apply"
            (Annotation.function
                [ expressionType
                , Annotation.list expressionType
                ]
                expressionType
            )
        )
        [ fn
        , Elm.list args
        ]


chooseName base tags =
    case tags of
        [] ->
            base

        ( name, _ ) :: rest ->
            if name == base then
                chooseName (base ++ "_") rest

            else
                chooseName base rest


blockToIdField : Elm.Docs.Block -> Maybe ( String, Elm.Expression )
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
                ( value.name
                , valueFrom
                    thisModuleName
                    (Elm.string value.name)
                    value.tipe
                )

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
            [ Elm.declaration ("type" ++ union.name)
                (Elm.record
                    (( chooseName "annotation" union.tags
                     , annotationNamed union.name
                     )
                        :: List.map
                            (\( name, tag ) ->
                                ( name
                                , valueFrom thisModuleName
                                    (Elm.string name)
                                    (Elm.Type.Type union.name
                                        (List.map Elm.Type.Var union.args)
                                    )
                                )
                            )
                            union.tags
                    )
                )
                |> Elm.withDocumentation union.comment
            ]

        Elm.Docs.AliasBlock alias ->
            [ Elm.declaration ("alias" ++ alias.name)
                (Elm.record
                    [ ( "annotation"
                      , annotationNamed alias.name
                      )
                    ]
                )
                |> Elm.withDocumentation alias.comment
            ]

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
                            (valueFrom
                                thisModuleName
                                (Elm.string value.name)
                                value.tipe
                            )
                            (List.reverse (List.drop 1 captured.values))
                        )
                        |> Elm.withDocumentation value.comment
                        |> Elm.expose
                    ]

                _ ->
                    [ Elm.declarationWith value.name
                        expressionType
                        (valueFrom
                            thisModuleName
                            (Elm.string value.name)
                            value.tipe
                        )
                        |> Elm.withDocumentation value.comment
                        |> Elm.expose
                    ]

        Elm.Docs.BinopBlock binop ->
            --All binops are defined in the top level `Elm` library
            []

        Elm.Docs.UnknownBlock str ->
            []


logAnnotation str ((Util.Expression exp) as val) =
    let
        _ =
            Debug.log str exp.annotation
    in
    val


{-| Ultimately we want to capture

    { arguments =
        [ ( expressionType, Elm.Pattern.var "one" )
        , ( expressionType, Elm.Pattern.var "two" )
        , ( expressionType, Elm.Pattern.car "three" )
        ]
    , body =
        Elm.apply
            (valueFrom
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
        , arguments : List ( Annotation.Annotation, Pattern.Pattern )
        , values : List Elm.Expression
        }
    ->
        { index : Int
        , arguments : List ( Annotation.Annotation, Pattern.Pattern )
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


asArgument : Int -> Elm.Type.Type -> ( Annotation.Annotation, Pattern.Pattern )
asArgument index tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            ( asArgumentTypeHelper tipe
            , Pattern.var (argName index)
            )

        _ ->
            ( expressionType
            , Pattern.var (argName index)
            )


asArgumentTypeHelper : Elm.Type.Type -> Annotation.Annotation
asArgumentTypeHelper tipe =
    case tipe of
        Elm.Type.Lambda one two ->
            Annotation.function
                [ asArgumentTypeHelper one ]
                (asArgumentTypeHelper two)

        _ ->
            expressionType


{-| -}
asValue : Int -> Elm.Type.Type -> Elm.Expression
asValue index tipe =
    asValueHelper index tipe []


asValueHelper : Int -> Elm.Type.Type -> List Elm.Expression -> Elm.Expression
asValueHelper index tipe args =
    case tipe of
        Elm.Type.Lambda one two ->
            asValueHelper index two (skip :: args)

        _ ->
            case args of
                [] ->
                    Elm.valueWith local
                        (argName index)
                        expressionType

                _ ->
                    Elm.apply
                        (Elm.valueWith local
                            (argName index)
                            (Annotation.function
                                (List.repeat (List.length args) expressionType)
                                expressionType
                            )
                        )
                        (List.reverse args)


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
            Annotation.namedWith (Elm.moduleName []) name (List.map typeToAnnotation types)

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
            Elm.apply
                (Elm.valueWith elmAnnotation
                    "function"
                    (Annotation.function
                        [ Annotation.list annotationType
                        , annotationType
                        ]
                        annotationType
                    )
                )
                [ Elm.list (List.reverse exps)
                , typeToExpression tipe
                ]


typeToExpression : Elm.Type.Type -> Elm.Expression
typeToExpression elmType =
    case elmType of
        Elm.Type.Var string ->
            Elm.apply
                (Elm.valueWith elmAnnotation
                    "var"
                    (Annotation.function
                        [ Annotation.string ]
                        annotationType
                    )
                )
                [ Elm.string string
                ]

        Elm.Type.Lambda one two ->
            chompLambdas
                [ typeToExpression one
                ]
                two

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    Elm.valueWith elmAnnotation "unit" annotationType

                [ one, two ] ->
                    Elm.apply
                        (Elm.valueWith elmAnnotation
                            "tuple"
                            (Annotation.function
                                [ annotationType
                                , annotationType
                                ]
                                annotationType
                            )
                        )
                        [ typeToExpression one
                        , typeToExpression two
                        ]

                [ one, two, three ] ->
                    Elm.apply
                        (Elm.valueWith elmAnnotation
                            "triple"
                            (Annotation.function
                                [ annotationType
                                , annotationType
                                , annotationType
                                ]
                                annotationType
                            )
                        )
                        [ typeToExpression one
                        , typeToExpression two
                        , typeToExpression three
                        ]

                _ ->
                    -- this should never happen :/
                    Elm.valueWith elmAnnotation "unit" annotationType

        Elm.Type.Type name types ->
            let
                frags =
                    String.split "." name

                fragsLength =
                    List.length frags

                typeName =
                    List.drop (fragsLength - 1) frags
                        |> List.head
                        |> Maybe.withDefault name

                mod =
                    List.take (fragsLength - 1) frags
                        |> List.map Elm.string
            in
            Elm.apply
                (Elm.valueWith elmAnnotation
                    "namedWith"
                    (Annotation.function
                        [ Annotation.named elm "Module"
                        , Annotation.string
                        , Annotation.list annotationType
                        ]
                        annotationType
                    )
                )
                [ Elm.apply
                    (Elm.valueWith elm
                        "moduleName"
                        (Annotation.function
                            [ Annotation.list Annotation.string
                            ]
                            (Annotation.named elm "Module")
                        )
                    )
                    [ Elm.list mod ]
                , Elm.string typeName
                , Elm.list (List.map typeToExpression types)
                ]

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Elm.apply
                        (Elm.valueWith elmAnnotation
                            "record"
                            (Annotation.function
                                [ Annotation.list
                                    (Annotation.tuple
                                        Annotation.string
                                        annotationType
                                    )
                                ]
                                annotationType
                            )
                        )
                        [ Elm.list
                            (List.map
                                (\( fieldName, fieldType ) ->
                                    Elm.tuple
                                        (Elm.string fieldName)
                                        (typeToExpression fieldType)
                                )
                                fields
                            )
                        ]

                Just base ->
                    Elm.apply
                        (Elm.valueWith elmAnnotation
                            "extensible"
                            (Annotation.function
                                [ Annotation.string
                                , Annotation.list
                                    (Annotation.tuple
                                        Annotation.string
                                        annotationType
                                    )
                                ]
                                annotationType
                            )
                        )
                        [ Elm.string base
                        , Elm.list
                            (List.map
                                (\( fieldName, fieldType ) ->
                                    Elm.tuple
                                        (Elm.string fieldName)
                                        (typeToExpression fieldType)
                                )
                                fields
                            )
                        ]
