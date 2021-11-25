export default () => `
module Generator exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Gen


main : Program {} () ()
main =
    Platform.worker
        { init =
            \\json ->
                ( ()
                , Elm.Gen.files
                    [ file
                    ]
                )
        , update =
            \\msg model ->
                ( model, Cmd.none )
        , subscriptions = \\_ -> Sub.none
        }


file =
    Elm.file [ "My", "Module" ]
        [ Elm.declaration "hello"
            (Elm.string "World!")
        ]
`