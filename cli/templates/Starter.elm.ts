export default () => `
module Generate exposing (main)

{-| -}

import Elm
import Elm.Annotation as Type
import Gen.CodeGen.Generate as Generate
import Gen.Helper


main : Program {} () ()
main =
    Platform.worker
        { init =
            \\json ->
                ( ()
                , Generate.files
                    [ file
                    ]
                )
        , update =
            \\msg model ->
                ( model, Cmd.none )
        , subscriptions = \\_ -> Sub.none
        }


file : Elm.File
file =
    Elm.file [ "HelloWorld" ]
        [ Elm.declaration "hello"
            (Elm.string "World!")

        -- Here's an example of using a helper file!
        -- Add functions to codegen/helpers/{Whatever}.elm
        -- run elm-codegen install
        -- Then you can call those functions using import Gen.{Whatever}
        , Elm.declaration "usingAHelper"
            (Gen.Helper.add5 20)
        ]
`
