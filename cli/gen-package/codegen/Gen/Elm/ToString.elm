module Gen.Elm.ToString exposing
    ( annotation
    , annotationWith
    , call_
    , declaration
    , declarationWith
    , expression
    , expressionWith
    , moduleName_
    , values_
    )

{-|
# Generated bindings for Elm.ToString

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
expression expressionArg_ =
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
        [ expressionArg_ ]


{-| annotation: Elm.Annotation.Annotation -> { imports : String, signature : String } -}
annotation : Elm.Expression -> Elm.Expression
annotation annotationArg_ =
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
        [ annotationArg_ ]


{-| declaration: 
    Elm.Declaration
    -> List { imports : String, docs : String, signature : String, body : String }
-}
declaration : Elm.Expression -> Elm.Expression
declaration declarationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "ToString" ]
             , name = "declaration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                          (Type.list
                               (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "docs", Type.string )
                                    , ( "signature", Type.string )
                                    , ( "body", Type.string )
                                    ]
                               )
                          )
                     )
             }
        )
        [ declarationArg_ ]


{-| expressionWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Expression
    -> { imports : String, body : String, signature : String }
-}
expressionWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
expressionWith expressionWithArg_ expressionWithArg_0 =
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
            [ Tuple.pair "aliases" (Elm.list expressionWithArg_.aliases) ]
        , expressionWithArg_0
        ]


{-| annotationWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Annotation.Annotation
    -> { imports : String, signature : String }
-}
annotationWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
annotationWith annotationWithArg_ annotationWithArg_0 =
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
        [ Elm.record
            [ Tuple.pair "aliases" (Elm.list annotationWithArg_.aliases) ]
        , annotationWithArg_0
        ]


{-| declarationWith: 
    { aliases : List ( List String, String ) }
    -> Elm.Declaration
    -> List { imports : String, docs : String, signature : String, body : String }
-}
declarationWith :
    { aliases : List Elm.Expression } -> Elm.Expression -> Elm.Expression
declarationWith declarationWithArg_ declarationWithArg_0 =
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
                          (Type.list
                               (Type.record
                                    [ ( "imports", Type.string )
                                    , ( "docs", Type.string )
                                    , ( "signature", Type.string )
                                    , ( "body", Type.string )
                                    ]
                               )
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "aliases" (Elm.list declarationWithArg_.aliases) ]
        , declarationWithArg_0
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
        \expressionArg_ ->
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
                [ expressionArg_ ]
    , annotation =
        \annotationArg_ ->
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
                [ annotationArg_ ]
    , declaration =
        \declarationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "ToString" ]
                     , name = "declaration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                  (Type.list
                                       (Type.record
                                            [ ( "imports", Type.string )
                                            , ( "docs", Type.string )
                                            , ( "signature", Type.string )
                                            , ( "body", Type.string )
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ declarationArg_ ]
    , expressionWith =
        \expressionWithArg_ expressionWithArg_0 ->
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
                [ expressionWithArg_, expressionWithArg_0 ]
    , annotationWith =
        \annotationWithArg_ annotationWithArg_0 ->
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
                [ annotationWithArg_, annotationWithArg_0 ]
    , declarationWith =
        \declarationWithArg_ declarationWithArg_0 ->
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
                                  (Type.list
                                       (Type.record
                                            [ ( "imports", Type.string )
                                            , ( "docs", Type.string )
                                            , ( "signature", Type.string )
                                            , ( "body", Type.string )
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ declarationWithArg_, declarationWithArg_0 ]
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
    , declaration =
        Elm.value
            { importFrom = [ "Elm", "ToString" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                         (Type.list
                              (Type.record
                                   [ ( "imports", Type.string )
                                   , ( "docs", Type.string )
                                   , ( "signature", Type.string )
                                   , ( "body", Type.string )
                                   ]
                              )
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
                         (Type.list
                              (Type.record
                                   [ ( "imports", Type.string )
                                   , ( "docs", Type.string )
                                   , ( "signature", Type.string )
                                   , ( "body", Type.string )
                                   ]
                              )
                         )
                    )
            }
    }