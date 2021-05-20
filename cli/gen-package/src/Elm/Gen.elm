port module Elm.Gen exposing (File, error, files)

import Json.Encode as Json


type alias File =
    { path : String
    , contents : String
    }


encodeFile : File -> Json.Value
encodeFile file =
    Json.object
        [ ( "path", Json.string file.path )
        , ( "contents", Json.string file.contents )
        ]


files : List File -> Cmd msg
files list =
    onSuccessSend (List.map encodeFile list)


error : String -> Cmd msg
error err =
    onFailureSend err


port onSuccessSend : List Json.Value -> Cmd msg


port onFailureSend : String -> Cmd msg
