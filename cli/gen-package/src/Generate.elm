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


file =
    Elm.file (Elm.moduleName [ "My", "Module" ])
        [ Elm.declaration "placeholder"
            (Elm.valueFrom (Elm.moduleAs [ "Json", "Decode" ] "Json")
                "map2"
            )
        , Elm.declaration "myRecord"
            (Elm.record
                [ ( "field1", Elm.string "My cool string" )
                , ( "field2", Elm.int 5 )
                , ( "field4", Elm.string "My cool string" )
                , ( "field5", Elm.int 5 )
                , ( "field6", Elm.string "My cool string" )
                , ( "field7"
                  , Elm.record
                        [ ( "field1", Elm.string "My cool string" )
                        , ( "field2", Elm.int 5 )
                        ]
                  )
                ]
            )
            |> Elm.expose
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
    in
    Elm.file (Elm.moduleName modName)
        ((Elm.declarationWith "thisModule"
            (Annotation.named elm "Module")
            (Elm.apply
                (Elm.valueWith elm "moduleName" (Annotation.named elm "Module"))
                [ Elm.list (List.map Elm.string sourceModName)
                ]
            )
            |> Elm.withDocumentation " The name of this module. "
         )
            :: List.concatMap generateBlocks blocks
        )


elmAnnotation : Elm.Module
elmAnnotation =
    Elm.moduleName [ "Elm", "Annotation" ]


elm : Elm.Module
elm =
    Elm.moduleName [ "Elm" ]


local : Elm.Module
local =
    Elm.moduleName []


thisModuleName : Elm.Expression
thisModuleName =
    Elm.valueWith local "thisModule" (Annotation.named elm "Module")


generateBlocks : Elm.Docs.Block -> List Elm.Declaration
generateBlocks block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            []

        Elm.Docs.UnionBlock union ->
            -- we need a way to expose both the constructors and
            -- the annotation
            -- It's also possible no contructors are exposed.
            [--Elm.customTypeWith union.name
             --   union.args
             --   (List.map
             --       (\( name, types ) ->
             --           ( name, List.map convertType types )
             --       )
             --       union.tags
             --   )
             --   |> Elm.withDocumentation union.comment
            ]

        Elm.Docs.AliasBlock alias ->
            [ Elm.aliasWith alias.name
                alias.args
                (convertType alias.tipe)
                |> Elm.withDocumentation alias.comment
                |> Elm.expose
            ]

        Elm.Docs.ValueBlock value ->
            --if value.name /= "int" then
            --    []
            --
            --else
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


expressionType : Annotation.Annotation
expressionType =
    Annotation.named elm "Expression"


skip : Elm.Expression
skip =
    Elm.valueWith elm
        "pass"
        expressionType


valueFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
valueFrom mod name =
    Elm.apply
        (Elm.valueWith elm
            "valueFrom"
            (Annotation.function
                [ Annotation.named elm "Module"
                , Annotation.string

                --, Annotation.named elmAnnotation "Annotation"
                ]
                (Annotation.named elm "Expression")
            )
            --|> Debug.log "   VALUE FROM "
            |> logAnnotation "   VALUE FROM "
        )
        [ mod
        , name
        ]
        |> logAnnotation "   VF APPLIED -> "


apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply fn args =
    Elm.apply
        (Elm.valueWith elm
            "apply"
            (Annotation.function
                [ expressionType
                , expressionType
                ]
                expressionType
            )
        )
        [ fn
        , Elm.list args
        ]


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
convertType : Elm.Type.Type -> Annotation.Annotation
convertType elmType =
    case elmType of
        Elm.Type.Var string ->
            Annotation.var string

        Elm.Type.Lambda one two ->
            Annotation.function
                [ convertType one ]
                (convertType two)

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    Annotation.unit

                [ one, two ] ->
                    Annotation.tuple (convertType one) (convertType two)

                [ one, two, three ] ->
                    Annotation.triple (convertType one) (convertType two) (convertType three)

                _ ->
                    -- this should never happen :/
                    Annotation.unit

        Elm.Type.Type name types ->
            Annotation.namedWith (Elm.moduleName []) name (List.map convertType types)

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Annotation.record (List.map (Tuple.mapSecond convertType) fields)

                Just base ->
                    Annotation.extensible base (List.map (Tuple.mapSecond convertType) fields)
