module Gen.Elm.Case exposing (annotation_, branch0, branch1, branch2, branch3, branch4, branch5, branch6, branchList, branchWith, call_, custom, list, maybe, moduleName_, otherwise, result, string, triple, tuple, values_)

{-| 
@docs moduleName_, maybe, result, list, string, tuple, triple, custom, otherwise, branch0, branch1, branch2, branch3, branch4, branch5, branch6, branchWith, branchList, annotation_, call_, values_
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
        [ resultArg
        , Elm.record
            [ Tuple.pair "err" resultArg0.err, Tuple.pair "ok" resultArg0.ok ]
        ]


{-| Let's unpack the first value from a list.

    Elm.Case.list myList
        { empty = Elm.int 0
        , nonEmpty =
            \top remaining ->
                Elm.plus (Elm.int 5) top
        }

Generates

    case myList of
        [] ->
            0

        top :: remaining ->
            top + 5

**Note** if you want more control over unpacking lists, check out [`branchList`](#branchList)

list: 
    Elm.Expression
    -> { empty : Elm.Expression
    , nonEmpty : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
-}
list :
    Elm.Expression
    -> { empty : Elm.Expression
    , nonEmpty : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
list listArg listArg0 =
    Elm.apply
        (Elm.value
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
        [ listArg
        , Elm.record
            [ Tuple.pair "empty" listArg0.empty
            , Tuple.pair
                "nonEmpty"
                (Elm.functionReduced
                    "listUnpack"
                    (\functionReducedUnpack ->
                        Elm.functionReduced
                            "unpack"
                            (listArg0.nonEmpty functionReducedUnpack)
                    )
                )
            ]
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
string stringArg stringArg0 =
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
                              , Type.namedWith [ "Elm" ] "Expression" []
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ stringArg
        , Elm.record
            [ Tuple.pair "cases" (Elm.list stringArg0.cases)
            , Tuple.pair "otherwise" stringArg0.otherwise
            ]
        ]


{-| Elm.Case.tuple myTuple
        "first"
        "second"
        (\one two ->
            Elm.plus (Elm.int 5) two
        )

Generates

    case myTuple of
        ( first, second ) ->
            5 + second

tuple: 
    Elm.Expression
    -> String
    -> String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
tuple :
    Elm.Expression
    -> String
    -> String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
tuple tupleArg tupleArg0 tupleArg1 tupleArg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.string
                        , Type.string
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
        [ tupleArg
        , Elm.string tupleArg0
        , Elm.string tupleArg1
        , Elm.functionReduced
            "tupleUnpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (tupleArg2 functionReducedUnpack)
            )
        ]


{-| Elm.Case.triple myTriple
        "one"
        "two"
        "three"
        (\one two three ->
            Elm.plus (Elm.int 5) two
        )

Generates

    case myTriple of
        ( one, two, three ) ->
            5 + two

triple: 
    Elm.Expression
    -> String
    -> String
    -> String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
triple :
    Elm.Expression
    -> String
    -> String
    -> String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 tripleArg2 tripleArg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.string
                        , Type.string
                        , Type.string
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
        [ tripleArg
        , Elm.string tripleArg0
        , Elm.string tripleArg1
        , Elm.string tripleArg2
        , Elm.functionReduced
            "tripleUnpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (tripleArg3 functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
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
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.list
                            (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ customArg, customArg0, Elm.list customArg1 ]


{-| A catchall branch in case you want the case to be nonexhaustive.

otherwise: (Elm.Expression -> Elm.Expression) -> Elm.Case.Branch
-}
otherwise : (Elm.Expression -> Elm.Expression) -> Elm.Expression
otherwise otherwiseArg =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced "otherwiseUnpack" otherwiseArg ]


{-| branch0: String -> Elm.Expression -> Elm.Case.Branch -}
branch0 : String -> Elm.Expression -> Elm.Expression
branch0 branch0Arg branch0Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch0"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.string branch0Arg, branch0Arg0 ]


{-| branch1: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch1 :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch1 branch1Arg branch1Arg0 branch1Arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch1"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
        )
        [ Elm.string branch1Arg
        , branch1Arg0
        , Elm.functionReduced "branch1Unpack" branch1Arg1
        ]


{-| branch2: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch2 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch2 branch2Arg branch2Arg0 branch2Arg1 branch2Arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
        [ Elm.string branch2Arg
        , branch2Arg0
        , branch2Arg1
        , Elm.functionReduced
            "branch2Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (branch2Arg2 functionReducedUnpack)
            )
        ]


{-| branch3: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch3 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
branch3 branch3Arg branch3Arg0 branch3Arg1 branch3Arg2 branch3Arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
        [ Elm.string branch3Arg
        , branch3Arg0
        , branch3Arg1
        , branch3Arg2
        , Elm.functionReduced
            "branch3Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (branch3Arg3 functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
        ]


{-| branch4: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch4 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
branch4 branch4Arg branch4Arg0 branch4Arg1 branch4Arg2 branch4Arg3 branch4Arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
        [ Elm.string branch4Arg
        , branch4Arg0
        , branch4Arg1
        , branch4Arg2
        , branch4Arg3
        , Elm.functionReduced
            "branch4Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_5_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (branch4Arg4 functionReducedUnpack
                                         functionReducedUnpack0
                                        functionReducedUnpack_2_1_2_0_2_5_2_0_0
                                    )
                            )
                    )
            )
        ]


{-| branch5: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch5 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
branch5 branch5Arg branch5Arg0 branch5Arg1 branch5Arg2 branch5Arg3 branch5Arg4 branch5Arg5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
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
        [ Elm.string branch5Arg
        , branch5Arg0
        , branch5Arg1
        , branch5Arg2
        , branch5Arg3
        , branch5Arg4
        , Elm.functionReduced
            "branch5Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_6_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (branch5Arg5 functionReducedUnpack
                                                 functionReducedUnpack0
                                                 functionReducedUnpack_2_1_2_0_2_6_2_0_0
                                                functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0
                                            )
                                    )
                            )
                    )
            )
        ]


{-| branch6: 
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Case.Branch
-}
branch6 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
branch6 branch6Arg branch6Arg0 branch6Arg1 branch6Arg2 branch6Arg3 branch6Arg4 branch6Arg5 branch6Arg6 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
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
        [ Elm.string branch6Arg
        , branch6Arg0
        , branch6Arg1
        , branch6Arg2
        , branch6Arg3
        , branch6Arg4
        , branch6Arg5
        , Elm.functionReduced
            "branch6Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_7_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (branch6Arg6
                                                         functionReducedUnpack
                                                         functionReducedUnpack0
                                                         functionReducedUnpack_2_1_2_0_2_7_2_0_0
                                                         functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0
                                                        functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| branchWith: String -> Int -> (List Elm.Expression -> Elm.Expression) -> Elm.Case.Branch -}
branchWith :
    String -> Int -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branchWith branchWithArg branchWithArg0 branchWithArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branchWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
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
        [ Elm.string branchWithArg
        , Elm.int branchWithArg0
        , Elm.functionReduced "branchWithUnpack" branchWithArg1
        ]


{-| branchList: Int -> (List Elm.Expression -> Elm.Expression) -> Elm.Case.Branch -}
branchList : Int -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branchList branchListArg branchListArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branchList"
            , annotation =
                Just
                    (Type.function
                        [ Type.int
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
        [ Elm.int branchListArg
        , Elm.functionReduced "branchListUnpack" branchListArg0
        ]


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
    , list : Elm.Expression -> Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tuple :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , triple :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , custom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , otherwise : Elm.Expression -> Elm.Expression
    , branch0 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , branch1 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , branch2 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , branch3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , branch4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , branch5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , branch6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , branchWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , branchList : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    , list =
        \listArg listArg0 ->
            Elm.apply
                (Elm.value
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
                                      )
                                    ]
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ listArg, listArg0 ]
    , string =
        \stringArg stringArg0 ->
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
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      )
                                    ]
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ stringArg, stringArg0 ]
    , tuple =
        \tupleArg tupleArg0 tupleArg1 tupleArg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "tuple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.string
                                , Type.string
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
                [ tupleArg, tupleArg0, tupleArg1, tupleArg2 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 tripleArg2 tripleArg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "triple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.string
                                , Type.string
                                , Type.string
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
                [ tripleArg, tripleArg0, tripleArg1, tripleArg2, tripleArg3 ]
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
    , otherwise =
        \otherwiseArg ->
            Elm.apply
                (Elm.value
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
                [ otherwiseArg ]
    , branch0 =
        \branch0Arg branch0Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch0"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                            )
                    }
                )
                [ branch0Arg, branch0Arg0 ]
    , branch1 =
        \branch1Arg branch1Arg0 branch1Arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch1"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                            )
                    }
                )
                [ branch1Arg, branch1Arg0, branch1Arg1 ]
    , branch2 =
        \branch2Arg branch2Arg0 branch2Arg1 branch2Arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
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
                [ branch2Arg, branch2Arg0, branch2Arg1, branch2Arg2 ]
    , branch3 =
        \branch3Arg branch3Arg0 branch3Arg1 branch3Arg2 branch3Arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
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
                [ branch3Arg
                , branch3Arg0
                , branch3Arg1
                , branch3Arg2
                , branch3Arg3
                ]
    , branch4 =
        \branch4Arg branch4Arg0 branch4Arg1 branch4Arg2 branch4Arg3 branch4Arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
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
                [ branch4Arg
                , branch4Arg0
                , branch4Arg1
                , branch4Arg2
                , branch4Arg3
                , branch4Arg4
                ]
    , branch5 =
        \branch5Arg branch5Arg0 branch5Arg1 branch5Arg2 branch5Arg3 branch5Arg4 branch5Arg5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
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
                [ branch5Arg
                , branch5Arg0
                , branch5Arg1
                , branch5Arg2
                , branch5Arg3
                , branch5Arg4
                , branch5Arg5
                ]
    , branch6 =
        \branch6Arg branch6Arg0 branch6Arg1 branch6Arg2 branch6Arg3 branch6Arg4 branch6Arg5 branch6Arg6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branch6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
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
                [ branch6Arg
                , branch6Arg0
                , branch6Arg1
                , branch6Arg2
                , branch6Arg3
                , branch6Arg4
                , branch6Arg5
                , branch6Arg6
                ]
    , branchWith =
        \branchWithArg branchWithArg0 branchWithArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branchWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.int
                                , Type.function
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                            )
                    }
                )
                [ branchWithArg, branchWithArg0, branchWithArg1 ]
    , branchList =
        \branchListArg branchListArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case" ]
                    , name = "branchList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.function
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                            )
                    }
                )
                [ branchListArg, branchListArg0 ]
    }


values_ :
    { maybe : Elm.Expression
    , result : Elm.Expression
    , list : Elm.Expression
    , string : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , custom : Elm.Expression
    , otherwise : Elm.Expression
    , branch0 : Elm.Expression
    , branch1 : Elm.Expression
    , branch2 : Elm.Expression
    , branch3 : Elm.Expression
    , branch4 : Elm.Expression
    , branch5 : Elm.Expression
    , branch6 : Elm.Expression
    , branchWith : Elm.Expression
    , branchList : Elm.Expression
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
    , list =
        Elm.value
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
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
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
    , tuple =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.string
                        , Type.string
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.string
                        , Type.string
                        , Type.string
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.list
                            (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , otherwise =
        Elm.value
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch0"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch1 =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch1"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch2 =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
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
    , branch5 =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm", "Case" ] "Branch" [])
                    )
            }
    , branch6 =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branch6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.tuple
                            Type.string
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
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
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branchWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
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
    , branchList =
        Elm.value
            { importFrom = [ "Elm", "Case" ]
            , name = "branchList"
            , annotation =
                Just
                    (Type.function
                        [ Type.int
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