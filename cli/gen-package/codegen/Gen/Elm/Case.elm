module Gen.Elm.Case exposing (branch, branch2, branch3, branch4, branch5, custom, list, list2, list3, maybe, moduleName_, otherwise, result, triple, tuple, types_, values_)

{-| @docs moduleName_, types_, values_, maybe, result, list, list2, list3, tuple, triple, custom, otherwise, branch, branch2, branch3, branch4, branch5
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Case" ]


types_ : { branch : { annotation : Type.Annotation } }
types_ =
    { branch = { annotation = Type.namedWith moduleName_ "Branch" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { maybe : Elm.Expression
    , result : Elm.Expression
    , list : Elm.Expression
    , list2 : Elm.Expression
    , list3 : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , custom : Elm.Expression
    , otherwise : Elm.Expression
    , branch : Elm.Expression
    , branch2 : Elm.Expression
    , branch3 : Elm.Expression
    , branch4 : Elm.Expression
    , branch5 : Elm.Expression
    }
values_ =
    { maybe =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "nothing", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "just"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "maybe")
    , result =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "err"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "ok"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "result")
    , list =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list")
    , list2 =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "one"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list2")
    , list3 =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "one"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "two"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list3")
    , tuple =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "tuple")
    , triple =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "triple")
    , custom =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.list types_.branch.annotation
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "custom")
    , otherwise =
        Elm.withType
            (Type.function
                [ Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "otherwise")
    , branch =
        Elm.withType
            (Type.function
                [ Type.string, Type.namedWith [ "Elm" ] "Expression" [] ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch")
    , branch2 =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch2")
    , branch3 =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch3")
    , branch4 =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch4")
    , branch5 =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch5")
    }


{-| -}
maybe :
    Elm.Expression
    -> { nothing : Elm.Expression, just : Elm.Expression -> Elm.Expression }
    -> Elm.Expression
maybe arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "nothing", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "just"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "maybe")
        )
        [ arg1
        , Elm.record
            [ Elm.field "nothing" arg2.nothing
            , Elm.field
                "just"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.just
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            ]
        ]


{-| -}
result :
    Elm.Expression
    -> { err : Elm.Expression -> Elm.Expression
    , ok : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
result arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "err"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "ok"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "result")
        )
        [ arg1
        , Elm.record
            [ Elm.field
                "err"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.err
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            , Elm.field
                "ok"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.ok
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            ]
        ]


{-| -}
list :
    Elm.Expression
    -> { empty : Elm.Expression, remaining : Elm.Expression -> Elm.Expression }
    -> Elm.Expression
list arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list")
        )
        [ arg1
        , Elm.record
            [ Elm.field "empty" arg2.empty
            , Elm.field
                "remaining"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            ]
        ]


{-| -}
list2 :
    Elm.Expression
    -> { empty : Elm.Expression
    , one : Elm.Expression -> Elm.Expression
    , remaining : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
list2 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "one"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list2")
        )
        [ arg1
        , Elm.record
            [ Elm.field "empty" arg2.empty
            , Elm.field
                "one"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.one
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            , Elm.field
                "remaining"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            ]
        ]


{-| -}
list3 :
    Elm.Expression
    -> { empty : Elm.Expression
    , one : Elm.Expression -> Elm.Expression
    , two : Elm.Expression -> Elm.Expression -> Elm.Expression
    , remaining : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
list3 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.record
                    [ ( "empty", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "one"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "two"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    , ( "remaining"
                      , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                      )
                    ]
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "list3")
        )
        [ arg1
        , Elm.record
            [ Elm.field "empty" arg2.empty
            , Elm.field
                "one"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.one
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            , Elm.field
                "two"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" )
                    , ( "ar2", Type.named [ "Elm" ] "Expression" )
                    ]
                    (arg2.two
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar2")
                        )
                    )
                )
            , Elm.field
                "remaining"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
                        )
                    )
                )
            ]
        ]


{-| -}
tuple :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "tuple")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
            )
        ]


{-| -}
triple :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
triple arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "triple")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
            )
        ]


{-| -}
custom : Elm.Expression -> List Elm.Expression -> Elm.Expression
custom arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.list types_.branch.annotation
                ]
                (Type.namedWith [ "Elm" ] "Expression" [])
            )
            (Elm.valueFrom moduleName_ "custom")
        )
        [ arg1, Elm.list arg2 ]


{-|

    A catchall branch in case you want the case to be nonexhaustive.

-}
otherwise : (Elm.Expression -> Elm.Expression) -> Elm.Expression
otherwise arg1 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "otherwise")
        )
        [ Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg1
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
            )
        ]


{-| -}
branch : Elm.Expression -> Elm.Expression -> Elm.Expression
branch arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string, Type.namedWith [ "Elm" ] "Expression" [] ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch")
        )
        [ arg1, arg2 ]


{-| -}
branch2 : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branch2 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch2")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
            )
        ]


{-| -}
branch3 :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch3 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch3")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
            )
        ]


{-| -}
branch4 :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch4 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch4")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
            )
        ]


{-| -}
branch5 :
    Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
branch5 arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    , Type.namedWith [ "Elm" ] "Expression" []
                    ]
                    (Type.namedWith [ "Elm" ] "Expression" [])
                ]
                types_.branch.annotation
            )
            (Elm.valueFrom moduleName_ "branch5")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            , ( "ar4", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar4")
                )
            )
        ]


