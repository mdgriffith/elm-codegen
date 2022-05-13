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


equal one two =
    Expect.equal (Elm.toString one)
        (Elm.toString two)


suite : Test
suite =
    only <|
        describe "Package helpers"
            [ test "Make_ is equivalent to top-level just constructor" <|
                \_ ->
                    equal
                        (Gen.Maybe.make_.just (Elm.int 5))
                        (Elm.just (Elm.int 5))
            , test "Elm.withAlias needs to unify stuff" <|
                \_ ->
                    Expect.fail "Not implemented"
            , test "Lambds in records with have diff arg typevar names" <|
                \_ ->
                    Expect.equal
                        (Elm.record
                            [ Elm.fn "arg"
                                (\arg ->
                                    Elm.plus arg (Elm.int 5)
                                )
                                |> Elm.field "one"
                            , Elm.fn "arg"
                                (\arg ->
                                    Elm.append arg (Elm.string "World")
                                )
                                |> Elm.field "two"
                            ]
                            |> Elm.declaration "test"
                            |> Elm.declarationToString
                        )
                        """test : { one : Int -> Int, two : String -> String }
test =
    { one = \\arg -> arg + 5, two = \\arg -> arg ++ "World" }"""
            ]
