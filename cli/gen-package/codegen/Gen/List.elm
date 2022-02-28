module Gen.List exposing (all, any, append, call_, concat, concatMap, drop, filter, filterMap, foldl, foldr, head, indexedMap, intersperse, isEmpty, length, map, map2, map3, map4, map5, maximum, member, minimum, moduleName_, partition, product, range, repeat, reverse, singleton, sort, sortBy, sortWith, sum, tail, take, unzip, values_)

{-| 
@docs moduleName_, singleton, repeat, range, map, indexedMap, foldl, foldr, filter, filterMap, length, reverse, member, all, any, maximum, minimum, sum, product, append, concat, concatMap, intersperse, map2, map3, map4, map5, sort, sortBy, sortWith, isEmpty, head, tail, take, drop, partition, unzip, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "List" ]


{-| Create a list with only one element:

    singleton 1234 == [1234]
    singleton "hi" == ["hi"]
-}
singleton : Elm.Expression -> Elm.Expression
singleton arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "singleton"
            , annotation =
                Just (Type.function [ Type.var "a" ] (Type.list (Type.var "a")))
            }
        )
        [ arg1 ]


{-| Create a list with *n* copies of a value:

    repeat 3 (0,0) == [(0,0),(0,0),(0,0)]
-}
repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
repeat arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "repeat"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.var "a" ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Create a list of numbers, every element increasing by one.
You give the lowest and highest number that should be in the list.

    range 3 6 == [3, 4, 5, 6]
    range 3 3 == [3]
    range 6 3 == []
-}
range : Elm.Expression -> Elm.Expression -> Elm.Expression
range arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "range"
            , annotation =
                Just (Type.function [ Type.int, Type.int ] (Type.list Type.int))
            }
        )
        [ arg1, arg2_1 ]


{-| Apply a function to every element of a list.

    map sqrt [1,4,9] == [1,2,3]

    map not [True,False,True] == [False,True,False]

So `map func [ a, b, c ]` is the same as `[ func a, func b, func c ]`
-}
map :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
map arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Same as `map` but the function is also applied to the index of each
element (starting at zero).

    indexedMap Tuple.pair ["Tom","Sue","Bob"] == [ (0,"Tom"), (1,"Sue"), (2,"Bob") ]
-}
indexedMap :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> List Elm.Expression
    -> Elm.Expression
indexedMap arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "indexedMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.int, Type.var "a" ]
                            (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
        , Elm.list arg2_1
        ]


{-| Reduce a list from the left.

    foldl (+)  0  [1,2,3] == 6
    foldl (::) [] [1,2,3] == [3,2,1]

So `foldl step state [1,2,3]` is like saying:

    state
      |> step 1
      |> step 2
      |> step 3
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
foldl arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
        , arg2_1
        , Elm.list arg3_2
        ]


{-| Reduce a list from the right.

    foldr (+)  0  [1,2,3] == 6
    foldr (::) [] [1,2,3] == [1,2,3]

So `foldr step state [1,2,3]` is like saying:

    state
      |> step 3
      |> step 2
      |> step 1
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
foldr arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
        , arg2_1
        , Elm.list arg3_2
        ]


{-| Keep elements that satisfy the test.

    filter isEven [1,2,3,4,5,6] == [2,4,6]
-}
filter :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
filter arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Filter out certain values. For example, maybe you have a bunch of strings
from an untrusted source and you want to turn them into numbers:

    numbers : List Int
    numbers =
      filterMap String.toInt ["3", "hi", "12", "4th", "May"]

    -- numbers == [3, 12]

-}
filterMap :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
filterMap arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "filterMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Determine the length of a list.

    length [1,2,3] == 3
-}
length : List Elm.Expression -> Elm.Expression
length arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "length"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.int)
            }
        )
        [ Elm.list arg1 ]


{-| Reverse a list.

    reverse [1,2,3,4] == [4,3,2,1]
-}
reverse : List Elm.Expression -> Elm.Expression
reverse arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "reverse"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Figure out whether a list contains a value.

    member 9 [1,2,3,4] == False
    member 4 [1,2,3,4] == True
-}
member : Elm.Expression -> List Elm.Expression -> Elm.Expression
member arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        Type.bool
                    )
            }
        )
        [ arg1, Elm.list arg2_1 ]


{-| Determine if all elements satisfy some test.

    all isEven [2,4] == True
    all isEven [2,3] == False
    all isEven [] == True
-}
all :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
all arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Determine if any elements satisfy some test.

    any isEven [2,3] == True
    any isEven [1,3] == False
    any isEven [] == False
-}
any :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
any arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Find the maximum element in a non-empty list.

    maximum [1,4,2] == Just 4
    maximum []      == Nothing
-}
maximum : List Elm.Expression -> Elm.Expression
maximum arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "maximum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Find the minimum element in a non-empty list.

    minimum [3,2,1] == Just 1
    minimum []      == Nothing
-}
minimum : List Elm.Expression -> Elm.Expression
minimum arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "minimum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Get the sum of the list elements.

    sum [1,2,3] == 6
    sum [1,1,1] == 3
    sum []      == 0

-}
sum : List Elm.Expression -> Elm.Expression
sum arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "sum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Get the product of the list elements.

    product [2,2,2] == 8
    product [3,3,3] == 27
    product []      == 1

-}
product : List Elm.Expression -> Elm.Expression
product arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "product"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Put two lists together.

    append [1,1,2] [3,5,8] == [1,1,2,3,5,8]
    append ['a','b'] ['c'] == ['a','b','c']

You can also use [the `(++)` operator](Basics#++) to append lists.
-}
append : List Elm.Expression -> List Elm.Expression -> Elm.Expression
append arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a"), Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.list arg1, Elm.list arg2_1 ]


{-| Concatenate a bunch of lists into a single list:

    concat [[1,2],[3],[4,5]] == [1,2,3,4,5]
-}
concat : List (List Elm.Expression) -> Elm.Expression
concat arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "concat"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.list (Type.var "a")) ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.list (List.map (\lambdaArg0 -> Elm.list lambdaArg0_4_3_0) arg1) ]


{-| Map a given function onto a list and flatten the resulting lists.

    concatMap f xs == concat (map f xs)
-}
concatMap :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
concatMap arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "concatMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.list (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Places the given value between all members of the given list.

    intersperse "on" ["turtles","turtles","turtles"] == ["turtles","on","turtles","on","turtles"]
-}
intersperse : Elm.Expression -> List Elm.Expression -> Elm.Expression
intersperse arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "intersperse"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ arg1, Elm.list arg2_1 ]


{-| Combine two lists, combining them with the given function.
If one list is longer, the extra elements are dropped.

    totals : List Int -> List Int -> List Int
    totals xs ys =
      List.map2 (+) xs ys

    -- totals [1,2,3] [4,5,6] == [5,7,9]

    pairs : List a -> List b -> List (a,b)
    pairs xs ys =
      List.map2 Tuple.pair xs ys

    -- pairs ["alice","bob","chuck"] [2,5,7,8]
    --   == [("alice",2),("bob",5),("chuck",7)]

-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> List Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
map2 arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
        , Elm.list arg2_1
        , Elm.list arg3_2
        ]


{-|-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
map3 arg1 arg2_1 arg3_2 arg4_3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                arg1 fn0_3_3_0 fn0_3_3_3_0 fn0_3_3_3_3_0
                            )
                    )
            )
        , Elm.list arg2_1
        , Elm.list arg3_2
        , Elm.list arg4_3
        ]


{-|-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
map4 arg1 arg2_1 arg3_2 arg4_3 arg5_4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                Elm.fn
                                    "unpack3"
                                    (\fn0_3_3_3_3_3_0 ->
                                        arg1 fn0_3_3_0 fn0_3_3_3_0 fn0_3_3_3_3_0
                                            fn0_3_3_3_3_3_0
                                    )
                            )
                    )
            )
        , Elm.list arg2_1
        , Elm.list arg3_2
        , Elm.list arg4_3
        , Elm.list arg5_4
        ]


{-|-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
map5 arg1 arg2_1 arg3_2 arg4_3 arg5_4 arg6_5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        , Type.list (Type.var "e")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn
                    "unpack1"
                    (\fn0_3_3_3_0 ->
                        Elm.fn
                            "unpack2"
                            (\fn0_3_3_3_3_0 ->
                                Elm.fn
                                    "unpack3"
                                    (\fn0_3_3_3_3_3_0 ->
                                        Elm.fn
                                            "unpack4"
                                            (\fn0_3_3_3_3_3_3_0 ->
                                                arg1 fn0_3_3_0 fn0_3_3_3_0
                                                    fn0_3_3_3_3_0
                                                    fn0_3_3_3_3_3_0
                                                    fn0_3_3_3_3_3_3_0
                                            )
                                    )
                            )
                    )
            )
        , Elm.list arg2_1
        , Elm.list arg3_2
        , Elm.list arg4_3
        , Elm.list arg5_4
        , Elm.list arg6_5
        ]


{-| Sort values from lowest to highest

    sort [3,1,5] == [1,3,5]
-}
sort : List Elm.Expression -> Elm.Expression
sort arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "sort"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.list (Type.var "comparable"))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Sort values by a derived property.

    alice = { name="Alice", height=1.62 }
    bob   = { name="Bob"  , height=1.85 }
    chuck = { name="Chuck", height=1.76 }

    sortBy .name   [chuck,alice,bob] == [alice,bob,chuck]
    sortBy .height [chuck,alice,bob] == [alice,chuck,bob]

    sortBy String.length ["mouse","cat"] == ["cat","mouse"]
-}
sortBy :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
sortBy arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "sortBy"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "comparable")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Sort values with a custom comparison function.

    sortWith flippedComparison [1,2,3,4,5] == [5,4,3,2,1]

    flippedComparison a b =
        case compare a b of
          LT -> GT
          EQ -> EQ
          GT -> LT

This is also the most general sort function, allowing you
to define any other: `sort == sortWith compare`
-}
sortWith :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> List Elm.Expression
    -> Elm.Expression
sortWith arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "sortWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "a" ]
                            (Type.namedWith [ "Basics" ] "Order" [])
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ Elm.fn
            "unpack0"
            (\fn0_3_3_0 ->
                Elm.fn "unpack1" (\fn0_3_3_3_0 -> arg1 fn0_3_3_0 fn0_3_3_3_0)
            )
        , Elm.list arg2_1
        ]


{-| Determine if a list is empty.

    isEmpty [] == True

**Note:** It is usually preferable to use a `case` to test this so you do not
forget to handle the `(x :: xs)` case as well!
-}
isEmpty : List Elm.Expression -> Elm.Expression
isEmpty arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "isEmpty"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.bool)
            }
        )
        [ Elm.list arg1 ]


{-| Extract the first element of a list.

    head [1,2,3] == Just 1
    head [] == Nothing

**Note:** It is usually preferable to use a `case` to deconstruct a `List`
because it gives you `(x :: xs)` and you can work with both subparts.
-}
head : List Elm.Expression -> Elm.Expression
head arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "head"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.var "a"))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Extract the rest of the list.

    tail [1,2,3] == Just [2,3]
    tail [] == Nothing

**Note:** It is usually preferable to use a `case` to deconstruct a `List`
because it gives you `(x :: xs)` and you can work with both subparts.
-}
tail : List Elm.Expression -> Elm.Expression
tail arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "tail"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.list (Type.var "a")))
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Take the first *n* members of a list.

    take 2 [1,2,3,4] == [1,2]
-}
take : Elm.Expression -> List Elm.Expression -> Elm.Expression
take arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "take"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ arg1, Elm.list arg2_1 ]


{-| Drop the first *n* members of a list.

    drop 2 [1,2,3,4] == [3,4]
-}
drop : Elm.Expression -> List Elm.Expression -> Elm.Expression
drop arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "drop"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
        )
        [ arg1, Elm.list arg2_1 ]


{-| Partition a list based on some test. The first list contains all values
that satisfy the test, and the second list contains all the value that do not.

    partition (\x -> x < 3) [0,1,2,3,4,5] == ([0,1,2], [3,4,5])
    partition isEven        [0,1,2,3,4,5] == ([0,2,4], [1,3,5])
-}
partition :
    (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
partition arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "a"))
                        )
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), Elm.list arg2_1 ]


{-| Decompose a list of tuples into a tuple of lists.

    unzip [(0, True), (17, False), (1337, True)] == ([0,17,1337], [True,False,True])
-}
unzip : List Elm.Expression -> Elm.Expression
unzip arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "unzip"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.tuple (Type.var "a") (Type.var "b")) ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "b"))
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


call_ :
    { singleton : Elm.Expression -> Elm.Expression
    , repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
    , range : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indexedMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , filterMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , length : Elm.Expression -> Elm.Expression
    , reverse : Elm.Expression -> Elm.Expression
    , member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , all : Elm.Expression -> Elm.Expression -> Elm.Expression
    , any : Elm.Expression -> Elm.Expression -> Elm.Expression
    , maximum : Elm.Expression -> Elm.Expression
    , minimum : Elm.Expression -> Elm.Expression
    , sum : Elm.Expression -> Elm.Expression
    , product : Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , concat : Elm.Expression -> Elm.Expression
    , concatMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intersperse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , sort : Elm.Expression -> Elm.Expression
    , sortBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sortWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , tail : Elm.Expression -> Elm.Expression
    , take : Elm.Expression -> Elm.Expression -> Elm.Expression
    , drop : Elm.Expression -> Elm.Expression -> Elm.Expression
    , partition : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unzip : Elm.Expression -> Elm.Expression
    }
call_ =
    { singleton =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "singleton"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_0 ]
    , repeat =
        \arg1_1_0 arg2_2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "repeat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.var "a" ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_1_0, arg2_2_0 ]
    , range =
        \arg1_2_0 arg2_3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "range"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.int ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ arg1_2_0, arg2_3_0 ]
    , map =
        \arg1_3_0 arg2_4_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "b")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ arg1_3_0, arg2_4_0 ]
    , indexedMap =
        \arg1_4_0 arg2_5_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "indexedMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.int, Type.var "a" ]
                                    (Type.var "b")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ arg1_4_0, arg2_5_0 ]
    , foldl =
        \arg1_5_0 arg2_6_0 arg3_7_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.list (Type.var "a")
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_5_0, arg2_6_0, arg3_7_0 ]
    , foldr =
        \arg1_6_0 arg2_7_0 arg3_8_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.list (Type.var "a")
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_6_0, arg2_7_0, arg3_8_0 ]
    , filter =
        \arg1_7_0 arg2_8_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_7_0, arg2_8_0 ]
    , filterMap =
        \arg1_8_0 arg2_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "filterMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.maybe (Type.var "b"))
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ arg1_8_0, arg2_9_0 ]
    , length =
        \arg1_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "length"
                    , annotation =
                        Just
                            (Type.function [ Type.list (Type.var "a") ] Type.int
                            )
                    }
                )
                [ arg1_9_0 ]
    , reverse =
        \arg1_10_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "reverse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_10_0 ]
    , member =
        \arg1_11_0 arg2_12_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "member"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.list (Type.var "a") ]
                                Type.bool
                            )
                    }
                )
                [ arg1_11_0, arg2_12_0 ]
    , all =
        \arg1_12_0 arg2_13_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "all"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_12_0, arg2_13_0 ]
    , any =
        \arg1_13_0 arg2_14_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "any"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_13_0, arg2_14_0 ]
    , maximum =
        \arg1_14_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "maximum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.maybe (Type.var "comparable"))
                            )
                    }
                )
                [ arg1_14_0 ]
    , minimum =
        \arg1_15_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "minimum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.maybe (Type.var "comparable"))
                            )
                    }
                )
                [ arg1_15_0 ]
    , sum =
        \arg1_16_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "number") ]
                                (Type.var "number")
                            )
                    }
                )
                [ arg1_16_0 ]
    , product =
        \arg1_17_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "product"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "number") ]
                                (Type.var "number")
                            )
                    }
                )
                [ arg1_17_0 ]
    , append =
        \arg1_18_0 arg2_19_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "append"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_18_0, arg2_19_0 ]
    , concat =
        \arg1_19_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "concat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.list (Type.var "a")) ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_19_0 ]
    , concatMap =
        \arg1_20_0 arg2_21_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "concatMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.list (Type.var "b"))
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ arg1_20_0, arg2_21_0 ]
    , intersperse =
        \arg1_21_0 arg2_22_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "intersperse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_21_0, arg2_22_0 ]
    , map2 =
        \arg1_22_0 arg2_23_0 arg3_24_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ arg1_22_0, arg2_23_0, arg3_24_0 ]
    , map3 =
        \arg1_23_0 arg2_24_0 arg3_25_0 arg4_26_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b", Type.var "c" ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ arg1_23_0, arg2_24_0, arg3_25_0, arg4_26_0 ]
    , map4 =
        \arg1_24_0 arg2_25_0 arg3_26_0 arg4_27_0 arg5_28_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                , Type.list (Type.var "d")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ arg1_24_0, arg2_25_0, arg3_26_0, arg4_27_0, arg5_28_0 ]
    , map5 =
        \arg1_25_0 arg2_26_0 arg3_27_0 arg4_28_0 arg5_29_0 arg6_30_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                , Type.list (Type.var "d")
                                , Type.list (Type.var "e")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ arg1_25_0
                , arg2_26_0
                , arg3_27_0
                , arg4_28_0
                , arg5_29_0
                , arg6_30_0
                ]
    , sort =
        \arg1_26_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sort"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.list (Type.var "comparable"))
                            )
                    }
                )
                [ arg1_26_0 ]
    , sortBy =
        \arg1_27_0 arg2_28_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sortBy"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "comparable")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_27_0, arg2_28_0 ]
    , sortWith =
        \arg1_28_0 arg2_29_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sortWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "a" ]
                                    (Type.namedWith [ "Basics" ] "Order" [])
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_28_0, arg2_29_0 ]
    , isEmpty =
        \arg1_29_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "isEmpty"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                Type.bool
                            )
                    }
                )
                [ arg1_29_0 ]
    , head =
        \arg1_30_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "head"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.maybe (Type.var "a"))
                            )
                    }
                )
                [ arg1_30_0 ]
    , tail =
        \arg1_31_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "tail"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.maybe (Type.list (Type.var "a")))
                            )
                    }
                )
                [ arg1_31_0 ]
    , take =
        \arg1_32_0 arg2_33_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "take"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_32_0, arg2_33_0 ]
    , drop =
        \arg1_33_0 arg2_34_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "drop"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ arg1_33_0, arg2_34_0 ]
    , partition =
        \arg1_34_0 arg2_35_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "partition"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                (Type.tuple
                                    (Type.list (Type.var "a"))
                                    (Type.list (Type.var "a"))
                                )
                            )
                    }
                )
                [ arg1_34_0, arg2_35_0 ]
    , unzip =
        \arg1_35_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "unzip"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple (Type.var "a") (Type.var "b"))
                                ]
                                (Type.tuple
                                    (Type.list (Type.var "a"))
                                    (Type.list (Type.var "b"))
                                )
                            )
                    }
                )
                [ arg1_35_0 ]
    }


values_ :
    { singleton : Elm.Expression
    , repeat : Elm.Expression
    , range : Elm.Expression
    , map : Elm.Expression
    , indexedMap : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , filter : Elm.Expression
    , filterMap : Elm.Expression
    , length : Elm.Expression
    , reverse : Elm.Expression
    , member : Elm.Expression
    , all : Elm.Expression
    , any : Elm.Expression
    , maximum : Elm.Expression
    , minimum : Elm.Expression
    , sum : Elm.Expression
    , product : Elm.Expression
    , append : Elm.Expression
    , concat : Elm.Expression
    , concatMap : Elm.Expression
    , intersperse : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , sort : Elm.Expression
    , sortBy : Elm.Expression
    , sortWith : Elm.Expression
    , isEmpty : Elm.Expression
    , head : Elm.Expression
    , tail : Elm.Expression
    , take : Elm.Expression
    , drop : Elm.Expression
    , partition : Elm.Expression
    , unzip : Elm.Expression
    }
values_ =
    { singleton =
        Elm.value
            { importFrom = [ "List" ]
            , name = "singleton"
            , annotation =
                Just (Type.function [ Type.var "a" ] (Type.list (Type.var "a")))
            }
    , repeat =
        Elm.value
            { importFrom = [ "List" ]
            , name = "repeat"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.var "a" ]
                        (Type.list (Type.var "a"))
                    )
            }
    , range =
        Elm.value
            { importFrom = [ "List" ]
            , name = "range"
            , annotation =
                Just (Type.function [ Type.int, Type.int ] (Type.list Type.int))
            }
    , map =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , indexedMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "indexedMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.int, Type.var "a" ]
                            (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "List" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "List" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "List" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , filterMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "filterMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , length =
        Elm.value
            { importFrom = [ "List" ]
            , name = "length"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.int)
            }
    , reverse =
        Elm.value
            { importFrom = [ "List" ]
            , name = "reverse"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , member =
        Elm.value
            { importFrom = [ "List" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        Type.bool
                    )
            }
    , all =
        Elm.value
            { importFrom = [ "List" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
    , any =
        Elm.value
            { importFrom = [ "List" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
    , maximum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "maximum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
    , minimum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "minimum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
    , sum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
    , product =
        Elm.value
            { importFrom = [ "List" ]
            , name = "product"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "List" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a"), Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , concat =
        Elm.value
            { importFrom = [ "List" ]
            , name = "concat"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.list (Type.var "a")) ]
                        (Type.list (Type.var "a"))
                    )
            }
    , concatMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "concatMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.list (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , intersperse =
        Elm.value
            { importFrom = [ "List" ]
            , name = "intersperse"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        , Type.list (Type.var "e")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , sort =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sort"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.list (Type.var "comparable"))
                    )
            }
    , sortBy =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sortBy"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "comparable")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , sortWith =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sortWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "a" ]
                            (Type.namedWith [ "Basics" ] "Order" [])
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , isEmpty =
        Elm.value
            { importFrom = [ "List" ]
            , name = "isEmpty"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.bool)
            }
    , head =
        Elm.value
            { importFrom = [ "List" ]
            , name = "head"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.var "a"))
                    )
            }
    , tail =
        Elm.value
            { importFrom = [ "List" ]
            , name = "tail"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.list (Type.var "a")))
                    )
            }
    , take =
        Elm.value
            { importFrom = [ "List" ]
            , name = "take"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , drop =
        Elm.value
            { importFrom = [ "List" ]
            , name = "drop"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , partition =
        Elm.value
            { importFrom = [ "List" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "a"))
                        )
                    )
            }
    , unzip =
        Elm.value
            { importFrom = [ "List" ]
            , name = "unzip"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.tuple (Type.var "a") (Type.var "b")) ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "b"))
                        )
                    )
            }
    }


