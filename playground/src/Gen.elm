module Gen exposing (main)

{-|-}


import Elm
import Elm.Type as Type
import Elm.Pattern as Pattern
import Generate


main : Program {} () ()
main =
    Platform.worker
        { init =
            \json ->
                ( ()
                , Generate.files
                    [ Elm.render file
                    ]
                )
        , update =
            \msg model ->
                (model, Cmd.none)
        , subscriptions = \_ -> Sub.none
        }



file =
    Elm.file (Elm.moduleName [ "My", "Module" ])
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]