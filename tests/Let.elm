module Let exposing (suite)

import Dict
import Elm
import Elm.Annotation as Type
import Elm.Let
import Elm.Op
import Elm.ToString
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Gen.Element
import Gen.Maybe
import Internal.Compiler as Compiler
import Internal.Debug
import Internal.Write
import Test exposing (..)


renderedAs : Elm.Expression -> String -> Expectation
renderedAs expression str =
    Expect.equal
        (Elm.ToString.expression expression
            |> .body
        )
        (String.trim str)


suite =
    describe "Let bindings"
        [ test "Simple" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\one two ->
                            Elm.Op.append one two
                        )
                        |> Elm.Let.value "one" (Elm.string "Hello")
                        |> Elm.Let.value "two" (Elm.string "World!")
                        |> Elm.Let.toExpression
                    )
                    """
let
    one =
        "Hello"

    two =
        "World!"
in
one ++ two
                    """
        , test "Nested lets will merge in to one" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\one two ->
                            Elm.Let.letIn
                                (\three four ->
                                    Elm.tuple
                                        (Elm.Op.append one two)
                                        (Elm.Op.append three four)
                                )
                                |> Elm.Let.value "three" (Elm.string "and")
                                |> Elm.Let.value "four" (Elm.string "the moon")
                                |> Elm.Let.toExpression
                        )
                        |> Elm.Let.value "one" (Elm.string "Hello")
                        |> Elm.Let.value "two" (Elm.string "World!")
                        |> Elm.Let.toExpression
                    )
                    """
let
    one =
        "Hello"

    two =
        "World!"

    three =
        "and"

    four =
        "the moon"
in
( one ++ two, three ++ four )
                    """
        , test "Tuples" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\( first, second ) ->
                            Elm.Op.append first second
                        )
                        |> Elm.Let.tuple "first" "second" (Elm.tuple (Elm.string "Hello") (Elm.string "World!"))
                        |> Elm.Let.toExpression
                    )
                    """
let
    ( first, second ) =
        ( "Hello", "World!" )
in
first ++ second
                    """
        , test "Records" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\fields ->
                            case fields of
                                [ first, second ] ->
                                    Elm.Op.append first second

                                _ ->
                                    Elm.unit
                        )
                        |> Elm.Let.record [ "first", "second" ]
                            (Elm.record
                                [ ( "first", Elm.string "Hello" )
                                , ( "second", Elm.string "world!" )
                                ]
                            )
                        |> Elm.Let.toExpression
                    )
                    """
let
    { first, second } =
        { first = "Hello", second = "world!" }
in
first ++ second
                    """
        , test "Elm.fn" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\myFn ->
                            Elm.apply myFn [ Elm.bool True ]
                        )
                        |> Elm.Let.value "myFn"
                            (Elm.fn
                                ( "arg", Just Type.bool )
                                (\arg ->
                                    Elm.ifThen arg
                                        (Elm.string "True")
                                        (Elm.string "False")
                                )
                            )
                        |> Elm.Let.toExpression
                    )
                    """
let
    myFn arg =
        if arg then
            "True"

        else
            "False"
in
myFn True
                    """
        , test "Function" <|
            \_ ->
                renderedAs
                    (Elm.Let.letIn
                        (\myFn ->
                            myFn (Elm.bool True)
                        )
                        |> Elm.Let.fn "myFn"
                            ( "arg", Just Type.bool )
                            (\arg ->
                                Elm.ifThen arg
                                    (Elm.string "True")
                                    (Elm.string "False")
                            )
                        |> Elm.Let.toExpression
                    )
                    """
let
    myFn arg =
        if arg then
            "True"

        else
            "False"
in
myFn True
                    """
        ]
