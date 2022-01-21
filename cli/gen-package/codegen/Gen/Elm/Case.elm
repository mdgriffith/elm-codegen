module Gen.Elm.Case exposing (branch0, branch1, branch2, branch3, branch4, branchWith, custom, list, maybe, moduleName_, otherwise, result, triple, tuple, types_, values_)

{-| 
@docs moduleName_, maybe, result, list, tuple, triple, custom, otherwise, branch0, branch1, branch2, branch3, branch4, branchWith, types_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Case" ]


{-|

    Elm.fn "myMaybe" <|
        \myMaybe ->
            Elm.Case.list myMaybe
                { nothing = Elm.int 0
                , just =
                    \content ->
                        Elm.plus (Elm.int 5) content
                }

Generates

    \myMaybe ->
        case myMaybe of
            Nothing ->
                0

            Just just ->
                just + 5

-}
maybe :
    Elm.Expression
    -> { nothing : Elm.Expression, just : Elm.Expression -> Elm.Expression }
    -> Elm.Expression
maybe arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1
        , Elm.record
            [ Elm.field "nothing" arg2.nothing
            , Elm.field
                "just"
                (Elm.functionAdvanced
                    [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
                    (arg2.just
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar0"
                            , annotation =
                                Just (Type.namedWith [ "Elm" ] "Expression" [])
                            }
                        )
                    )
                )
            ]
        ]


{-|

    Elm.fn "myResult" <|
        \myResult ->
            Elm.Case.triple myResult
                { ok =
                    \ok ->
                        Elm.string "No errors"
                , err =
                    \err ->
                        err
                }

Generates

    \myResult ->
        case myResult of
            Ok ok ->
                "No errors"

            Err err ->
                err

-}
result :
    Elm.Expression
    -> { err : Elm.Expression -> Elm.Expression
    , ok : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
result arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "result"
            , annotation =
                Just
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
            }
        )
        [ arg1
        , Elm.record
            [ Elm.field
                "err"
                (Elm.functionAdvanced
                    [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
                    (arg2.err
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar0"
                            , annotation =
                                Just (Type.namedWith [ "Elm" ] "Expression" [])
                            }
                        )
                    )
                )
            , Elm.field
                "ok"
                (Elm.functionAdvanced
                    [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
                    (arg2.ok
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar0"
                            , annotation =
                                Just (Type.namedWith [ "Elm" ] "Expression" [])
                            }
                        )
                    )
                )
            ]
        ]


{-|

    Elm.fn "myList" <|
        \myList ->
            Elm.Case.list myList
                { empty = Elm.int 0
                , nonEmpty =
                    \top remaining ->
                        Elm.plus (Elm.int 5) top
                }

Generates

    \myList ->
        case myList of
            [] ->
                0

            top :: remaining ->
                top + 5

-}
list :
    Elm.Expression
    -> { empty : Elm.Expression
    , nonEmpty : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
list arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.record
                            [ ( "empty"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              )
                            , ( "nonEmpty"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1
        , Elm.record
            [ Elm.field "empty" arg2.empty
            , Elm.field
                "nonEmpty"
                (Elm.functionAdvanced
                    [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
                    , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
                    ]
                    (arg2.nonEmpty
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar0"
                            , annotation =
                                Just (Type.namedWith [ "Elm" ] "Expression" [])
                            }
                        )
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar1"
                            , annotation =
                                Just (Type.namedWith [ "Elm" ] "Expression" [])
                            }
                        )
                    )
                )
            ]
        ]


{-|

    Elm.fn "myTuple" <|
        \myTuple ->
            Elm.Case.tuple myTuple
                { nothing = Elm.int 0
                , just =
                    \one two ->
                        Elm.plus (Elm.int 5) two
                }

Generates

    \myTuple ->
        case myTuple of
            ( one, two ) ->
                5 + two

-}
tuple :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "tuple"
            , annotation =
                Just
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
            }
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-|

    Elm.fn "myTriple" <|
        \myTriple ->
            Elm.Case.triple myTriple
                { nothing = Elm.int 0
                , just =
                    \one two three ->
                        Elm.plus (Elm.int 5) two
                }

Generates

    \myTriple ->
        case myTriple of
            ( one, two, three ) ->
                5 + two

-}
triple :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
triple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "triple"
            , annotation =
                Just
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
            }
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-|

    Elm.fn "maybeString" <|
        \maybeString ->
            Elm.Case.custom maybeString
                [ Elm.Case.branch [ "Maybe" ]
                    "Nothing"
                    (Elm.string "It's nothing, I swear!")
                , Elm.Case.branch2 [ "Maybe" ] "Just" <|
                    \just ->
                        Elm.append (Elm.string "Actually, it's: ") just
                ]

Generates

    \maybeString ->
        case maybeString of
            Nothing ->
                "It's nothing, I swear!"

            Just just ->
                "Actually, it's " ++ just

-}
custom : Elm.Expression -> List Elm.Expression -> Elm.Expression
custom arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list
                            (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| A catchall branch in case you want the case to be nonexhaustive.
-}
otherwise : (Elm.Expression -> Elm.Expression) -> Elm.Expression
otherwise arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "otherwise"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
branch0 :
    List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
branch0 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch0"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.list arg1, arg2, arg3 ]


{-| -}
branch1 :
    List Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch1 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch1"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.list arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
branch2 :
    List Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch2"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.list arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
branch3 :
    List Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch3 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch3"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.list arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
branch4 :
    List Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
branch4 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch4"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
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
            }
        )
        [ Elm.list arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar3", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
branchWith :
    List Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branchWith arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branchWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.int
                        , Type.function
                            [ Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.list arg1
        , arg2
        , arg3
        , Elm.functionAdvanced
            [ ( "ar0", Type.list (Type.namedWith [ "Elm" ] "Expression" []) ) ]
            (arg4
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just
                            (Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
            )
        ]


types_ : { branch : { annotation : Type.Annotation } }
types_ =
    { branch = { annotation = Type.namedWith moduleName_ "Branch" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { maybe : Elm.Expression
    , result : Elm.Expression
    , list : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , custom : Elm.Expression
    , otherwise : Elm.Expression
    , branch0 : Elm.Expression
    , branch1 : Elm.Expression
    , branch2 : Elm.Expression
    , branch3 : Elm.Expression
    , branch4 : Elm.Expression
    , branchWith : Elm.Expression
    }
values_ =
    { maybe =
        Elm.valueWith
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
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , result =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "result"
            , annotation =
                Just
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
            }
    , list =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.record
                            [ ( "empty"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              )
                            , ( "nonEmpty"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , tuple =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "tuple"
            , annotation =
                Just
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
            }
    , triple =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "triple"
            , annotation =
                Just
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
            }
    , custom =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list
                            (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , otherwise =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "otherwise"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch0 =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch0"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch1 =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch1"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch2 =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch2"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch3 =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch3"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch4 =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branch4"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
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
            }
    , branchWith =
        Elm.valueWith
            { importFrom = [ "Elm", "Case" ]
            , name = "branchWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.int
                        , Type.function
                            [ Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    }


