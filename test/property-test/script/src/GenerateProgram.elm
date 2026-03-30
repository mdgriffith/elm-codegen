port module GenerateProgram exposing (main)

{-| A simple Platform.worker that generates random Elm programs
using elm-codegen and sends them through a port to be written by Node.js.
-}

import Elm
import Generate.Program
import Json.Encode
import Random


port output : Json.Encode.Value -> Cmd msg


type alias Flags =
    { seed : Int
    , count : Int
    }


main : Program Flags () Never
main =
    Platform.worker
        { init =
            \flags ->
                let
                    initialSeed =
                        Random.initialSeed flags.seed

                    allFiles =
                        generatePrograms initialSeed flags.count []

                    encodedFiles =
                        allFiles
                            |> List.map
                                (\file ->
                                    Json.Encode.object
                                        [ ( "path", Json.Encode.string file.path )
                                        , ( "contents", Json.Encode.string file.contents )
                                        ]
                                )

                    moduleNames =
                        allFiles
                            |> List.map
                                (\file ->
                                    -- Extract module name from path: "Test0.elm" -> "Test0"
                                    file.path
                                        |> String.replace ".elm" ""
                                        |> String.replace "/" "."
                                )

                    payload =
                        Json.Encode.object
                            [ ( "files", Json.Encode.list identity encodedFiles )
                            , ( "moduleNames", Json.Encode.list Json.Encode.string moduleNames )
                            ]
                in
                ( (), output payload )
        , update = \_ model -> ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


{-| Generate all files across all test programs. Each program can produce
1 or 2 files (single module or library+consumer pair).
-}
generatePrograms : Random.Seed -> Int -> List Elm.File -> List Elm.File
generatePrograms seed remaining acc =
    if remaining <= 0 then
        List.reverse acc

    else
        let
            index =
                List.length acc

            ( files, nextSeed ) =
                Random.step (Generate.Program.programGenerator index) seed
        in
        generatePrograms nextSeed
            (remaining - 1)
            (List.reverse files ++ acc)
