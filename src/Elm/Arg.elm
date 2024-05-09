module Elm.Arg exposing
    ( Arg, unit, var, varWith
    , tuple, triple
    , record, field
    , Expression
    )

{-|

@docs Arg, unit, var, varWith

@docs tuple, triple

@docs record, field

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
tuple : Arg Expression -> Arg Expression -> Arg ( Expression, Expression )
tuple =
    Internal.Arg.tuple


{-| -}
triple : Arg Expression -> Arg Expression -> Arg Expression -> Arg ( Expression, Expression, Expression )
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
