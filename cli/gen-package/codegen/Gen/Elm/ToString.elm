module Gen.Elm.ToString exposing (annotation, annotationWith, call_, declaration, declarationWith, expression, expressionWith, moduleName_, values_)

{-| 
@docs moduleName_, expression, annotation, declaration, expressionWith, annotationWith, declarationWith, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "ToString" ]


{-| expression: Elm.Expression -> { imports : String, body : String, signature : String } -}
expression : Elm.Expression -> Elm.Expression
expression expressionArg =
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
        [ expressionArg ]


{-| annotation: Elm.Annotation.Annotation -> { imports : String, signature : String } -}
annotation : Elm.Expression -> Elm.Expression
annotation annotationArg =
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
        [ annotationArg ]


{-| declaration: 
    Elm.Declaration
    -> { imports : String, docs : String, signature : String, body : String }
-}
declaration : Elm.Expression -> Elm.Expression
declaration declarationArg =
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
        [ declarationArg ]


{-| expressionWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Expression
    -> { imports : String, body : String, signature : String }
-}
expressionWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
expressionWith expressionWithArg expressionWithArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "expressionWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "body", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "aliases" (Elm.list expressionWithArg.aliases) ]
        , expressionWithArg0
        ]


{-| annotationWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Annotation.Annotation
    -> { imports : String, signature : String }
-}
annotationWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
annotationWith annotationWithArg annotationWithArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "annotationWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "aliases" (Elm.list annotationWithArg.aliases) ]
        , annotationWithArg0
        ]


{-| declarationWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Declaration
    -> { imports : String, docs : String, signature : String, body : String }
-}
declarationWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
declarationWith declarationWithArg declarationWithArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "declarationWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
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
        [ Elm.record
            [ Tuple.pair "aliases" (Elm.list declarationWithArg.aliases) ]
        , declarationWithArg0
        ]


call_ :
    { expression : Elm.Expression -> Elm.Expression
    , annotation : Elm.Expression -> Elm.Expression
    , declaration : Elm.Expression -> Elm.Expression
    , expressionWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , annotationWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , declarationWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { expression =
        \expressionArg ->
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
                [ expressionArg ]
    , annotation =
        \annotationArg ->
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
                [ annotationArg ]
    , declaration =
        \declarationArg ->
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
                [ declarationArg ]
    , expressionWith =
        \expressionWithArg expressionWithArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "expressionWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "aliases"
                                      , Type.list
                                            (Type.tuple
                                                (Type.list Type.string)
                                                Type.string
                                            )
                                      )
                                    ]
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "body", Type.string )
                                    , ( "signature", Type.string )
                                    ]
                                )
                            )
                    }
                )
                [ expressionWithArg, expressionWithArg0 ]
    , annotationWith =
        \annotationWithArg annotationWithArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "annotationWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "aliases"
                                      , Type.list
                                            (Type.tuple
                                                (Type.list Type.string)
                                                Type.string
                                            )
                                      )
                                    ]
                                , Type.namedWith
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
                [ annotationWithArg, annotationWithArg0 ]
    , declarationWith =
        \declarationWithArg declarationWithArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "ToString" ]
                    , name = "declarationWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "aliases"
                                      , Type.list
                                            (Type.tuple
                                                (Type.list Type.string)
                                                Type.string
                                            )
                                      )
                                    ]
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                ]
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
                [ declarationWithArg, declarationWithArg0 ]
    }


values_ :
    { expression : Elm.Expression
    , annotation : Elm.Expression
    , declaration : Elm.Expression
    , expressionWith : Elm.Expression
    , annotationWith : Elm.Expression
    , declarationWith : Elm.Expression
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
    , expressionWith =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "expressionWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "body", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
    , annotationWith =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "annotationWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.record
                            [ ( "imports", Type.string )
                            , ( "signature", Type.string )
                            ]
                        )
                    )
            }
    , declarationWith =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "declarationWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
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