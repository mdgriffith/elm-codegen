module Pattern exposing (suite)

import Elm
import Elm.Annotation as Type
import Elm.Arg as Arg
import Elm.Case
import Elm.Expect
import Elm.Op
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Case expressions"
        [ test "Simple" <|
            \() ->
                Elm.Case.maybe Elm.nothing
                    { nothing = Elm.unit
                    , just = ( "_", \_ -> Elm.unit )
                    }
                    |> Elm.Expect.renderedAs
                        """
                        case Nothing of
                            Nothing ->
                                ()

                            Just _ ->
                                ()
                        """
        , test "tuple destructuring" <|
            \() ->
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
                        (\_ ->
                            Elm.int 5
                        )
                    , Elm.Case.branch
                        (Arg.tuple
                            (Arg.customType "just" identity
                                |> Arg.item (Arg.var "left")
                            )
                            (Arg.customType "Just" identity
                                |> Arg.item (Arg.var "right")
                            )
                        )
                        (\_ ->
                            Elm.int 8
                        )
                    , Elm.Case.branch Arg.ignore (\_ -> Elm.int 0)
                    ]
                    |> Elm.Expect.renderedAs
                        """
                        case ( Just 'a', Just 'b' ) of
                            ( Just 'a', Just 'b' ) ->
                                5

                            ( Just left, Just right ) ->
                                8

                            _ ->
                                0
                        """
        , test "triple" <|
            \() ->
                Elm.Case.custom (Elm.val "foo")
                    Type.unit
                    [ Elm.Case.branch
                        (Arg.triple Arg.unit (Arg.var "name") (Arg.char 'a'))
                        (\_ ->
                            Elm.unit
                        )
                    ]
                    |> Elm.Expect.renderedAs
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
                    |> Elm.Expect.renderedAs
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
                            |> Arg.aliasAs "record"
                        )
                        (\( ( first, second ), record ) ->
                            Elm.triple record first second
                        )
                    ]
                    |> Elm.Expect.renderedAs
                        """
                        case { first = "Jane", last = "Doe" } of
                            { first, last } as record ->
                                ( record, first, last )
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
                        (\_ ->
                            Elm.string "There are more items"
                        )
                    , Elm.Case.branch (Arg.customType "Nothing" ())
                        (\_ -> Elm.string "Oh, it's nothing.")
                    ]
                    |> Elm.Expect.renderedAs
                        """
                        case Nothing of
                            Just 'c' ->
                                "There is 1 item"

                            Just n ->
                                "There are more items"

                            Nothing ->
                                "Oh, it's nothing."
                        """
        , test "custom type helpers - with imports" <|
            \() ->
                Elm.fn
                    (Arg.customTypeWith { importFrom = [ "From", "Here" ], variantName = "Variant", typeName = "SomeType" } identity
                        |> Arg.item (Arg.char 'c')
                    )
                    (\_ -> Elm.string "There is 1 item")
                    |> Elm.Expect.renderedAs
                        """
                        \\(From.Here.Variant 'c') -> "There is 1 item"
                        """
        , test "custom type helpers - type qualification" <|
            \() ->
                (Elm.declaration "fn" <|
                    Elm.fn
                        (Arg.customTypeWith { importFrom = [ "From", "Here" ], variantName = "Variant", typeName = "SomeType" } identity
                            |> Arg.item (Arg.char 'c')
                        )
                        (\_ -> Elm.string "There is 1 item")
                )
                    |> Elm.Expect.declarationAs
                        """
                        fn : From.Here.SomeType -> String
                        fn (From.Here.Variant 'c') =
                            "There is 1 item"
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
                        |> Elm.Expect.renderedAs
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
                        |> Elm.Expect.renderedAs
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
                        |> Elm.Expect.renderedAs
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
                        |> Elm.Expect.renderedAs
                            """
                            case 'z' of
                                ab ->
                                    ab
                            """
            ]
        , destructuringItems
        ]


destructuringItems : Test
destructuringItems =
    describe "Item and items"
        [ test "list destructuring" <|
            \() ->
                let
                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.list [ Elm.char 'a' ])
                            (Type.maybe Type.int)
                            [ Elm.Case.branch
                                (Arg.list identity
                                    |> Arg.items
                                        [ Arg.var "first"
                                        , Arg.var "second"
                                        , Arg.var "third"
                                        ]
                                )
                                (\allVars ->
                                    Elm.list allVars
                                )
                            , Elm.Case.branch Arg.ignore (\_ -> Elm.int 0)
                            ]
                in
                expression
                    |> Elm.Expect.renderedAs
                        """
                        case [ 'a' ] of
                            [ first, second, third ] ->
                                [ first, second, third ]

                            _ ->
                                0
                        """
        , test "type destructuring" <|
            \() ->
                Elm.Case.custom
                    (Elm.val "Test")
                    (Type.maybe Type.int)
                    [ Elm.Case.branch
                        (Arg.customType "MyType" identity
                            |> Arg.items
                                [ Arg.var "first"
                                , Arg.var "second"
                                , Arg.var "third"
                                ]
                        )
                        (\allVars ->
                            Elm.list allVars
                        )
                    , Elm.Case.branch Arg.ignore (\_ -> Elm.int 0)
                    ]
                    |> Elm.Expect.renderedAs
                        """
                        case Test of
                            MyType first second third ->
                                [ first, second, third ]

                            _ ->
                                0
                        """
        ]
