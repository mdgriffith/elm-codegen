module Pattern exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Case
import Elm.Case.Branch as Pattern
import Elm.Expect
import Elm.Op
import Elm.ToString
import Expect
import Gen.String
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
                                (Elm.just (Elm.int 1))
                                (Elm.just (Elm.int 2))
                            )
                            (Type.maybe Type.int)
                            [ Pattern.tuple
                                (Pattern.customType "Just"
                                    (\literalInt -> literalInt)
                                    |> Pattern.withParam (Pattern.int 1 1)
                                    |> Pattern.toPattern
                                )
                                (Pattern.just (Pattern.int 2 2))
                                |> Pattern.map
                                    (\( left, right ) ->
                                        Elm.int (left + right)
                                    )
                            , Pattern.tuple
                                (Pattern.customType "Just"
                                    (\literalInt -> literalInt)
                                    |> Pattern.withParam (Pattern.var "left")
                                    |> Pattern.toPattern
                                )
                                (Pattern.customType "Just"
                                    (\literalInt -> literalInt)
                                    |> Pattern.withParam (Pattern.var "right")
                                    |> Pattern.toPattern
                                )
                                |> Pattern.map
                                    (\( left, right ) ->
                                        Elm.Op.plus left right
                                    )
                            , Elm.Case.otherwise (\_ -> Elm.int 0)
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case ( Just 1, Just 2 ) of
    ( Just 1, Just 2 ) ->
        3

    ( Just left, Just right ) ->
        left + right

    otherwise ->
        0"""
        , test "triple" <|
            \() ->
                Elm.Case.custom (Elm.val "foo")
                    Type.unit
                    [ Pattern.triple (Pattern.unit ()) (Pattern.var "name") (Pattern.int 123 (Elm.int 123))
                        |> Pattern.map
                            (\( (), _, _ ) ->
                                Elm.unit
                            )
                    ]
                    |> renderedAs
                        """
case foo of
    ( (), name, 123 ) ->
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
                    [ Pattern.record2
                        (\first last ->
                            Elm.Op.append first last
                        )
                        "first"
                        "last"
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
                    [ Pattern.record2 Tuple.pair "first" "last"
                        |> Pattern.aliasAs "record"
                            (\record ( first, last ) ->
                                Elm.tuple record
                                    (Elm.Op.append first last)
                            )
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
                    Type.unit
                    [ Pattern.just (Pattern.int 1 (Elm.string "There is 1 item"))
                    , Pattern.just
                        (Pattern.var "n")
                        |> Pattern.map
                            (\n ->
                                Elm.Op.append
                                    (Elm.Op.append
                                        (Elm.string "There are ")
                                        (Gen.String.call_.fromInt n)
                                    )
                                    (Elm.string " items")
                            )
                    , Pattern.nothing (Elm.string "Oh, it's nothing.")
                    ]
                    |> renderedAs
                        """
case Nothing of
    Just 1 ->
        "There is 1 item"

    Just n ->
        ("There are " ++ String.fromInt n) ++ " items"

    Nothing ->
        "Oh, it's nothing."
"""
        , describe "literal patterns"
            [ test "unit" <|
                \() ->
                    Elm.Case.custom Elm.unit
                        Type.unit
                        [ Pattern.unit Elm.unit
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
                        Type.unit
                        [ Pattern.string "Hi!" (Elm.string "Hello to you!")
                        , Pattern.ignore (Elm.string "Excuse me?")
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
                        [ Pattern.char 'z' (Elm.int 26)
                        , Pattern.ignore (Elm.int 0)
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
                        [ Pattern.var "a.b" ]
                        |> renderedAs """
case 'z' of
    ab ->
        ab
"""
            ]
        ]


expectImports :
    List (List String)
    -> Compiler.Expression
    -> Expect.Expectation
expectImports expectedImports expression =
    expression
        |> Compiler.toExpressionDetails Index.startIndex
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
