module Docs exposing
    ( Docs, decoder
    , Module
    , Union, Alias, Value
    )

{-|

@docs Docs, decoder
@docs Module
@docs Union, Alias, Value

-}

import Dict exposing (Dict)
import Json.Decode as Json


type alias Docs =
    List Module


{-| This is the fully qualified name of the value/function.

Like `Html.text`

-}
type alias QualifiedValue =
    String


type alias FileName =
    String


type alias UsageCount =
    Int


type alias Module =
    { name : String
    , comment : String
    , unions : List Union
    , aliases : List Alias
    , values : List Value
    }


type alias Union =
    { name : String
    , comment : String
    , args : List String
    , cases : List ( String, List String )
    }


type alias Alias =
    { name : String
    , comment : String
    , args : List String
    , type_ : String
    }


type alias Value =
    { name : String
    , comment : String
    , type_ : String
    }


decoder : Json.Decoder Docs
decoder =
    Json.list moduleDecoder


moduleDecoder : Json.Decoder Module
moduleDecoder =
    Json.map5 Module
        (Json.field "name" Json.string)
        (Json.field "comment" Json.string)
        (Json.field "unions" (Json.list unionDecoder))
        (Json.field "aliases" (Json.list aliasDecoder))
        (Json.field "values" (Json.list valueDecoder))


unionDecoder : Json.Decoder Union
unionDecoder =
    let
        caseDecoder : Json.Decoder ( String, List String )
        caseDecoder =
            Json.map2 Tuple.pair
                (Json.index 0 Json.string)
                (Json.index 1 (Json.list Json.string))
    in
    Json.map4 Union
        (Json.field "name" Json.string)
        (Json.field "comment" Json.string)
        (Json.field "args" (Json.list Json.string))
        (Json.field "cases" (Json.list caseDecoder))


aliasDecoder : Json.Decoder Alias
aliasDecoder =
    Json.map4 Alias
        (Json.field "name" Json.string)
        (Json.field "comment" Json.string)
        (Json.field "args" (Json.list Json.string))
        (Json.field "type" Json.string)


valueDecoder : Json.Decoder Value
valueDecoder =
    Json.map3 Value
        (Json.field "name" Json.string)
        (Json.field "comment" Json.string)
        (Json.field "type" Json.string)
