module Gen.Elm.Op exposing
    ( and
    , append
    , call_
    , cons
    , divide
    , equal
    , gt
    , gte
    , intDivide
    , keep
    , lt
    , lte
    , minus
    , moduleName_
    , multiply
    , notEqual
    , or
    , parens
    , pipe
    , pipeLeft
    , plus
    , power
    , query
    , skip
    , slash
    , values_
    )

{-|
# Generated bindings for Elm.Op

@docs moduleName_, equal, notEqual, and, or, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, pipe, pipeLeft, parens, keep, skip, slash, query, call_, values_
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
equal equalArg_ equalArg_0 =
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
        [ equalArg_, equalArg_0 ]


{-| `/=`

notEqual: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual notEqualArg_ notEqualArg_0 =
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
        [ notEqualArg_, notEqualArg_0 ]


{-| `&&`

and: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and andArg_ andArg_0 =
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
        [ andArg_, andArg_0 ]


{-| `||`

or: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or orArg_ orArg_0 =
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
        [ orArg_, orArg_0 ]


{-| `++`

append: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append appendArg_ appendArg_0 =
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
        [ appendArg_, appendArg_0 ]


{-| `::`

cons: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons consArg_ consArg_0 =
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
        [ consArg_, consArg_0 ]


{-| `+`

plus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus plusArg_ plusArg_0 =
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
        [ plusArg_, plusArg_0 ]


{-| `-`

minus: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus minusArg_ minusArg_0 =
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
        [ minusArg_, minusArg_0 ]


{-| `*`

multiply: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply multiplyArg_ multiplyArg_0 =
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
        [ multiplyArg_, multiplyArg_0 ]


{-| `/`

divide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide divideArg_ divideArg_0 =
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
        [ divideArg_, divideArg_0 ]


{-| `//`

intDivide: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide intDivideArg_ intDivideArg_0 =
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
        [ intDivideArg_, intDivideArg_0 ]


{-| The to-the-power-of operator `^`

power: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power powerArg_ powerArg_0 =
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
        [ powerArg_, powerArg_0 ]


{-| `<`

lt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt ltArg_ ltArg_0 =
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
        [ ltArg_, ltArg_0 ]


{-| `>`

gt: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt gtArg_ gtArg_0 =
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
        [ gtArg_, gtArg_0 ]


{-| `<=`

lte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte lteArg_ lteArg_0 =
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
        [ lteArg_, lteArg_0 ]


{-| `>=`

gte: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte gteArg_ gteArg_0 =
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
        [ gteArg_, gteArg_0 ]


{-| `|>`

    Elm.value
        { importFrom = []
        , name = "thang"
        , annotation = Nothing
        }
        |> Elm.Op.pipe (Elm.value "thang2")
        |> Elm.Op.pipe (Elm.value "thang3")

Results in

    thang
        |> thang2
        |> thang3

pipe: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
pipe pipeArg_ pipeArg_0 =
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
        [ pipeArg_, pipeArg_0 ]


{-| `<|`

pipeLeft: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
pipeLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
pipeLeft pipeLeftArg_ pipeLeftArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Op" ]
             , name = "pipeLeft"
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
        [ pipeLeftArg_, pipeLeftArg_0 ]


{-| Wrap an expression in parentheses.

Generally you won't need this as `elm-codegen` handles parens for you, but it can be useful to semantically group operations from this module.

parens: Elm.Expression -> Elm.Expression
-}
parens : Elm.Expression -> Elm.Expression
parens parensArg_ =
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
        [ parensArg_ ]


{-| used in the `elm/parser` library

`|=`

keep: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep keepArg_ keepArg_0 =
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
        [ keepArg_, keepArg_0 ]


{-| `|.`

skip: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip skipArg_ skipArg_0 =
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
        [ skipArg_, skipArg_0 ]


{-| `</>` used in url parsing

slash: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash slashArg_ slashArg_0 =
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
        [ slashArg_, slashArg_0 ]


{-| `<?>` used in url parsing

query: Elm.Expression -> Elm.Expression -> Elm.Expression
-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query queryArg_ queryArg_0 =
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
        [ queryArg_, queryArg_0 ]


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
    , pipeLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
    , parens : Elm.Expression -> Elm.Expression
    , keep : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skip : Elm.Expression -> Elm.Expression -> Elm.Expression
    , slash : Elm.Expression -> Elm.Expression -> Elm.Expression
    , query : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { equal =
        \equalArg_ equalArg_0 ->
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
                [ equalArg_, equalArg_0 ]
    , notEqual =
        \notEqualArg_ notEqualArg_0 ->
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
                [ notEqualArg_, notEqualArg_0 ]
    , and =
        \andArg_ andArg_0 ->
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
                [ andArg_, andArg_0 ]
    , or =
        \orArg_ orArg_0 ->
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
                [ orArg_, orArg_0 ]
    , append =
        \appendArg_ appendArg_0 ->
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
                [ appendArg_, appendArg_0 ]
    , cons =
        \consArg_ consArg_0 ->
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
                [ consArg_, consArg_0 ]
    , plus =
        \plusArg_ plusArg_0 ->
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
                [ plusArg_, plusArg_0 ]
    , minus =
        \minusArg_ minusArg_0 ->
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
                [ minusArg_, minusArg_0 ]
    , multiply =
        \multiplyArg_ multiplyArg_0 ->
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
                [ multiplyArg_, multiplyArg_0 ]
    , divide =
        \divideArg_ divideArg_0 ->
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
                [ divideArg_, divideArg_0 ]
    , intDivide =
        \intDivideArg_ intDivideArg_0 ->
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
                [ intDivideArg_, intDivideArg_0 ]
    , power =
        \powerArg_ powerArg_0 ->
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
                [ powerArg_, powerArg_0 ]
    , lt =
        \ltArg_ ltArg_0 ->
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
                [ ltArg_, ltArg_0 ]
    , gt =
        \gtArg_ gtArg_0 ->
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
                [ gtArg_, gtArg_0 ]
    , lte =
        \lteArg_ lteArg_0 ->
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
                [ lteArg_, lteArg_0 ]
    , gte =
        \gteArg_ gteArg_0 ->
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
                [ gteArg_, gteArg_0 ]
    , pipe =
        \pipeArg_ pipeArg_0 ->
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
                [ pipeArg_, pipeArg_0 ]
    , pipeLeft =
        \pipeLeftArg_ pipeLeftArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Op" ]
                     , name = "pipeLeft"
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
                [ pipeLeftArg_, pipeLeftArg_0 ]
    , parens =
        \parensArg_ ->
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
                [ parensArg_ ]
    , keep =
        \keepArg_ keepArg_0 ->
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
                [ keepArg_, keepArg_0 ]
    , skip =
        \skipArg_ skipArg_0 ->
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
                [ skipArg_, skipArg_0 ]
    , slash =
        \slashArg_ slashArg_0 ->
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
                [ slashArg_, slashArg_0 ]
    , query =
        \queryArg_ queryArg_0 ->
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
                [ queryArg_, queryArg_0 ]
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
    , pipeLeft : Elm.Expression
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
    , pipeLeft =
        Elm.value
            { importFrom = [ "Elm", "Op" ]
            , name = "pipeLeft"
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