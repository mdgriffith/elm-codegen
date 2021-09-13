module My.Module exposing (myRecord)

{-| 


-}

import Json.Decode as Json


placeholder =
    Json.map2


myRecord :
    { field1 : String
    , field2 : Int
    , field4 : String
    , field5 : Int
    , field6 : String
    , field7 : { field1 : String, field2 : Int }
    }
myRecord =
    { field1 = "My cool string"
    , field2 = 5
    , field4 = "My cool string"
    , field5 = 5
    , field6 = "My cool string"
    , field7 = { field1 = "My cool string", field2 = 5 }
    }
