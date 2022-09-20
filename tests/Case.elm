module Case exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type exposing (Annotation)
import Elm.Case
import Elm.Expect
import Elm.Op
import Elm.Pattern as Pattern
import Elm.ToString
import Expect
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

    Just __1 ->
        ()"""
        , test "Nothing with uncons" <|
            \() ->
                let
                    inner : Elm.Case.Branch
                    inner =
                        Pattern.startUncons
                            (\_ _ ->
                                Elm.unit
                            )
                            |> Pattern.addUncons (Pattern.newBranch0 "Nothing")
                            |> Pattern.toUncons "rest" Type.unit
                            |> Elm.Case.patternToBranch identity

                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.list
                                [ Elm.nothing
                                , Elm.string "hello" |> Elm.just
                                ]
                            )
                            Type.unit
                            [ inner
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case [ Nothing, Just "hello" ] of
    Nothing :: rest ->
        ()"""
        , test "list pattern" <|
            \() ->
                let
                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.list
                                [ Elm.nothing
                                , Elm.string "hello" |> Elm.just
                                ]
                            )
                            Type.unit
                            [ Pattern.startUncons
                                (\left () ->
                                    left
                                )
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "left", Type.string ))
                                |> Pattern.addUncons (Pattern.newBranch0 "Nothing")
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.startUncons
                                (\() right ->
                                    right
                                )
                                |> Pattern.addUncons (Pattern.newBranch0 "Nothing")
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "right", Type.string ))
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.startUncons
                                (\left right ->
                                    Elm.Op.append left right
                                )
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "left", Type.string ))
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "right", Type.string ))
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.startUncons
                                (\left right rest ->
                                    Elm.Op.append
                                        (Elm.Op.append left right)
                                        (Elm.string "And there's more!")
                                )
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "left", Type.string ))
                                |> Pattern.addUncons (Pattern.newBranch1 "Just" ( "right", Type.string ))
                                |> Pattern.toUncons "rest" (Type.maybe Type.string)
                                |> Elm.Case.patternToBranch identity
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case [ Nothing, Just "hello" ] of
    [ Nothing, (Just left) ] ->
        left

    [ (Just right), Nothing ] ->
        right

    [ (Just right), (Just left) ] ->
        left ++ right

    (Just left) :: (Just right) :: rest ->
        (left ++ right) ++ "And there's more!\""""
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
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.int 1)
                                    |> Pattern.buildCustom
                                )
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.int 2)
                                    |> Pattern.buildCustom
                                )
                                |> Elm.Case.patternToBranch
                                    (\( left, right ) ->
                                        Elm.int (left + right)
                                    )
                            , Pattern.tuple
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.varPattern "left")
                                    |> Pattern.buildCustom
                                )
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.varPattern "right")
                                    |> Pattern.buildCustom
                                )
                                |> Elm.Case.patternToBranch
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

    otherwise_1_0 ->
        0"""
        , test "triple" <|
            \() ->
                Elm.Case.custom (Elm.val "foo")
                    Type.unit
                    [ Pattern.triple Pattern.unit (Pattern.varPattern "name") (Pattern.int 123)
                        |> Elm.Case.patternToBranch
                            (\( (), name, literalInt ) ->
                                Elm.unit
                            )
                    ]
                    |> renderedAs
                        """
case foo of
    ( (), name, 123 ) ->
        ()
"""
        , describe "literal patterns"
            [ test "unit" <|
                \() ->
                    Elm.Case.custom Elm.unit
                        Type.unit
                        [ Pattern.unit
                            |> Elm.Case.patternToBranch
                                (\() ->
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
                        Type.unit
                        [ Pattern.string "Hi!"
                            |> Elm.Case.patternToBranch
                                (\_ ->
                                    Elm.string "Hello to you!"
                                )
                        , Pattern.ignore
                            |> Elm.Case.patternToBranch
                                (\() ->
                                    Elm.string "Excuse me?"
                                )
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
                        [ Pattern.char 'z'
                            |> Elm.Case.patternToBranch
                                (\_ ->
                                    Elm.int 26
                                )
                        , Pattern.ignore
                            |> Elm.Case.patternToBranch
                                (\() ->
                                    Elm.int 0
                                )
                        ]
                        |> renderedAs
                            """
case 'z' of
    'z' ->
        26

    _ ->
        0
"""
            ]
        ]


renderedAs : String -> Expression -> Expect.Expectation
renderedAs expected actual =
    (Elm.ToString.expression actual
        |> .body
    )
        |> Expect.equal
            (String.trim expected)
