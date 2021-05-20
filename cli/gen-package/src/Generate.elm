module Generate exposing (main)

{-| -}

import Docs
import Elm
import Elm.Gen
import Elm.Pattern as Pattern
import Elm.Type as Type
import Json.Decode as Json


main : Program Json.Value () ()
main =
    Platform.worker
        { init =
            \json ->
                case Debug.log "Value decoding" (Json.decodeValue Docs.decoder json) of
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


moduleToFile : Docs.Module -> Elm.File
moduleToFile docs =
    let
        sourceModName =
            String.split "." docs.name

        modName =
            "Elm" :: "Gen" :: sourceModName
    in
    Elm.file (Elm.moduleName modName)
        (List.concat
            [ List.map (generateValues sourceModName) docs.values
            ]
        )


elm =
    Elm.moduleName [ "Elm" ]


generateValues : List String -> Docs.Value -> Elm.Declaration
generateValues mod value =
    Elm.declaration value.name
        (Elm.apply
            (Elm.valueFrom elm "valueFrom")
            [ Elm.apply (Elm.valueFrom elm "moduleName")
                [ Elm.list (List.map Elm.string mod)
                ]
            , Elm.string value.name
            ]
        )



--value.name)
