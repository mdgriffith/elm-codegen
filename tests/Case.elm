module Case exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type exposing (Annotation)
import Elm.Case
import Elm.Expect
import Elm.Op
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
                        Elm.Case.startUncons
                            (\_ _ ->
                                Elm.unit
                            )
                            |> Elm.Case.addUncons (Elm.Case.newBranch0 "Nothing")
                            |> Elm.Case.toUncons "rest" Type.unit

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
                            [ Elm.Case.startUncons
                                (\left () ->
                                    left
                                )
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "left", Type.string ))
                                |> Elm.Case.addUncons (Elm.Case.newBranch0 "Nothing")
                                |> Elm.Case.toListBranch
                            , Elm.Case.startUncons
                                (\() right ->
                                    right
                                )
                                |> Elm.Case.addUncons (Elm.Case.newBranch0 "Nothing")
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "right", Type.string ))
                                |> Elm.Case.toListBranch
                            , Elm.Case.startUncons
                                (\left right ->
                                    Elm.Op.append left right
                                )
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "left", Type.string ))
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "right", Type.string ))
                                |> Elm.Case.toListBranch
                            , Elm.Case.startUncons
                                (\left right rest ->
                                    Elm.Op.append
                                        (Elm.Op.append left right)
                                        (Elm.string "And there's more!")
                                )
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "left", Type.string ))
                                |> Elm.Case.addUncons (Elm.Case.newBranch1 "Just" ( "right", Type.string ))
                                |> Elm.Case.toUncons "rest" (Type.maybe Type.string)
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
                            [ Elm.Case.tupleNew
                                (\( left, right ) ->
                                    Elm.int (left + right)
                                )
                                (Elm.Case.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Elm.Case.customWithParam (Elm.Case.int 1)
                                    |> Elm.Case.buildCustom
                                )
                                (Elm.Case.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Elm.Case.customWithParam (Elm.Case.int 2)
                                    |> Elm.Case.buildCustom
                                )
                                |> Elm.Case.patternToBranch
                            , Elm.Case.tupleNew
                                (\( left, right ) ->
                                    Elm.Op.plus left right
                                )
                                (Elm.Case.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Elm.Case.customWithParam (Elm.Case.varPattern "left")
                                    |> Elm.Case.buildCustom
                                )
                                (Elm.Case.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Elm.Case.customWithParam (Elm.Case.varPattern "right")
                                    |> Elm.Case.buildCustom
                                )
                                |> Elm.Case.patternToBranch
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
        ]
