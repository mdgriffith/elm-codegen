module Gen.Dict exposing
    ( annotation_
    , call_
    , diff
    , empty
    , filter
    , foldl
    , foldr
    , fromList
    , get
    , insert
    , intersect
    , isEmpty
    , keys
    , map
    , member
    , merge
    , moduleName_
    , partition
    , remove
    , singleton
    , size
    , toList
    , union
    , update
    , values
    , values_
    )

{-|
# Generated bindings for Dict

@docs moduleName_, empty, singleton, insert, update, remove, isEmpty, member, get, size, keys, values, toList, fromList, map, foldl, foldr, filter, partition, union, intersect, diff, merge, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Dict" ]


{-| Create an empty dictionary.

empty: Dict.Dict k v
-}
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


{-| Create a dictionary with one key-value pair.

singleton: comparable -> v -> Dict.Dict comparable v
-}
singleton : Elm.Expression -> Elm.Expression -> Elm.Expression
singleton singletonArg_ singletonArg_0 =
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
        [ singletonArg_, singletonArg_0 ]


{-| Insert a key-value pair into a dictionary. Replaces value when there is
a collision.

insert: comparable -> v -> Dict.Dict comparable v -> Dict.Dict comparable v
-}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
insert insertArg_ insertArg_0 insertArg_1 =
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
        [ insertArg_, insertArg_0, insertArg_1 ]


{-| Update the value of a dictionary for a specific key with a given function.

update: 
    comparable
    -> (Maybe v -> Maybe v)
    -> Dict.Dict comparable v
    -> Dict.Dict comparable v
-}
update :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
update updateArg_ updateArg_0 updateArg_1 =
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
        [ updateArg_
        , Elm.functionReduced "updateUnpack" updateArg_0
        , updateArg_1
        ]


{-| Remove a key-value pair from a dictionary. If the key is not found,
no changes are made.

remove: comparable -> Dict.Dict comparable v -> Dict.Dict comparable v
-}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove removeArg_ removeArg_0 =
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
        [ removeArg_, removeArg_0 ]


{-| Determine if a dictionary is empty.

    isEmpty empty == True

isEmpty: Dict.Dict k v -> Bool
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty isEmptyArg_ =
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
        [ isEmptyArg_ ]


{-| Determine if a key is in a dictionary.

member: comparable -> Dict.Dict comparable v -> Bool
-}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member memberArg_ memberArg_0 =
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
        [ memberArg_, memberArg_0 ]


{-| Get the value associated with a key. If the key is not found, return
`Nothing`. This is useful when you are not sure if a key will be in the
dictionary.

    animals = fromList [ ("Tom", Cat), ("Jerry", Mouse) ]

    get "Tom"   animals == Just Cat
    get "Jerry" animals == Just Mouse
    get "Spike" animals == Nothing

get: comparable -> Dict.Dict comparable v -> Maybe v
-}
get : Elm.Expression -> Elm.Expression -> Elm.Expression
get getArg_ getArg_0 =
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
        [ getArg_, getArg_0 ]


{-| Determine the number of key-value pairs in the dictionary.

size: Dict.Dict k v -> Int
-}
size : Elm.Expression -> Elm.Expression
size sizeArg_ =
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
        [ sizeArg_ ]


{-| Get all of the keys in a dictionary, sorted from lowest to highest.

    keys (fromList [(0,"Alice"),(1,"Bob")]) == [0,1]

keys: Dict.Dict k v -> List k
-}
keys : Elm.Expression -> Elm.Expression
keys keysArg_ =
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
        [ keysArg_ ]


{-| Get all of the values in a dictionary, in the order of their keys.

    values (fromList [(0,"Alice"),(1,"Bob")]) == ["Alice", "Bob"]

values: Dict.Dict k v -> List v
-}
values : Elm.Expression -> Elm.Expression
values valuesArg_ =
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
        [ valuesArg_ ]


{-| Convert a dictionary into an association list of key-value pairs, sorted by keys.

toList: Dict.Dict k v -> List ( k, v )
-}
toList : Elm.Expression -> Elm.Expression
toList toListArg_ =
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
        [ toListArg_ ]


{-| Convert an association list into a dictionary.

fromList: List ( comparable, v ) -> Dict.Dict comparable v
-}
fromList : List Elm.Expression -> Elm.Expression
fromList fromListArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Dict" ]
             , name = "fromList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.tuple (Type.var "comparable") (Type.var "v")
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
        [ Elm.list fromListArg_ ]


{-| Apply a function to all values in a dictionary.

map: (k -> a -> b) -> Dict.Dict k a -> Dict.Dict k b
-}
map :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
map mapArg_ mapArg_0 =
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
        [ Elm.functionReduced
            "mapUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (mapArg_ functionReducedUnpack)
            )
        , mapArg_0
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

foldl: (k -> v -> b -> b) -> b -> Dict.Dict k v -> b
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl foldlArg_ foldlArg_0 foldlArg_1 =
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
        [ Elm.functionReduced
            "foldlUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((foldlArg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , foldlArg_0
        , foldlArg_1
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

foldr: (k -> v -> b -> b) -> b -> Dict.Dict k v -> b
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr foldrArg_ foldrArg_0 foldrArg_1 =
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
        [ Elm.functionReduced
            "foldrUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((foldrArg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , foldrArg_0
        , foldrArg_1
        ]


{-| Keep only the key-value pairs that pass the given test.

filter: (comparable -> v -> Bool) -> Dict.Dict comparable v -> Dict.Dict comparable v
-}
filter :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
filter filterArg_ filterArg_0 =
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
        [ Elm.functionReduced
            "filterUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (filterArg_ functionReducedUnpack)
            )
        , filterArg_0
        ]


{-| Partition a dictionary according to some test. The first dictionary
contains all key-value pairs which passed the test, and the second contains
the pairs that did not.

partition: 
    (comparable -> v -> Bool)
    -> Dict.Dict comparable v
    -> ( Dict.Dict comparable v, Dict.Dict comparable v )
-}
partition :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
partition partitionArg_ partitionArg_0 =
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
        [ Elm.functionReduced
            "partitionUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (partitionArg_ functionReducedUnpack)
            )
        , partitionArg_0
        ]


{-| Combine two dictionaries. If there is a collision, preference is given
to the first dictionary.

union: Dict.Dict comparable v -> Dict.Dict comparable v -> Dict.Dict comparable v
-}
union : Elm.Expression -> Elm.Expression -> Elm.Expression
union unionArg_ unionArg_0 =
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
        [ unionArg_, unionArg_0 ]


{-| Keep a key-value pair when its key appears in the second dictionary.
Preference is given to values in the first dictionary.

intersect: Dict.Dict comparable v -> Dict.Dict comparable v -> Dict.Dict comparable v
-}
intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
intersect intersectArg_ intersectArg_0 =
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
        [ intersectArg_, intersectArg_0 ]


{-| Keep a key-value pair when its key does not appear in the second dictionary.

diff: Dict.Dict comparable a -> Dict.Dict comparable b -> Dict.Dict comparable a
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression
diff diffArg_ diffArg_0 =
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
        [ diffArg_, diffArg_0 ]


{-| The most general way of combining two dictionaries. You provide three
accumulators for when a given key appears:

  1. Only in the left dictionary.
  2. In both dictionaries.
  3. Only in the right dictionary.

You then traverse all the keys from lowest to highest, building up whatever
you want.

merge: 
    (comparable -> a -> result -> result)
    -> (comparable -> a -> b -> result -> result)
    -> (comparable -> b -> result -> result)
    -> Dict.Dict comparable a
    -> Dict.Dict comparable b
    -> result
    -> result
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
merge mergeArg_ mergeArg_0 mergeArg_1 mergeArg_2 mergeArg_3 mergeArg_4 =
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
        [ Elm.functionReduced
            "mergeUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((mergeArg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , Elm.functionReduced
            "mergeUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_1_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((mergeArg_0 functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_1_2_0_0
                                     )
                            )
                   )
            )
        , Elm.functionReduced
            "mergeUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((mergeArg_1 functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , mergeArg_2
        , mergeArg_3
        , mergeArg_4
        ]


annotation_ : { dict : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { dict =
        \dictArg0 dictArg1 ->
            Type.namedWith [ "Dict" ] "Dict" [ dictArg0, dictArg1 ]
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
        \singletonArg_ singletonArg_0 ->
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
                [ singletonArg_, singletonArg_0 ]
    , insert =
        \insertArg_ insertArg_0 insertArg_1 ->
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
                [ insertArg_, insertArg_0, insertArg_1 ]
    , update =
        \updateArg_ updateArg_0 updateArg_1 ->
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
                [ updateArg_, updateArg_0, updateArg_1 ]
    , remove =
        \removeArg_ removeArg_0 ->
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
                [ removeArg_, removeArg_0 ]
    , isEmpty =
        \isEmptyArg_ ->
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
                [ isEmptyArg_ ]
    , member =
        \memberArg_ memberArg_0 ->
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
                [ memberArg_, memberArg_0 ]
    , get =
        \getArg_ getArg_0 ->
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
                [ getArg_, getArg_0 ]
    , size =
        \sizeArg_ ->
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
                [ sizeArg_ ]
    , keys =
        \keysArg_ ->
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
                [ keysArg_ ]
    , values =
        \valuesArg_ ->
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
                [ valuesArg_ ]
    , toList =
        \toListArg_ ->
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
                                       (Type.tuple (Type.var "k") (Type.var "v")
                                       )
                                  )
                             )
                     }
                )
                [ toListArg_ ]
    , fromList =
        \fromListArg_ ->
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
                [ fromListArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
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
                [ mapArg_, mapArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Dict" ]
                     , name = "foldl"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "k"
                                      , Type.var "v"
                                      , Type.var "b"
                                      ]
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
                [ foldlArg_, foldlArg_0, foldlArg_1 ]
    , foldr =
        \foldrArg_ foldrArg_0 foldrArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Dict" ]
                     , name = "foldr"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "k"
                                      , Type.var "v"
                                      , Type.var "b"
                                      ]
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
                [ foldrArg_, foldrArg_0, foldrArg_1 ]
    , filter =
        \filterArg_ filterArg_0 ->
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
                [ filterArg_, filterArg_0 ]
    , partition =
        \partitionArg_ partitionArg_0 ->
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
                                            [ Type.var "comparable"
                                            , Type.var "v"
                                            ]
                                       )
                                       (Type.namedWith
                                            [ "Dict" ]
                                            "Dict"
                                            [ Type.var "comparable"
                                            , Type.var "v"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ partitionArg_, partitionArg_0 ]
    , union =
        \unionArg_ unionArg_0 ->
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
                [ unionArg_, unionArg_0 ]
    , intersect =
        \intersectArg_ intersectArg_0 ->
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
                [ intersectArg_, intersectArg_0 ]
    , diff =
        \diffArg_ diffArg_0 ->
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
                [ diffArg_, diffArg_0 ]
    , merge =
        \mergeArg_ mergeArg_0 mergeArg_1 mergeArg_2 mergeArg_3 mergeArg_4 ->
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
                [ mergeArg_
                , mergeArg_0
                , mergeArg_1
                , mergeArg_2
                , mergeArg_3
                , mergeArg_4
                ]
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