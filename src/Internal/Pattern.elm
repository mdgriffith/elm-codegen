module Internal.Pattern exposing (Pattern(..))

import Elm.Syntax.Pattern


type Pattern a
    = Pattern Elm.Syntax.Pattern.Pattern a
