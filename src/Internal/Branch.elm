module Internal.Branch exposing (Branch, Pattern(..))

import Elm exposing (Expression)
import Elm.Syntax.Pattern
import Internal.Index as Index


{-| -}
type alias Branch =
    Pattern Expression


type Pattern a
    = Branch (Index.Index -> ( Index.Index, Elm.Syntax.Pattern.Pattern, a ))
