port module Elm.Gen exposing (File, error, files)

import Json.Encode as Json


type alias File =
    { path : String
    , contents : String
    , warnings :
        List
            { declaration : String
            , warning : String
            }
    }


encodeFile : File -> Json.Value
encodeFile file =
    Json.object
        [ ( "path", Json.string file.path )
        , ( "contents", Json.string file.contents )
        ]


{-|

     Provide the list of files to be generated.
     These files will be generated and the script will end.

-}
files : List File -> Cmd msg
files list =
    onSuccessSend (List.map encodeFile list)


{-|

     Report an error.  The script will end

-}
error : { title : String, description : String } -> Cmd msg
error err =
    onFailureSend err


port onSuccessSend : List Json.Value -> Cmd msg


port onFailureSend : { title : String, description : String } -> Cmd msg
