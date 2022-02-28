module Gen.String exposing (all, annotation_, any, append, call_, concat, cons, contains, dropLeft, dropRight, endsWith, filter, foldl, foldr, fromChar, fromFloat, fromInt, fromList, indexes, indices, isEmpty, join, left, length, lines, map, moduleName_, pad, padLeft, padRight, repeat, replace, reverse, right, slice, split, startsWith, toFloat, toInt, toList, toLower, toUpper, trim, trimLeft, trimRight, uncons, values_, words)

{-| 
@docs moduleName_, isEmpty, length, reverse, repeat, replace, append, concat, split, join, words, lines, slice, left, right, dropLeft, dropRight, contains, startsWith, endsWith, indexes, indices, toInt, fromInt, toFloat, fromFloat, fromChar, cons, uncons, toList, fromList, toUpper, toLower, pad, padLeft, padRight, trim, trimLeft, trimRight, map, filter, foldl, foldr, any, all, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "String" ]


{-| Determine if a string is empty.

    isEmpty "" == True
    isEmpty "the world" == False
-}
isEmpty : Elm.Expression -> Elm.Expression
isEmpty arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "isEmpty"
            , annotation = Just (Type.function [ Type.string ] Type.bool)
            }
        )
        [ arg1 ]


{-| Get the length of a string.

    length "innumerable" == 11
    length "" == 0

-}
length : Elm.Expression -> Elm.Expression
length arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "length"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
        )
        [ arg1 ]


{-| Reverse a string.

    reverse "stressed" == "desserts"
-}
reverse : Elm.Expression -> Elm.Expression
reverse arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "reverse"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Repeat a string *n* times.

    repeat 3 "ha" == "hahaha"
-}
repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
repeat arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "repeat"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Replace all occurrences of some substring.

    replace "." "-" "Json.Decode.succeed" == "Json-Decode-succeed"
    replace "," "/" "a,b,c,d,e"           == "a/b/c/d/e"

**Note:** If you need more advanced replacements, check out the
[`elm/parser`][parser] or [`elm/regex`][regex] package.

[parser]: /packages/elm/parser/latest
[regex]: /packages/elm/regex/latest
-}
replace : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
replace arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "replace"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string, Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, arg2_1, arg3_2 ]


{-| Append two strings. You can also use [the `(++)` operator](Basics#++)
to do this.

    append "butter" "fly" == "butterfly"
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "append"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Concatenate many strings into one.

    concat ["never","the","less"] == "nevertheless"
-}
concat : List Elm.Expression -> Elm.Expression
concat arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "concat"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
        )
        [ Elm.list arg1 ]


{-| Split a string using a given separator.

    split "," "cat,dog,cow"        == ["cat","dog","cow"]
    split "/" "home/evan/Desktop/" == ["home","evan","Desktop", ""]

-}
split : Elm.Expression -> Elm.Expression -> Elm.Expression
split arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "split"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.string)
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Put many strings together with a given separator.

    join "a" ["H","w","ii","n"]        == "Hawaiian"
    join " " ["cat","dog","cow"]       == "cat dog cow"
    join "/" ["home","evan","Desktop"] == "home/evan/Desktop"
-}
join : Elm.Expression -> List Elm.Expression -> Elm.Expression
join arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "join"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.list Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, Elm.list arg2_1 ]


{-| Break a string into words, splitting on chunks of whitespace.

    words "How are \t you? \n Good?" == ["How","are","you?","Good?"]
-}
words : Elm.Expression -> Elm.Expression
words arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "words"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
        )
        [ arg1 ]


{-| Break a string into lines, splitting on newlines.

    lines "How are you?\nGood?" == ["How are you?", "Good?"]
-}
lines : Elm.Expression -> Elm.Expression
lines arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "lines"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
        )
        [ arg1 ]


{-| Take a substring given a start and end index. Negative indexes
are taken starting from the *end* of the list.

    slice  7  9 "snakes on a plane!" == "on"
    slice  0  6 "snakes on a plane!" == "snakes"
    slice  0 -7 "snakes on a plane!" == "snakes on a"
    slice -6 -1 "snakes on a plane!" == "plane"
-}
slice : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
slice arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "slice"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.int, Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, arg2_1, arg3_2 ]


{-| Take *n* characters from the left side of a string.

    left 2 "Mulder" == "Mu"
-}
left : Elm.Expression -> Elm.Expression -> Elm.Expression
left arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "left"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Take *n* characters from the right side of a string.

    right 2 "Scully" == "ly"
-}
right : Elm.Expression -> Elm.Expression -> Elm.Expression
right arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "right"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Drop *n* characters from the left side of a string.

    dropLeft 2 "The Lone Gunmen" == "e Lone Gunmen"
-}
dropLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
dropLeft arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "dropLeft"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Drop *n* characters from the right side of a string.

    dropRight 2 "Cigarette Smoking Man" == "Cigarette Smoking M"
-}
dropRight : Elm.Expression -> Elm.Expression -> Elm.Expression
dropRight arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "dropRight"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| See if the second string contains the first one.

    contains "the" "theory" == True
    contains "hat" "theory" == False
    contains "THE" "theory" == False

-}
contains : Elm.Expression -> Elm.Expression -> Elm.Expression
contains arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "contains"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2_1 ]


{-| See if the second string starts with the first one.

    startsWith "the" "theory" == True
    startsWith "ory" "theory" == False
-}
startsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
startsWith arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "startsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2_1 ]


{-| See if the second string ends with the first one.

    endsWith "the" "theory" == False
    endsWith "ory" "theory" == True
-}
endsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
endsWith arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "endsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2_1 ]


{-| Get all of the indexes for a substring in another string.

    indexes "i" "Mississippi"   == [1,4,7,10]
    indexes "ss" "Mississippi"  == [2,5]
    indexes "needle" "haystack" == []
-}
indexes : Elm.Expression -> Elm.Expression -> Elm.Expression
indexes arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "indexes"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Alias for `indexes`. -}
indices : Elm.Expression -> Elm.Expression -> Elm.Expression
indices arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "indices"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
        )
        [ arg1, arg2_1 ]


{-| Try to convert a string into an int, failing on improperly formatted strings.

    String.toInt "123" == Just 123
    String.toInt "-42" == Just -42
    String.toInt "3.1" == Nothing
    String.toInt "31a" == Nothing

If you are extracting a number from some raw user input, you will typically
want to use [`Maybe.withDefault`](Maybe#withDefault) to handle bad data:

    Maybe.withDefault 0 (String.toInt "42") == 42
    Maybe.withDefault 0 (String.toInt "ab") == 0
-}
toInt : Elm.Expression -> Elm.Expression
toInt arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "toInt"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.int))
            }
        )
        [ arg1 ]


{-| Convert an `Int` to a `String`.

    String.fromInt 123 == "123"
    String.fromInt -42 == "-42"

Check out [`Debug.toString`](Debug#toString) to convert *any* value to a string
for debugging purposes.
-}
fromInt : Elm.Expression -> Elm.Expression
fromInt arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "fromInt"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
        )
        [ arg1 ]


{-| Try to convert a string into a float, failing on improperly formatted strings.

    String.toFloat "123" == Just 123.0
    String.toFloat "-42" == Just -42.0
    String.toFloat "3.1" == Just 3.1
    String.toFloat "31a" == Nothing

If you are extracting a number from some raw user input, you will typically
want to use [`Maybe.withDefault`](Maybe#withDefault) to handle bad data:

    Maybe.withDefault 0 (String.toFloat "42.5") == 42.5
    Maybe.withDefault 0 (String.toFloat "cats") == 0
-}
toFloat : Elm.Expression -> Elm.Expression
toFloat arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "toFloat"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.float))
            }
        )
        [ arg1 ]


{-| Convert a `Float` to a `String`.

    String.fromFloat 123 == "123"
    String.fromFloat -42 == "-42"
    String.fromFloat 3.9 == "3.9"

Check out [`Debug.toString`](Debug#toString) to convert *any* value to a string
for debugging purposes.
-}
fromFloat : Elm.Expression -> Elm.Expression
fromFloat arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "fromFloat"
            , annotation = Just (Type.function [ Type.float ] Type.string)
            }
        )
        [ arg1 ]


{-| Create a string from a given character.

    fromChar 'a' == "a"
-}
fromChar : Elm.Expression -> Elm.Expression
fromChar arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "fromChar"
            , annotation = Just (Type.function [ Type.char ] Type.string)
            }
        )
        [ arg1 ]


{-| Add a character to the beginning of a string.

    cons 'T' "he truth is out there" == "The truth is out there"
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "cons"
            , annotation =
                Just (Type.function [ Type.char, Type.string ] Type.string)
            }
        )
        [ arg1, arg2_1 ]


{-| Split a non-empty string into its head and tail. This lets you
pattern match on strings exactly as you would with lists.

    uncons "abc" == Just ('a',"bc")
    uncons ""    == Nothing
-}
uncons : Elm.Expression -> Elm.Expression
uncons arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "uncons"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.maybe (Type.tuple Type.char Type.string))
                    )
            }
        )
        [ arg1 ]


{-| Convert a string to a list of characters.

    toList "abc" == ['a','b','c']
    toList "🙈🙉🙊" == ['🙈','🙉','🙊']
-}
toList : Elm.Expression -> Elm.Expression
toList arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "toList"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.char))
            }
        )
        [ arg1 ]


{-| Convert a list of characters into a String. Can be useful if you
want to create a string primarily by consing, perhaps for decoding
something.

    fromList ['a','b','c'] == "abc"
    fromList ['🙈','🙉','🙊'] == "🙈🙉🙊"
-}
fromList : List Elm.Expression -> Elm.Expression
fromList arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "fromList"
            , annotation =
                Just (Type.function [ Type.list Type.char ] Type.string)
            }
        )
        [ Elm.list arg1 ]


{-| Convert a string to all upper case. Useful for case-insensitive comparisons
and VIRTUAL YELLING.

    toUpper "skinner" == "SKINNER"
-}
toUpper : Elm.Expression -> Elm.Expression
toUpper arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Convert a string to all lower case. Useful for case-insensitive comparisons.

    toLower "X-FILES" == "x-files"
-}
toLower : Elm.Expression -> Elm.Expression
toLower arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Pad a string on both sides until it has a given length.

    pad 5 ' ' "1"   == "  1  "
    pad 5 ' ' "11"  == "  11 "
    pad 5 ' ' "121" == " 121 "
-}
pad : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
pad arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "pad"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, arg2_1, arg3_2 ]


{-| Pad a string on the left until it has a given length.

    padLeft 5 '.' "1"   == "....1"
    padLeft 5 '.' "11"  == "...11"
    padLeft 5 '.' "121" == "..121"
-}
padLeft : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
padLeft arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "padLeft"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, arg2_1, arg3_2 ]


{-| Pad a string on the right until it has a given length.

    padRight 5 '.' "1"   == "1...."
    padRight 5 '.' "11"  == "11..."
    padRight 5 '.' "121" == "121.."
-}
padRight : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
padRight arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "padRight"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
        )
        [ arg1, arg2_1, arg3_2 ]


{-| Get rid of whitespace on both sides of a string.

    trim "  hats  \n" == "hats"
-}
trim : Elm.Expression -> Elm.Expression
trim arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "trim"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Get rid of whitespace on the left of a string.

    trimLeft "  hats  \n" == "hats  \n"
-}
trimLeft : Elm.Expression -> Elm.Expression
trimLeft arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "trimLeft"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Get rid of whitespace on the right of a string.

    trimRight "  hats  \n" == "  hats"
-}
trimRight : Elm.Expression -> Elm.Expression
trimRight arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "trimRight"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| Transform every character in a string

    map (\c -> if c == '/' then '.' else c) "a/b/c" == "a.b.c"
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.char, Type.string ]
                        Type.string
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


{-| Keep only the characters that pass the test.

    filter isDigit "R2-D2" == "22"
-}
filter : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
filter arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.string
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


{-| Reduce a string from the left.

    foldl cons "" "time" == "emit"
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 -> Elm.functionReduced "unpack" (arg1 unpack_3_3_0))
        , arg2_1
        , arg3_2
        ]


{-| Reduce a string from the right.

    foldr cons "" "time" == "time"
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr arg1 arg2_1 arg3_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack_3_3_0 -> Elm.functionReduced "unpack" (arg1 unpack_3_3_0))
        , arg2_1
        , arg3_2
        ]


{-| Determine whether *any* characters pass the test.

    any isDigit "90210" == True
    any isDigit "R2-D2" == True
    any isDigit "heart" == False
-}
any : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
any arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


{-| Determine whether *all* characters pass the test.

    all isDigit "90210" == True
    all isDigit "R2-D2" == False
    all isDigit "heart" == False
-}
all : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
all arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2_1 ]


annotation_ : { string : Type.Annotation }
annotation_ =
    { string = Type.namedWith moduleName_ "String" [] }


call_ :
    { isEmpty : Elm.Expression -> Elm.Expression
    , length : Elm.Expression -> Elm.Expression
    , reverse : Elm.Expression -> Elm.Expression
    , repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
    , replace :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , concat : Elm.Expression -> Elm.Expression
    , split : Elm.Expression -> Elm.Expression -> Elm.Expression
    , join : Elm.Expression -> Elm.Expression -> Elm.Expression
    , words : Elm.Expression -> Elm.Expression
    , lines : Elm.Expression -> Elm.Expression
    , slice :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , left : Elm.Expression -> Elm.Expression -> Elm.Expression
    , right : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
    , dropRight : Elm.Expression -> Elm.Expression -> Elm.Expression
    , contains : Elm.Expression -> Elm.Expression -> Elm.Expression
    , startsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , endsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indexes : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indices : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toInt : Elm.Expression -> Elm.Expression
    , fromInt : Elm.Expression -> Elm.Expression
    , toFloat : Elm.Expression -> Elm.Expression
    , fromFloat : Elm.Expression -> Elm.Expression
    , fromChar : Elm.Expression -> Elm.Expression
    , cons : Elm.Expression -> Elm.Expression -> Elm.Expression
    , uncons : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , toUpper : Elm.Expression -> Elm.Expression
    , toLower : Elm.Expression -> Elm.Expression
    , pad : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , padLeft :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , padRight :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , trim : Elm.Expression -> Elm.Expression
    , trimLeft : Elm.Expression -> Elm.Expression
    , trimRight : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , any : Elm.Expression -> Elm.Expression -> Elm.Expression
    , all : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { isEmpty =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "isEmpty"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , length =
        \arg1_1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "length"
                    , annotation = Just (Type.function [ Type.string ] Type.int)
                    }
                )
                [ arg1_1_0 ]
    , reverse =
        \arg1_2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "reverse"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_2_0 ]
    , repeat =
        \arg1_3_0 arg2_4_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "repeat"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_3_0, arg2_4_0 ]
    , replace =
        \arg1_4_0 arg2_5_0 arg3_6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "replace"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_4_0, arg2_5_0, arg3_6_0 ]
    , append =
        \arg1_5_0 arg2_6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "append"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_5_0, arg2_6_0 ]
    , concat =
        \arg1_6_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "concat"
                    , annotation =
                        Just
                            (Type.function [ Type.list Type.string ] Type.string
                            )
                    }
                )
                [ arg1_6_0 ]
    , split =
        \arg1_7_0 arg2_8_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "split"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ arg1_7_0, arg2_8_0 ]
    , join =
        \arg1_8_0 arg2_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "join"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.list Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_8_0, arg2_9_0 ]
    , words =
        \arg1_9_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "words"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ arg1_9_0 ]
    , lines =
        \arg1_10_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "lines"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ arg1_10_0 ]
    , slice =
        \arg1_11_0 arg2_12_0 arg3_13_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "slice"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.int, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_11_0, arg2_12_0, arg3_13_0 ]
    , left =
        \arg1_12_0 arg2_13_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "left"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_12_0, arg2_13_0 ]
    , right =
        \arg1_13_0 arg2_14_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "right"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_13_0, arg2_14_0 ]
    , dropLeft =
        \arg1_14_0 arg2_15_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "dropLeft"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_14_0, arg2_15_0 ]
    , dropRight =
        \arg1_15_0 arg2_16_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "dropRight"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_15_0, arg2_16_0 ]
    , contains =
        \arg1_16_0 arg2_17_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "contains"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ arg1_16_0, arg2_17_0 ]
    , startsWith =
        \arg1_17_0 arg2_18_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "startsWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ arg1_17_0, arg2_18_0 ]
    , endsWith =
        \arg1_18_0 arg2_19_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "endsWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                Type.bool
                            )
                    }
                )
                [ arg1_18_0, arg2_19_0 ]
    , indexes =
        \arg1_19_0 arg2_20_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "indexes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ arg1_19_0, arg2_20_0 ]
    , indices =
        \arg1_20_0 arg2_21_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "indices"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ arg1_20_0, arg2_21_0 ]
    , toInt =
        \arg1_21_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toInt"
                    , annotation =
                        Just
                            (Type.function [ Type.string ] (Type.maybe Type.int)
                            )
                    }
                )
                [ arg1_21_0 ]
    , fromInt =
        \arg1_22_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromInt"
                    , annotation = Just (Type.function [ Type.int ] Type.string)
                    }
                )
                [ arg1_22_0 ]
    , toFloat =
        \arg1_23_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toFloat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.float)
                            )
                    }
                )
                [ arg1_23_0 ]
    , fromFloat =
        \arg1_24_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromFloat"
                    , annotation =
                        Just (Type.function [ Type.float ] Type.string)
                    }
                )
                [ arg1_24_0 ]
    , fromChar =
        \arg1_25_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromChar"
                    , annotation =
                        Just (Type.function [ Type.char ] Type.string)
                    }
                )
                [ arg1_25_0 ]
    , cons =
        \arg1_26_0 arg2_27_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "cons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_26_0, arg2_27_0 ]
    , uncons =
        \arg1_27_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "uncons"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe (Type.tuple Type.char Type.string))
                            )
                    }
                )
                [ arg1_27_0 ]
    , toList =
        \arg1_28_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function [ Type.string ] (Type.list Type.char)
                            )
                    }
                )
                [ arg1_28_0 ]
    , fromList =
        \arg1_29_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "fromList"
                    , annotation =
                        Just (Type.function [ Type.list Type.char ] Type.string)
                    }
                )
                [ arg1_29_0 ]
    , toUpper =
        \arg1_30_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toUpper"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_30_0 ]
    , toLower =
        \arg1_31_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "toLower"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_31_0 ]
    , pad =
        \arg1_32_0 arg2_33_0 arg3_34_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "pad"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_32_0, arg2_33_0, arg3_34_0 ]
    , padLeft =
        \arg1_33_0 arg2_34_0 arg3_35_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "padLeft"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_33_0, arg2_34_0, arg3_35_0 ]
    , padRight =
        \arg1_34_0 arg2_35_0 arg3_36_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "padRight"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.char, Type.string ]
                                Type.string
                            )
                    }
                )
                [ arg1_34_0, arg2_35_0, arg3_36_0 ]
    , trim =
        \arg1_35_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trim"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_35_0 ]
    , trimLeft =
        \arg1_36_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trimLeft"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_36_0 ]
    , trimRight =
        \arg1_37_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "trimRight"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_37_0 ]
    , map =
        \arg1_38_0 arg2_39_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.char
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ arg1_38_0, arg2_39_0 ]
    , filter =
        \arg1_39_0 arg2_40_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ arg1_39_0, arg2_40_0 ]
    , foldl =
        \arg1_40_0 arg2_41_0 arg3_42_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.char, Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.string
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_40_0, arg2_41_0, arg3_42_0 ]
    , foldr =
        \arg1_41_0 arg2_42_0 arg3_43_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.char, Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.string
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ arg1_41_0, arg2_42_0, arg3_43_0 ]
    , any =
        \arg1_42_0 arg2_43_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "any"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_42_0, arg2_43_0 ]
    , all =
        \arg1_43_0 arg2_44_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "String" ]
                    , name = "all"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.string
                                ]
                                Type.bool
                            )
                    }
                )
                [ arg1_43_0, arg2_44_0 ]
    }


values_ :
    { isEmpty : Elm.Expression
    , length : Elm.Expression
    , reverse : Elm.Expression
    , repeat : Elm.Expression
    , replace : Elm.Expression
    , append : Elm.Expression
    , concat : Elm.Expression
    , split : Elm.Expression
    , join : Elm.Expression
    , words : Elm.Expression
    , lines : Elm.Expression
    , slice : Elm.Expression
    , left : Elm.Expression
    , right : Elm.Expression
    , dropLeft : Elm.Expression
    , dropRight : Elm.Expression
    , contains : Elm.Expression
    , startsWith : Elm.Expression
    , endsWith : Elm.Expression
    , indexes : Elm.Expression
    , indices : Elm.Expression
    , toInt : Elm.Expression
    , fromInt : Elm.Expression
    , toFloat : Elm.Expression
    , fromFloat : Elm.Expression
    , fromChar : Elm.Expression
    , cons : Elm.Expression
    , uncons : Elm.Expression
    , toList : Elm.Expression
    , fromList : Elm.Expression
    , toUpper : Elm.Expression
    , toLower : Elm.Expression
    , pad : Elm.Expression
    , padLeft : Elm.Expression
    , padRight : Elm.Expression
    , trim : Elm.Expression
    , trimLeft : Elm.Expression
    , trimRight : Elm.Expression
    , map : Elm.Expression
    , filter : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , any : Elm.Expression
    , all : Elm.Expression
    }
values_ =
    { isEmpty =
        Elm.value
            { importFrom = [ "String" ]
            , name = "isEmpty"
            , annotation = Just (Type.function [ Type.string ] Type.bool)
            }
    , length =
        Elm.value
            { importFrom = [ "String" ]
            , name = "length"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
    , reverse =
        Elm.value
            { importFrom = [ "String" ]
            , name = "reverse"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , repeat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "repeat"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , replace =
        Elm.value
            { importFrom = [ "String" ]
            , name = "replace"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string, Type.string ]
                        Type.string
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "String" ]
            , name = "append"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.string)
            }
    , concat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "concat"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
    , split =
        Elm.value
            { importFrom = [ "String" ]
            , name = "split"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.string)
                    )
            }
    , join =
        Elm.value
            { importFrom = [ "String" ]
            , name = "join"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.list Type.string ]
                        Type.string
                    )
            }
    , words =
        Elm.value
            { importFrom = [ "String" ]
            , name = "words"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , lines =
        Elm.value
            { importFrom = [ "String" ]
            , name = "lines"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , slice =
        Elm.value
            { importFrom = [ "String" ]
            , name = "slice"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.int, Type.string ]
                        Type.string
                    )
            }
    , left =
        Elm.value
            { importFrom = [ "String" ]
            , name = "left"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , right =
        Elm.value
            { importFrom = [ "String" ]
            , name = "right"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "dropLeft"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "dropRight"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , contains =
        Elm.value
            { importFrom = [ "String" ]
            , name = "contains"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , startsWith =
        Elm.value
            { importFrom = [ "String" ]
            , name = "startsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , endsWith =
        Elm.value
            { importFrom = [ "String" ]
            , name = "endsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , indexes =
        Elm.value
            { importFrom = [ "String" ]
            , name = "indexes"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
    , indices =
        Elm.value
            { importFrom = [ "String" ]
            , name = "indices"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.list Type.int)
                    )
            }
    , toInt =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toInt"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.int))
            }
    , fromInt =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromInt"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    , toFloat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toFloat"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.float))
            }
    , fromFloat =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromFloat"
            , annotation = Just (Type.function [ Type.float ] Type.string)
            }
    , fromChar =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromChar"
            , annotation = Just (Type.function [ Type.char ] Type.string)
            }
    , cons =
        Elm.value
            { importFrom = [ "String" ]
            , name = "cons"
            , annotation =
                Just (Type.function [ Type.char, Type.string ] Type.string)
            }
    , uncons =
        Elm.value
            { importFrom = [ "String" ]
            , name = "uncons"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.maybe (Type.tuple Type.char Type.string))
                    )
            }
    , toList =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toList"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.char))
            }
    , fromList =
        Elm.value
            { importFrom = [ "String" ]
            , name = "fromList"
            , annotation =
                Just (Type.function [ Type.list Type.char ] Type.string)
            }
    , toUpper =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , toLower =
        Elm.value
            { importFrom = [ "String" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , pad =
        Elm.value
            { importFrom = [ "String" ]
            , name = "pad"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , padLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "padLeft"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , padRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "padRight"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.char, Type.string ]
                        Type.string
                    )
            }
    , trim =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trim"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimLeft =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trimLeft"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimRight =
        Elm.value
            { importFrom = [ "String" ]
            , name = "trimRight"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , map =
        Elm.value
            { importFrom = [ "String" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.char, Type.string ]
                        Type.string
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "String" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.string
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "String" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "String" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.char, Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.string
                        ]
                        (Type.var "b")
                    )
            }
    , any =
        Elm.value
            { importFrom = [ "String" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
    , all =
        Elm.value
            { importFrom = [ "String" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.char ] Type.bool, Type.string ]
                        Type.bool
                    )
            }
    }


