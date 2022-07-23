module PackageHelpers exposing (suite)

import Elm
import Elm.Annotation as Type
import Elm.Op
import Elm.ToString
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Gen.Maybe
import Internal.Compiler as Compiler
import Internal.Debug
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
        (Elm.ToString.expression expression
            |> .body
        )
        str


declarationAs decl str =
    Expect.equal
        (Elm.ToString.declaration decl
            |> .body
        )
        str


equal one two =
    Expect.equal
        (Elm.ToString.expression one
            |> .body
        )
        (Elm.ToString.expression two
            |> .body
        )


suite : Test
suite =
    describe "Package helpers"
        [ test "Make_ is equivalent to top-level just constructor" <|
            \_ ->
                equal
                    (Gen.Maybe.make_.just (Elm.int 5))
                    (Elm.just (Elm.int 5))
        , test "typevariables in functions within a record dnt pollute each other" <|
            \_ ->
                Expect.equal
                    (Elm.record
                        [ Elm.fn ( "arg", Nothing )
                            (\arg ->
                                Elm.Op.plus arg (Elm.int 5)
                            )
                            |> Tuple.pair "one"
                        , Elm.fn ( "arg", Nothing )
                            (\arg ->
                                Elm.Op.append arg (Elm.string "World")
                            )
                            |> Tuple.pair "two"
                        ]
                        |> (\d ->
                                let
                                    _ =
                                        Debug.log "   RECORD" (Internal.Debug.everything d)
                                in
                                d
                           )
                        |> Elm.declaration "test"
                        |> Elm.ToString.declaration
                        |> .body
                    )
                    """test : { one : Int -> Int, two : String -> String }
test =
    { one = \\arg -> arg + 5, two = \\arg -> arg ++ "World" }"""
        ]
