module Elm.Debug exposing (annotation)

{-| -}

import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler


type alias Expression =
    Compiler.Expression


{-| Print out what elm-prefab thinks the type signature is at any given point.
-}
annotation :
    (String
     -> Result (List Compiler.InferenceError) Annotation.TypeAnnotation
     -> Result (List Compiler.InferenceError) Annotation.TypeAnnotation
    )
    -> String
    -> Expression
    -> Expression
annotation debugLog tag exp =
    let
        _ =
            case exp of
                Compiler.Expression expres ->
                    debugLog tag expres.annotation
    in
    exp
