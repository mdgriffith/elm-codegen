module Gen.String exposing (all, any, append, call_, concat, cons, contains, dropLeft, dropRight, endsWith, filter, foldl, foldr, fromChar, fromFloat, fromInt, fromList, indexes, indices, isEmpty, join, left, length, lines, map, moduleName_, pad, padLeft, padRight, repeat, replace, reverse, right, slice, split, startsWith, toFloat, toInt, toList, toLower, toUpper, trim, trimLeft, trimRight, types_, uncons, values_, words)

{-| 
@docs moduleName_, isEmpty, length, reverse, repeat, replace, append, concat, split, join, words, lines, slice, left, right, dropLeft, dropRight, contains, startsWith, endsWith, indexes, indices, toInt, fromInt, toFloat, fromFloat, fromChar, cons, uncons, toList, fromList, toUpper, toLower, pad, padLeft, padRight, trim, trimLeft, trimRight, map, filter, foldl, foldr, any, all, types_, values_, call_
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
repeat arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "repeat"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Replace all occurrences of some substring.

    replace "." "-" "Json.Decode.succeed" == "Json-Decode-succeed"
    replace "," "/" "a,b,c,d,e"           == "a/b/c/d/e"

**Note:** If you need more advanced replacements, check out the
[`elm/parser`][parser] or [`elm/regex`][regex] package.

[parser]: /packages/elm/parser/latest
[regex]: /packages/elm/regex/latest
-}
replace : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
replace arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Append two strings. You can also use [the `(++)` operator](Basics#++)
to do this.

    append "butter" "fly" == "butterfly"
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "append"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Concatenate many strings into one.

    concat ["never","the","less"] == "nevertheless"
-}
concat : List Elm.Expression -> Elm.Expression
concat arg1 =
    Elm.apply
        (Elm.valueWith
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
split arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| Put many strings together with a given separator.

    join "a" ["H","w","ii","n"]        == "Hawaiian"
    join " " ["cat","dog","cow"]       == "cat dog cow"
    join "/" ["home","evan","Desktop"] == "home/evan/Desktop"
-}
join : Elm.Expression -> List Elm.Expression -> Elm.Expression
join arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, Elm.list arg2 ]


{-| Break a string into words, splitting on chunks of whitespace.

    words "How are \t you? \n Good?" == ["How","are","you?","Good?"]
-}
words : Elm.Expression -> Elm.Expression
words arg1 =
    Elm.apply
        (Elm.valueWith
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
        (Elm.valueWith
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
slice arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Take *n* characters from the left side of a string.

    left 2 "Mulder" == "Mu"
-}
left : Elm.Expression -> Elm.Expression -> Elm.Expression
left arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "left"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Take *n* characters from the right side of a string.

    right 2 "Scully" == "ly"
-}
right : Elm.Expression -> Elm.Expression -> Elm.Expression
right arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "right"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Drop *n* characters from the left side of a string.

    dropLeft 2 "The Lone Gunmen" == "e Lone Gunmen"
-}
dropLeft : Elm.Expression -> Elm.Expression -> Elm.Expression
dropLeft arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "dropLeft"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Drop *n* characters from the right side of a string.

    dropRight 2 "Cigarette Smoking Man" == "Cigarette Smoking M"
-}
dropRight : Elm.Expression -> Elm.Expression -> Elm.Expression
dropRight arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "dropRight"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| See if the second string contains the first one.

    contains "the" "theory" == True
    contains "hat" "theory" == False
    contains "THE" "theory" == False

-}
contains : Elm.Expression -> Elm.Expression -> Elm.Expression
contains arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "contains"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2 ]


{-| See if the second string starts with the first one.

    startsWith "the" "theory" == True
    startsWith "ory" "theory" == False
-}
startsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
startsWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "startsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2 ]


{-| See if the second string ends with the first one.

    endsWith "the" "theory" == False
    endsWith "ory" "theory" == True
-}
endsWith : Elm.Expression -> Elm.Expression -> Elm.Expression
endsWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "endsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
        )
        [ arg1, arg2 ]


{-| Get all of the indexes for a substring in another string.

    indexes "i" "Mississippi"   == [1,4,7,10]
    indexes "ss" "Mississippi"  == [2,5]
    indexes "needle" "haystack" == []
-}
indexes : Elm.Expression -> Elm.Expression -> Elm.Expression
indexes arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| Alias for `indexes`. -}
indices : Elm.Expression -> Elm.Expression -> Elm.Expression
indices arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
cons arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "String" ]
            , name = "cons"
            , annotation =
                Just (Type.function [ Type.char, Type.string ] Type.string)
            }
        )
        [ arg1, arg2 ]


{-| Split a non-empty string into its head and tail. This lets you
pattern match on strings exactly as you would with lists.

    uncons "abc" == Just ('a',"bc")
    uncons ""    == Nothing
-}
uncons : Elm.Expression -> Elm.Expression
uncons arg1 =
    Elm.apply
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
pad arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Pad a string on the left until it has a given length.

    padLeft 5 '.' "1"   == "....1"
    padLeft 5 '.' "11"  == "...11"
    padLeft 5 '.' "121" == "..121"
-}
padLeft : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
padLeft arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Pad a string on the right until it has a given length.

    padRight 5 '.' "1"   == "1...."
    padRight 5 '.' "11"  == "11..."
    padRight 5 '.' "121" == "121.."
-}
padRight : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
padRight arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Get rid of whitespace on both sides of a string.

    trim "  hats  \n" == "hats"
-}
trim : Elm.Expression -> Elm.Expression
trim arg1 =
    Elm.apply
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
map arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "mapArg0_0", Type.char ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "mapArg0_0"
                    , annotation = Just Type.char
                    }
                )
            )
        , arg2
        ]


{-| Keep only the characters that pass the test.

    filter isDigit "R2-D2" == "22"
-}
filter : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
filter arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "filterArg0_0", Type.char ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "filterArg0_0"
                    , annotation = Just Type.char
                    }
                )
            )
        , arg2
        ]


{-| Reduce a string from the left.

    foldl cons "" "time" == "emit"
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldl arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "foldlArg0_0", Type.char ), ( "foldlArg0_1", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "foldlArg0_0"
                    , annotation = Just Type.char
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "foldlArg0_1"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg2
        , arg3
        ]


{-| Reduce a string from the right.

    foldr cons "" "time" == "time"
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
foldr arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "foldrArg0_0", Type.char ), ( "foldrArg0_1", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "foldrArg0_0"
                    , annotation = Just Type.char
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "foldrArg0_1"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
        , arg2
        , arg3
        ]


{-| Determine whether *any* characters pass the test.

    any isDigit "90210" == True
    any isDigit "R2-D2" == True
    any isDigit "heart" == False
-}
any : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
any arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "anyArg0_0", Type.char ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "anyArg0_0"
                    , annotation = Just Type.char
                    }
                )
            )
        , arg2
        ]


{-| Determine whether *all* characters pass the test.

    all isDigit "90210" == True
    all isDigit "R2-D2" == False
    all isDigit "heart" == False
-}
all : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
all arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "allArg0_0", Type.char ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "allArg0_0"
                    , annotation = Just Type.char
                    }
                )
            )
        , arg2
        ]


types_ : { string : { annotation : Type.Annotation } }
types_ =
    { string = { annotation = Type.namedWith moduleName_ "String" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "isEmpty"
            , annotation = Just (Type.function [ Type.string ] Type.bool)
            }
    , length =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "length"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
    , reverse =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "reverse"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , repeat =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "repeat"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , replace =
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "append"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.string)
            }
    , concat =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "concat"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
    , split =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "words"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , lines =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "lines"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    , slice =
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "left"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , right =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "right"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropLeft =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "dropLeft"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , dropRight =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "dropRight"
            , annotation =
                Just (Type.function [ Type.int, Type.string ] Type.string)
            }
    , contains =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "contains"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , startsWith =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "startsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , endsWith =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "endsWith"
            , annotation =
                Just (Type.function [ Type.string, Type.string ] Type.bool)
            }
    , indexes =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "toInt"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.int))
            }
    , fromInt =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "fromInt"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    , toFloat =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "toFloat"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.float))
            }
    , fromFloat =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "fromFloat"
            , annotation = Just (Type.function [ Type.float ] Type.string)
            }
    , fromChar =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "fromChar"
            , annotation = Just (Type.function [ Type.char ] Type.string)
            }
    , cons =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "cons"
            , annotation =
                Just (Type.function [ Type.char, Type.string ] Type.string)
            }
    , uncons =
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "toList"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.char))
            }
    , fromList =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "fromList"
            , annotation =
                Just (Type.function [ Type.list Type.char ] Type.string)
            }
    , toUpper =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , toLower =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , pad =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "trim"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimLeft =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "trimLeft"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , trimRight =
        Elm.valueWith
            { importFrom = [ "String" ]
            , name = "trimRight"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , map =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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


{-| Every value/function in this module in case you need to refer to it directly. -}
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
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "isEmpty"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , length =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "length"
                    , annotation = Just (Type.function [ Type.string ] Type.int)
                    }
                )
                [ arg1_0 ]
    , reverse =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "reverse"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , repeat =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "repeat"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , replace =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , append =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , concat =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "concat"
                    , annotation =
                        Just
                            (Type.function [ Type.list Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0 ]
    , split =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , join =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , words =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , lines =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , slice =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , left =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "left"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , right =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "right"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , dropLeft =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "dropLeft"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , dropRight =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "dropRight"
                    , annotation =
                        Just
                            (Type.function [ Type.int, Type.string ] Type.string
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , contains =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , startsWith =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , endsWith =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , indexes =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , indices =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , toInt =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "toInt"
                    , annotation =
                        Just
                            (Type.function [ Type.string ] (Type.maybe Type.int)
                            )
                    }
                )
                [ arg1_0 ]
    , fromInt =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "fromInt"
                    , annotation = Just (Type.function [ Type.int ] Type.string)
                    }
                )
                [ arg1_0 ]
    , toFloat =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , fromFloat =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "fromFloat"
                    , annotation =
                        Just (Type.function [ Type.float ] Type.string)
                    }
                )
                [ arg1_0 ]
    , fromChar =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "fromChar"
                    , annotation =
                        Just (Type.function [ Type.char ] Type.string)
                    }
                )
                [ arg1_0 ]
    , cons =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , uncons =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , toList =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function [ Type.string ] (Type.list Type.char)
                            )
                    }
                )
                [ arg1_0 ]
    , fromList =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "fromList"
                    , annotation =
                        Just (Type.function [ Type.list Type.char ] Type.string)
                    }
                )
                [ arg1_0 ]
    , toUpper =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "toUpper"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , toLower =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "toLower"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , pad =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , padLeft =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , padRight =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , trim =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "trim"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , trimLeft =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "trimLeft"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , trimRight =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "String" ]
                    , name = "trimRight"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ arg1_0 ]
    , map =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , filter =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , foldl =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , foldr =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , any =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , all =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    }


