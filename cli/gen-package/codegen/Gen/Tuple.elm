module Gen.Tuple exposing (call_, first, mapBoth, mapFirst, mapSecond, moduleName_, pair, second, types_, values_)

{-| 
@docs moduleName_, pair, first, second, mapFirst, mapSecond, mapBoth, types_, values_, call_
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
pair arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| Extract the first value from a tuple.

    first (3, 4) == 3
    first ("john", "doe") == "john"
-}
first : Elm.Expression -> Elm.Expression
first arg1 =
    Elm.apply
        (Elm.valueWith
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
        (Elm.valueWith
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
mapFirst arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
            )
        , arg2
        ]


{-| Transform the second value in a tuple.

    mapSecond sqrt   ("stressed", 16) == ("stressed", 4)
    mapSecond negate ("stressed", 16) == ("stressed", -16)
-}
mapSecond :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapSecond arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg2
        ]


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
mapBoth arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
            )
        , Elm.functionAdvanced
            [ ( "ar0", Type.var "b" ) ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg3
        ]


types_ : {}
types_ =
    {}


{-| Every value/function in this module in case you need to refer to it directly. -}
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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


{-| Every value/function in this module in case you need to refer to it directly. -}
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
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , first =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , second =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , mapFirst =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , mapSecond =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , mapBoth =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    }


