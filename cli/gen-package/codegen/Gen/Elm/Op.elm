module Gen.Elm.Op exposing (and, append, call_, cons, divide, equal, gt, gte, intDivide, keep, lt, lte, minus, moduleName_, multiply, notEqual, or, pipe, plus, power, query, skip, slash, values_)

{-| 
@docs moduleName_, equal, notEqual, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, and, or, pipe, keep, skip, slash, query, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Op" ]


{-| `==`

equal: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
equal : Elm.Expression -> Elm.Expression -> Elm.Expression
equal arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "equal"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `/=`

notEqual: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "notEqual"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `++`

append: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `::`

cons: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "cons"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `+`

plus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `-`

minus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `*`

multiply: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "multiply"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `/`

divide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "divide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `//`

intDivide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "intDivide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| The to-the-power-of operator `^`

power: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "power"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `<`

lt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "lt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `>`

gt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "gt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `<=`

lte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "lte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `>=`

gte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "gte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `&&`

and: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "and"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `||`

or: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "or"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `|>`

    Elm.value "thang"
        |> Elm.pipe (Elm.value "thang2")
        |> Elm.pipe (Elm.value "thang3")

Results in

    thang
        |> thang2
        |> thang3

pipe: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
pipe arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "pipe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| used in the `elm/parser` library

`|=`

keep: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "keep"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `|.`

skip: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "skip"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `</>` used in url parsing

slash: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| `<?>` used in url parsing

query: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


call_ :
    { equal : Elm.Expression -> Elm.Expression -> Elm.Expression
    , notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cons : Elm.Expression -> Elm.Expression -> Elm.Expression
    , plus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , minus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
    , divide : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
    , power : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lte : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gte : Elm.Expression -> Elm.Expression -> Elm.Expression
    , and : Elm.Expression -> Elm.Expression -> Elm.Expression
    , or : Elm.Expression -> Elm.Expression -> Elm.Expression
    , pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , keep : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skip : Elm.Expression -> Elm.Expression -> Elm.Expression
    , slash : Elm.Expression -> Elm.Expression -> Elm.Expression
    , query : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { equal =
        \arg arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "equal"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg0 ]
    , notEqual =
        \arg arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "notEqual"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg1 ]
    , append =
        \arg arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "append"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg2 ]
    , cons =
        \arg arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "cons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg3 ]
    , plus =
        \arg arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "plus"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg4 ]
    , minus =
        \arg arg5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "minus"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg5 ]
    , multiply =
        \arg arg6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "multiply"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg6 ]
    , divide =
        \arg arg7 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "divide"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg7 ]
    , intDivide =
        \arg arg8 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "intDivide"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg8 ]
    , power =
        \arg arg9 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "power"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg9 ]
    , lt =
        \arg arg10 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "lt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg10 ]
    , gt =
        \arg arg11 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "gt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg11 ]
    , lte =
        \arg arg12 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "lte"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg12 ]
    , gte =
        \arg arg13 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "gte"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg13 ]
    , and =
        \arg arg14 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "and"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg14 ]
    , or =
        \arg arg15 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "or"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg15 ]
    , pipe =
        \arg arg16 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "pipe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg16 ]
    , keep =
        \arg arg17 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "keep"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg17 ]
    , skip =
        \arg arg18 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "skip"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg18 ]
    , slash =
        \arg arg19 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "slash"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg19 ]
    , query =
        \arg arg20 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "query"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg20 ]
    }


values_ :
    { equal : Elm.Expression
    , notEqual : Elm.Expression
    , append : Elm.Expression
    , cons : Elm.Expression
    , plus : Elm.Expression
    , minus : Elm.Expression
    , multiply : Elm.Expression
    , divide : Elm.Expression
    , intDivide : Elm.Expression
    , power : Elm.Expression
    , lt : Elm.Expression
    , gt : Elm.Expression
    , lte : Elm.Expression
    , gte : Elm.Expression
    , and : Elm.Expression
    , or : Elm.Expression
    , pipe : Elm.Expression
    , keep : Elm.Expression
    , skip : Elm.Expression
    , slash : Elm.Expression
    , query : Elm.Expression
    }
values_ =
    { equal =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "equal"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , notEqual =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "notEqual"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , cons =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "cons"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , plus =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , minus =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , multiply =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "multiply"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , divide =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "divide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , intDivide =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "intDivide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , power =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "power"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , lt =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "lt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , gt =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "gt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , lte =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "lte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , gte =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "gte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , and =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "and"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , or =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "or"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , pipe =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "pipe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , keep =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "keep"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , skip =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "skip"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , slash =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , query =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    }


