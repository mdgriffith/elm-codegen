module PackageHelpers exposing (suite)

import Dict
import Elm
import Elm.Annotation as Type
import Elm.Expect
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


detectCycles list =
    let
        dict =
            list
                |> Dict.fromList
    in
    dict
        |> Dict.keys
        |> List.map
            (\key ->
                hasCycles dict key []
            )


countCycles list =
    let
        dict =
            list
                |> Dict.fromList
    in
    dict
        |> Dict.keys
        |> List.map
            (\key ->
                findDepth dict key [] 0
            )


hasCycles dict key found =
    case Dict.get key dict of
        Nothing ->
            False

        Just type_ ->
            let
                val =
                    Internal.Write.writeAnnotation type_
            in
            if List.member val found then
                True

            else
                hasCycles dict val (val :: found)


findDepth dict key found depth =
    case Dict.get key dict of
        Nothing ->
            depth

        Just type_ ->
            let
                val =
                    Internal.Write.writeAnnotation type_
            in
            if List.member val found then
                1000

            else
                findDepth dict val (val :: found) (depth + 1)


suite : Test
suite =
    describe "Generated code"
        [ packageHelpers
        , stringifying
        ]


packageHelpers : Test
packageHelpers =
    describe "Package helpers"
        [ test "Make_ is equivalent to top-level just constructor" <|
            \_ ->
                Elm.Expect.equal
                    (Gen.Maybe.make_.just (Elm.int 5))
                    (Elm.just (Elm.int 5))
        , test "typechecking an Element.row doesn't hang forever" <|
            \_ ->
                let
                    myRow =
                        Gen.Element.row [ Gen.Element.spacing 5 ]
                            [ Gen.Element.none ]

                    layout =
                        Gen.Element.layout []
                            (Gen.Element.column [ Gen.Element.spacing 24 ]
                                [ myRow
                                , myRow
                                , myRow
                                ]
                            )

                    cycles =
                        layout
                            |> Compiler.facts
                            |> Result.map (List.any ((==) True) << detectCycles)
                            |> Result.withDefault True
                in
                Expect.equal False cycles
        , test "typevariables in functions within a record dont pollute each other" <|
            \_ ->
                Expect.equal
                    (Elm.record
                        [ Elm.fn ( "arg", Nothing )
                            (\arg ->
                                Elm.Op.plus arg (Elm.int 5)
                            )
                            |> Tuple.pair "one"
                        , Elm.fn ( "arg", Nothing )
                            (\arg ->
                                Elm.Op.append arg (Elm.string "World")
                            )
                            |> Tuple.pair "two"
                        ]
                        |> Elm.declaration "test"
                        |> Elm.ToString.declaration
                        |> .body
                    )
                    """test : { one : Int -> Int, two : String -> String }
test =
    { one = \\arg -> arg + 5, two = \\arg -> arg ++ "World" }"""
        ]


stringifying : Test
stringifying =
    only <|
        describe "ToString"
            [ test "expressionWith applies aliases as expected" <|
                \_ ->
                    Expect.equal
                        (Elm.record
                            [ Elm.fn ( "arg", Nothing )
                                (\arg ->
                                    Elm.apply
                                        (Elm.value
                                            { importFrom = [ "Longer", "Module" ]
                                            , name = "gorthalax"
                                            , annotation = Nothing
                                            }
                                        )
                                        [ arg
                                        ]
                                )
                                |> Tuple.pair "one"
                            ]
                            |> Elm.ToString.expressionWith
                                { aliases =
                                    [ ( [ "Longer", "Module" ], "Ui" )
                                    ]
                                }
                            |> .body
                        )
                        "{ one = \\arg -> Ui.gorthalax arg }"
            , test "expressionWith generates aliases as expected" <|
                \_ ->
                    Expect.equal
                        (Elm.record
                            [ Elm.fn ( "arg", Nothing )
                                (\arg ->
                                    Elm.apply
                                        (Elm.value
                                            { importFrom = [ "Longer", "Module" ]
                                            , name = "gorthalax"
                                            , annotation = Nothing
                                            }
                                        )
                                        [ arg
                                        ]
                                )
                                |> Tuple.pair "one"
                            ]
                            |> Elm.ToString.expressionWith
                                { aliases =
                                    [ ( [ "Longer", "Module" ], "Ui" )
                                    ]
                                }
                            |> .imports
                        )
                        "import Longer.Module as Ui"
            ]
