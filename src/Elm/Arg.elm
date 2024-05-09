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
