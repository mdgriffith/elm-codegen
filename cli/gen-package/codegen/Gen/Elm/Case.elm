module Gen.Elm.Case exposing (annotation_, branch0, branch1, branch2, branch3, branch4, branch5, branch6, branchList, branchWith, call_, custom, list, maybe, moduleName_, otherwise, result, string, triple, tuple, values_)

{-| 
@docs moduleName_, maybe, result, list, string, tuple, triple, custom, otherwise, branch0, branch1, branch2, branch3, branch4, branch5, branch6, branchWith, branchList, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Tuple


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
maybe arg arg0 =
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
        [ arg
        , Elm.record
            [ Tuple.pair "nothing" arg0.nothing, Tuple.pair "just" arg0.just ]
        ]


{-| Elm.Case.triple myResult
        { ok =
            \ok ->
                Elm.string "No errors"
        , err =
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
result arg arg0 =
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
        [ arg
        , Elm.record [ Tuple.pair "err" arg0.err, Tuple.pair "ok" arg0.ok ]
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
list arg arg0 =
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
        [ arg
        , Elm.record
            [ Tuple.pair "empty" arg0.empty
            , Tuple.pair
                "nonEmpty"
                (Elm.functionReduced
                    "unpack"
                    (\unpack ->
                        Elm.functionReduced "unpack" (arg0.nonEmpty unpack)
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
string arg arg0 =
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
        [ arg
        , Elm.record
            [ Tuple.pair "cases" (Elm.list arg0.cases)
            , Tuple.pair "otherwise" arg0.otherwise
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
tuple arg arg0 arg1 arg2 =
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
        [ arg
        , Elm.string arg0
        , Elm.string arg1
        , Elm.functionReduced
            "unpack"
            (\unpack -> Elm.functionReduced "unpack" (arg2 unpack))
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
triple arg arg0 arg1 arg2 arg3 =
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
        [ arg
        , Elm.string arg0
        , Elm.string arg1
        , Elm.string arg2
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced "unpack" (arg3 unpack unpack0)
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
custom arg arg0 arg1 =
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
        [ arg, arg0, Elm.list arg1 ]


{-| A catchall branch in case you want the case to be nonexhaustive.

otherwise: (Elm.Expression -> Elm.Expression) -> Elm.Case.Branch
-}
otherwise : (Elm.Expression -> Elm.Expression) -> Elm.Expression
otherwise arg =
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
        [ Elm.functionReduced "unpack" arg ]


{-| branch0: String -> Elm.Expression -> Elm.Case.Branch -}
branch0 : String -> Elm.Expression -> Elm.Expression
branch0 arg arg0 =
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
        [ Elm.string arg, arg0 ]


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
branch1 arg arg0 arg1 =
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
        [ Elm.string arg, arg0, Elm.functionReduced "unpack" arg1 ]


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
branch2 arg arg0 arg1 arg2 =
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
        [ Elm.string arg
        , arg0
        , arg1
        , Elm.functionReduced
            "unpack"
            (\unpack -> Elm.functionReduced "unpack" (arg2 unpack))
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
branch3 arg arg0 arg1 arg2 arg3 =
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
        [ Elm.string arg
        , arg0
        , arg1
        , arg2
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced "unpack" (arg3 unpack unpack0)
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
branch4 arg arg0 arg1 arg2 arg3 arg4 =
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
        [ Elm.string arg
        , arg0
        , arg1
        , arg2
        , arg3
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_2_1_2_0_2_5_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (arg4 unpack unpack0
                                        unpack_2_1_2_0_2_5_2_0_0
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
branch5 arg arg0 arg1 arg2 arg3 arg4 arg5 =
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
        [ Elm.string arg
        , arg0
        , arg1
        , arg2
        , arg3
        , arg4
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_2_1_2_0_2_6_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_2_1_2_1_2_0_2_6_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (arg5 unpack unpack0
                                                 unpack_2_1_2_0_2_6_2_0_0
                                                unpack_2_1_2_1_2_0_2_6_2_0_0
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
branch6 arg arg0 arg1 arg2 arg3 arg4 arg5 arg6 =
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
        [ Elm.string arg
        , arg0
        , arg1
        , arg2
        , arg3
        , arg4
        , arg5
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_2_1_2_0_2_7_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_2_1_2_1_2_0_2_7_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\unpack_2_1_2_1_2_1_2_0_2_7_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (arg6 unpack unpack0
                                                         unpack_2_1_2_0_2_7_2_0_0
                                                         unpack_2_1_2_1_2_0_2_7_2_0_0
                                                        unpack_2_1_2_1_2_1_2_0_2_7_2_0_0
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
branchWith arg arg0 arg1 =
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
        [ Elm.string arg, Elm.int arg0, Elm.functionReduced "unpack" arg1 ]


{-| branchList: Int -> (List Elm.Expression -> Elm.Expression) -> Elm.Case.Branch -}
branchList : Int -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
branchList arg arg0 =
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
        [ Elm.int arg, Elm.functionReduced "unpack" arg0 ]


annotation_ : { branch : Type.Annotation }
annotation_ =
    { branch = Type.namedWith [ "Elm", "Case" ] "Branch" [] }


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
        \arg arg0 ->
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
                [ arg, arg0 ]
    , result =
        \arg arg0 ->
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
                [ arg, arg0 ]
    , list =
        \arg arg0 ->
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
                [ arg, arg0 ]
    , string =
        \arg arg0 ->
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
                [ arg, arg0 ]
    , tuple =
        \arg arg0 arg1 arg2 ->
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
                [ arg, arg0, arg1, arg2 ]
    , triple =
        \arg arg0 arg1 arg2 arg3 ->
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
                [ arg, arg0, arg1, arg2, arg3 ]
    , custom =
        \arg arg0 arg1 ->
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
                [ arg, arg0, arg1 ]
    , otherwise =
        \arg ->
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
                [ arg ]
    , branch0 =
        \arg arg0 ->
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
                [ arg, arg0 ]
    , branch1 =
        \arg arg0 arg1 ->
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
                [ arg, arg0, arg1 ]
    , branch2 =
        \arg arg0 arg1 arg2 ->
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
                [ arg, arg0, arg1, arg2 ]
    , branch3 =
        \arg arg0 arg1 arg2 arg3 ->
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
                [ arg, arg0, arg1, arg2, arg3 ]
    , branch4 =
        \arg arg0 arg1 arg2 arg3 arg4 ->
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
                [ arg, arg0, arg1, arg2, arg3, arg4 ]
    , branch5 =
        \arg arg0 arg1 arg2 arg3 arg4 arg5 ->
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
                [ arg, arg0, arg1, arg2, arg3, arg4, arg5 ]
    , branch6 =
        \arg arg0 arg1 arg2 arg3 arg4 arg5 arg6 ->
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
                [ arg, arg0, arg1, arg2, arg3, arg4, arg5, arg6 ]
    , branchWith =
        \arg arg0 arg1 ->
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
                [ arg, arg0, arg1 ]
    , branchList =
        \arg arg0 ->
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
                [ arg, arg0 ]
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


