module Gen.Result exposing (andThen, annotation_, call_, caseOf_, fromMaybe, make_, map, map2, map3, map4, map5, mapError, moduleName_, toMaybe, values_, withDefault)

{-| 
@docs moduleName_, map, map2, map3, map4, map5, andThen, withDefault, toMaybe, fromMaybe, mapError, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Result" ]


{-| Apply a function to a result. If the result is `Ok`, it will be converted.
If the result is an `Err`, the same error value will propagate through.

    map sqrt (Ok 4.0)          == Ok 2.0
    map sqrt (Err "bad input") == Err "bad input"
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


{-| Apply a function if both results are `Ok`. If not, the first `Err` will
propagate through.

    map2 max (Ok 42)   (Ok 13)   == Ok 42
    map2 max (Err "x") (Ok 13)   == Err "x"
    map2 max (Ok 42)   (Err "y") == Err "y"
    map2 max (Err "x") (Err "y") == Err "x"

This can be useful if you have two computations that may fail, and you want
to put them together quickly.
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 -> Elm.functionReduced "unpack" (arg1 unpack_3_3_0))
        , arg2_1
        , arg3_2
        ]


{-|-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 arg1 arg2_1 arg3_2 arg4_3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 ->
                Elm.functionReduced
                    "unpack"
                    (\unpack_3_3_3_0 ->
                        Elm.functionReduced
                            "unpack"
                            (arg1 unpack_3_3_0 unpack_3_3_3_0)
                    )
            )
        , arg2_1
        , arg3_2
        , arg4_3
        ]


{-|-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 arg1 arg2_1 arg3_2 arg4_3 arg5_4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 ->
                Elm.functionReduced
                    "unpack"
                    (\unpack_3_3_3_0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_3_3_3_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (arg1 unpack_3_3_0 unpack_3_3_3_0
                                        unpack_3_3_3_3_0
                                    )
                            )
                    )
            )
        , arg2_1
        , arg3_2
        , arg4_3
        , arg5_4
        ]


{-|-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 arg1 arg2_1 arg3_2 arg4_3 arg5_4 arg6_5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 ->
                Elm.functionReduced
                    "unpack"
                    (\unpack_3_3_3_0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_3_3_3_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_3_3_3_3_3_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (arg1 unpack_3_3_0 unpack_3_3_3_0
                                                 unpack_3_3_3_3_0
                                                unpack_3_3_3_3_3_0
                                            )
                                    )
                            )
                    )
            )
        , arg2_1
        , arg3_2
        , arg4_3
        , arg5_4
        , arg6_5
        ]


{-| Chain together a sequence of computations that may fail. It is helpful
to see its definition:

    andThen : (a -> Result e b) -> Result e a -> Result e b
    andThen callback result =
        case result of
          Ok value -> callback value
          Err msg -> Err msg

This means we only continue with the callback if things are going well. For
example, say you need to use (`toInt : String -> Result String Int`) to parse
a month and make sure it is between 1 and 12:

    toValidMonth : Int -> Result String Int
    toValidMonth month =
        if month >= 1 && month <= 12
            then Ok month
            else Err "months must be between 1 and 12"

    toMonth : String -> Result String Int
    toMonth rawString =
        toInt rawString
          |> andThen toValidMonth

    -- toMonth "4" == Ok 4
    -- toMonth "9" == Ok 9
    -- toMonth "a" == Err "cannot parse to an Int"
    -- toMonth "0" == Err "months must be between 1 and 12"

This allows us to come out of a chain of operations with quite a specific error
message. It is often best to create a custom type that explicitly represents
the exact ways your computation may fail. This way it is easy to handle in your
code.
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


{-| If the result is `Ok` return the value, but if the result is an `Err` then
return a given default value. The following examples try to parse integers.

    Result.withDefault 0 (Ok 123)   == 123
    Result.withDefault 0 (Err "no") == 0
-}
withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
withDefault arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a"
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.var "a")
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Convert to a simpler `Maybe` if the actual error message is not needed or
you need to interact with some code that primarily uses maybes.

    parseInt : String -> Result ParseError Int

    maybeParseInt : String -> Maybe Int
    maybeParseInt string =
        toMaybe (parseInt string)
-}
toMaybe : Elm.Expression -> Elm.Expression
toMaybe arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "toMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.maybe (Type.var "a"))
                    )
            }
        )
        [ arg1 ]


{-| Convert from a simple `Maybe` to interact with some code that primarily
uses `Results`.

    parseInt : String -> Maybe Int

    resultParseInt : String -> Result String Int
    resultParseInt string =
        fromMaybe ("error parsing string: " ++ toString string) (parseInt string)
-}
fromMaybe : Elm.Expression -> Elm.Expression -> Elm.Expression
fromMaybe arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "fromMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x", Type.maybe (Type.var "a") ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Transform an `Err` value. For example, say the errors we get have too much
information:

    parseInt : String -> Result ParseError Int

    type alias ParseError =
        { message : String
        , code : Int
        , position : (Int,Int)
        }

    mapError .message (parseInt "123") == Ok 123
    mapError .message (parseInt "abc") == Err "char 'a' is not a number"
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "x" ] (Type.var "y")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


annotation_ : { result : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { result =
        \arg0_0 arg1_1_0 ->
            Type.namedWith moduleName_ "Result" [ arg0_0, arg1_1_0 ]
    }


make_ :
    { ok : Elm.Expression -> Elm.Expression
    , err : Elm.Expression -> Elm.Expression
    }
make_ =
    { ok =
        \ar0_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "Ok"
                    , annotation =
                        Just
                            (Type.namedWith
                                []
                                "Result"
                                [ Type.var "error", Type.var "value" ]
                            )
                    }
                )
                [ ar0_0 ]
    , err =
        \ar0_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "Err"
                    , annotation =
                        Just
                            (Type.namedWith
                                []
                                "Result"
                                [ Type.var "error", Type.var "value" ]
                            )
                    }
                )
                [ ar0_1_0 ]
    }


caseOf_ :
    { result :
        Elm.Expression
        -> { tags_1_0
            | ok : Elm.Expression -> Elm.Expression
            , err : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { result =
        \expresssion_0 tags_1_0 ->
            Elm.Case.custom
                expresssion_0
                [ Elm.Case.branch1 [ "Result" ] "Ok" tags_1_0.ok
                , Elm.Case.branch1 [ "Result" ] "Err" tags_1_0.err
                ]
    }


call_ :
    { map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toMaybe : Elm.Expression -> Elm.Expression
    , fromMaybe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , mapError : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { map =
        \arg1_0 arg2_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "value" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_1_0 ]
    , map2 =
        \arg1_1_0 arg2_2_0 arg3_3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "value" ]
                                )
                            )
                    }
                )
                [ arg1_1_0, arg2_2_0, arg3_3_0 ]
    , map3 =
        \arg1_2_0 arg2_3_0 arg3_4_0 arg4_5_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b", Type.var "c" ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "c" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "value" ]
                                )
                            )
                    }
                )
                [ arg1_2_0, arg2_3_0, arg3_4_0, arg4_5_0 ]
    , map4 =
        \arg1_3_0 arg2_4_0 arg3_5_0 arg4_6_0 arg5_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "map4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "c" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "d" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "value" ]
                                )
                            )
                    }
                )
                [ arg1_3_0, arg2_4_0, arg3_5_0, arg4_6_0, arg5_7_0 ]
    , map5 =
        \arg1_4_0 arg2_5_0 arg3_6_0 arg4_7_0 arg5_8_0 arg6_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "map5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "c" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "d" ]
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "e" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "value" ]
                                )
                            )
                    }
                )
                [ arg1_4_0, arg2_5_0, arg3_6_0, arg4_7_0, arg5_8_0, arg6_9_0 ]
    , andThen =
        \arg1_5_0 arg2_6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "b" ]
                                    )
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "b" ]
                                )
                            )
                    }
                )
                [ arg1_5_0, arg2_6_0 ]
    , withDefault =
        \arg1_6_0 arg2_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "withDefault"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a"
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.var "a")
                            )
                    }
                )
                [ arg1_6_0, arg2_7_0 ]
    , toMaybe =
        \arg1_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "toMaybe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.maybe (Type.var "a"))
                            )
                    }
                )
                [ arg1_7_0 ]
    , fromMaybe =
        \arg1_8_0 arg2_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "fromMaybe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x", Type.maybe (Type.var "a") ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1_8_0, arg2_9_0 ]
    , mapError =
        \arg1_9_0 arg2_10_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "mapError"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "x" ] (Type.var "y")
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "y", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1_9_0, arg2_10_0 ]
    }


values_ :
    { map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , andThen : Elm.Expression
    , withDefault : Elm.Expression
    , toMaybe : Elm.Expression
    , fromMaybe : Elm.Expression
    , mapError : Elm.Expression
    }
values_ =
    { map =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
    , withDefault =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a"
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.var "a")
                    )
            }
    , toMaybe =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "toMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.maybe (Type.var "a"))
                    )
            }
    , fromMaybe =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "fromMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x", Type.maybe (Type.var "a") ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "x" ] (Type.var "y")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
    }


