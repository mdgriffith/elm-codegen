module Case exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type exposing (Annotation)
import Elm.Case
import Elm.Expect
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
                            |> Elm.Case.addUncons (Elm.Case.branch0 "Nothing" Elm.unit)
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
                                (\_ ->
                                    Elm.unit
                                )
                                |> Elm.Case.addUncons (Elm.Case.branch0 "Nothing" Elm.unit)
                                |> Elm.Case.toListBranch
                            , Elm.Case.startUncons
                                (\_ ->
                                    Elm.unit
                                )
                                |> Elm.Case.addUncons (Elm.Case.branch1 "Just" ( "foo", Type.string ) (\_ -> Elm.unit))
                                |> Elm.Case.toListBranch
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case [ Nothing, Just "hello" ] of
    [ Nothing ] ->
        ()

    [ (Just foo) ] ->
        ()"""
        ]
