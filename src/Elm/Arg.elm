module Elm.Arg exposing
    ( Arg, unit, var, varWith
    , tuple, triple
    , record, field
    , aliasAs
    , ignore, string, char
    , list, item, listRemaining
    , customType
    )

{-|

@docs Arg, unit, var, varWith

@docs tuple, triple

@docs record, field

@docs aliasAs


## Useful for case expressions

@docs ignore, string, char

@docs list, item, listRemaining

@docs customType

-}

import Elm.Annotation
import Internal.Arg
import Internal.Compiler as Compiler


{-| -}
type alias Expression =
    Compiler.Expression


{-| -}
type alias Arg val =
    Internal.Arg.Arg val


{-| -}
var : String -> Arg Expression
var =
    Internal.Arg.var


{-| -}
varWith : String -> Elm.Annotation.Annotation -> Arg Expression
varWith =
    Internal.Arg.varWith


{-| -}
unit : Arg Expression
unit =
    Internal.Arg.unit


{-| -}
aliasAs : String -> Arg arg -> Arg ( arg, Expression )
aliasAs =
    Internal.Arg.aliasAs


{-| -}
tuple : Arg one -> Arg two -> Arg ( one, two )
tuple =
    Internal.Arg.tuple


{-| -}
triple : Arg one -> Arg two -> Arg three -> Arg ( one, two, three )
triple =
    Internal.Arg.triple


{-| -}
record : fields -> Arg fields
record =
    Internal.Arg.record


{-| -}
field : String -> Arg (Expression -> a) -> Arg a
field =
    Internal.Arg.field


{-| -}
string : String -> Arg Expression
string =
    Internal.Arg.string


{-| -}
char : Char -> Arg Expression
char =
    Internal.Arg.char


{-| -}
ignore : Arg Expression
ignore =
    Internal.Arg.ignore


{-|

    Arg.list Tuple.pair
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")

Will genrate

    [ first, second ]

And

     Arg.list
        (\one two remaining ->
            { one = one
            , two = two
            , remaining = remaining
            }
        )
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")
        |> Arg.listRemaining "remaining"

Will generate

    first :: second :: remaining

-}
list : a -> Arg a
list =
    Internal.Arg.list


{-| -}
listRemaining : String -> Arg (Expression -> a) -> Arg a
listRemaining =
    Internal.Arg.listRemaining


{-| -}
item : Arg arg -> Arg (arg -> a) -> Arg a
item =
    Internal.Arg.item


{-|

    Arg.customType "MyCustomType" Tuple.pair
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")

Will generate

    MyCustomType first second

-}
customType : String -> a -> Arg a
customType =
    Internal.Arg.customType
