module OperatorPrecedence exposing (get, operators, pipes)

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Expect
import Elm.Op exposing (equal, multiply, or, plus)
import Test exposing (Test, describe, test)


todo : String -> Elm.Expression
todo todoArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Debug" ]
            , name = "todo"
            , annotation = Just (Type.function [ Type.string ] (Type.var "a"))
            }
        )
        [ Elm.string todoArg ]


valueTodo : Elm.Expression
valueTodo =
    Elm.value
        { importFrom = [ "Debug" ]
        , name = "todo"
        , annotation = Just (Type.function [ Type.string ] (Type.var "a"))
        }


get : Test
get =
    describe "Elm.get"
        [ test "Works correctly if the argument is a function call" <|
            \_ ->
                Elm.get "field" (todo "todo")
                    |> Elm.Expect.renderedAs """(Debug.todo "todo").field"""
        , test "Works correctly if the argument is a value" <|
            \_ ->
                Elm.get "field" valueTodo
                    |> Elm.Expect.renderedAs """Debug.todo.field"""
        , test "Works correctly if the argument is a record" <|
            \_ ->
                Elm.get "field" (Elm.record [])
                    |> Elm.Expect.renderedAs """{}.field"""
        , test "Works correctly if the argument is a record update" <|
            \_ ->
                Elm.get "field" (Elm.updateRecord [ ( "bar", Elm.int 3 ) ] (Elm.val "foo"))
                    |> Elm.Expect.renderedAs """{ foo | bar = 3 }.field"""
        , test "Works correctly if the argument is a field" <|
            \_ ->
                Elm.get "field2" (Elm.get "field1" (Elm.record []))
                    |> Elm.Expect.renderedAs """{}.field1.field2"""
        ]


operators : Test
operators =
    let
        two : Elm.Expression
        two =
            Elm.int 2

        three : Elm.Expression
        three =
            Elm.int 3

        five : Elm.Expression
        five =
            Elm.int 5
    in
    describe "+ and *"
        [ test "(2 + 3) + 5" <|
            \_ ->
                plus (plus two three) five
                    |> Elm.Expect.renderedAs """2 + 3 + 5"""
        , test "(2 * 3) * 5" <|
            \_ ->
                multiply (multiply two three) five
                    |> Elm.Expect.renderedAs """2 * 3 * 5"""
        , test "(2 + 3) * 5" <|
            \_ ->
                multiply (plus two three) five
                    |> Elm.Expect.renderedAs """(2 + 3) * 5"""
        , test "(2 * 3) + 5" <|
            \_ ->
                plus (multiply two three) five
                    |> Elm.Expect.renderedAs """2 * 3 + 5"""
        , test "2 + (3 * 5)" <|
            \_ ->
                plus two (multiply three five)
                    |> Elm.Expect.renderedAs """2 + 3 * 5"""
        , test "2 * (3 + 5)" <|
            \_ ->
                multiply two (plus three five)
                    |> Elm.Expect.renderedAs """2 * (3 + 5)"""
        , test "(2 + 3) + (3 + 5)" <|
            \_ ->
                plus (plus two three) (plus three five)
                    |> Elm.Expect.renderedAs "2 + 3 + (3 + 5)"
        , test "(2 == 3) == (3 == 5)" <|
            \_ ->
                equal (equal two three) (equal three five)
                    |> Elm.Expect.renderedAs "(2 == 3) == (3 == 5)"
        , test "2 || (3 || 5)" <|
            \_ ->
                or two (or three five)
                    |> Elm.Expect.renderedAs "2 || 3 || 5"
        , test "(2 || 3) || 5" <|
            \_ ->
                or (or two three) five
                    |> Elm.Expect.renderedAs "(2 || 3) || 5"
        ]


pipes : Test
pipes =
    describe "|> with lambdas"
        [ test "Pipe into lambda is parenthesized" <|
            \_ ->
                Elm.string "hello"
                    |> Elm.Op.pipe
                        (Elm.fn (Elm.Arg.var "x") (\x -> x))
                    |> Elm.Expect.renderedAs
                        """"hello" |> (\\x -> x)"""
        , test "Chained pipes into lambdas are each parenthesized" <|
            \_ ->
                Elm.string "hello"
                    |> Elm.Op.pipe
                        (Elm.fn (Elm.Arg.var "x") (\x -> x))
                    |> Elm.Op.pipe
                        (Elm.fn (Elm.Arg.var "y") (\y -> y))
                    |> Elm.Expect.renderedAs
                        """"hello" |> (\\x -> x) |> (\\y -> y)"""
        , test "pipeLeft with lambda is parenthesized" <|
            \_ ->
                Elm.Op.pipeLeft
                    (Elm.fn (Elm.Arg.var "x") (\x -> x))
                    (Elm.string "hello")
                    |> Elm.Expect.renderedAs
                        """(\\x -> x) <| "hello\""""
        , test "pipeLeft with lambda applied to complex expression" <|
            \_ ->
                Elm.Op.pipeLeft
                    (Elm.fn (Elm.Arg.var "x")
                        (\x -> Elm.Op.append x (Elm.string "!"))
                    )
                    (Elm.string "hello")
                    |> Elm.Expect.renderedAs
                        """(\\x -> x ++ "!") <| "hello\""""
        ]
