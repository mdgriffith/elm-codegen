module Elm.Gen.Elm.Case exposing (branch, branch2, branch3, branch4, branch5, custom, id_, list, list2, list3, make_, maybe, moduleName_, otherwise, result, types_)

{-| @docs moduleName_, types_, make_, maybe, result, list, list2, list3, custom, otherwise, branch, branch2, branch3, branch4, branch5, id_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Case" ]


types_ : { branch : Type.Annotation }
types_ =
    { branch = Type.namedWith moduleName_ "Branch" [] }


make_ : {}
make_ =
    {}


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
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.just (Elm.value "ar1"))
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
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.err (Elm.value "ar1"))
                )
            , Elm.field
                "ok"
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.ok (Elm.value "ar1"))
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
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining (Elm.value "ar1"))
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
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.one (Elm.value "ar1"))
                )
            , Elm.field
                "remaining"
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining (Elm.value "ar1"))
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
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.one (Elm.value "ar1"))
                )
            , Elm.field
                "two"
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" )
                    , ( "ar2", Type.named [ "Elm" ] "Expression" )
                    ]
                    (arg2.two (Elm.value "ar1") (Elm.value "ar2"))
                )
            , Elm.field
                "remaining"
                (Elm.lambdaWith
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.remaining (Elm.value "ar1"))
                )
            ]
        ]


{-| -}
custom : Elm.Expression -> List Elm.Expression -> Elm.Expression
custom arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm" ] "Expression" []
                 , Type.list (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
             )
            (Elm.valueFrom moduleName_ "otherwise")
        )
        [ Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg1 (Elm.value "ar1"))
        ]


{-| -}
branch : Elm.Expression -> Elm.Expression -> Elm.Expression
branch arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.string, Type.namedWith [ "Elm" ] "Expression" [] ]
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
             )
            (Elm.valueFrom moduleName_ "branch2")
        )
        [ arg1
        , Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2 (Elm.value "ar1"))
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
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
             )
            (Elm.valueFrom moduleName_ "branch3")
        )
        [ arg1
        , Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2 (Elm.value "ar1") (Elm.value "ar2"))
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
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
             )
            (Elm.valueFrom moduleName_ "branch4")
        )
        [ arg1
        , Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2 (Elm.value "ar1") (Elm.value "ar2") (Elm.value "ar3"))
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
                 (Type.namedWith [ "Elm", "Case" ] "Branch" [])
             )
            (Elm.valueFrom moduleName_ "branch5")
        )
        [ arg1
        , Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            , ( "ar4", Type.named [ "Elm" ] "Expression" )
            ]
            (arg2
                (Elm.value "ar1")
                (Elm.value "ar2")
                (Elm.value "ar3")
                (Elm.value "ar4")
            )
        ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ =
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
    , custom =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm" ] "Expression" []
                , Type.list (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
            )
            (Elm.valueFrom moduleName_ "otherwise")
    , branch =
        Elm.withType
            (Type.function
                [ Type.string, Type.namedWith [ "Elm" ] "Expression" [] ]
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
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
                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
            )
            (Elm.valueFrom moduleName_ "branch5")
    }


