module Gen.Elm.ToString exposing (annotation, call_, declaration, expression, moduleName_, values_)

{-| 
@docs moduleName_, expression, annotation, declaration, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "ToString" ]


{-| expression: Elm.Expression -> { imports : String, body : String, signature : String } -}
expression : Elm.Expression -> Elm.Expression
expression arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "expression"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "body", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
        )
        [ arg ]


{-| annotation: Elm.Annotation.Annotation -> { imports : String, signature : String } -}
annotation : Elm.Expression -> Elm.Expression
annotation arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "annotation"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
        )
        [ arg ]


{-| declaration: 
    Elm.Declaration
    -> { imports : String, docs : String, signature : String, body : String }
-}
declaration : Elm.Expression -> Elm.Expression
declaration arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "docs", Type.string )
                            , ( "signature", Type.string )
                            , ( "body", Type.string )
                            ]
                        )
                    )
            }
        )
        [ arg ]


call_ :
    { expression : Elm.Expression -> Elm.Expression
    , annotation : Elm.Expression -> Elm.Expression
    , declaration : Elm.Expression -> Elm.Expression
    }
call_ =
    { expression =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "expression"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "body", Type.string )
                                    , ( "signature", Type.string )
                                    ]
                                )
                            )
                    }
                )
                [ arg ]
    , annotation =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "annotation"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "signature", Type.string )
                                    ]
                                )
                            )
                    }
                )
                [ arg ]
    , declaration =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "declaration"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "docs", Type.string )
                                    , ( "signature", Type.string )
                                    , ( "body", Type.string )
                                    ]
                                )
                            )
                    }
                )
                [ arg ]
    }


values_ :
    { expression : Elm.Expression
    , annotation : Elm.Expression
    , declaration : Elm.Expression
    }
values_ =
    { expression =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "expression"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "body", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
    , annotation =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "annotation"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
    , declaration =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "docs", Type.string )
                            , ( "signature", Type.string )
                            , ( "body", Type.string )
                            ]
                        )
                    )
            }
    }


