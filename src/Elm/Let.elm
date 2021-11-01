module Elm.Let exposing
    ( Declaration, value, destructure
    , function
    )

{-|

@docs Declaration, value, destructure

@docs function

-}

import Elm.Pattern as Pattern exposing (Pattern)
import Elm.Syntax.Expression as Exp
import Internal.Compiler as Util


type alias Expression generated =
    Util.Expression generated


{-| -}
type alias Declaration =
    Util.LetDeclaration


{-| -}
value : String -> Expression a -> Declaration
value name exp =
    destructure (Pattern.var name) exp


{-| -}
destructure : Pattern -> Expression a -> Declaration
destructure pattern (Util.Expression expr) =
    Util.LetDeclaration expr.imports
        (Exp.LetDestructuring (Util.nodify pattern)
            (Util.nodify expr.expression)
        )


{-| -}
function : String -> List Pattern -> Expression a -> Declaration
function name args (Util.Expression body) =
    Util.LetDeclaration body.imports
        (Exp.LetFunction
            { documentation = Util.nodifyMaybe Nothing
            , signature =
                case body.annotation of
                    Ok sig ->
                        Just
                            (Util.nodify
                                { name = Util.nodify name
                                , typeAnnotation = Util.nodify sig
                                }
                            )

                    Err _ ->
                        Util.nodifyMaybe Nothing
            , declaration =
                Util.nodify
                    { name = Util.nodify name
                    , arguments = Util.nodifyAll args
                    , expression = Util.nodify body.expression
                    }
            }
        )
