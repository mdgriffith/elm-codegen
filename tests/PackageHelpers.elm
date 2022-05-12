module PackageHelpers exposing (suite)

import Elm
import Elm.Annotation as Type
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Gen.Maybe
import Internal.Compiler as Compiler
import Test exposing (..)


successfullyInferredType expression =
    let
        ( _, details ) =
            Compiler.toExpressionDetails Compiler.startIndex expression
    in
    case details.annotation of
        Ok _ ->
            Expect.pass

        Err errs ->
            Expect.fail
                ("Failed to typecheck"
                    ++ String.join "\n"
                        (List.map Compiler.inferenceErrorToString errs)
                )


renderedAs expression str =
    Expect.equal
        (Elm.toString expression)
        str


declarationAs decl str =
    Expect.equal
        (Elm.declarationToString decl)
        str


suite : Test
suite =
    only <|
        describe "Package helpers"
            [ test "Strings" <|
                \_ ->
                    Expect.equal
                        (Gen.Maybe.make_.just (Elm.int 5))
                        (Elm.just (Elm.int 5))
            ]
