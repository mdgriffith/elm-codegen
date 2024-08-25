module Gen.String exposing
    ( all
    , annotation_
    , any
    , append
    , call_
    , concat
    , cons
    , contains
    , dropLeft
    , dropRight
    , endsWith
    , filter
    , foldl
    , foldr
    , fromChar
    , fromFloat
    , fromInt
    , fromList
    , indexes
    , indices
    , isEmpty
    , join
    , left
    , length
    , lines
    , map
    , moduleName_
    , pad
    , padLeft
    , padRight
    , repeat
    , replace
    , reverse
    , right
    , slice
    , split
    , startsWith
    , toFloat
    , toInt
    , toList
    , toLower
    , toUpper
    , trim
    , trimLeft
    , trimRight
    , uncons
    , values_
    , words
    )

{-|
# Generated bindings for String

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

isEmpty: String -> Bool
-}
isEmpty : String -> Elm.Expression
isEmpty isEmptyArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "isEmpty"
             , annotation = Just (Type.function [ Type.string ] Type.bool)
             }
        )
        [ Elm.string isEmptyArg_ ]


{-| Get the length of a string.

    length "innumerable" == 11
    length "" == 0

length: String -> Int
-}
length : String -> Elm.Expression
length lengthArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "length"
             , annotation = Just (Type.function [ Type.string ] Type.int)
             }
        )
        [ Elm.string lengthArg_ ]


{-| Reverse a string.

    reverse "stressed" == "desserts"

reverse: String -> String
-}
reverse : String -> Elm.Expression
reverse reverseArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "reverse"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string reverseArg_ ]


{-| Repeat a string *n* times.

    repeat 3 "ha" == "hahaha"

repeat: Int -> String -> String
-}
repeat : Int -> String -> Elm.Expression
repeat repeatArg_ repeatArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "repeat"
             , annotation =
                 Just (Type.function [ Type.int, Type.string ] Type.string)
             }
        )
        [ Elm.int repeatArg_, Elm.string repeatArg_0 ]


{-| Replace all occurrences of some substring.

    replace "." "-" "Json.Decode.succeed" == "Json-Decode-succeed"
    replace "," "/" "a,b,c,d,e"           == "a/b/c/d/e"

**Note:** If you need more advanced replacements, check out the
[`elm/parser`][parser] or [`elm/regex`][regex] package.

[parser]: /packages/elm/parser/latest
[regex]: /packages/elm/regex/latest

replace: String -> String -> String -> String
-}
replace : String -> String -> String -> Elm.Expression
replace replaceArg_ replaceArg_0 replaceArg_1 =
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
        [ Elm.string replaceArg_
        , Elm.string replaceArg_0
        , Elm.string replaceArg_1
        ]


{-| Append two strings. You can also use [the `(++)` operator](Basics#++)
to do this.

    append "butter" "fly" == "butterfly"

append: String -> String -> String
-}
append : String -> String -> Elm.Expression
append appendArg_ appendArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "append"
             , annotation =
                 Just (Type.function [ Type.string, Type.string ] Type.string)
             }
        )
        [ Elm.string appendArg_, Elm.string appendArg_0 ]


{-| Concatenate many strings into one.

    concat ["never","the","less"] == "nevertheless"

concat: List String -> String
-}
concat : List String -> Elm.Expression
concat concatArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "concat"
             , annotation =
                 Just (Type.function [ Type.list Type.string ] Type.string)
             }
        )
        [ Elm.list (List.map Elm.string concatArg_) ]


{-| Split a string using a given separator.

    split "," "cat,dog,cow"        == ["cat","dog","cow"]
    split "/" "home/evan/Desktop/" == ["home","evan","Desktop", ""]

split: String -> String -> List String
-}
split : String -> String -> Elm.Expression
split splitArg_ splitArg_0 =
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
        [ Elm.string splitArg_, Elm.string splitArg_0 ]


{-| Put many strings together with a given separator.

    join "a" ["H","w","ii","n"]        == "Hawaiian"
    join " " ["cat","dog","cow"]       == "cat dog cow"
    join "/" ["home","evan","Desktop"] == "home/evan/Desktop"

join: String -> List String -> String
-}
join : String -> List String -> Elm.Expression
join joinArg_ joinArg_0 =
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
        [ Elm.string joinArg_, Elm.list (List.map Elm.string joinArg_0) ]


{-| Break a string into words, splitting on chunks of whitespace.

    words "How are \t you? \n Good?" == ["How","are","you?","Good?"]

words: String -> List String
-}
words : String -> Elm.Expression
words wordsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "words"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.list Type.string))
             }
        )
        [ Elm.string wordsArg_ ]


{-| Break a string into lines, splitting on newlines.

    lines "How are you?\nGood?" == ["How are you?", "Good?"]

lines: String -> List String
-}
lines : String -> Elm.Expression
lines linesArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "lines"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.list Type.string))
             }
        )
        [ Elm.string linesArg_ ]


{-| Take a substring given a start and end index. Negative indexes
are taken starting from the *end* of the list.

    slice  7  9 "snakes on a plane!" == "on"
    slice  0  6 "snakes on a plane!" == "snakes"
    slice  0 -7 "snakes on a plane!" == "snakes on a"
    slice -6 -1 "snakes on a plane!" == "plane"

slice: Int -> Int -> String -> String
-}
slice : Int -> Int -> String -> Elm.Expression
slice sliceArg_ sliceArg_0 sliceArg_1 =
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
        [ Elm.int sliceArg_, Elm.int sliceArg_0, Elm.string sliceArg_1 ]


{-| Take *n* characters from the left side of a string.

    left 2 "Mulder" == "Mu"

left: Int -> String -> String
-}
left : Int -> String -> Elm.Expression
left leftArg_ leftArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "left"
             , annotation =
                 Just (Type.function [ Type.int, Type.string ] Type.string)
             }
        )
        [ Elm.int leftArg_, Elm.string leftArg_0 ]


{-| Take *n* characters from the right side of a string.

    right 2 "Scully" == "ly"

right: Int -> String -> String
-}
right : Int -> String -> Elm.Expression
right rightArg_ rightArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "right"
             , annotation =
                 Just (Type.function [ Type.int, Type.string ] Type.string)
             }
        )
        [ Elm.int rightArg_, Elm.string rightArg_0 ]


{-| Drop *n* characters from the left side of a string.

    dropLeft 2 "The Lone Gunmen" == "e Lone Gunmen"

dropLeft: Int -> String -> String
-}
dropLeft : Int -> String -> Elm.Expression
dropLeft dropLeftArg_ dropLeftArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "dropLeft"
             , annotation =
                 Just (Type.function [ Type.int, Type.string ] Type.string)
             }
        )
        [ Elm.int dropLeftArg_, Elm.string dropLeftArg_0 ]


{-| Drop *n* characters from the right side of a string.

    dropRight 2 "Cigarette Smoking Man" == "Cigarette Smoking M"

dropRight: Int -> String -> String
-}
dropRight : Int -> String -> Elm.Expression
dropRight dropRightArg_ dropRightArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "dropRight"
             , annotation =
                 Just (Type.function [ Type.int, Type.string ] Type.string)
             }
        )
        [ Elm.int dropRightArg_, Elm.string dropRightArg_0 ]


{-| See if the second string contains the first one.

    contains "the" "theory" == True
    contains "hat" "theory" == False
    contains "THE" "theory" == False

contains: String -> String -> Bool
-}
contains : String -> String -> Elm.Expression
contains containsArg_ containsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "contains"
             , annotation =
                 Just (Type.function [ Type.string, Type.string ] Type.bool)
             }
        )
        [ Elm.string containsArg_, Elm.string containsArg_0 ]


{-| See if the second string starts with the first one.

    startsWith "the" "theory" == True
    startsWith "ory" "theory" == False

startsWith: String -> String -> Bool
-}
startsWith : String -> String -> Elm.Expression
startsWith startsWithArg_ startsWithArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "startsWith"
             , annotation =
                 Just (Type.function [ Type.string, Type.string ] Type.bool)
             }
        )
        [ Elm.string startsWithArg_, Elm.string startsWithArg_0 ]


{-| See if the second string ends with the first one.

    endsWith "the" "theory" == False
    endsWith "ory" "theory" == True

endsWith: String -> String -> Bool
-}
endsWith : String -> String -> Elm.Expression
endsWith endsWithArg_ endsWithArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "endsWith"
             , annotation =
                 Just (Type.function [ Type.string, Type.string ] Type.bool)
             }
        )
        [ Elm.string endsWithArg_, Elm.string endsWithArg_0 ]


{-| Get all of the indexes for a substring in another string.

    indexes "i" "Mississippi"   == [1,4,7,10]
    indexes "ss" "Mississippi"  == [2,5]
    indexes "needle" "haystack" == []

indexes: String -> String -> List Int
-}
indexes : String -> String -> Elm.Expression
indexes indexesArg_ indexesArg_0 =
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
        [ Elm.string indexesArg_, Elm.string indexesArg_0 ]


{-| Alias for `indexes`.

indices: String -> String -> List Int
-}
indices : String -> String -> Elm.Expression
indices indicesArg_ indicesArg_0 =
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
        [ Elm.string indicesArg_, Elm.string indicesArg_0 ]


{-| Try to convert a string into an int, failing on improperly formatted strings.

    String.toInt "123" == Just 123
    String.toInt "-42" == Just -42
    String.toInt "3.1" == Nothing
    String.toInt "31a" == Nothing

If you are extracting a number from some raw user input, you will typically
want to use [`Maybe.withDefault`](Maybe#withDefault) to handle bad data:

    Maybe.withDefault 0 (String.toInt "42") == 42
    Maybe.withDefault 0 (String.toInt "ab") == 0

toInt: String -> Maybe Int
-}
toInt : String -> Elm.Expression
toInt toIntArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "toInt"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.maybe Type.int))
             }
        )
        [ Elm.string toIntArg_ ]


{-| Convert an `Int` to a `String`.

    String.fromInt 123 == "123"
    String.fromInt -42 == "-42"

Check out [`Debug.toString`](Debug#toString) to convert *any* value to a string
for debugging purposes.

fromInt: Int -> String
-}
fromInt : Int -> Elm.Expression
fromInt fromIntArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "fromInt"
             , annotation = Just (Type.function [ Type.int ] Type.string)
             }
        )
        [ Elm.int fromIntArg_ ]


{-| Try to convert a string into a float, failing on improperly formatted strings.

    String.toFloat "123" == Just 123.0
    String.toFloat "-42" == Just -42.0
    String.toFloat "3.1" == Just 3.1
    String.toFloat "31a" == Nothing

If you are extracting a number from some raw user input, you will typically
want to use [`Maybe.withDefault`](Maybe#withDefault) to handle bad data:

    Maybe.withDefault 0 (String.toFloat "42.5") == 42.5
    Maybe.withDefault 0 (String.toFloat "cats") == 0

toFloat: String -> Maybe Float
-}
toFloat : String -> Elm.Expression
toFloat toFloatArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "toFloat"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.maybe Type.float))
             }
        )
        [ Elm.string toFloatArg_ ]


{-| Convert a `Float` to a `String`.

    String.fromFloat 123 == "123"
    String.fromFloat -42 == "-42"
    String.fromFloat 3.9 == "3.9"

Check out [`Debug.toString`](Debug#toString) to convert *any* value to a string
for debugging purposes.

fromFloat: Float -> String
-}
fromFloat : Float -> Elm.Expression
fromFloat fromFloatArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "fromFloat"
             , annotation = Just (Type.function [ Type.float ] Type.string)
             }
        )
        [ Elm.float fromFloatArg_ ]


{-| Create a string from a given character.

    fromChar 'a' == "a"

fromChar: Char.Char -> String
-}
fromChar : Char.Char -> Elm.Expression
fromChar fromCharArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "fromChar"
             , annotation = Just (Type.function [ Type.char ] Type.string)
             }
        )
        [ Elm.char fromCharArg_ ]


{-| Add a character to the beginning of a string.

    cons 'T' "he truth is out there" == "The truth is out there"

cons: Char.Char -> String -> String
-}
cons : Char.Char -> String -> Elm.Expression
cons consArg_ consArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "cons"
             , annotation =
                 Just (Type.function [ Type.char, Type.string ] Type.string)
             }
        )
        [ Elm.char consArg_, Elm.string consArg_0 ]


{-| Split a non-empty string into its head and tail. This lets you
pattern match on strings exactly as you would with lists.

    uncons "abc" == Just ('a',"bc")
    uncons ""    == Nothing

uncons: String -> Maybe ( Char.Char, String )
-}
uncons : String -> Elm.Expression
uncons unconsArg_ =
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
        [ Elm.string unconsArg_ ]


{-| Convert a string to a list of characters.

    toList "abc" == ['a','b','c']
    toList "🙈🙉🙊" == ['🙈','🙉','🙊']

toList: String -> List Char.Char
-}
toList : String -> Elm.Expression
toList toListArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "toList"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.list Type.char))
             }
        )
        [ Elm.string toListArg_ ]


{-| Convert a list of characters into a String. Can be useful if you
want to create a string primarily by consing, perhaps for decoding
something.

    fromList ['a','b','c'] == "abc"
    fromList ['🙈','🙉','🙊'] == "🙈🙉🙊"

fromList: List Char.Char -> String
-}
fromList : List Char.Char -> Elm.Expression
fromList fromListArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "fromList"
             , annotation =
                 Just (Type.function [ Type.list Type.char ] Type.string)
             }
        )
        [ Elm.list (List.map Elm.char fromListArg_) ]


{-| Convert a string to all upper case. Useful for case-insensitive comparisons
and VIRTUAL YELLING.

    toUpper "skinner" == "SKINNER"

toUpper: String -> String
-}
toUpper : String -> Elm.Expression
toUpper toUpperArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "toUpper"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string toUpperArg_ ]


{-| Convert a string to all lower case. Useful for case-insensitive comparisons.

    toLower "X-FILES" == "x-files"

toLower: String -> String
-}
toLower : String -> Elm.Expression
toLower toLowerArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "toLower"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string toLowerArg_ ]


{-| Pad a string on both sides until it has a given length.

    pad 5 ' ' "1"   == "  1  "
    pad 5 ' ' "11"  == "  11 "
    pad 5 ' ' "121" == " 121 "

pad: Int -> Char.Char -> String -> String
-}
pad : Int -> Char.Char -> String -> Elm.Expression
pad padArg_ padArg_0 padArg_1 =
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
        [ Elm.int padArg_, Elm.char padArg_0, Elm.string padArg_1 ]


{-| Pad a string on the left until it has a given length.

    padLeft 5 '.' "1"   == "....1"
    padLeft 5 '.' "11"  == "...11"
    padLeft 5 '.' "121" == "..121"

padLeft: Int -> Char.Char -> String -> String
-}
padLeft : Int -> Char.Char -> String -> Elm.Expression
padLeft padLeftArg_ padLeftArg_0 padLeftArg_1 =
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
        [ Elm.int padLeftArg_, Elm.char padLeftArg_0, Elm.string padLeftArg_1 ]


{-| Pad a string on the right until it has a given length.

    padRight 5 '.' "1"   == "1...."
    padRight 5 '.' "11"  == "11..."
    padRight 5 '.' "121" == "121.."

padRight: Int -> Char.Char -> String -> String
-}
padRight : Int -> Char.Char -> String -> Elm.Expression
padRight padRightArg_ padRightArg_0 padRightArg_1 =
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
        [ Elm.int padRightArg_
        , Elm.char padRightArg_0
        , Elm.string padRightArg_1
        ]


{-| Get rid of whitespace on both sides of a string.

    trim "  hats  \n" == "hats"

trim: String -> String
-}
trim : String -> Elm.Expression
trim trimArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "trim"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string trimArg_ ]


{-| Get rid of whitespace on the left of a string.

    trimLeft "  hats  \n" == "hats  \n"

trimLeft: String -> String
-}
trimLeft : String -> Elm.Expression
trimLeft trimLeftArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "trimLeft"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string trimLeftArg_ ]


{-| Get rid of whitespace on the right of a string.

    trimRight "  hats  \n" == "  hats"

trimRight: String -> String
-}
trimRight : String -> Elm.Expression
trimRight trimRightArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "String" ]
             , name = "trimRight"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string trimRightArg_ ]


{-| Transform every character in a string

    map (\c -> if c == '/' then '.' else c) "a/b/c" == "a.b.c"

map: (Char.Char -> Char.Char) -> String -> String
-}
map : (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
map mapArg_ mapArg_0 =
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
        [ Elm.functionReduced "mapUnpack" mapArg_, Elm.string mapArg_0 ]


{-| Keep only the characters that pass the test.

    filter isDigit "R2-D2" == "22"

filter: (Char.Char -> Bool) -> String -> String
-}
filter : (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
filter filterArg_ filterArg_0 =
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
        [ Elm.functionReduced "filterUnpack" filterArg_
        , Elm.string filterArg_0
        ]


{-| Reduce a string from the left.

    foldl cons "" "time" == "emit"

foldl: (Char.Char -> b -> b) -> b -> String -> b
-}
foldl :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> String
    -> Elm.Expression
foldl foldlArg_ foldlArg_0 foldlArg_1 =
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
            "foldlUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (foldlArg_ functionReducedUnpack)
            )
        , foldlArg_0
        , Elm.string foldlArg_1
        ]


{-| Reduce a string from the right.

    foldr cons "" "time" == "time"

foldr: (Char.Char -> b -> b) -> b -> String -> b
-}
foldr :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> String
    -> Elm.Expression
foldr foldrArg_ foldrArg_0 foldrArg_1 =
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
            "foldrUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (foldrArg_ functionReducedUnpack)
            )
        , foldrArg_0
        , Elm.string foldrArg_1
        ]


{-| Determine whether *any* characters pass the test.

    any isDigit "90210" == True
    any isDigit "R2-D2" == True
    any isDigit "heart" == False

any: (Char.Char -> Bool) -> String -> Bool
-}
any : (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
any anyArg_ anyArg_0 =
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
        [ Elm.functionReduced "anyUnpack" anyArg_, Elm.string anyArg_0 ]


{-| Determine whether *all* characters pass the test.

    all isDigit "90210" == True
    all isDigit "R2-D2" == False
    all isDigit "heart" == False

all: (Char.Char -> Bool) -> String -> Bool
-}
all : (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
all allArg_ allArg_0 =
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
        [ Elm.functionReduced "allUnpack" allArg_, Elm.string allArg_0 ]


annotation_ : { string : Type.Annotation }
annotation_ =
    { string = Type.namedWith [] "String" [] }


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
        \isEmptyArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "isEmpty"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.bool)
                     }
                )
                [ isEmptyArg_ ]
    , length =
        \lengthArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "length"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.int)
                     }
                )
                [ lengthArg_ ]
    , reverse =
        \reverseArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "reverse"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ reverseArg_ ]
    , repeat =
        \repeatArg_ repeatArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "repeat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.string ]
                                  Type.string
                             )
                     }
                )
                [ repeatArg_, repeatArg_0 ]
    , replace =
        \replaceArg_ replaceArg_0 replaceArg_1 ->
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
                [ replaceArg_, replaceArg_0, replaceArg_1 ]
    , append =
        \appendArg_ appendArg_0 ->
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
                [ appendArg_, appendArg_0 ]
    , concat =
        \concatArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "concat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string ]
                                  Type.string
                             )
                     }
                )
                [ concatArg_ ]
    , split =
        \splitArg_ splitArg_0 ->
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
                [ splitArg_, splitArg_0 ]
    , join =
        \joinArg_ joinArg_0 ->
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
                [ joinArg_, joinArg_0 ]
    , words =
        \wordsArg_ ->
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
                [ wordsArg_ ]
    , lines =
        \linesArg_ ->
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
                [ linesArg_ ]
    , slice =
        \sliceArg_ sliceArg_0 sliceArg_1 ->
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
                [ sliceArg_, sliceArg_0, sliceArg_1 ]
    , left =
        \leftArg_ leftArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "left"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.string ]
                                  Type.string
                             )
                     }
                )
                [ leftArg_, leftArg_0 ]
    , right =
        \rightArg_ rightArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "right"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.string ]
                                  Type.string
                             )
                     }
                )
                [ rightArg_, rightArg_0 ]
    , dropLeft =
        \dropLeftArg_ dropLeftArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "dropLeft"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.string ]
                                  Type.string
                             )
                     }
                )
                [ dropLeftArg_, dropLeftArg_0 ]
    , dropRight =
        \dropRightArg_ dropRightArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "dropRight"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int, Type.string ]
                                  Type.string
                             )
                     }
                )
                [ dropRightArg_, dropRightArg_0 ]
    , contains =
        \containsArg_ containsArg_0 ->
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
                [ containsArg_, containsArg_0 ]
    , startsWith =
        \startsWithArg_ startsWithArg_0 ->
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
                [ startsWithArg_, startsWithArg_0 ]
    , endsWith =
        \endsWithArg_ endsWithArg_0 ->
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
                [ endsWithArg_, endsWithArg_0 ]
    , indexes =
        \indexesArg_ indexesArg_0 ->
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
                [ indexesArg_, indexesArg_0 ]
    , indices =
        \indicesArg_ indicesArg_0 ->
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
                [ indicesArg_, indicesArg_0 ]
    , toInt =
        \toIntArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "toInt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.maybe Type.int)
                             )
                     }
                )
                [ toIntArg_ ]
    , fromInt =
        \fromIntArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "fromInt"
                     , annotation =
                         Just (Type.function [ Type.int ] Type.string)
                     }
                )
                [ fromIntArg_ ]
    , toFloat =
        \toFloatArg_ ->
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
                [ toFloatArg_ ]
    , fromFloat =
        \fromFloatArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "fromFloat"
                     , annotation =
                         Just (Type.function [ Type.float ] Type.string)
                     }
                )
                [ fromFloatArg_ ]
    , fromChar =
        \fromCharArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "fromChar"
                     , annotation =
                         Just (Type.function [ Type.char ] Type.string)
                     }
                )
                [ fromCharArg_ ]
    , cons =
        \consArg_ consArg_0 ->
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
                [ consArg_, consArg_0 ]
    , uncons =
        \unconsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "uncons"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.maybe (Type.tuple Type.char Type.string)
                                  )
                             )
                     }
                )
                [ unconsArg_ ]
    , toList =
        \toListArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "toList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.list Type.char)
                             )
                     }
                )
                [ toListArg_ ]
    , fromList =
        \fromListArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "fromList"
                     , annotation =
                         Just
                             (Type.function [ Type.list Type.char ] Type.string)
                     }
                )
                [ fromListArg_ ]
    , toUpper =
        \toUpperArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "toUpper"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ toUpperArg_ ]
    , toLower =
        \toLowerArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "toLower"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ toLowerArg_ ]
    , pad =
        \padArg_ padArg_0 padArg_1 ->
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
                [ padArg_, padArg_0, padArg_1 ]
    , padLeft =
        \padLeftArg_ padLeftArg_0 padLeftArg_1 ->
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
                [ padLeftArg_, padLeftArg_0, padLeftArg_1 ]
    , padRight =
        \padRightArg_ padRightArg_0 padRightArg_1 ->
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
                [ padRightArg_, padRightArg_0, padRightArg_1 ]
    , trim =
        \trimArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "trim"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ trimArg_ ]
    , trimLeft =
        \trimLeftArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "trimLeft"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ trimLeftArg_ ]
    , trimRight =
        \trimRightArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "String" ]
                     , name = "trimRight"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ trimRightArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
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
                [ mapArg_, mapArg_0 ]
    , filter =
        \filterArg_ filterArg_0 ->
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
                [ filterArg_, filterArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
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
                [ foldlArg_, foldlArg_0, foldlArg_1 ]
    , foldr =
        \foldrArg_ foldrArg_0 foldrArg_1 ->
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
                [ foldrArg_, foldrArg_0, foldrArg_1 ]
    , any =
        \anyArg_ anyArg_0 ->
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
                [ anyArg_, anyArg_0 ]
    , all =
        \allArg_ allArg_0 ->
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
                [ allArg_, allArg_0 ]
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