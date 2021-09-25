module My.Module exposing (myRecord, myString, myString2)

{-| 

@docs myRecord

@docs myString, myString2


-}


import Json.Decode as Json


placeholder12 =
    Json.map2


{- Yo, wassuyp!? -}


myRecord :
    { field1 : String
    , field2 : Int
    , field4 : Bool
    , field5 : Int
    , field6 : String
    , field7 : { field1 : String, field2 : Int }
    }
myRecord =
    { field1 = "My cool string"
    , field2 = 5
    , field4 = False
    , field5 = 5
    , field6 = "My cool string?!?!?!"
    , field7 = { field1 = "My cool string", field2 = 5 }
    }


myString : String
myString =
    "Hello world!"


myString2 : String
myString2 =
    "Hello world!"


type MyType
    = One
    | Two (List String)


type MyType markdown
    = One
    | Two (List markdown)


