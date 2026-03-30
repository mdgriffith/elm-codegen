module ReviewConfig exposing (config)

{-| elm-review rules for property-test generated code.

These rules assert properties that elm-codegen should always satisfy
when generating code through its public API.

-}

import NoMissingTypeAnnotation
import Review.Rule exposing (Rule)


config : List Rule
config =
    [ -- Every top-level declaration should have a type annotation.
      -- elm-codegen infers types for all declarations, so if one is
      -- missing, that's a bug.
      NoMissingTypeAnnotation.rule
    ]
