module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Annotation
import Elm.Docs
import Elm.Gen
import Elm.Pattern as Pattern
import Elm.Type
import Json.Decode as Json


main : Program Json.Value () ()
main =
    Platform.worker
        { init =
            \json ->
                case Debug.log "Value decoding" (Json.decodeValue (Json.list Elm.Docs.decoder) json) of
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
        (List.concatMap (generateBlocks modName) blocks)


elm =
    Elm.moduleName [ "Elm" ]


generateBlocks : List String -> Elm.Docs.Block -> List Elm.Declaration
generateBlocks mod block =
    case block of
        Elm.Docs.MarkdownBlock str ->
            []

        Elm.Docs.UnionBlock union ->
            []

        Elm.Docs.AliasBlock alias ->
            [--Elm.declarationWith value.name
             --    (Annotation.named elm "Expression")
             --    (Elm.apply
             --        (Elm.valueFrom elm "valueFrom")
             --        [ Elm.apply (Elm.valueFrom elm "moduleName")
             --            [ Elm.list (List.map Elm.string mod)
             --            ]
             --        , Elm.string value.name
             --        ]
             --    )
             --    |> Elm.withDocumentation (value.comment ++ "\n\n")
            ]

        Elm.Docs.ValueBlock value ->
            [ Elm.declarationWith value.name
                (Annotation.named elm "Expression")
                (Elm.apply
                    (Elm.valueFrom elm "valueFrom")
                    [ Elm.apply (Elm.valueFrom elm "moduleName")
                        [ Elm.list (List.map Elm.string mod)
                        ]
                    , Elm.string value.name
                    ]
                )
                |> Elm.withDocumentation (value.comment ++ "\n\n")
            ]

        Elm.Docs.BinopBlock binop ->
            []

        Elm.Docs.UnknownBlock str ->
            []


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
            Debug.todo ""

        Elm.Type.Tuple types ->
            case types of
                [] ->
                    Annotation.unit

                [ one, two ] ->
                    Annotation.tuple (convertType one) (convertType two)

                [ one, two, three ] ->
                    Annotation.triple (convertType one) (convertType two) (convertType three)

                _ ->
                    Debug.todo "what to do??"

        Elm.Type.Type name types ->
            Annotation.namedWith (Elm.moduleName []) name (List.map convertType types)

        Elm.Type.Record fields maybeExtensible ->
            case maybeExtensible of
                Nothing ->
                    Annotation.record (List.map (Tuple.mapSecond convertType) fields)

                Just base ->
                    Annotation.extensible base (List.map (Tuple.mapSecond convertType) fields)
