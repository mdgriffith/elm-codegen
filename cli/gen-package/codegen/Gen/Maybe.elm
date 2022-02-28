module Gen.Maybe exposing (andThen, annotation_, call_, caseOf_, make_, map, map2, map3, map4, map5, moduleName_, values_, withDefault)

{-| 
@docs moduleName_, withDefault, map, map2, map3, map4, map5, andThen, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Maybe" ]


{-| Provide a default value, turning an optional value into a normal
value.  This comes in handy when paired with functions like
[`Dict.get`](Dict#get) which gives back a `Maybe`.

    withDefault 100 (Just 42)   -- 42
    withDefault 100 Nothing     -- 100

    withDefault "unknown" (Dict.get "Tom" Dict.empty)   -- "unknown"

**Note:** This can be overused! Many cases are better handled by a `case`
expression. And if you end up using `withDefault` a lot, it can be a good sign
that a [custom type][ct] will clean your code up quite a bit!

[ct]: https://guide.elm-lang.org/types/custom_types.html
-}
withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
withDefault arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.maybe (Type.var "a") ]
                        (Type.var "a")
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Transform a `Maybe` value with a given function:

    map sqrt (Just 9) == Just 3
    map sqrt Nothing  == Nothing

    map sqrt (String.toFloat "9") == Just 3
    map sqrt (String.toFloat "x") == Nothing

-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), arg2_1 ]


{-| Apply a function if all the arguments are `Just` a value.

    map2 (+) (Just 3) (Just 4) == Just 7
    map2 (+) (Just 3) Nothing == Nothing
    map2 (+) Nothing (Just 4) == Nothing

    map2 (+) (String.toInt "1") (String.toInt "123") == Just 124
    map2 (+) (String.toInt "x") (String.toInt "123") == Nothing
    map2 (+) (String.toInt "1") (String.toInt "1.3") == Nothing
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
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
            { importFrom = [ "Maybe" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                arg1 fn0_3_3_0 fn0_3_3_3_0 fn0_3_3_3_3_0
                            )
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
            { importFrom = [ "Maybe" ]
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
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        , Type.maybe (Type.var "d")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                Elm.fn
                                    "unpack3"
                                    (\fn0_3_3_3_3_3_0 ->
                                        arg1 fn0_3_3_0 fn0_3_3_3_0 fn0_3_3_3_3_0
                                            fn0_3_3_3_3_3_0
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
            { importFrom = [ "Maybe" ]
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
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        , Type.maybe (Type.var "d")
                        , Type.maybe (Type.var "e")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                Elm.fn
                                    "unpack3"
                                    (\fn0_3_3_3_3_3_0 ->
                                        Elm.fn
                                            "unpack4"
                                            (\fn0_3_3_3_3_3_3_0 ->
                                                arg1 fn0_3_3_0 fn0_3_3_3_0
                                                    fn0_3_3_3_3_0
                                                    fn0_3_3_3_3_3_0
                                                    fn0_3_3_3_3_3_3_0
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


{-| Chain together many computations that may fail. It is helpful to see its
definition:

    andThen : (a -> Maybe b) -> Maybe a -> Maybe b
    andThen callback maybe =
        case maybe of
            Just value ->
                callback value

            Nothing ->
                Nothing

This means we only continue with the callback if things are going well. For
example, say you need to parse some user input as a month:

    parseMonth : String -> Maybe Int
    parseMonth userInput =
        String.toInt userInput
          |> andThen toValidMonth

    toValidMonth : Int -> Maybe Int
    toValidMonth month =
        if 1 <= month && month <= 12 then
            Just month
        else
            Nothing

In the `parseMonth` function, if `String.toInt` produces `Nothing` (because
the `userInput` was not an integer) this entire chain of operations will
short-circuit and result in `Nothing`. If `toValidMonth` results in `Nothing`,
again the chain of computations will result in `Nothing`.
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), arg2_1 ]


annotation_ : { maybe : Type.Annotation -> Type.Annotation }
annotation_ =
    { maybe = \arg0_0 -> Type.namedWith moduleName_ "Maybe" [ arg0_0 ] }


make_ : { just : Elm.Expression -> Elm.Expression, nothing : Elm.Expression }
make_ =
    { just =
        \ar0_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "Just"
                    , annotation =
                        Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
                    }
                )
                [ ar0_0 ]
    , nothing =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "Nothing"
            , annotation = Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
            }
    }


caseOf_ :
    { maybe :
        Elm.Expression
        -> { tags_1_0
            | just : Elm.Expression -> Elm.Expression
            , nothing : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { maybe =
        \expresssion_0 tags_1_0 ->
            Elm.Case.custom
                expresssion_0
                [ Elm.Case.branch1 [ "Maybe" ] "Just" tags_1_0.just
                , Elm.Case.branch0 [ "Maybe" ] "Nothing" tags_1_0.nothing
                ]
    }


call_ :
    { withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    }
call_ =
    { withDefault =
        \arg1_0 arg2_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "withDefault"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.maybe (Type.var "a") ]
                                (Type.var "a")
                            )
                    }
                )
                [ arg1_0, arg2_1_0 ]
    , map =
        \arg1_1_0 arg2_2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "b")
                                , Type.maybe (Type.var "a")
                                ]
                                (Type.maybe (Type.var "b"))
                            )
                    }
                )
                [ arg1_1_0, arg2_2_0 ]
    , map2 =
        \arg1_2_0 arg2_3_0 arg3_4_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "value")
                                , Type.maybe (Type.var "a")
                                , Type.maybe (Type.var "b")
                                ]
                                (Type.maybe (Type.var "value"))
                            )
                    }
                )
                [ arg1_2_0, arg2_3_0, arg3_4_0 ]
    , map3 =
        \arg1_3_0 arg2_4_0 arg3_5_0 arg4_6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b", Type.var "c" ]
                                    (Type.var "value")
                                , Type.maybe (Type.var "a")
                                , Type.maybe (Type.var "b")
                                , Type.maybe (Type.var "c")
                                ]
                                (Type.maybe (Type.var "value"))
                            )
                    }
                )
                [ arg1_3_0, arg2_4_0, arg3_5_0, arg4_6_0 ]
    , map4 =
        \arg1_4_0 arg2_5_0 arg3_6_0 arg4_7_0 arg5_8_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
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
                                , Type.maybe (Type.var "a")
                                , Type.maybe (Type.var "b")
                                , Type.maybe (Type.var "c")
                                , Type.maybe (Type.var "d")
                                ]
                                (Type.maybe (Type.var "value"))
                            )
                    }
                )
                [ arg1_4_0, arg2_5_0, arg3_6_0, arg4_7_0, arg5_8_0 ]
    , map5 =
        \arg1_5_0 arg2_6_0 arg3_7_0 arg4_8_0 arg5_9_0 arg6_10_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
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
                                , Type.maybe (Type.var "a")
                                , Type.maybe (Type.var "b")
                                , Type.maybe (Type.var "c")
                                , Type.maybe (Type.var "d")
                                , Type.maybe (Type.var "e")
                                ]
                                (Type.maybe (Type.var "value"))
                            )
                    }
                )
                [ arg1_5_0, arg2_6_0, arg3_7_0, arg4_8_0, arg5_9_0, arg6_10_0 ]
    , andThen =
        \arg1_6_0 arg2_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Maybe" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.maybe (Type.var "b"))
                                , Type.maybe (Type.var "a")
                                ]
                                (Type.maybe (Type.var "b"))
                            )
                    }
                )
                [ arg1_6_0, arg2_7_0 ]
    }


values_ :
    { withDefault : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , andThen : Elm.Expression
    }
values_ =
    { withDefault =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.maybe (Type.var "a") ]
                        (Type.var "a")
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Maybe" ]
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
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        , Type.maybe (Type.var "d")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Maybe" ]
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
                        , Type.maybe (Type.var "a")
                        , Type.maybe (Type.var "b")
                        , Type.maybe (Type.var "c")
                        , Type.maybe (Type.var "d")
                        , Type.maybe (Type.var "e")
                        ]
                        (Type.maybe (Type.var "value"))
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
    }


