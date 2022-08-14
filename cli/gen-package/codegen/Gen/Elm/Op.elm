module Gen.Elm.Op exposing (and, append, call_, cons, divide, equal, gt, gte, intDivide, keep, lt, lte, minus, moduleName_, multiply, notEqual, or, parens, pipe, plus, power, query, skip, slash, values_)

{-| 
@docs moduleName_, equal, notEqual, and, or, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, pipe, parens, keep, skip, slash, query, call_, values_
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


{-| Wrap an expression in parentheses.

Generally you won't need this as `elm-codegen` handles parens for you, but it can be useful to semantically group operaties from this module.

parens: Elm.Expression -> Elm.Expression
-}
parens : Elm.Expression -> Elm.Expression
parens arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "parens"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg ]


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
    , and : Elm.Expression -> Elm.Expression -> Elm.Expression
    , or : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    , pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , parens : Elm.Expression -> Elm.Expression
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
        \arg arg0 ->
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
    , and =
        \arg arg0 ->
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
    , or =
        \arg arg0 ->
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
    , append =
        \arg arg0 ->
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
    , cons =
        \arg arg0 ->
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
    , plus =
        \arg arg0 ->
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
    , minus =
        \arg arg0 ->
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
    , multiply =
        \arg arg0 ->
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
    , divide =
        \arg arg0 ->
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
    , intDivide =
        \arg arg0 ->
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
    , power =
        \arg arg0 ->
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
    , lt =
        \arg arg0 ->
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
    , gt =
        \arg arg0 ->
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
    , lte =
        \arg arg0 ->
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
    , gte =
        \arg arg0 ->
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
    , pipe =
        \arg arg0 ->
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
    , parens =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Op" ]
                    , name = "parens"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , keep =
        \arg arg0 ->
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
    , skip =
        \arg arg0 ->
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
    , slash =
        \arg arg0 ->
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
    , query =
        \arg arg0 ->
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
    }


values_ :
    { equal : Elm.Expression
    , notEqual : Elm.Expression
    , and : Elm.Expression
    , or : Elm.Expression
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
    , pipe : Elm.Expression
    , parens : Elm.Expression
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
    , parens =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "parens"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
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


