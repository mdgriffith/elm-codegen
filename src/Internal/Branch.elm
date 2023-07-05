module Internal.Branch exposing (Branch, Pattern(..), map, pattern)

import Elm exposing (Expression)
import Elm.Syntax.Pattern
import Internal.Index as Index


{-| -}
type alias Branch =
    Pattern Expression


type Pattern a
    = Branch (Index.Index -> ( Index.Index, Elm.Syntax.Pattern.Pattern, a ))


pattern : Elm.Syntax.Pattern.Pattern -> a -> Pattern a
pattern patt val =
    Branch
        (\index ->
            ( index, patt, val )
        )


map : (a -> b) -> Pattern a -> Pattern b
map fn (Branch branch) =
    Branch
        (\index ->
            let
                ( newIndex, patt, val ) =
                    branch index
            in
            ( newIndex, patt, fn val )
        )
