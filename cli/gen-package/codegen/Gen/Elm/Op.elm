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
equal equalArg equalArg0 =
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
        [ equalArg, equalArg0 ]


{-| `/=`

notEqual: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual notEqualArg notEqualArg0 =
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
        [ notEqualArg, notEqualArg0 ]


{-| `&&`

and: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and andArg andArg0 =
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
        [ andArg, andArg0 ]


{-| `||`

or: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or orArg orArg0 =
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
        [ orArg, orArg0 ]


{-| `++`

append: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append appendArg appendArg0 =
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
        [ appendArg, appendArg0 ]


{-| `::`

cons: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons consArg consArg0 =
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
        [ consArg, consArg0 ]


{-| `+`

plus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus plusArg plusArg0 =
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
        [ plusArg, plusArg0 ]


{-| `-`

minus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus minusArg minusArg0 =
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
        [ minusArg, minusArg0 ]


{-| `*`

multiply: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply multiplyArg multiplyArg0 =
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
        [ multiplyArg, multiplyArg0 ]


{-| `/`

divide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide divideArg divideArg0 =
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
        [ divideArg, divideArg0 ]


{-| `//`

intDivide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide intDivideArg intDivideArg0 =
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
        [ intDivideArg, intDivideArg0 ]


{-| The to-the-power-of operator `^`

power: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power powerArg powerArg0 =
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
        [ powerArg, powerArg0 ]


{-| `<`

lt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt ltArg ltArg0 =
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
        [ ltArg, ltArg0 ]


{-| `>`

gt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt gtArg gtArg0 =
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
        [ gtArg, gtArg0 ]


{-| `<=`

lte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte lteArg lteArg0 =
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
        [ lteArg, lteArg0 ]


{-| `>=`

gte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte gteArg gteArg0 =
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
        [ gteArg, gteArg0 ]


{-| `|>`

    Elm.value "thang"
        |> Elm.Op.pipe (Elm.value "thang2")
        |> Elm.Op.pipe (Elm.value "thang3")

Results in

    thang
        |> thang2
        |> thang3

pipe: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
pipe pipeArg pipeArg0 =
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
        [ pipeArg, pipeArg0 ]


{-| Wrap an expression in parentheses.

Generally you won't need this as `elm-codegen` handles parens for you, but it can be useful to semantically group operations from this module.

parens: Elm.Expression -> Elm.Expression
-}
parens : Elm.Expression -> Elm.Expression
parens parensArg =
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
        [ parensArg ]


{-| used in the `elm/parser` library

`|=`

keep: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep keepArg keepArg0 =
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
        [ keepArg, keepArg0 ]


{-| `|.`

skip: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip skipArg skipArg0 =
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
        [ skipArg, skipArg0 ]


{-| `</>` used in url parsing

slash: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash slashArg slashArg0 =
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
        [ slashArg, slashArg0 ]


{-| `<?>` used in url parsing

query: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query queryArg queryArg0 =
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
        [ queryArg, queryArg0 ]


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
        \equalArg equalArg0 ->
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
                [ equalArg, equalArg0 ]
    , notEqual =
        \notEqualArg notEqualArg0 ->
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
                [ notEqualArg, notEqualArg0 ]
    , and =
        \andArg andArg0 ->
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
                [ andArg, andArg0 ]
    , or =
        \orArg orArg0 ->
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
                [ orArg, orArg0 ]
    , append =
        \appendArg appendArg0 ->
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
                [ appendArg, appendArg0 ]
    , cons =
        \consArg consArg0 ->
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
                [ consArg, consArg0 ]
    , plus =
        \plusArg plusArg0 ->
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
                [ plusArg, plusArg0 ]
    , minus =
        \minusArg minusArg0 ->
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
                [ minusArg, minusArg0 ]
    , multiply =
        \multiplyArg multiplyArg0 ->
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
                [ multiplyArg, multiplyArg0 ]
    , divide =
        \divideArg divideArg0 ->
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
                [ divideArg, divideArg0 ]
    , intDivide =
        \intDivideArg intDivideArg0 ->
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
                [ intDivideArg, intDivideArg0 ]
    , power =
        \powerArg powerArg0 ->
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
                [ powerArg, powerArg0 ]
    , lt =
        \ltArg ltArg0 ->
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
                [ ltArg, ltArg0 ]
    , gt =
        \gtArg gtArg0 ->
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
                [ gtArg, gtArg0 ]
    , lte =
        \lteArg lteArg0 ->
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
                [ lteArg, lteArg0 ]
    , gte =
        \gteArg gteArg0 ->
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
                [ gteArg, gteArg0 ]
    , pipe =
        \pipeArg pipeArg0 ->
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
                [ pipeArg, pipeArg0 ]
    , parens =
        \parensArg ->
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
                [ parensArg ]
    , keep =
        \keepArg keepArg0 ->
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
                [ keepArg, keepArg0 ]
    , skip =
        \skipArg skipArg0 ->
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
                [ skipArg, skipArg0 ]
    , slash =
        \slashArg slashArg0 ->
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
                [ slashArg, slashArg0 ]
    , query =
        \queryArg queryArg0 ->
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
                [ queryArg, queryArg0 ]
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