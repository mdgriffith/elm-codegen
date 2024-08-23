module PackageHelpers exposing (suite)

import Dict exposing (Dict)
import Elm
import Elm.Arg
import Elm.Expect
import Elm.Op
import Elm.Syntax.TypeAnnotation exposing (TypeAnnotation)
import Elm.ToString
import Expect
import Gen.Element
import Gen.Maybe
import Internal.Compiler as Compiler
import Internal.Write
import Test exposing (Test, describe, test)


detectCycles : List ( String, TypeAnnotation ) -> List Bool
detectCycles list =
    let
        dict : Dict String TypeAnnotation
        dict =
            Dict.fromList list
    in
    dict
        |> Dict.keys
        |> List.map
            (\key ->
                hasCycles dict key []
            )


countCycles : List ( String, TypeAnnotation ) -> List number
countCycles list =
    let
        dict : Dict String TypeAnnotation
        dict =
            Dict.fromList list
    in
    dict
        |> Dict.keys
        |> List.map
            (\key ->
                findDepth dict key [] 0
            )


hasCycles : Dict String TypeAnnotation -> String -> List String -> Bool
hasCycles dict key found =
    case Dict.get key dict of
        Nothing ->
            False

        Just type_ ->
            let
                val : String
                val =
                    Internal.Write.writeAnnotation type_
            in
            List.member val found
                || hasCycles dict val (val :: found)


findDepth : Dict String TypeAnnotation -> String -> List String -> number -> number
findDepth dict key found depth =
    case Dict.get key dict of
        Nothing ->
            depth

        Just type_ ->
            let
                val : String
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
                    myRow : Elm.Expression
                    myRow =
                        Gen.Element.row [ Gen.Element.spacing 5 ]
                            [ Gen.Element.none ]

                    layout : Elm.Expression
                    layout =
                        Gen.Element.layout []
                            (Gen.Element.column [ Gen.Element.spacing 24 ]
                                [ myRow
                                , myRow
                                , myRow
                                ]
                            )

                    cycles : Bool
                    cycles =
                        layout
                            |> Compiler.facts
                            |> Result.map (List.member True << detectCycles)
                            |> Result.withDefault True
                in
                Expect.equal False cycles
        , test "typevariables in functions within a record dont pollute each other" <|
            \_ ->
                Expect.equal
                    (Elm.record
                        [ Elm.fn (Elm.Arg.var "arg")
                            (\arg ->
                                Elm.Op.plus arg (Elm.int 5)
                            )
                            |> Tuple.pair "one"
                        , Elm.fn (Elm.Arg.var "arg")
                            (\arg ->
                                Elm.Op.append arg (Elm.string "World")
                            )
                            |> Tuple.pair "two"
                        ]
                        |> Elm.declaration "test"
                        |> Elm.ToString.declaration
                        |> List.map .body
                        |> String.join "\n"
                        |> String.trim
                    )
                    """test : { one : Int -> Int, two : String -> String }
test =
    { one = \\arg -> arg + 5, two = \\arg -> arg ++ "World" }"""
        ]


stringifying : Test
stringifying =
    describe "ToString"
        [ test "expressionWith applies aliases as expected" <|
            \_ ->
                Elm.record
                    [ Elm.fn (Elm.Arg.var "arg")
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
                    |> Expect.equal "{ one = \\arg -> Ui.gorthalax arg }"
        , test "expressionWith generates aliases as expected" <|
            \_ ->
                Elm.record
                    [ Elm.fn (Elm.Arg.var "arg")
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
                    |> Expect.equal "import Longer.Module as Ui"
        , test "declarations named `main` do not get sanitized" <|
            \_ ->
                Elm.Expect.declarationAs
                    (Elm.declaration "main"
                        (Elm.int 5)
                    )
                    "main : Int\nmain =\n    5"
        , test "Pipelines are paren-ed correctly" <|
            \_ ->
                Elm.Expect.renderedAs
                    (Elm.string "Hello"
                        |> Elm.Op.pipe
                            (Elm.value
                                { importFrom = []
                                , name = "one"
                                , annotation = Nothing
                                }
                            )
                        |> Elm.Op.pipe
                            (Elm.apply
                                (Elm.value
                                    { importFrom = []
                                    , name = "two"
                                    , annotation = Nothing
                                    }
                                )
                                [ Elm.int 5
                                , Elm.string "HELLOOOOOOOOOOOOOO"
                                ]
                            )
                    )
                    """"Hello" |> one |> two 5 "HELLOOOOOOOOOOOOOO\""""
        ]
