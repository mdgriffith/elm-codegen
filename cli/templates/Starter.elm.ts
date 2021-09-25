export default () => `
module Generator exposing (main)

{-| -}

import Elm
import Elm.Pattern as Pattern
import Elm.Type as Type
import Elm.Gen


main : Program {} () ()
main =
    Platform.worker
        { init =
            \\json ->
                ( ()
                , Elm.Gen.files
                    [ Elm.render file
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