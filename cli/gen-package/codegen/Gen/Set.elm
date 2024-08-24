module Gen.Set exposing
    ( annotation_
    , call_
    , diff
    , empty
    , filter
    , foldl
    , foldr
    , fromList
    , insert
    , intersect
    , isEmpty
    , map
    , member
    , moduleName_
    , partition
    , remove
    , singleton
    , size
    , toList
    , union
    , values_
    )

{-|
# Generated bindings for Set

@docs moduleName_, empty, singleton, insert, remove, isEmpty, member, size, union, intersect, diff, toList, fromList, map, foldl, foldr, filter, partition, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Set" ]


{-| Create an empty set.

empty: Set.Set a
-}
empty : Elm.Expression
empty =
    Elm.value
        { importFrom = [ "Set" ]
        , name = "empty"
        , annotation = Just (Type.namedWith [ "Set" ] "Set" [ Type.var "a" ])
        }


{-| Create a set with one value.

singleton: comparable -> Set.Set comparable
-}
singleton : Elm.Expression -> Elm.Expression
singleton singletonArg_ =
    Elm.apply
        (Elm.value
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
        [ singletonArg_ ]


{-| Insert a value into a set.

insert: comparable -> Set.Set comparable -> Set.Set comparable
-}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression
insert insertArg_ insertArg_0 =
    Elm.apply
        (Elm.value
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
        [ insertArg_, insertArg_0 ]


{-| Remove a value from a set. If the value is not found, no changes are made.

remove: comparable -> Set.Set comparable -> Set.Set comparable
-}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove removeArg_ removeArg_0 =
    Elm.apply
        (Elm.value
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
        [ removeArg_, removeArg_0 ]


{-| Determine if a set is empty.

isEmpty: Set.Set a -> Bool
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty isEmptyArg_ =
    Elm.apply
        (Elm.value
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
        [ isEmptyArg_ ]


{-| Determine if a value is in a set.

member: comparable -> Set.Set comparable -> Bool
-}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member memberArg_ memberArg_0 =
    Elm.apply
        (Elm.value
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
        [ memberArg_, memberArg_0 ]


{-| Determine the number of elements in a set.

size: Set.Set a -> Int
-}
size : Elm.Expression -> Elm.Expression
size sizeArg_ =
    Elm.apply
        (Elm.value
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
        [ sizeArg_ ]


{-| Get the union of two sets. Keep all values.

union: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
union : Elm.Expression -> Elm.Expression -> Elm.Expression
union unionArg_ unionArg_0 =
    Elm.apply
        (Elm.value
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
        [ unionArg_, unionArg_0 ]


{-| Get the intersection of two sets. Keeps values that appear in both sets.

intersect: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
intersect intersectArg_ intersectArg_0 =
    Elm.apply
        (Elm.value
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
        [ intersectArg_, intersectArg_0 ]


{-| Get the difference between the first set and the second. Keeps values
that do not appear in the second set.

diff: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression
diff diffArg_ diffArg_0 =
    Elm.apply
        (Elm.value
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
        [ diffArg_, diffArg_0 ]


{-| Convert a set into a list, sorted from lowest to highest.

toList: Set.Set a -> List a
-}
toList : Elm.Expression -> Elm.Expression
toList toListArg_ =
    Elm.apply
        (Elm.value
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
        [ toListArg_ ]


{-| Convert a list into a set, removing any duplicates.

fromList: List comparable -> Set.Set comparable
-}
fromList : List Elm.Expression -> Elm.Expression
fromList fromListArg_ =
    Elm.apply
        (Elm.value
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
        [ Elm.list fromListArg_ ]


{-| Map a function onto a set, creating a new set with no duplicates.

map: (comparable -> comparable2) -> Set.Set comparable -> Set.Set comparable2
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Fold over the values in a set, in order from lowest to highest.

foldl: (a -> b -> b) -> b -> Set.Set a -> b
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl foldlArg_ foldlArg_0 foldlArg_1 =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced
            "foldlUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (foldlArg_ functionReducedUnpack)
            )
        , foldlArg_0
        , foldlArg_1
        ]


{-| Fold over the values in a set, in order from highest to lowest.

foldr: (a -> b -> b) -> b -> Set.Set a -> b
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr foldrArg_ foldrArg_0 foldrArg_1 =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced
            "foldrUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (foldrArg_ functionReducedUnpack)
            )
        , foldrArg_0
        , foldrArg_1
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

filter: (comparable -> Bool) -> Set.Set comparable -> Set.Set comparable
-}
filter : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
filter filterArg_ filterArg_0 =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced "filterUnpack" filterArg_, filterArg_0 ]


{-| Create two new sets. The first contains all the elements that passed the
given test, and the second contains all the elements that did not.

partition: 
    (comparable -> Bool)
    -> Set.Set comparable
    -> ( Set.Set comparable, Set.Set comparable )
-}
partition :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
partition partitionArg_ partitionArg_0 =
    Elm.apply
        (Elm.value
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
        [ Elm.functionReduced "partitionUnpack" partitionArg_, partitionArg_0 ]


annotation_ : { set : Type.Annotation -> Type.Annotation }
annotation_ =
    { set = \setArg0 -> Type.namedWith [ "Set" ] "Set" [ setArg0 ] }


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
        \singletonArg_ ->
            Elm.apply
                (Elm.value
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
                [ singletonArg_ ]
    , insert =
        \insertArg_ insertArg_0 ->
            Elm.apply
                (Elm.value
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
                [ insertArg_, insertArg_0 ]
    , remove =
        \removeArg_ removeArg_0 ->
            Elm.apply
                (Elm.value
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
                [ removeArg_, removeArg_0 ]
    , isEmpty =
        \isEmptyArg_ ->
            Elm.apply
                (Elm.value
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
                [ isEmptyArg_ ]
    , member =
        \memberArg_ memberArg_0 ->
            Elm.apply
                (Elm.value
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
                [ memberArg_, memberArg_0 ]
    , size =
        \sizeArg_ ->
            Elm.apply
                (Elm.value
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
                [ sizeArg_ ]
    , union =
        \unionArg_ unionArg_0 ->
            Elm.apply
                (Elm.value
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
                [ unionArg_, unionArg_0 ]
    , intersect =
        \intersectArg_ intersectArg_0 ->
            Elm.apply
                (Elm.value
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
                [ intersectArg_, intersectArg_0 ]
    , diff =
        \diffArg_ diffArg_0 ->
            Elm.apply
                (Elm.value
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
                [ diffArg_, diffArg_0 ]
    , toList =
        \toListArg_ ->
            Elm.apply
                (Elm.value
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
                [ toListArg_ ]
    , fromList =
        \fromListArg_ ->
            Elm.apply
                (Elm.value
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
                [ fromListArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
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
                [ mapArg_, mapArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
            Elm.apply
                (Elm.value
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
                [ foldlArg_, foldlArg_0, foldlArg_1 ]
    , foldr =
        \foldrArg_ foldrArg_0 foldrArg_1 ->
            Elm.apply
                (Elm.value
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
                [ foldrArg_, foldrArg_0, foldrArg_1 ]
    , filter =
        \filterArg_ filterArg_0 ->
            Elm.apply
                (Elm.value
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
                [ filterArg_, filterArg_0 ]
    , partition =
        \partitionArg_ partitionArg_0 ->
            Elm.apply
                (Elm.value
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
                [ partitionArg_, partitionArg_0 ]
    }


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
        Elm.value
            { importFrom = [ "Set" ]
            , name = "empty"
            , annotation =
                Just (Type.namedWith [ "Set" ] "Set" [ Type.var "a" ])
            }
    , singleton =
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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