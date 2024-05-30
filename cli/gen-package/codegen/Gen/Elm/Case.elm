module Gen.Elm.Case exposing
    ( annotation_
    , branch
    , call_
    , custom
    , maybe
    , moduleName_
    , result
    , values_
    )

{-|
@docs moduleName_, maybe, result, custom, branch, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Case" ]


{-| maybe: 
    Elm.Expression
    -> { nothing : Elm.Expression
    , just : ( String, Elm.Expression -> Elm.Expression )
    }
    -> Elm.Expression
-}
maybe :
    Elm.Expression
    -> { nothing : Elm.Expression, just : Elm.Expression }
    -> Elm.Expression
maybe maybeArg maybeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "maybe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.record
                              [ ( "nothing"
                                , Type.namedWith [ "Elm" ] "Expression" []
                                )
                              , ( "just"
                                , Type.tuple
                                    Type.string
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ maybeArg
        , Elm.record
            [ Tuple.pair "nothing" maybeArg0.nothing
            , Tuple.pair "just" maybeArg0.just
            ]
        ]


{-| Elm.Case.result myResult
        { ok =
            Tuple.pair "ok" <|
                \ok ->
                    Elm.string "No errors"
        , err =
            Tuple.pair "err" <|
                \err ->
                    err
        }

Generates

    case myResult of
        Ok ok ->
            "No errors"

        Err err ->
            err

result: 
    Elm.Expression
    -> { err : ( String, Elm.Expression -> Elm.Expression )
    , ok : ( String, Elm.Expression -> Elm.Expression )
    }
    -> Elm.Expression
-}
result :
    Elm.Expression
    -> { err : Elm.Expression, ok : Elm.Expression }
    -> Elm.Expression
result resultArg resultArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "result"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.record
                              [ ( "err"
                                , Type.tuple
                                    Type.string
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              , ( "ok"
                                , Type.tuple
                                    Type.string
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ resultArg
        , Elm.record
            [ Tuple.pair "err" resultArg0.err, Tuple.pair "ok" resultArg0.ok ]
        ]


{-| custom: 
    Elm.Expression
    -> Elm.Annotation.Annotation
    -> List Elm.Case.Branch
    -> Elm.Expression
-}
custom :
    Elm.Expression -> Elm.Expression -> List Elm.Expression -> Elm.Expression
custom customArg customArg0 customArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "custom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.list
                              (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ customArg, customArg0, Elm.list customArg1 ]


{-| branch: Elm.Arg.Arg val -> (val -> Elm.Expression) -> Elm.Case.Branch -}
branch : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branch branchArg branchArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "branch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "val" ]
                          , Type.function
                              [ Type.var "val" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                     )
             }
        )
        [ branchArg, Elm.functionReduced "branchUnpack" branchArg0 ]


annotation_ : { branch : Type.Annotation }
annotation_ =
    { branch =
        Type.alias
            moduleName_
            "Branch"
            []
            (Type.namedWith [ "Internal", "Branch" ] "Branch" [])
    }


call_ :
    { maybe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , result : Elm.Expression -> Elm.Expression -> Elm.Expression
    , custom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , branch : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { maybe =
        \maybeArg maybeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "maybe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.record
                                      [ ( "nothing"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                      , ( "just"
                                        , Type.tuple
                                            Type.string
                                            (Type.function
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
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ maybeArg, maybeArg0 ]
    , result =
        \resultArg resultArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "result"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.record
                                      [ ( "err"
                                        , Type.tuple
                                            Type.string
                                            (Type.function
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
                                            )
                                        )
                                      , ( "ok"
                                        , Type.tuple
                                            Type.string
                                            (Type.function
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
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ resultArg, resultArg0 ]
    , custom =
        \customArg customArg0 customArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "custom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.list
                                      (Type.namedWith
                                         [ "Elm", "Case" ]
                                         "Branch"
                                         []
                                      )
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ customArg, customArg0, customArg1 ]
    , branch =
        \branchArg branchArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "branch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "val" ]
                                  , Type.function
                                      [ Type.var "val" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                             )
                     }
                )
                [ branchArg, branchArg0 ]
    }


values_ :
    { maybe : Elm.Expression
    , result : Elm.Expression
    , custom : Elm.Expression
    , branch : Elm.Expression
    }
values_ =
    { maybe =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.record
                             [ ( "nothing"
                               , Type.namedWith [ "Elm" ] "Expression" []
                               )
                             , ( "just"
                               , Type.tuple
                                   Type.string
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , result =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "result"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.record
                             [ ( "err"
                               , Type.tuple
                                   Type.string
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             , ( "ok"
                               , Type.tuple
                                   Type.string
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , custom =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.list
                             (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , branch =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "val" ]
                         , Type.function
                             [ Type.var "val" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    }