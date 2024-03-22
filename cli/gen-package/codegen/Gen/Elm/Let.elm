module Gen.Elm.Let exposing (annotation_, call_, fn, fn2, fn3, letIn, moduleName_, record, toExpression, triple, tuple, value, values_)

{-| 
@docs moduleName_, letIn, value, tuple, triple, record, fn, fn2, fn3, toExpression, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Let" ]


{-| letIn: a -> Elm.Let.Let a -}
letIn : Elm.Expression -> Elm.Expression
letIn letInArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ letInArg ]


{-| value: String -> Elm.Expression -> Elm.Let.Let (Elm.Expression -> a) -> Elm.Let.Let a -}
value : String -> Elm.Expression -> Elm.Expression -> Elm.Expression
value valueArg valueArg0 valueArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string valueArg, valueArg0, valueArg1 ]


{-| tuple: 
    String
    -> String
    -> Elm.Expression
    -> Elm.Let.Let (( Elm.Expression, Elm.Expression ) -> a)
    -> Elm.Let.Let a
-}
tuple : String -> String -> Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg tupleArg0 tupleArg1 tupleArg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.tuple
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string tupleArg, Elm.string tupleArg0, tupleArg1, tupleArg2 ]


{-| triple: 
    String
    -> String
    -> String
    -> Elm.Expression
    -> Elm.Let.Let (( Elm.Expression, Elm.Expression, Elm.Expression ) -> a)
    -> Elm.Let.Let a
-}
triple :
    String
    -> String
    -> String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 tripleArg2 tripleArg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.triple
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string tripleArg
        , Elm.string tripleArg0
        , Elm.string tripleArg1
        , tripleArg2
        , tripleArg3
        ]


{-| record: 
    List String
    -> Elm.Expression
    -> Elm.Let.Let (List Elm.Expression -> a)
    -> Elm.Let.Let a
-}
record : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
record recordArg recordArg0 recordArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.list
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.list (List.map Elm.string recordArg), recordArg0, recordArg1 ]


{-| fn: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Let.Let ((Elm.Expression -> Elm.Expression) -> a)
    -> Elm.Let.Let a
-}
fn :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
fn fnArg fnArg0 fnArg1 fnArg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string fnArg
        , fnArg0
        , Elm.functionReduced "fnUnpack" fnArg1
        , fnArg2
        ]


{-| fn2: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Let.Let ((Elm.Expression -> Elm.Expression -> Elm.Expression) -> a)
    -> Elm.Let.Let a
-}
fn2 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
fn2 fn2Arg fn2Arg0 fn2Arg1 fn2Arg2 fn2Arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string fn2Arg
        , fn2Arg0
        , fn2Arg1
        , Elm.functionReduced
            "fn2Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (fn2Arg2 functionReducedUnpack)
            )
        , fn2Arg3
        ]


{-| fn3: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Let.Let ((Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> a)
    -> Elm.Let.Let a
-}
fn3 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
fn3 fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 fn3Arg3 fn3Arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
        )
        [ Elm.string fn3Arg
        , fn3Arg0
        , fn3Arg1
        , fn3Arg2
        , Elm.functionReduced
            "fn3Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (fn3Arg3 functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
        , fn3Arg4
        ]


{-| toExpression: Elm.Let.Let Elm.Expression -> Elm.Expression -}
toExpression : Elm.Expression -> Elm.Expression
toExpression toExpressionArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "toExpression"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ toExpressionArg ]


annotation_ : { let_ : Type.Annotation -> Type.Annotation }
annotation_ =
    { let_ = \letArg0 -> Type.namedWith [ "Elm", "Let" ] "Let" [ letArg0 ] }


call_ :
    { letIn : Elm.Expression -> Elm.Expression
    , value :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , tuple :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , triple :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn2 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , toExpression : Elm.Expression -> Elm.Expression
    }
call_ =
    { letIn =
        \letInArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "letIn"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ letInArg ]
    , value =
        \valueArg valueArg0 valueArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "value"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ valueArg, valueArg0, valueArg1 ]
    , tuple =
        \tupleArg tupleArg0 tupleArg1 tupleArg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "tuple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.tuple
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ tupleArg, tupleArg0, tupleArg1, tupleArg2 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 tripleArg2 tripleArg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "triple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.triple
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ tripleArg, tripleArg0, tripleArg1, tripleArg2, tripleArg3 ]
    , record =
        \recordArg recordArg0 recordArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "record"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.list
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ recordArg, recordArg0, recordArg1 ]
    , fn =
        \fnArg fnArg0 fnArg1 fnArg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "fn"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ fnArg, fnArg0, fnArg1, fnArg2 ]
    , fn2 =
        \fn2Arg fn2Arg0 fn2Arg1 fn2Arg2 fn2Arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "fn2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            , Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ fn2Arg, fn2Arg0, fn2Arg1, fn2Arg2, fn2Arg3 ]
    , fn3 =
        \fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 fn3Arg3 fn3Arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "fn3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                , Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.function
                                        [ Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            , Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            , Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            )
                                        ]
                                        (Type.var "a")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ fn3Arg, fn3Arg0, fn3Arg1, fn3Arg2, fn3Arg3, fn3Arg4 ]
    , toExpression =
        \toExpressionArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Let" ]
                    , name = "toExpression"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Let" ]
                                    "Let"
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ toExpressionArg ]
    }


values_ :
    { letIn : Elm.Expression
    , value : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , record : Elm.Expression
    , fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , toExpression : Elm.Expression
    }
values_ =
    { letIn =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , value =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , tuple =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.tuple
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , triple =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.triple
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , record =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.list
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , fn =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , fn2 =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , fn3 =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        , Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.var "a")
                            ]
                        ]
                        (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ])
                    )
            }
    , toExpression =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "toExpression"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Let" ]
                            "Let"
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    }