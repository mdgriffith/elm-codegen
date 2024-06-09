module Gen.Elm.Let exposing
    ( annotation_
    , call_
    , fn
    , fn2
    , fn3
    , letIn
    , moduleName_
    , toExpression
    , unpack
    , value
    , values_
    , withBody
    )

{-|
@docs moduleName_, letIn, value, unpack, fn, fn2, fn3, toExpression, withBody, annotation_, call_, values_
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
                          (Type.namedWith
                               [ "Elm", "Let" ]
                               "Let"
                               [ Type.var "a" ]
                          )
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
                          (Type.namedWith
                               [ "Elm", "Let" ]
                               "Let"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string valueArg, valueArg0, valueArg1 ]


{-| unpack: Elm.Arg.Arg arg -> Elm.Expression -> Elm.Let.Let (arg -> b) -> Elm.Let.Let b -}
unpack : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
unpack unpackArg unpackArg0 unpackArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Let" ]
             , name = "unpack"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "arg" ]
                          , Type.namedWith [ "Elm" ] "Expression" []
                          , Type.namedWith
                              [ "Elm", "Let" ]
                              "Let"
                              [ Type.function [ Type.var "arg" ] (Type.var "b")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Let" ]
                               "Let"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ unpackArg, unpackArg0, unpackArg1 ]


{-| fn: 
    String
    -> Elm.Arg.Arg arg
    -> (arg -> Elm.Expression)
    -> Elm.Let.Let ((Elm.Expression -> Elm.Expression) -> a)
    -> Elm.Let.Let a
-}
fn :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
fn fn_Arg fn_Arg0 fn_Arg1 fn_Arg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Let" ]
             , name = "fn"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "arg" ]
                          , Type.function
                              [ Type.var "arg" ]
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
        [ Elm.string fn_Arg
        , fn_Arg0
        , Elm.functionReduced "fnUnpack" fn_Arg1
        , fn_Arg2
        ]


{-| fn2: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> (one -> two -> Elm.Expression)
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
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.function
                              [ Type.var "one", Type.var "two" ]
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
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> (one -> two -> three -> Elm.Expression)
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
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
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
                            ((fn3Arg3 functionReducedUnpack)
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


{-| Define the body of your `let` at the bottom instead of the top so it matches the generated syntax a bit closer.

These two are equivalent
import Elm
import Elm.Let as Let

      Let.letIn
          (\one two ->
              Elm.Op.append one two
          )
          |> Let.value "one" (Elm.string "Hello")
          |> Let.value "two" (Elm.string "World!")
          |> Let.toExpression


      Let.letIn Tuple.pair
          |> Let.value "one" (Elm.string "Hello")
          |> Let.value "two" (Elm.string "World!")
          |> Let.withBody
              (\(one, two) ->
                  Elm.Op.append one two
              )

And will generate

      let
          one = "Hello"
          two = "World!"
      in
      one ++ two

withBody: (val -> Elm.Expression) -> Elm.Let.Let val -> Elm.Expression
-}
withBody :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
withBody withBodyArg withBodyArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Let" ]
             , name = "withBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "val" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Let" ]
                              "Let"
                              [ Type.var "val" ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ Elm.functionReduced "withBodyUnpack" withBodyArg, withBodyArg0 ]


annotation_ : { let_ : Type.Annotation -> Type.Annotation }
annotation_ =
    { let_ = \letArg0 -> Type.namedWith [ "Elm", "Let" ] "Let" [ letArg0 ] }


call_ :
    { letIn : Elm.Expression -> Elm.Expression
    , value :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , unpack :
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
    , withBody : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    , unpack =
        \unpackArg unpackArg0 unpackArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Let" ]
                     , name = "unpack"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith
                                      [ "Elm", "Let" ]
                                      "Let"
                                      [ Type.function
                                            [ Type.var "arg" ]
                                            (Type.var "b")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Let" ]
                                       "Let"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ unpackArg, unpackArg0, unpackArg1 ]
    , fn =
        \fn_Arg fn_Arg0 fn_Arg1 fn_Arg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Let" ]
                     , name = "fn"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.function
                                      [ Type.var "arg" ]
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
                [ fn_Arg, fn_Arg0, fn_Arg1, fn_Arg2 ]
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
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.function
                                      [ Type.var "one", Type.var "two" ]
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
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
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
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ toExpressionArg ]
    , withBody =
        \withBodyArg withBodyArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Let" ]
                     , name = "withBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "val" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Let" ]
                                      "Let"
                                      [ Type.var "val" ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ withBodyArg, withBodyArg0 ]
    }


values_ :
    { letIn : Elm.Expression
    , value : Elm.Expression
    , unpack : Elm.Expression
    , fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , toExpression : Elm.Expression
    , withBody : Elm.Expression
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
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ]
                         )
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
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ]
                         )
                    )
            }
    , unpack =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "unpack"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "arg" ]
                         , Type.namedWith [ "Elm" ] "Expression" []
                         , Type.namedWith
                             [ "Elm", "Let" ]
                             "Let"
                             [ Type.function [ Type.var "arg" ] (Type.var "b") ]
                         ]
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "b" ]
                         )
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
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "arg" ]
                         , Type.function
                             [ Type.var "arg" ]
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ]
                         )
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
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.function
                             [ Type.var "one", Type.var "two" ]
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ]
                         )
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
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm", "Let" ] "Let" [ Type.var "a" ]
                         )
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
    , withBody =
        Elm.value
            { importFrom = [ "Elm", "Let" ]
            , name = "withBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "val" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Let" ]
                             "Let"
                             [ Type.var "val" ]
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    }