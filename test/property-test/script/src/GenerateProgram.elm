module GenerateProgram exposing (run)

{-| elm-pages script that generates random Elm programs using elm-codegen
and writes them to disk for property testing.
-}

import BackendTask
import Cli.Option as Option
import Cli.OptionsParser as OptionsParser
import Cli.Program as Program
import Elm
import FatalError exposing (FatalError)
import Generate.Program
import Json.Encode
import Pages.Script as Script exposing (Script)
import Random


type alias CliOptions =
    { seed : Int
    , count : Int
    }


run : Script
run =
    Script.withCliOptions program
        (\{ seed, count } ->
            let
                initialSeed =
                    Random.initialSeed seed

                allFiles =
                    generatePrograms initialSeed count []
            in
            allFiles
                |> List.map writeFile
                |> BackendTask.combine
                |> BackendTask.andThen
                    (\_ ->
                        writeManifest
                            (allFiles
                                |> List.map
                                    (\file ->
                                        file.path
                                            |> String.replace ".elm" ""
                                            |> String.replace "/" "."
                                    )
                            )
                    )
                |> BackendTask.andThen
                    (\_ ->
                        Script.log
                            ("Generated "
                                ++ String.fromInt (List.length allFiles)
                                ++ " files with seed "
                                ++ String.fromInt seed
                            )
                    )
        )


program : Program.Config CliOptions
program =
    Program.config
        |> Program.add
            (OptionsParser.build CliOptions
                |> OptionsParser.with
                    (Option.requiredKeywordArg "seed"
                        |> Option.validateMap
                            (\s ->
                                case String.toInt s of
                                    Just i ->
                                        Ok i

                                    Nothing ->
                                        Err "seed must be an integer"
                            )
                    )
                |> OptionsParser.with
                    (Option.optionalKeywordArg "count"
                        |> Option.withDefault "10"
                        |> Option.validateMap
                            (\s ->
                                case String.toInt s of
                                    Just i ->
                                        Ok i

                                    Nothing ->
                                        Err "count must be an integer"
                            )
                    )
            )


writeFile : Elm.File -> BackendTask.BackendTask FatalError ()
writeFile file =
    Script.writeFile
        { path = "../generated/src/" ++ file.path
        , body = file.contents
        }
        |> BackendTask.allowFatal


writeManifest : List String -> BackendTask.BackendTask FatalError ()
writeManifest moduleNames =
    Script.writeFile
        { path = "../generated/manifest.json"
        , body = Json.Encode.encode 2 (Json.Encode.list Json.Encode.string moduleNames)
        }
        |> BackendTask.allowFatal


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
