module Gen.Elm.Let exposing (letIn, moduleName_, record, toExpression, tuple, types_, value, values_)

{-| 
@docs moduleName_, letIn, value, tuple, record, toExpression, types_, values_
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
        (Elm.valueWith
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
value arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| -}
tuple :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
tuple arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3, arg4 ]


{-| -}
record :
    List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
record arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1, arg2, arg3 ]


{-| -}
toExpression : Elm.Expression -> Elm.Expression
toExpression arg1 =
    Elm.apply
        (Elm.valueWith
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


types_ : {}
types_ =
    {}


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { letIn : Elm.Expression
    , value : Elm.Expression
    , tuple : Elm.Expression
    , record : Elm.Expression
    , toExpression : Elm.Expression
    }
values_ =
    { letIn =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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


