module Gen.Dict exposing (annotation_, call_, diff, empty, filter, foldl, foldr, fromList, get, insert, intersect, isEmpty, keys, map, member, merge, moduleName_, partition, remove, singleton, size, toList, union, update, values, values_)

{-| 
@docs moduleName_, empty, singleton, insert, update, remove, isEmpty, member, get, size, keys, values, toList, fromList, map, foldl, foldr, filter, partition, union, intersect, diff, merge, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Dict" ]


{-| Create an empty dictionary. -}
empty : Elm.Expression
empty =
    Elm.value
        { importFrom = [ "Dict" ]
        , name = "empty"
        , annotation =
            Just
                (Type.namedWith [ "Dict" ] "Dict" [ Type.var "k", Type.var "v" ]
                )
        }


{-| Create a dictionary with one key-value pair. -}
singleton : Elm.Expression -> Elm.Expression -> Elm.Expression
singleton arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "singleton"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable", Type.var "v" ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Insert a key-value pair into a dictionary. Replaces value when there is
a collision. -}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
insert arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.var "v"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, arg2, arg3 ]


{-| Update the value of a dictionary for a specific key with a given function. -}
update :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
update arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.function
                            [ Type.maybe (Type.var "v") ]
                            (Type.maybe (Type.var "v"))
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, Elm.fn "update0" (\fn0_2_0 -> arg2 fn0_2_0), arg3 ]


{-| Remove a key-value pair from a dictionary. If the key is not found,
no changes are made. -}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Determine if a dictionary is empty.

    isEmpty empty == True
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "isEmpty"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        Type.bool
                    )
            }
        )
        [ arg1 ]


{-| Determine if a key is in a dictionary. -}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        Type.bool
                    )
            }
        )
        [ arg1, arg2 ]


{-| Get the value associated with a key. If the key is not found, return
`Nothing`. This is useful when you are not sure if a key will be in the
dictionary.

    animals = fromList [ ("Tom", Cat), ("Jerry", Mouse) ]

    get "Tom"   animals == Just Cat
    get "Jerry" animals == Just Mouse
    get "Spike" animals == Nothing

-}
get : Elm.Expression -> Elm.Expression -> Elm.Expression
get arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.maybe (Type.var "v"))
                    )
            }
        )
        [ arg1, arg2 ]


{-| Determine the number of key-value pairs in the dictionary. -}
size : Elm.Expression -> Elm.Expression
size arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "size"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        Type.int
                    )
            }
        )
        [ arg1 ]


{-| Get all of the keys in a dictionary, sorted from lowest to highest.

    keys (fromList [(0,"Alice"),(1,"Bob")]) == [0,1]
-}
keys : Elm.Expression -> Elm.Expression
keys arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "keys"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.var "k"))
                    )
            }
        )
        [ arg1 ]


{-| Get all of the values in a dictionary, in the order of their keys.

    values (fromList [(0,"Alice"),(1,"Bob")]) == ["Alice", "Bob"]
-}
values : Elm.Expression -> Elm.Expression
values arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "values"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.var "v"))
                    )
            }
        )
        [ arg1 ]


{-| Convert a dictionary into an association list of key-value pairs, sorted by keys. -}
toList : Elm.Expression -> Elm.Expression
toList arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.tuple (Type.var "k") (Type.var "v")))
                    )
            }
        )
        [ arg1 ]


{-| Convert an association list into a dictionary. -}
fromList : List Elm.Expression -> Elm.Expression
fromList arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "fromList"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple (Type.var "comparable") (Type.var "v"))
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Apply a function to all values in a dictionary.
-}
map :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
map arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "a" ]
                            (Type.var "b")
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.fn
            "map0"
            (\fn0_2_0 -> Elm.fn "map1" (\fn0_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0))
        , arg2
        ]


{-| Fold over the key-value pairs in a dictionary from lowest key to highest key.

    import Dict exposing (Dict)

    getAges : Dict String User -> List String
    getAges users =
      Dict.foldl addAge [] users

    addAge : String -> User -> List String -> List String
    addAge _ user ages =
      user.age :: ages

    -- getAges users == [33,19,28]
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "v", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.fn
            "foldl0"
            (\fn0_2_0 ->
                Elm.fn
                    "foldl1"
                    (\fn0_2_2_0 ->
                        Elm.fn
                            "foldl2"
                            (\fn0_2_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0 fn0_2_2_2_0)
                    )
            )
        , arg2
        , arg3
        ]


{-| Fold over the key-value pairs in a dictionary from highest key to lowest key.

    import Dict exposing (Dict)

    getAges : Dict String User -> List String
    getAges users =
      Dict.foldr addAge [] users

    addAge : String -> User -> List String -> List String
    addAge _ user ages =
      user.age :: ages

    -- getAges users == [28,19,33]
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "v", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.fn
            "foldr0"
            (\fn0_2_0 ->
                Elm.fn
                    "foldr1"
                    (\fn0_2_2_0 ->
                        Elm.fn
                            "foldr2"
                            (\fn0_2_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0 fn0_2_2_2_0)
                    )
            )
        , arg2
        , arg3
        ]


{-| Keep only the key-value pairs that pass the given test. -}
filter :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
filter arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable", Type.var "v" ]
                            Type.bool
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ Elm.fn
            "filter0"
            (\fn0_2_0 -> Elm.fn "filter1" (\fn0_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0)
            )
        , arg2
        ]


{-| Partition a dictionary according to some test. The first dictionary
contains all key-value pairs which passed the test, and the second contains
the pairs that did not.
-}
partition :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
partition arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable", Type.var "v" ]
                            Type.bool
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.tuple
                            (Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.var "comparable", Type.var "v" ]
                            )
                            (Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.var "comparable", Type.var "v" ]
                            )
                        )
                    )
            }
        )
        [ Elm.fn
            "partition0"
            (\fn0_2_0 ->
                Elm.fn "partition1" (\fn0_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0)
            )
        , arg2
        ]


{-| Combine two dictionaries. If there is a collision, preference is given
to the first dictionary.
-}
union : Elm.Expression -> Elm.Expression -> Elm.Expression
union arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "union"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Keep a key-value pair when its key appears in the second dictionary.
Preference is given to values in the first dictionary.
-}
intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
intersect arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "intersect"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| Keep a key-value pair when its key does not appear in the second dictionary.
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression
diff arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        )
                    )
            }
        )
        [ arg1, arg2 ]


{-| The most general way of combining two dictionaries. You provide three
accumulators for when a given key appears:

  1. Only in the left dictionary.
  2. In both dictionaries.
  3. Only in the right dictionary.

You then traverse all the keys from lowest to highest, building up whatever
you want.
-}
merge :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
merge arg1 arg2 arg3 arg4 arg5 arg6 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "merge"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable"
                            , Type.var "a"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.function
                            [ Type.var "comparable"
                            , Type.var "a"
                            , Type.var "b"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.function
                            [ Type.var "comparable"
                            , Type.var "b"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "b" ]
                        , Type.var "result"
                        ]
                        (Type.var "result")
                    )
            }
        )
        [ Elm.fn
            "merge0"
            (\fn0_2_0 ->
                Elm.fn
                    "merge1"
                    (\fn0_2_2_0 ->
                        Elm.fn
                            "merge2"
                            (\fn0_2_2_2_0 -> arg1 fn0_2_0 fn0_2_2_0 fn0_2_2_2_0)
                    )
            )
        , Elm.fn
            "merge0"
            (\fn0_2_0 ->
                Elm.fn
                    "merge1"
                    (\fn0_3_2_0 ->
                        Elm.fn
                            "merge2"
                            (\fn0_2_3_2_0 ->
                                Elm.fn
                                    "merge3"
                                    (\fn0_2_2_3_2_0 ->
                                        arg2 fn0_2_0 fn0_3_2_0 fn0_2_3_2_0
                                            fn0_2_2_3_2_0
                                    )
                            )
                    )
            )
        , Elm.fn
            "merge0"
            (\fn0_2_0 ->
                Elm.fn
                    "merge1"
                    (\fn0_4_2_0 ->
                        Elm.fn
                            "merge2"
                            (\fn0_2_4_2_0 -> arg3 fn0_2_0 fn0_4_2_0 fn0_2_4_2_0)
                    )
            )
        , arg4
        , arg5
        , arg6
        ]


annotation_ : { dict : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { dict =
        \arg0_0 arg1_0 -> Type.namedWith moduleName_ "Dict" [ arg0_0, arg1_0 ]
    }


call_ :
    { singleton : Elm.Expression -> Elm.Expression -> Elm.Expression
    , insert :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , update :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , remove : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , size : Elm.Expression -> Elm.Expression
    , keys : Elm.Expression -> Elm.Expression
    , values : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , partition : Elm.Expression -> Elm.Expression -> Elm.Expression
    , union : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , merge :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    }
call_ =
    { singleton =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "singleton"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable", Type.var "v" ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , insert =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "insert"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.var "v"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , update =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "update"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.function
                                    [ Type.maybe (Type.var "v") ]
                                    (Type.maybe (Type.var "v"))
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , remove =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "remove"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , isEmpty =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "isEmpty"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_0 ]
    , member =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "member"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , get =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.maybe (Type.var "v"))
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , size =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "size"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                Type.int
                            )
                    }
                )
                [ arg1_0 ]
    , keys =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "keys"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list (Type.var "k"))
                            )
                    }
                )
                [ arg1_0 ]
    , values =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "values"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list (Type.var "v"))
                            )
                    }
                )
                [ arg1_0 ]
    , toList =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list
                                    (Type.tuple (Type.var "k") (Type.var "v"))
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , fromList =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "fromList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        (Type.var "comparable")
                                        (Type.var "v")
                                    )
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , map =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k", Type.var "a" ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "b" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , foldl =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k", Type.var "v", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , foldr =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k", Type.var "v", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , filter =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable", Type.var "v" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , partition =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "partition"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable", Type.var "v" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.tuple
                                    (Type.namedWith
                                        [ "Dict" ]
                                        "Dict"
                                        [ Type.var "comparable", Type.var "v" ]
                                    )
                                    (Type.namedWith
                                        [ "Dict" ]
                                        "Dict"
                                        [ Type.var "comparable", Type.var "v" ]
                                    )
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , union =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "union"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , intersect =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "intersect"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , diff =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "diff"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , merge =
        \arg1_0 arg2_0 arg3_0 arg4_0 arg5_0 arg6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "merge"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable"
                                    , Type.var "a"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.function
                                    [ Type.var "comparable"
                                    , Type.var "a"
                                    , Type.var "b"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.function
                                    [ Type.var "comparable"
                                    , Type.var "b"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "b" ]
                                , Type.var "result"
                                ]
                                (Type.var "result")
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0, arg4_0, arg5_0, arg6_0 ]
    }


values_ :
    { empty : Elm.Expression
    , singleton : Elm.Expression
    , insert : Elm.Expression
    , update : Elm.Expression
    , remove : Elm.Expression
    , isEmpty : Elm.Expression
    , member : Elm.Expression
    , get : Elm.Expression
    , size : Elm.Expression
    , keys : Elm.Expression
    , values : Elm.Expression
    , toList : Elm.Expression
    , fromList : Elm.Expression
    , map : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , filter : Elm.Expression
    , partition : Elm.Expression
    , union : Elm.Expression
    , intersect : Elm.Expression
    , diff : Elm.Expression
    , merge : Elm.Expression
    }
values_ =
    { empty =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "empty"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Dict" ]
                        "Dict"
                        [ Type.var "k", Type.var "v" ]
                    )
            }
    , singleton =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "singleton"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable", Type.var "v" ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , insert =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.var "v"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.function
                            [ Type.maybe (Type.var "v") ]
                            (Type.maybe (Type.var "v"))
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , remove =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , isEmpty =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "isEmpty"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        Type.bool
                    )
            }
    , member =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        Type.bool
                    )
            }
    , get =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.maybe (Type.var "v"))
                    )
            }
    , size =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "size"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        Type.int
                    )
            }
    , keys =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "keys"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.var "k"))
                    )
            }
    , values =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "values"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.var "v"))
                    )
            }
    , toList =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.tuple (Type.var "k") (Type.var "v")))
                    )
            }
    , fromList =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "fromList"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple (Type.var "comparable") (Type.var "v"))
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "a" ]
                            (Type.var "b")
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "b" ]
                        )
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "v", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "k", Type.var "v", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.var "b")
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable", Type.var "v" ]
                            Type.bool
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , partition =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable", Type.var "v" ]
                            Type.bool
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.tuple
                            (Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.var "comparable", Type.var "v" ]
                            )
                            (Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.var "comparable", Type.var "v" ]
                            )
                        )
                    )
            }
    , union =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "union"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , intersect =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "intersect"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        )
                    )
            }
    , diff =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        )
                    )
            }
    , merge =
        Elm.value
            { importFrom = [ "Dict" ]
            , name = "merge"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "comparable"
                            , Type.var "a"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.function
                            [ Type.var "comparable"
                            , Type.var "a"
                            , Type.var "b"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.function
                            [ Type.var "comparable"
                            , Type.var "b"
                            , Type.var "result"
                            ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "a" ]
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "b" ]
                        , Type.var "result"
                        ]
                        (Type.var "result")
                    )
            }
    }


