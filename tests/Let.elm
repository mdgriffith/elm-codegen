module Let exposing (suite)

import Elm
import Elm.Annotation as Type
import Elm.Expect
import Elm.Let
import Elm.Op
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Let bindings"
        [ generation
        , imports
        ]


imports : Test
imports =
    describe "Import propagation"
        [ test "Simple" <|
            \_ ->
                Elm.Expect.importAs
                    (Elm.Let.letIn
                        (\one two ->
                            Elm.Op.append one two
                        )
                        |> Elm.Let.value "one"
                            (Elm.value
                                { importFrom = [ "Module" ]
                                , name = "constant"
                                , annotation = Nothing
                                }
                            )
                        |> Elm.Let.value "two" (Elm.string "World!")
                        |> Elm.Let.toExpression
                    )
                    "import Module"
        , test "Second" <|
            \_ ->
                Elm.Expect.importAs
                    (Elm.Let.letIn
                        (\one two ->
                            Elm.Op.append one two
                        )
                        |> Elm.Let.value "two" (Elm.string "World!")
                        |> Elm.Let.value "one"
                            (Elm.value
                                { importFrom = [ "Module" ]
                                , name = "constant"
                                , annotation = Nothing
                                }
                            )
                        |> Elm.Let.toExpression
                    )
                    "import Module"
        , test "Nested" <|
            \_ ->
                Elm.Expect.importAs
                    (Elm.Let.letIn
                        (\one two ->
                            Elm.Let.letIn
                                (\three four ->
                                    Elm.tuple
                                        (Elm.Op.append one two)
                                        (Elm.Op.append three four)
                                )
                                |> Elm.Let.value "three" (Elm.string "and")
                                |> Elm.Let.value "four"
                                    (Elm.value
                                        { importFrom = [ "Module" ]
                                        , name = "constant"
                                        , annotation = Nothing
                                        }
                                    )
                                |> Elm.Let.toExpression
                        )
                        |> Elm.Let.value "one" (Elm.string "Hello")
                        |> Elm.Let.value "two" (Elm.string "World!")
                        |> Elm.Let.toExpression
                    )
                    "import Module"
        ]


generation : Test
generation =
    describe "Generation"
        [ test "Simple" <|
            \_ ->
                Elm.Expect.renderedAs
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
                Elm.Expect.renderedAs
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
                Elm.Expect.renderedAs
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
                Elm.Expect.renderedAs
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
                Elm.Expect.renderedAs
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
                Elm.Expect.renderedAs
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
