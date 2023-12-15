port module Gen.CodeGen.Generate exposing
    ( run, fromJson, fromText, fromDirectory, directoryDecoder
    , withFeedback, Error
    , File, Directory(..)
    , error, files, info
    )

{-|


# Simple API

@docs run, fromJson, fromText, fromDirectory, directoryDecoder


# With errors

@docs withFeedback, Error


# Types

@docs File, Directory


# Flexible API

This is the low level API if you need more control over the generation process proceeds.

@docs error, files, info

-}

import Dict exposing (Dict)
import Json.Decode exposing (Decoder)
import Json.Encode as Json


{-| Produce a list of files without taking input.
-}
run : List File -> Program flags () ()
run f =
    Platform.worker
        { init =
            \_ ->
                ( ()
                , files f
                )
        , update =
            \_ model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


{-| Given the flags, decoded from JSON, produce a list of files as output.
-}
fromJson : Decoder flags -> (flags -> List File) -> Program Json.Value () ()
fromJson decoder f =
    Platform.worker
        { init =
            \flags ->
                case Json.Decode.decodeValue decoder flags of
                    Ok input ->
                        ( ()
                        , files (f input)
                        )

                    Err e ->
                        ( ()
                        , error
                            [ { title = "Error decoding flags"
                              , description = Json.Decode.errorToString e
                              }
                            ]
                        )
        , update =
            \_ model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


{-| Given the file passed in with `--flags-from` as String, produce a list of files as output.
-}
fromText : (String -> List File) -> Program String () ()
fromText f =
    Platform.worker
        { init =
            \flags ->
                ( ()
                , files (f flags)
                )
        , update =
            \_ model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


{-| Given the directory passed in with `--flags-from` as a file tree, produce a list of files as output.
-}
fromDirectory : (Directory -> List File) -> Program Json.Value () ()
fromDirectory f =
    Platform.worker
        { init =
            \flags ->
                case Json.Decode.decodeValue directoryDecoder flags of
                    Ok input ->
                        ( ()
                        , files (f input)
                        )

                    Err e ->
                        ( ()
                        , error
                            [ { title = "Error decoding flags"
                              , description = Json.Decode.errorToString e
                              }
                            ]
                        )
        , update =
            \_ model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


directoryDecoder : Decoder Directory
directoryDecoder =
    Json.Decode.lazy
        (\_ ->
            Json.Decode.oneOf
                [ Json.Decode.map Ok Json.Decode.string
                , Json.Decode.map Err directoryDecoder
                ]
                |> Json.Decode.dict
                |> Json.Decode.map
                    (\entries ->
                        entries
                            |> Dict.toList
                            |> List.foldl
                                (\( name, entry ) ( dirAcc, fileAcc ) ->
                                    case entry of
                                        Ok file ->
                                            ( dirAcc, ( name, file ) :: fileAcc )

                                        Err directory ->
                                            ( ( name, directory ) :: dirAcc, fileAcc )
                                )
                                ( [], [] )
                            |> (\( dirAcc, fileAcc ) ->
                                    Directory
                                        { directories = Dict.fromList dirAcc
                                        , files = Dict.fromList fileAcc
                                        }
                               )
                    )
        )


type Directory
    = Directory
        { files : Dict String String
        , directories : Dict String Directory
        }


type alias File =
    { path : String
    , contents : String
    , warnings :
        List
            { declaration : String
            , warning : String
            }
    }


type alias Error =
    { title : String
    , description : String
    }


withFeedback :
    (flags
     -> Result (List Error) { info : List String, files : List File }
    )
    -> Program flags () ()
withFeedback f =
    Platform.worker
        { init =
            \flags ->
                ( ()
                , case f flags of
                    Ok result ->
                        Cmd.batch <|
                            List.map info result.info
                                ++ [ files result.files ]

                    Err errors ->
                        error errors
                )
        , update =
            \_ model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


{-| Provide the list of files to be generated.
These files will be generated and the script will end.
-}
files : List File -> Cmd msg
files list =
    onSuccessSend list


{-| Report an error. The script will end.
-}
error : List Error -> Cmd msg
error errs =
    onFailureSend errs


{-| Report some info. The script will continue to run.
-}
info : String -> Cmd msg
info err =
    onInfoSend err


port onSuccessSend : List File -> Cmd msg


port onFailureSend : List Error -> Cmd msg


port onInfoSend : String -> Cmd msg
