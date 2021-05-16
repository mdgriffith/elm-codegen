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
                        , Elm.Gen.files
                            [ Elm.render file
                            ]
                        )

                    Ok docs ->
                        ( ()
                        , Elm.Gen.files
                            [ Elm.render file
                            ]
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
