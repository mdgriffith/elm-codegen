module Pattern exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Arg as Arg
import Elm.Case
import Elm.Expect
import Elm.Op
import Elm.ToString
import Expect
import Internal.Compiler as Compiler
import Internal.Index as Index
import Set
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Case expressions"
        [ test "Simple" <|
            \() ->
                Elm.Expect.renderedAs
                    (Elm.Case.maybe Elm.nothing
                        { nothing = Elm.unit
                        , just = ( "_", \_ -> Elm.unit )
                        }
                    )
                    """case Nothing of
    Nothing ->
        ()

    Just _ ->
        ()"""
        , test "tuple destructuring" <|
            \() ->
                let
                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.tuple
                                (Elm.just (Elm.char 'a'))
                                (Elm.just (Elm.char 'b'))
                            )
                            (Type.maybe Type.int)
                            [ Elm.Case.branch
                                (Arg.tuple
                                    (Arg.customType "Just" identity
                                        |> Arg.item (Arg.char 'a')
                                    )
                                    (Arg.customType "Just" identity
                                        |> Arg.item (Arg.char 'b')
                                    )
                                )
                                (\( left, right ) ->
                                    Elm.int 5
                                )
                            , Elm.Case.branch
                                (Arg.tuple
                                    (Arg.customType "Just" identity
                                        |> Arg.item (Arg.var "left")
                                    )
                                    (Arg.customType "Just" identity
                                        |> Arg.item (Arg.var "right")
                                    )
                                )
                                (\( left, right ) ->
                                    Elm.int 8
                                )
                            , Elm.Case.branch Arg.ignore (\_ -> Elm.int 0)
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case ( Just 'a', Just 'b' ) of
    ( Just 'a', Just 'b' ) ->
        5

    ( Just left, Just right ) ->
        8

    _ ->
        0"""
        , test "triple" <|
            \() ->
                Elm.Case.custom (Elm.val "foo")
                    Type.unit
                    [ Elm.Case.branch
                        (Arg.triple Arg.unit (Arg.var "name") (Arg.char 'a'))
                        (\( _, _, _ ) ->
                            Elm.unit
                        )
                    ]
                    |> renderedAs
                        """
case foo of
    ( (), name, 'a' ) ->
        ()
"""
        , test "record destructure" <|
            \() ->
                Elm.Case.custom
                    (Elm.record
                        [ ( "first", Elm.string "Jane" )
                        , ( "last", Elm.string "Doe" )
                        ]
                    )
                    Type.unit
                    [ Elm.Case.branch
                        (Arg.record Tuple.pair
                            |> Arg.field "first"
                            |> Arg.field "last"
                        )
                        (\( first, last ) ->
                            Elm.Op.append first last
                        )
                    ]
                    |> renderedAs
                        """
case { first = "Jane", last = "Doe" } of
    { first, last } ->
        first ++ last
"""
        , test "record destructure with as alias" <|
            \() ->
                Elm.Case.custom
                    (Elm.record
                        [ ( "first", Elm.string "Jane" )
                        , ( "last", Elm.string "Doe" )
                        ]
                    )
                    Type.unit
                    [ Elm.Case.branch
                        (Arg.record Tuple.pair
                            |> Arg.field "first"
                            |> Arg.field "last"
                        )
                        (\( first, second ) ->
                            Elm.tuple first second
                        )

                    -- |> Pattern.aliasAs "record")
                    --     (\record ( first, last ) ->
                    --         Elm.tuple record
                    --             (Elm.Op.append first last)
                    --     )
                    ]
                    |> renderedAs
                        """
case { first = "Jane", last = "Doe" } of
    { first, last } as record ->
        ( record, first ++ last )
"""
        , test "custom type helpers" <|
            \() ->
                Elm.Case.custom
                    Elm.nothing
                    (Type.maybe Type.char)
                    [ Elm.Case.branch
                        (Arg.customType "Just" identity
                            |> Arg.item (Arg.char 'c')
                        )
                        (\_ -> Elm.string "There is 1 item")
                    , Elm.Case.branch
                        (Arg.customType "Just" identity
                            |> Arg.item (Arg.var "n")
                        )
                        (\n ->
                            Elm.string "There are more items"
                        )
                    , Elm.Case.branch (Arg.customType "Nothing" ())
                        (\_ -> Elm.string "Oh, it's nothing.")
                    ]
                    |> renderedAs
                        """
case Nothing of
    Just 'c' ->
        "There is 1 item"

    Just n ->
        "There are more items"

    Nothing ->
        "Oh, it's nothing."
"""
        , describe "literal patterns"
            [ test "unit" <|
                \() ->
                    Elm.Case.custom Elm.unit
                        Type.unit
                        [ Elm.Case.branch
                            Arg.unit
                            (\_ ->
                                Elm.unit
                            )
                        ]
                        |> renderedAs
                            """
case () of
    () ->
        ()
"""
            , test "string" <|
                \() ->
                    Elm.Case.custom (Elm.string "Hi!")
                        Type.string
                        [ Elm.Case.branch (Arg.string "Hi!") (\_ -> Elm.string "Hello to you!")
                        , Elm.Case.branch Arg.ignore (\_ -> Elm.string "Excuse me?")
                        ]
                        |> renderedAs
                            """
case "Hi!" of
    "Hi!" ->
        "Hello to you!"

    _ ->
        "Excuse me?"
"""
            , test "char" <|
                \() ->
                    Elm.Case.custom (Elm.char 'z')
                        Type.unit
                        [ Elm.Case.branch (Arg.char 'z') (\_ -> Elm.int 26)
                        , Elm.Case.branch Arg.ignore (\_ -> Elm.int 0)
                        ]
                        |> renderedAs
                            """
case 'z' of
    'z' ->
        26

    _ ->
        0
"""
            , test "dots in names" <|
                \() ->
                    Elm.Case.custom (Elm.char 'z')
                        Type.unit
                        [ Elm.Case.branch (Arg.var "a.b")
                            (\arg ->
                                arg
                            )
                        ]
                        |> renderedAs """
case 'z' of
    ab ->
        ab
"""
            ]
        ]


fromInt fromIntArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "String" ]
            , name = "fromInt"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
        )
        [ fromIntArg ]


expectImports :
    List (List String)
    -> Compiler.Expression
    -> Expect.Expectation
expectImports expectedImports expression =
    expression
        |> Compiler.toExpressionDetails (Index.startIndex Nothing)
        |> Tuple.second
        |> Compiler.getImports
        |> List.filter (not << List.isEmpty)
        |> Set.fromList
        |> Expect.equal (Set.fromList expectedImports)


fromString : Expression -> Expression
fromString fromStringArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "QueryParams" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [] "QueryParams" [])
                    )
            }
        )
        [ fromStringArg ]


renderedAs : String -> Expression -> Expect.Expectation
renderedAs expected actual =
    (Elm.ToString.expression actual
        |> .body
    )
        |> Expect.equal
            (String.trim expected)
