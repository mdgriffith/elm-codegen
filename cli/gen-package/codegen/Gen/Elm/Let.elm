module Gen.Elm.Let exposing (call_, letIn, moduleName_, record, toExpression, tuple, value, values_)

{-| 
@docs moduleName_, letIn, value, tuple, record, toExpression, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Let" ]


{-| -}
letIn : Elm.Expression -> Elm.Expression
letIn arg1 =
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
        [ arg1 ]


{-| -}
value : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
value arg1 arg2_1 arg3_2 =
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
        [ arg1, arg2_1, arg3_2 ]


{-| -}
tuple :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
tuple arg1 arg2_1 arg3_2 arg4_3 =
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
        [ arg1, arg2_1, arg3_2, arg4_3 ]


{-| -}
record :
    List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
record arg1 arg2_1 arg3_2 =
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
        [ Elm.list arg1, arg2_1, arg3_2 ]


{-| -}
toExpression : Elm.Expression -> Elm.Expression
toExpression arg1 =
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
        [ arg1 ]


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
    , record :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , toExpression : Elm.Expression -> Elm.Expression
    }
call_ =
    { letIn =
        \arg1_0 ->
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
                [ arg1_0 ]
    , value =
        \arg1_1_0 arg2_2_0 arg3_3_0 ->
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
                [ arg1_1_0, arg2_2_0, arg3_3_0 ]
    , tuple =
        \arg1_2_0 arg2_3_0 arg3_4_0 arg4_5_0 ->
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
                [ arg1_2_0, arg2_3_0, arg3_4_0, arg4_5_0 ]
    , record =
        \arg1_3_0 arg2_4_0 arg3_5_0 ->
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
                [ arg1_3_0, arg2_4_0, arg3_5_0 ]
    , toExpression =
        \arg1_4_0 ->
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
                [ arg1_4_0 ]
    }


values_ :
    { letIn : Elm.Expression
    , value : Elm.Expression
    , tuple : Elm.Expression
    , record : Elm.Expression
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


