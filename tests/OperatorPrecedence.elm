module OperatorPrecedence exposing (get, operators)

import Elm
import Elm.Annotation as Type
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
                Elm.Expect.renderedAs (Elm.get "field" (todo "todo"))
                    """(Debug.todo "todo").field"""
        , test "Works correctly if the argument is a value" <|
            \_ ->
                Elm.Expect.renderedAs (Elm.get "field" valueTodo)
                    """Debug.todo.field"""
        , test "Works correctly if the argument is a record" <|
            \_ ->
                Elm.Expect.renderedAs (Elm.get "field" (Elm.record []))
                    """{}.field"""
        , test "Works correctly if the argument is a record update" <|
            \_ ->
                Elm.Expect.renderedAs (Elm.get "field" (Elm.updateRecord [ ( "bar", Elm.int 3 ) ] (Elm.val "foo")))
                    """{ foo | bar = 3 }.field"""
        , test "Works correctly if the argument is a field" <|
            \_ ->
                Elm.Expect.renderedAs (Elm.get "field2" (Elm.get "field1" (Elm.record [])))
                    """{}.field1.field2"""
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
                Elm.Expect.renderedAs (plus (plus two three) five)
                    """2 + 3 + 5"""
        , test "(2 * 3) * 5" <|
            \_ ->
                Elm.Expect.renderedAs (multiply (multiply two three) five)
                    """2 * 3 * 5"""
        , test "(2 + 3) * 5" <|
            \_ ->
                Elm.Expect.renderedAs (multiply (plus two three) five)
                    """(2 + 3) * 5"""
        , test "(2 * 3) + 5" <|
            \_ ->
                Elm.Expect.renderedAs (plus (multiply two three) five)
                    """2 * 3 + 5"""
        , test "2 + (3 * 5)" <|
            \_ ->
                Elm.Expect.renderedAs (plus two (multiply three five))
                    """2 + 3 * 5"""
        , test "2 * (3 + 5)" <|
            \_ ->
                Elm.Expect.renderedAs (multiply two (plus three five))
                    """2 * (3 + 5)"""
        , test "(2 + 3) + (3 + 5)" <|
            \_ ->
                Elm.Expect.renderedAs (plus (plus two three) (plus three five))
                    "2 + 3 + (3 + 5)"
        , test "(2 == 3) == (3 == 5)" <|
            \_ ->
                Elm.Expect.renderedAs (equal (equal two three) (equal three five))
                    "(2 == 3) == (3 == 5)"
        , test "2 || (3 || 5)" <|
            \_ ->
                Elm.Expect.renderedAs (or two (or three five))
                    "2 || 3 || 5"
        , test "(2 || 3) || 5" <|
            \_ ->
                Elm.Expect.renderedAs (or (or two three) five)
                    "(2 || 3) || 5"
        ]
