module Gen.Char exposing (annotation_, call_, fromCode, isAlpha, isAlphaNum, isDigit, isHexDigit, isLower, isOctDigit, isUpper, moduleName_, toCode, toLocaleLower, toLocaleUpper, toLower, toUpper, values_)

{-| 
@docs moduleName_, isUpper, isLower, isAlpha, isAlphaNum, isDigit, isOctDigit, isHexDigit, toUpper, toLower, toLocaleUpper, toLocaleLower, toCode, fromCode, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Char" ]


{-| Detect upper case ASCII characters.

    isUpper 'A' == True
    isUpper 'B' == True
    ...
    isUpper 'Z' == True

    isUpper '0' == False
    isUpper 'a' == False
    isUpper '-' == False
    isUpper 'Σ' == False
-}
isUpper : Elm.Expression -> Elm.Expression
isUpper arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isUpper"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect lower case ASCII characters.

    isLower 'a' == True
    isLower 'b' == True
    ...
    isLower 'z' == True

    isLower '0' == False
    isLower 'A' == False
    isLower '-' == False
    isLower 'π' == False
-}
isLower : Elm.Expression -> Elm.Expression
isLower arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isLower"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect upper case and lower case ASCII characters.

    isAlpha 'a' == True
    isAlpha 'b' == True
    isAlpha 'E' == True
    isAlpha 'Y' == True

    isAlpha '0' == False
    isAlpha '-' == False
    isAlpha 'π' == False
-}
isAlpha : Elm.Expression -> Elm.Expression
isAlpha arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isAlpha"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect upper case and lower case ASCII characters.

    isAlphaNum 'a' == True
    isAlphaNum 'b' == True
    isAlphaNum 'E' == True
    isAlphaNum 'Y' == True
    isAlphaNum '0' == True
    isAlphaNum '7' == True

    isAlphaNum '-' == False
    isAlphaNum 'π' == False
-}
isAlphaNum : Elm.Expression -> Elm.Expression
isAlphaNum arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isAlphaNum"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect digits `0123456789`

    isDigit '0' == True
    isDigit '1' == True
    ...
    isDigit '9' == True

    isDigit 'a' == False
    isDigit 'b' == False
    isDigit 'A' == False
-}
isDigit : Elm.Expression -> Elm.Expression
isDigit arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect octal digits `01234567`

    isOctDigit '0' == True
    isOctDigit '1' == True
    ...
    isOctDigit '7' == True

    isOctDigit '8' == False
    isOctDigit 'a' == False
    isOctDigit 'A' == False
-}
isOctDigit : Elm.Expression -> Elm.Expression
isOctDigit arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isOctDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Detect hexadecimal digits `0123456789abcdefABCDEF`
-}
isHexDigit : Elm.Expression -> Elm.Expression
isHexDigit arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "isHexDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
        )
        [ arg1 ]


{-| Convert to upper case. -}
toUpper : Elm.Expression -> Elm.Expression
toUpper arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
        )
        [ arg1 ]


{-| Convert to lower case. -}
toLower : Elm.Expression -> Elm.Expression
toLower arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
        )
        [ arg1 ]


{-| Convert to upper case, according to any locale-specific case mappings. -}
toLocaleUpper : Elm.Expression -> Elm.Expression
toLocaleUpper arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "toLocaleUpper"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
        )
        [ arg1 ]


{-| Convert to lower case, according to any locale-specific case mappings. -}
toLocaleLower : Elm.Expression -> Elm.Expression
toLocaleLower arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "toLocaleLower"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
        )
        [ arg1 ]


{-| Convert to the corresponding Unicode [code point][cp].

[cp]: https://en.wikipedia.org/wiki/Code_point

    toCode 'A' == 65
    toCode 'B' == 66
    toCode '木' == 0x6728
    toCode '𝌆' == 0x1D306
    toCode '😃' == 0x1F603
-}
toCode : Elm.Expression -> Elm.Expression
toCode arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "toCode"
            , annotation = Just (Type.function [ Type.char ] Type.int)
            }
        )
        [ arg1 ]


{-| Convert a Unicode [code point][cp] to a character.

    fromCode 65      == 'A'
    fromCode 66      == 'B'
    fromCode 0x6728  == '木'
    fromCode 0x1D306 == '𝌆'
    fromCode 0x1F603 == '😃'
    fromCode -1      == '�'

The full range of unicode is from `0` to `0x10FFFF`. With numbers outside that
range, you get [the replacement character][fffd].

[cp]: https://en.wikipedia.org/wiki/Code_point
[fffd]: https://en.wikipedia.org/wiki/Specials_(Unicode_block)#Replacement_character
-}
fromCode : Elm.Expression -> Elm.Expression
fromCode arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Char" ]
            , name = "fromCode"
            , annotation = Just (Type.function [ Type.int ] Type.char)
            }
        )
        [ arg1 ]


annotation_ : { char : Type.Annotation }
annotation_ =
    { char = Type.namedWith moduleName_ "Char" [] }


call_ :
    { isUpper : Elm.Expression -> Elm.Expression
    , isLower : Elm.Expression -> Elm.Expression
    , isAlpha : Elm.Expression -> Elm.Expression
    , isAlphaNum : Elm.Expression -> Elm.Expression
    , isDigit : Elm.Expression -> Elm.Expression
    , isOctDigit : Elm.Expression -> Elm.Expression
    , isHexDigit : Elm.Expression -> Elm.Expression
    , toUpper : Elm.Expression -> Elm.Expression
    , toLower : Elm.Expression -> Elm.Expression
    , toLocaleUpper : Elm.Expression -> Elm.Expression
    , toLocaleLower : Elm.Expression -> Elm.Expression
    , toCode : Elm.Expression -> Elm.Expression
    , fromCode : Elm.Expression -> Elm.Expression
    }
call_ =
    { isUpper =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isUpper"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isLower =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isLower"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isAlpha =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isAlpha"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isAlphaNum =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isAlphaNum"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isDigit =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isDigit"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isOctDigit =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isOctDigit"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , isHexDigit =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "isHexDigit"
                    , annotation = Just (Type.function [ Type.char ] Type.bool)
                    }
                )
                [ arg1_0 ]
    , toUpper =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "toUpper"
                    , annotation = Just (Type.function [ Type.char ] Type.char)
                    }
                )
                [ arg1_0 ]
    , toLower =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "toLower"
                    , annotation = Just (Type.function [ Type.char ] Type.char)
                    }
                )
                [ arg1_0 ]
    , toLocaleUpper =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "toLocaleUpper"
                    , annotation = Just (Type.function [ Type.char ] Type.char)
                    }
                )
                [ arg1_0 ]
    , toLocaleLower =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "toLocaleLower"
                    , annotation = Just (Type.function [ Type.char ] Type.char)
                    }
                )
                [ arg1_0 ]
    , toCode =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "toCode"
                    , annotation = Just (Type.function [ Type.char ] Type.int)
                    }
                )
                [ arg1_0 ]
    , fromCode =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Char" ]
                    , name = "fromCode"
                    , annotation = Just (Type.function [ Type.int ] Type.char)
                    }
                )
                [ arg1_0 ]
    }


values_ :
    { isUpper : Elm.Expression
    , isLower : Elm.Expression
    , isAlpha : Elm.Expression
    , isAlphaNum : Elm.Expression
    , isDigit : Elm.Expression
    , isOctDigit : Elm.Expression
    , isHexDigit : Elm.Expression
    , toUpper : Elm.Expression
    , toLower : Elm.Expression
    , toLocaleUpper : Elm.Expression
    , toLocaleLower : Elm.Expression
    , toCode : Elm.Expression
    , fromCode : Elm.Expression
    }
values_ =
    { isUpper =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isUpper"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isLower =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isLower"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isAlpha =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isAlpha"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isAlphaNum =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isAlphaNum"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isDigit =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isOctDigit =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isOctDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , isHexDigit =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "isHexDigit"
            , annotation = Just (Type.function [ Type.char ] Type.bool)
            }
    , toUpper =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "toUpper"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
    , toLower =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "toLower"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
    , toLocaleUpper =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "toLocaleUpper"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
    , toLocaleLower =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "toLocaleLower"
            , annotation = Just (Type.function [ Type.char ] Type.char)
            }
    , toCode =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "toCode"
            , annotation = Just (Type.function [ Type.char ] Type.int)
            }
    , fromCode =
        Elm.value
            { importFrom = [ "Char" ]
            , name = "fromCode"
            , annotation = Just (Type.function [ Type.int ] Type.char)
            }
    }


