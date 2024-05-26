module Gen.Set exposing (annotation_, call_, diff, empty, filter, foldl, foldr, fromList, insert, intersect, isEmpty, map, member, moduleName_, partition, remove, singleton, size, toList, union, values_)

{-| 
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
singleton singletonArg =
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
        [ singletonArg ]


{-| Insert a value into a set.

insert: comparable -> Set.Set comparable -> Set.Set comparable
-}
insert : Elm.Expression -> Elm.Expression -> Elm.Expression
insert insertArg insertArg0 =
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
        [ insertArg, insertArg0 ]


{-| Remove a value from a set. If the value is not found, no changes are made.

remove: comparable -> Set.Set comparable -> Set.Set comparable
-}
remove : Elm.Expression -> Elm.Expression -> Elm.Expression
remove removeArg removeArg0 =
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
        [ removeArg, removeArg0 ]


{-| Determine if a set is empty.

isEmpty: Set.Set a -> Bool
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty isEmptyArg =
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
        [ isEmptyArg ]


{-| Determine if a value is in a set.

member: comparable -> Set.Set comparable -> Bool
-}
member : Elm.Expression -> Elm.Expression -> Elm.Expression
member memberArg memberArg0 =
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
        [ memberArg, memberArg0 ]


{-| Determine the number of elements in a set.

size: Set.Set a -> Int
-}
size : Elm.Expression -> Elm.Expression
size sizeArg =
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
        [ sizeArg ]


{-| Get the union of two sets. Keep all values.

union: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
union : Elm.Expression -> Elm.Expression -> Elm.Expression
union unionArg unionArg0 =
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
        [ unionArg, unionArg0 ]


{-| Get the intersection of two sets. Keeps values that appear in both sets.

intersect: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
intersect intersectArg intersectArg0 =
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
        [ intersectArg, intersectArg0 ]


{-| Get the difference between the first set and the second. Keeps values
that do not appear in the second set.

diff: Set.Set comparable -> Set.Set comparable -> Set.Set comparable
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression
diff diffArg diffArg0 =
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
        [ diffArg, diffArg0 ]


{-| Convert a set into a list, sorted from lowest to highest.

toList: Set.Set a -> List a
-}
toList : Elm.Expression -> Elm.Expression
toList toListArg =
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
        [ toListArg ]


{-| Convert a list into a set, removing any duplicates.

fromList: List comparable -> Set.Set comparable
-}
fromList : List Elm.Expression -> Elm.Expression
fromList fromListArg =
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
        [ Elm.list fromListArg ]


{-| Map a function onto a set, creating a new set with no duplicates.

map: (comparable -> comparable2) -> Set.Set comparable -> Set.Set comparable2
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
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
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| Fold over the values in a set, in order from lowest to highest.

foldl: (a -> b -> b) -> b -> Set.Set a -> b
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl foldlArg foldlArg0 foldlArg1 =
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
               Elm.functionReduced "unpack" (foldlArg functionReducedUnpack)
            )
        , foldlArg0
        , foldlArg1
        ]


{-| Fold over the values in a set, in order from highest to lowest.

foldr: (a -> b -> b) -> b -> Set.Set a -> b
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr foldrArg foldrArg0 foldrArg1 =
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
               Elm.functionReduced "unpack" (foldrArg functionReducedUnpack)
            )
        , foldrArg0
        , foldrArg1
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
filter filterArg filterArg0 =
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
        [ Elm.functionReduced "filterUnpack" filterArg, filterArg0 ]


{-| Create two new sets. The first contains all the elements that passed the
given test, and the second contains all the elements that did not.

partition: 
    (comparable -> Bool)
    -> Set.Set comparable
    -> ( Set.Set comparable, Set.Set comparable )
-}
partition :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
partition partitionArg partitionArg0 =
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
        [ Elm.functionReduced "partitionUnpack" partitionArg, partitionArg0 ]


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
        \singletonArg ->
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
                [ singletonArg ]
    , insert =
        \insertArg insertArg0 ->
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
                [ insertArg, insertArg0 ]
    , remove =
        \removeArg removeArg0 ->
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
                [ removeArg, removeArg0 ]
    , isEmpty =
        \isEmptyArg ->
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
                [ isEmptyArg ]
    , member =
        \memberArg memberArg0 ->
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
                [ memberArg, memberArg0 ]
    , size =
        \sizeArg ->
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
                [ sizeArg ]
    , union =
        \unionArg unionArg0 ->
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
                [ unionArg, unionArg0 ]
    , intersect =
        \intersectArg intersectArg0 ->
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
                [ intersectArg, intersectArg0 ]
    , diff =
        \diffArg diffArg0 ->
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
                [ diffArg, diffArg0 ]
    , toList =
        \toListArg ->
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
                [ toListArg ]
    , fromList =
        \fromListArg ->
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
                [ fromListArg ]
    , map =
        \mapArg mapArg0 ->
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
                [ mapArg, mapArg0 ]
    , foldl =
        \foldlArg foldlArg0 foldlArg1 ->
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
                [ foldlArg, foldlArg0, foldlArg1 ]
    , foldr =
        \foldrArg foldrArg0 foldrArg1 ->
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
                [ foldrArg, foldrArg0, foldrArg1 ]
    , filter =
        \filterArg filterArg0 ->
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
                [ filterArg, filterArg0 ]
    , partition =
        \partitionArg partitionArg0 ->
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
                [ partitionArg, partitionArg0 ]
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