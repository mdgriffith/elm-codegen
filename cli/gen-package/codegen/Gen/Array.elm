module Gen.Array exposing (annotation_, append, call_, empty, filter, foldl, foldr, fromList, get, indexedMap, initialize, isEmpty, length, map, moduleName_, push, repeat, set, slice, toIndexedList, toList, values_)

{-| 
@docs moduleName_, empty, initialize, repeat, fromList, isEmpty, length, get, set, push, append, slice, toList, toIndexedList, map, indexedMap, foldl, foldr, filter, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Array" ]


{-| Return an empty array.

    length empty == 0

empty: Array.Array a
-}
empty : Elm.Expression
empty =
    Elm.value
        { importFrom = [ "Array" ]
        , name = "empty"
        , annotation =
            Just (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
        }


{-| Initialize an array. `initialize n f` creates an array of length `n` with
the element at index `i` initialized to the result of `(f i)`.

    initialize 4 identity    == fromList [0,1,2,3]
    initialize 4 (\n -> n*n) == fromList [0,1,4,9]
    initialize 4 (always 0)  == fromList [0,0,0,0]

initialize: Int -> (Int -> a) -> Array.Array a
-}
initialize : Int -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
initialize initializeArg initializeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "initialize"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.function [ Type.int ] (Type.var "a")
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.int initializeArg
        , Elm.functionReduced "initializeUnpack" initializeArg0
        ]


{-| Creates an array with a given length, filled with a default element.

    repeat 5 0     == fromList [0,0,0,0,0]
    repeat 3 "cat" == fromList ["cat","cat","cat"]

Notice that `repeat 3 x` is the same as `initialize 3 (always x)`.

repeat: Int -> a -> Array.Array a
-}
repeat : Int -> Elm.Expression -> Elm.Expression
repeat repeatArg repeatArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "repeat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int, Type.var "a" ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.int repeatArg, repeatArg0 ]


{-| Create an array from a `List`.

fromList: List a -> Array.Array a
-}
fromList : List Elm.Expression -> Elm.Expression
fromList fromListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "fromList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.var "a") ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.list fromListArg ]


{-| Determine if an array is empty.

    isEmpty empty == True

isEmpty: Array.Array a -> Bool
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty isEmptyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "isEmpty"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          Type.bool
                     )
             }
        )
        [ isEmptyArg ]


{-| Return the length of an array.

    length (fromList [1,2,3]) == 3

length: Array.Array a -> Int
-}
length : Elm.Expression -> Elm.Expression
length lengthArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "length"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          Type.int
                     )
             }
        )
        [ lengthArg ]


{-| Return `Just` the element at the index or `Nothing` if the index is out of
range.

    get  0 (fromList [0,1,2]) == Just 0
    get  2 (fromList [0,1,2]) == Just 2
    get  5 (fromList [0,1,2]) == Nothing
    get -1 (fromList [0,1,2]) == Nothing

get: Int -> Array.Array a -> Maybe a
-}
get : Int -> Elm.Expression -> Elm.Expression
get getArg getArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "get"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.maybe (Type.var "a"))
                     )
             }
        )
        [ Elm.int getArg, getArg0 ]


{-| Set the element at a particular index. Returns an updated array.
If the index is out of range, the array is unaltered.

    set 1 7 (fromList [1,2,3]) == fromList [1,7,3]

set: Int -> a -> Array.Array a -> Array.Array a
-}
set : Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
set setArg setArg0 setArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "set"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.var "a"
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.int setArg, setArg0, setArg1 ]


{-| Push an element onto the end of an array.

    push 3 (fromList [1,2]) == fromList [1,2,3]

push: a -> Array.Array a -> Array.Array a
-}
push : Elm.Expression -> Elm.Expression -> Elm.Expression
push pushArg pushArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "push"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a"
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ pushArg, pushArg0 ]


{-| Append two arrays to a new one.

    append (repeat 2 42) (repeat 3 81) == fromList [42,42,81,81,81]

append: Array.Array a -> Array.Array a -> Array.Array a
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append appendArg appendArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "append"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ appendArg, appendArg0 ]


{-| Get a sub-section of an array: `(slice start end array)`. The `start` is a
zero-based index where we will start our slice. The `end` is a zero-based index
that indicates the end of the slice. The slice extracts up to but not including
`end`.

    slice  0  3 (fromList [0,1,2,3,4]) == fromList [0,1,2]
    slice  1  4 (fromList [0,1,2,3,4]) == fromList [1,2,3]

Both the `start` and `end` indexes can be negative, indicating an offset from
the end of the array.

    slice  1 -1 (fromList [0,1,2,3,4]) == fromList [1,2,3]
    slice -2  5 (fromList [0,1,2,3,4]) == fromList [3,4]

This makes it pretty easy to `pop` the last element off of an array:
`slice 0 -1 array`

slice: Int -> Int -> Array.Array a -> Array.Array a
-}
slice : Int -> Int -> Elm.Expression -> Elm.Expression
slice sliceArg sliceArg0 sliceArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "slice"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.int
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.int sliceArg, Elm.int sliceArg0, sliceArg1 ]


{-| Create a list of elements from an array.

    toList (fromList [3,5,8]) == [3,5,8]

toList: Array.Array a -> List a
-}
toList : Elm.Expression -> Elm.Expression
toList toListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "toList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.list (Type.var "a"))
                     )
             }
        )
        [ toListArg ]


{-| Create an indexed list from an array. Each element of the array will be
paired with its index.

    toIndexedList (fromList ["cat","dog"]) == [(0,"cat"), (1,"dog")]

toIndexedList: Array.Array a -> List ( Int, a )
-}
toIndexedList : Elm.Expression -> Elm.Expression
toIndexedList toIndexedListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "toIndexedList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.list (Type.tuple Type.int (Type.var "a")))
                     )
             }
        )
        [ toIndexedListArg ]


{-| Apply a function on every element in an array.

    map sqrt (fromList [1,4,9]) == fromList [1,2,3]

map: (a -> b) -> Array.Array a -> Array.Array b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "b" ])
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| Apply a function on every element with its index as first argument.

    indexedMap (*) (fromList [5,5,5]) == fromList [0,5,10]

indexedMap: (Int -> a -> b) -> Array.Array a -> Array.Array b
-}
indexedMap :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
indexedMap indexedMapArg indexedMapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "indexedMap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.int, Type.var "a" ]
                              (Type.var "b")
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "b" ])
                     )
             }
        )
        [ Elm.functionReduced
            "indexedMapUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (indexedMapArg functionReducedUnpack)
            )
        , indexedMapArg0
        ]


{-| Reduce an array from the left. Read `foldl` as fold from the left.

    foldl (::) [] (fromList [1,2,3]) == [3,2,1]

foldl: (a -> b -> b) -> b -> Array.Array a -> b
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl foldlArg foldlArg0 foldlArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "foldl"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "b")
                          , Type.var "b"
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
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


{-| Reduce an array from the right. Read `foldr` as fold from the right.

    foldr (+) 0 (repeat 3 5) == 15

foldr: (a -> b -> b) -> b -> Array.Array a -> b
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr foldrArg foldrArg0 foldrArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "foldr"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "b")
                          , Type.var "b"
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
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


{-| Keep elements that pass the test.

    filter isEven (fromList [1,2,3,4,5,6]) == (fromList [2,4,6])

filter: (a -> Bool) -> Array.Array a -> Array.Array a
-}
filter : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
filter filterArg filterArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Array" ]
             , name = "filter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] Type.bool
                          , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                          ]
                          (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.functionReduced "filterUnpack" filterArg, filterArg0 ]


annotation_ : { array : Type.Annotation -> Type.Annotation }
annotation_ =
    { array = \arrayArg0 -> Type.namedWith [ "Array" ] "Array" [ arrayArg0 ] }


call_ :
    { initialize : Elm.Expression -> Elm.Expression -> Elm.Expression
    , repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , length : Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , set : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , push : Elm.Expression -> Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , slice :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , toIndexedList : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indexedMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { initialize =
        \initializeArg initializeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "initialize"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.function [ Type.int ] (Type.var "a")
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ initializeArg, initializeArg0 ]
    , repeat =
        \repeatArg repeatArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "repeat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.var "a" ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ repeatArg, repeatArg0 ]
    , fromList =
        \fromListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "fromList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list (Type.var "a") ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ fromListArg ]
    , isEmpty =
        \isEmptyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "isEmpty"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ isEmptyArg ]
    , length =
        \lengthArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "length"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  Type.int
                             )
                     }
                )
                [ lengthArg ]
    , get =
        \getArg getArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "get"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.maybe (Type.var "a"))
                             )
                     }
                )
                [ getArg, getArg0 ]
    , set =
        \setArg setArg0 setArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "set"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.var "a"
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ setArg, setArg0, setArg1 ]
    , push =
        \pushArg pushArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "push"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a"
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ pushArg, pushArg0 ]
    , append =
        \appendArg appendArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "append"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ appendArg, appendArg0 ]
    , slice =
        \sliceArg sliceArg0 sliceArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "slice"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.int
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ sliceArg, sliceArg0, sliceArg1 ]
    , toList =
        \toListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "toList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.list (Type.var "a"))
                             )
                     }
                )
                [ toListArg ]
    , toIndexedList =
        \toIndexedListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "toIndexedList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.list
                                       (Type.tuple Type.int (Type.var "a"))
                                  )
                             )
                     }
                )
                [ toIndexedListArg ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    , indexedMap =
        \indexedMapArg indexedMapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "indexedMap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.int, Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ indexedMapArg, indexedMapArg0 ]
    , foldl =
        \foldlArg foldlArg0 foldlArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Array" ]
                     , name = "foldl"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "b")
                                  , Type.var "b"
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
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
                     { importFrom = [ "Array" ]
                     , name = "foldr"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "b")
                                  , Type.var "b"
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
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
                     { importFrom = [ "Array" ]
                     , name = "filter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function [ Type.var "a" ] Type.bool
                                  , Type.namedWith
                                      [ "Array" ]
                                      "Array"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Array" ]
                                       "Array"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ filterArg, filterArg0 ]
    }


values_ :
    { empty : Elm.Expression
    , initialize : Elm.Expression
    , repeat : Elm.Expression
    , fromList : Elm.Expression
    , isEmpty : Elm.Expression
    , length : Elm.Expression
    , get : Elm.Expression
    , set : Elm.Expression
    , push : Elm.Expression
    , append : Elm.Expression
    , slice : Elm.Expression
    , toList : Elm.Expression
    , toIndexedList : Elm.Expression
    , map : Elm.Expression
    , indexedMap : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , filter : Elm.Expression
    }
values_ =
    { empty =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "empty"
            , annotation =
                Just (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
            }
    , initialize =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "initialize"
            , annotation =
                Just
                    (Type.function
                         [ Type.int, Type.function [ Type.int ] (Type.var "a") ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , repeat =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "repeat"
            , annotation =
                Just
                    (Type.function
                         [ Type.int, Type.var "a" ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , fromList =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "fromList"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.var "a") ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , isEmpty =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "isEmpty"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ] ]
                         Type.bool
                    )
            }
    , length =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "length"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ] ]
                         Type.int
                    )
            }
    , get =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.maybe (Type.var "a"))
                    )
            }
    , set =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "set"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.var "a"
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , push =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "push"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a"
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , slice =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "slice"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.int
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    , toList =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ] ]
                         (Type.list (Type.var "a"))
                    )
            }
    , toIndexedList =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "toIndexedList"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Array" ] "Array" [ Type.var "a" ] ]
                         (Type.list (Type.tuple Type.int (Type.var "a")))
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "b" ])
                    )
            }
    , indexedMap =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "indexedMap"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.int, Type.var "a" ]
                             (Type.var "b")
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "b" ])
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "b")
                         , Type.var "b"
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "b")
                         , Type.var "b"
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.var "b")
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "Array" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] Type.bool
                         , Type.namedWith [ "Array" ] "Array" [ Type.var "a" ]
                         ]
                         (Type.namedWith [ "Array" ] "Array" [ Type.var "a" ])
                    )
            }
    }