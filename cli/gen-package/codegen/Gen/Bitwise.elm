module Gen.Bitwise exposing
    ( and
    , call_
    , complement
    , moduleName_
    , or
    , shiftLeftBy
    , shiftRightBy
    , shiftRightZfBy
    , values_
    , xor
    )

{-|
# Generated bindings for Bitwise

@docs moduleName_, and, or, xor, complement, shiftLeftBy, shiftRightBy, shiftRightZfBy, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Bitwise" ]


{-| Bitwise AND

and: Int -> Int -> Int
-}
and : Int -> Int -> Elm.Expression
and andArg_ andArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "and"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int andArg_, Elm.int andArg_0 ]


{-| Bitwise OR

or: Int -> Int -> Int
-}
or : Int -> Int -> Elm.Expression
or orArg_ orArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "or"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int orArg_, Elm.int orArg_0 ]


{-| Bitwise XOR

xor: Int -> Int -> Int
-}
xor : Int -> Int -> Elm.Expression
xor xorArg_ xorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "xor"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int xorArg_, Elm.int xorArg_0 ]


{-| Flip each bit individually, often called bitwise NOT

complement: Int -> Int
-}
complement : Int -> Elm.Expression
complement complementArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "complement"
             , annotation = Just (Type.function [ Type.int ] Type.int)
             }
        )
        [ Elm.int complementArg_ ]


{-| Shift bits to the left by a given offset, filling new bits with zeros.
This can be used to multiply numbers by powers of two.

    shiftLeftBy 1 5 == 10
    shiftLeftBy 5 1 == 32

shiftLeftBy: Int -> Int -> Int
-}
shiftLeftBy : Int -> Int -> Elm.Expression
shiftLeftBy shiftLeftByArg_ shiftLeftByArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "shiftLeftBy"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int shiftLeftByArg_, Elm.int shiftLeftByArg_0 ]


{-| Shift bits to the right by a given offset, filling new bits with
whatever is the topmost bit. This can be used to divide numbers by powers of two.

    shiftRightBy 1  32 == 16
    shiftRightBy 2  32 == 8
    shiftRightBy 1 -32 == -16

This is called an [arithmetic right shift][ars], often written `>>`, and
sometimes called a sign-propagating right shift because it fills empty spots
with copies of the highest bit.

[ars]: https://en.wikipedia.org/wiki/Bitwise_operation#Arithmetic_shift

shiftRightBy: Int -> Int -> Int
-}
shiftRightBy : Int -> Int -> Elm.Expression
shiftRightBy shiftRightByArg_ shiftRightByArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "shiftRightBy"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int shiftRightByArg_, Elm.int shiftRightByArg_0 ]


{-| Shift bits to the right by a given offset, filling new bits with zeros.

    shiftRightZfBy 1  32 == 16
    shiftRightZfBy 2  32 == 8
    shiftRightZfBy 1 -32 == 2147483632

This is called an [logical right shift][lrs], often written `>>>`, and
sometimes called a zero-fill right shift because it fills empty spots with
zeros.

[lrs]: https://en.wikipedia.org/wiki/Bitwise_operation#Logical_shift

shiftRightZfBy: Int -> Int -> Int
-}
shiftRightZfBy : Int -> Int -> Elm.Expression
shiftRightZfBy shiftRightZfByArg_ shiftRightZfByArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Bitwise" ]
             , name = "shiftRightZfBy"
             , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
             }
        )
        [ Elm.int shiftRightZfByArg_, Elm.int shiftRightZfByArg_0 ]


call_ :
    { and : Elm.Expression -> Elm.Expression -> Elm.Expression
    , or : Elm.Expression -> Elm.Expression -> Elm.Expression
    , xor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , complement : Elm.Expression -> Elm.Expression
    , shiftLeftBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , shiftRightBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , shiftRightZfBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { and =
        \andArg_ andArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "and"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ andArg_, andArg_0 ]
    , or =
        \orArg_ orArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "or"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ orArg_, orArg_0 ]
    , xor =
        \xorArg_ xorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "xor"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ xorArg_, xorArg_0 ]
    , complement =
        \complementArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "complement"
                     , annotation = Just (Type.function [ Type.int ] Type.int)
                     }
                )
                [ complementArg_ ]
    , shiftLeftBy =
        \shiftLeftByArg_ shiftLeftByArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "shiftLeftBy"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ shiftLeftByArg_, shiftLeftByArg_0 ]
    , shiftRightBy =
        \shiftRightByArg_ shiftRightByArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "shiftRightBy"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ shiftRightByArg_, shiftRightByArg_0 ]
    , shiftRightZfBy =
        \shiftRightZfByArg_ shiftRightZfByArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bitwise" ]
                     , name = "shiftRightZfBy"
                     , annotation =
                         Just (Type.function [ Type.int, Type.int ] Type.int)
                     }
                )
                [ shiftRightZfByArg_, shiftRightZfByArg_0 ]
    }


values_ :
    { and : Elm.Expression
    , or : Elm.Expression
    , xor : Elm.Expression
    , complement : Elm.Expression
    , shiftLeftBy : Elm.Expression
    , shiftRightBy : Elm.Expression
    , shiftRightZfBy : Elm.Expression
    }
values_ =
    { and =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "and"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , or =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "or"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , xor =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "xor"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , complement =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "complement"
            , annotation = Just (Type.function [ Type.int ] Type.int)
            }
    , shiftLeftBy =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "shiftLeftBy"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , shiftRightBy =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "shiftRightBy"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , shiftRightZfBy =
        Elm.value
            { importFrom = [ "Bitwise" ]
            , name = "shiftRightZfBy"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    }