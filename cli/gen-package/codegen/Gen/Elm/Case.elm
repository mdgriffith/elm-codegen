module Gen.Elm.Case exposing
    ( annotation_
    , branch
    , call_
    , custom
    , maybe
    , moduleName_
    , result
    , string
    , values_
    )

{-|
# Generated bindings for Elm.Case

@docs moduleName_, maybe, result, string, custom, branch, annotation_, call_, values_
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
maybe maybeArg_ maybeArg_0 =
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
        [ maybeArg_
        , Elm.record
            [ Tuple.pair "nothing" maybeArg_0.nothing
            , Tuple.pair "just" maybeArg_0.just
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
result resultArg_ resultArg_0 =
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
        [ resultArg_
        , Elm.record
            [ Tuple.pair "err" resultArg_0.err, Tuple.pair "ok" resultArg_0.ok ]
        ]


{-| string: 
    Elm.Expression
    -> { cases : List ( String, Elm.Expression ), otherwise : Elm.Expression }
    -> Elm.Expression
-}
string :
    Elm.Expression
    -> { cases : List Elm.Expression, otherwise : Elm.Expression }
    -> Elm.Expression
string stringArg_ stringArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "string"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.record
                              [ ( "cases"
                                , Type.list
                                    (Type.tuple
                                       Type.string
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              , ( "otherwise"
                                , Type.namedWith [ "Elm" ] "Expression" []
                                )
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ stringArg_
        , Elm.record
            [ Tuple.pair "cases" (Elm.list stringArg_0.cases)
            , Tuple.pair "otherwise" stringArg_0.otherwise
            ]
        ]


{-| custom: 
    Elm.Expression
    -> Elm.Annotation.Annotation
    -> List Elm.Case.Branch
    -> Elm.Expression
-}
custom :
    Elm.Expression -> Elm.Expression -> List Elm.Expression -> Elm.Expression
custom customArg_ customArg_0 customArg_1 =
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
        [ customArg_, customArg_0, Elm.list customArg_1 ]


{-| branch: Elm.Arg val -> (val -> Elm.Expression) -> Elm.Case.Branch -}
branch : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branch branchArg_ branchArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Case" ]
             , name = "branch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "val" ]
                          , Type.function
                              [ Type.var "val" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                     )
             }
        )
        [ branchArg_, Elm.functionReduced "branchUnpack" branchArg_0 ]


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
    , string : Elm.Expression -> Elm.Expression -> Elm.Expression
    , custom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , branch : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { maybe =
        \maybeArg_ maybeArg_0 ->
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
                [ maybeArg_, maybeArg_0 ]
    , result =
        \resultArg_ resultArg_0 ->
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
                [ resultArg_, resultArg_0 ]
    , string =
        \stringArg_ stringArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "string"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.record
                                      [ ( "cases"
                                        , Type.list
                                            (Type.tuple
                                               Type.string
                                               (Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                               )
                                            )
                                        )
                                      , ( "otherwise"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ stringArg_, stringArg_0 ]
    , custom =
        \customArg_ customArg_0 customArg_1 ->
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
                [ customArg_, customArg_0, customArg_1 ]
    , branch =
        \branchArg_ branchArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Case" ]
                     , name = "branch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
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
                [ branchArg_, branchArg_0 ]
    }


values_ :
    { maybe : Elm.Expression
    , result : Elm.Expression
    , string : Elm.Expression
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
    , string =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.record
                             [ ( "cases"
                               , Type.list
                                   (Type.tuple
                                      Type.string
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             , ( "otherwise"
                               , Type.namedWith [ "Elm" ] "Expression" []
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "val" ]
                         , Type.function
                             [ Type.var "val" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    }