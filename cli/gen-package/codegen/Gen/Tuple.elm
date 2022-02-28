module Gen.Tuple exposing (call_, first, mapBoth, mapFirst, mapSecond, moduleName_, pair, second, values_)

{-| 
@docs moduleName_, pair, first, second, mapFirst, mapSecond, mapBoth, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Tuple" ]


{-| Create a 2-tuple.

    -- pair 3 4 == (3, 4)

    zip : List a -> List b -> List (a, b)
    zip xs ys =
      List.map2 Tuple.pair xs ys
-}
pair : Elm.Expression -> Elm.Expression -> Elm.Expression
pair arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "pair"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.var "b" ]
                        (Type.tuple (Type.var "a") (Type.var "b"))
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Extract the first value from a tuple.

    first (3, 4) == 3
    first ("john", "doe") == "john"
-}
first : Elm.Expression -> Elm.Expression
first arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "first"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple (Type.var "a") (Type.var "b") ]
                        (Type.var "a")
                    )
            }
        )
        [ arg1 ]


{-| Extract the second value from a tuple.

    second (3, 4) == 4
    second ("john", "doe") == "doe"
-}
second : Elm.Expression -> Elm.Expression
second arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "second"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple (Type.var "a") (Type.var "b") ]
                        (Type.var "b")
                    )
            }
        )
        [ arg1 ]


{-| Transform the first value in a tuple.

    import String

    mapFirst String.reverse ("stressed", 16) == ("desserts", 16)
    mapFirst String.length  ("stressed", 16) == (8, 16)
-}
mapFirst :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapFirst arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapFirst"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "x")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "x") (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), arg2_1 ]


{-| Transform the second value in a tuple.

    mapSecond sqrt   ("stressed", 16) == ("stressed", 4)
    mapSecond negate ("stressed", 16) == ("stressed", -16)
-}
mapSecond :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapSecond arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapSecond"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "b" ] (Type.var "y")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "a") (Type.var "y"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), arg2_1 ]


{-| Transform both parts of a tuple.

    import String

    mapBoth String.reverse sqrt  ("stressed", 16) == ("desserts", 4)
    mapBoth String.length negate ("stressed", 16) == (8, -16)
-}
mapBoth :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
mapBoth arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapBoth"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "x")
                        , Type.function [ Type.var "b" ] (Type.var "y")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "x") (Type.var "y"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0)
        , Elm.fn "unpack0" (\fn0_4_3_0 -> arg2_1 fn0_4_3_0)
        , arg3_2
        ]


call_ :
    { pair : Elm.Expression -> Elm.Expression -> Elm.Expression
    , first : Elm.Expression -> Elm.Expression
    , second : Elm.Expression -> Elm.Expression
    , mapFirst : Elm.Expression -> Elm.Expression -> Elm.Expression
    , mapSecond : Elm.Expression -> Elm.Expression -> Elm.Expression
    , mapBoth :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { pair =
        \arg1_0 arg2_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "pair"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.var "b" ]
                                (Type.tuple (Type.var "a") (Type.var "b"))
                            )
                    }
                )
                [ arg1_0, arg2_1_0 ]
    , first =
        \arg1_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "first"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple (Type.var "a") (Type.var "b") ]
                                (Type.var "a")
                            )
                    }
                )
                [ arg1_1_0 ]
    , second =
        \arg1_2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "second"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple (Type.var "a") (Type.var "b") ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_2_0 ]
    , mapFirst =
        \arg1_3_0 arg2_4_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "mapFirst"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "x")
                                , Type.tuple (Type.var "a") (Type.var "b")
                                ]
                                (Type.tuple (Type.var "x") (Type.var "b"))
                            )
                    }
                )
                [ arg1_3_0, arg2_4_0 ]
    , mapSecond =
        \arg1_4_0 arg2_5_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "mapSecond"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "b" ] (Type.var "y")
                                , Type.tuple (Type.var "a") (Type.var "b")
                                ]
                                (Type.tuple (Type.var "a") (Type.var "y"))
                            )
                    }
                )
                [ arg1_4_0, arg2_5_0 ]
    , mapBoth =
        \arg1_5_0 arg2_6_0 arg3_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Tuple" ]
                    , name = "mapBoth"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "x")
                                , Type.function [ Type.var "b" ] (Type.var "y")
                                , Type.tuple (Type.var "a") (Type.var "b")
                                ]
                                (Type.tuple (Type.var "x") (Type.var "y"))
                            )
                    }
                )
                [ arg1_5_0, arg2_6_0, arg3_7_0 ]
    }


values_ :
    { pair : Elm.Expression
    , first : Elm.Expression
    , second : Elm.Expression
    , mapFirst : Elm.Expression
    , mapSecond : Elm.Expression
    , mapBoth : Elm.Expression
    }
values_ =
    { pair =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "pair"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.var "b" ]
                        (Type.tuple (Type.var "a") (Type.var "b"))
                    )
            }
    , first =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "first"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple (Type.var "a") (Type.var "b") ]
                        (Type.var "a")
                    )
            }
    , second =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "second"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple (Type.var "a") (Type.var "b") ]
                        (Type.var "b")
                    )
            }
    , mapFirst =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapFirst"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "x")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "x") (Type.var "b"))
                    )
            }
    , mapSecond =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapSecond"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "b" ] (Type.var "y")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "a") (Type.var "y"))
                    )
            }
    , mapBoth =
        Elm.value
            { importFrom = [ "Tuple" ]
            , name = "mapBoth"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "x")
                        , Type.function [ Type.var "b" ] (Type.var "y")
                        , Type.tuple (Type.var "a") (Type.var "b")
                        ]
                        (Type.tuple (Type.var "x") (Type.var "y"))
                    )
            }
    }


