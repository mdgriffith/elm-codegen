module Gen.Set exposing (call_, diff, empty, filter, foldl, foldr, fromList, insert, intersect, isEmpty, map, member, moduleName_, partition, remove, singleton, size, toList, types_, union, values_)

{-| 
@docs moduleName_, empty, singleton, insert, remove, isEmpty, member, size, union, intersect, diff, toList, fromList, map, foldl, foldr, filter, partition, types_, values_, call_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Set" ]


{-| Create an empty set.
-}
empty : Elm.Expression
empty =
    Elm.valueWith
        { importFrom = [ "Set" ]
        , name = "empty"
        , annotation = Just (Type.namedWith [ "Set" ] "Set" [ Type.var "a" ])
        }


{-| Create a set with one value.
-}
singleton : Elm.Expression -> Elm.Expression
singleton arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "singleton"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable" ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| Insert a value into a set.
-}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression
insert arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Remove a value from a set. If the value is not found, no changes are made.
-}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Determine if a set is empty.
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "isEmpty"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        Type.bool
                    )
            }
        )
        [ arg1 ]


{-| Determine if a value is in a set.
-}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        Type.bool
                    )
            }
        )
        [ arg1, arg2 ]


{-| Determine the number of elements in a set.
-}
size : Elm.Expression -> Elm.Expression
size arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "size"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        Type.int
                    )
            }
        )
        [ arg1 ]


{-| Get the union of two sets. Keep all values.
-}
union : Elm.Expression -> Elm.Expression -> Elm.Expression
union arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "union"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Get the intersection of two sets. Keeps values that appear in both sets.
-}
intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
intersect arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "intersect"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Get the difference between the first set and the second. Keeps values
that do not appear in the second set.
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression
diff arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Convert a set into a list, sorted from lowest to highest.
-}
toList : Elm.Expression -> Elm.Expression
toList arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ arg1 ]


{-| Convert a list into a set, removing any duplicates.
-}
fromList : List Elm.Expression -> Elm.Expression
fromList arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "fromList"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Map a function onto a set, creating a new set with no duplicates.
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable" ]
                            (Type.var "comparable2")
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable2" ]
                        )
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "comparable" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "comparable")
                    }
                )
            )
        , arg2
        ]


{-| Fold over the values in a set, in order from lowest to highest.
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith [ "Set" ] "Set" [ Type.var "a" ]
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ), ( "ar1", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg2
        , arg3
        ]


{-| Fold over the values in a set, in order from highest to lowest.
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith [ "Set" ] "Set" [ Type.var "a" ]
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ), ( "ar1", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg2
        , arg3
        ]


{-| Only keep elements that pass the given test.

    import Set exposing (Set)

    numbers : Set Int
    numbers =
      Set.fromList [-2,-1,0,1,2]

    positives : Set Int
    positives =
      Set.filter (\x -> x > 0) numbers

    -- positives == Set.fromList [1,2]
-}
filter : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
filter arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "comparable" ] Type.bool
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "comparable" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "comparable")
                    }
                )
            )
        , arg2
        ]


{-| Create two new sets. The first contains all the elements that passed the
given test, and the second contains all the elements that did not.
-}
partition :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
partition arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "comparable" ] Type.bool
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.tuple
                            (Type.namedWith
                                [ "Set" ]
                                "Set"
                                [ Type.var "comparable" ]
                            )
                            (Type.namedWith
                                [ "Set" ]
                                "Set"
                                [ Type.var "comparable" ]
                            )
                        )
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "comparable" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "comparable")
                    }
                )
            )
        , arg2
        ]


types_ : { set : { annotation : Type.Annotation -> Type.Annotation } }
types_ =
    { set =
        { annotation =
            \arg0_0_0 -> Type.namedWith moduleName_ "Set" [ arg0_0_0 ]
        }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { empty : Elm.Expression
    , singleton : Elm.Expression
    , insert : Elm.Expression
    , remove : Elm.Expression
    , isEmpty : Elm.Expression
    , member : Elm.Expression
    , size : Elm.Expression
    , union : Elm.Expression
    , intersect : Elm.Expression
    , diff : Elm.Expression
    , toList : Elm.Expression
    , fromList : Elm.Expression
    , map : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , filter : Elm.Expression
    , partition : Elm.Expression
    }
values_ =
    { empty =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "empty"
            , annotation =
                Just (Type.namedWith [ "Set" ] "Set" [ Type.var "a" ])
            }
    , singleton =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "singleton"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable" ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , insert =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , remove =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , isEmpty =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "isEmpty"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        Type.bool
                    )
            }
    , member =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        Type.bool
                    )
            }
    , size =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "size"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        Type.int
                    )
            }
    , union =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "union"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , intersect =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "intersect"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , diff =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , toList =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Set" ] "Set" [ Type.var "a" ] ]
                        (Type.list (Type.var "a"))
                    )
            }
    , fromList =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "fromList"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , map =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable" ]
                            (Type.var "comparable2")
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable2" ]
                        )
                    )
            }
    , foldl =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith [ "Set" ] "Set" [ Type.var "a" ]
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith [ "Set" ] "Set" [ Type.var "a" ]
                        ]
                        (Type.var "b")
                    )
            }
    , filter =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "comparable" ] Type.bool
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        )
                    )
            }
    , partition =
        Elm.valueWith
            { importFrom = [ "Set" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "comparable" ] Type.bool
                        , Type.namedWith
                            [ "Set" ]
                            "Set"
                            [ Type.var "comparable" ]
                        ]
                        (Type.tuple
                            (Type.namedWith
                                [ "Set" ]
                                "Set"
                                [ Type.var "comparable" ]
                            )
                            (Type.namedWith
                                [ "Set" ]
                                "Set"
                                [ Type.var "comparable" ]
                            )
                        )
                    )
            }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
call_ :
    { singleton : Elm.Expression -> Elm.Expression
    , insert : Elm.Expression -> Elm.Expression -> Elm.Expression
    , remove : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , size : Elm.Expression -> Elm.Expression
    , union : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , partition : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { singleton =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "singleton"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable" ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , insert =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "insert"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , remove =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "remove"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , isEmpty =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "isEmpty"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_0 ]
    , member =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "member"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , size =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "size"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                Type.int
                            )
                    }
                )
                [ arg1_0 ]
    , union =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "union"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , intersect =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "intersect"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , diff =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "diff"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , toList =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_0 ]
    , fromList =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "fromList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , map =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable" ]
                                    (Type.var "comparable2")
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable2" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , foldl =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , foldr =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , filter =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , partition =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Set" ]
                    , name = "partition"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "comparable" ]
                                ]
                                (Type.tuple
                                    (Type.namedWith
                                        [ "Set" ]
                                        "Set"
                                        [ Type.var "comparable" ]
                                    )
                                    (Type.namedWith
                                        [ "Set" ]
                                        "Set"
                                        [ Type.var "comparable" ]
                                    )
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    }


