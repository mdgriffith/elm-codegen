module TypeChecking exposing (generatedCode, suite)

import Elm
import Elm.Annotation as Type
import Elm.Arg as Arg
import Elm.Case
import Elm.Expect
import Elm.Op
import Elm.ToString
import Expect
import Internal.Compiler as Compiler
import Internal.Index as Index
import String.Multiline
import Test exposing (Test, describe, test)


successfullyInferredType : Compiler.Expression -> Expect.Expectation
successfullyInferredType expression =
    let
        ( _, details ) =
            Compiler.toExpressionDetails (Index.startIndex Nothing) expression
    in
    case details.annotation of
        Ok _ ->
            Expect.pass

        Err errs ->
            Expect.fail
                ("Failed to typecheck"
                    ++ String.join "\n"
                        (List.map Compiler.inferenceErrorToString errs)
                )


suite : Test
suite =
    describe "Type inference!"
        [ test "Strings" <|
            \_ ->
                successfullyInferredType (Elm.string "Hello!")
        , test "Bools" <|
            \_ ->
                successfullyInferredType (Elm.bool True)
        , test "Floats" <|
            \_ ->
                successfullyInferredType (Elm.float 0.6)
        , test "Int" <|
            \_ ->
                successfullyInferredType (Elm.int 6)
        , test "Maybe Bool" <|
            \_ ->
                successfullyInferredType (Elm.maybe (Just (Elm.bool True)))
        , test "List of Records" <|
            \_ ->
                successfullyInferredType
                    (Elm.list
                        [ Elm.record
                            [ ( "first", Elm.int 5 )
                            , ( "second", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                            , ( "first2", Elm.int 5 )
                            , ( "second2", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                            , ( "first3", Elm.int 5 )
                            , ( "second3", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                            ]
                        ]
                    )
        , test "A simple plus function" <|
            \_ ->
                successfullyInferredType
                    (Elm.fn (Arg.var "myInt") <|
                        Elm.Op.plus (Elm.int 5)
                    )
        , test "Function with list mapping" <|
            \_ ->
                successfullyInferredType
                    (Elm.fn (Arg.var "myArg") <|
                        \myArg ->
                            listMap
                                (\i ->
                                    Elm.Op.plus (Elm.int 5) i
                                )
                                [ myArg
                                ]
                    )
        , test "Function that updates a literal elm record" <|
            \_ ->
                successfullyInferredType
                    (Elm.fn (Arg.var "myInt") <|
                        \myInt ->
                            Elm.record
                                [ ( "first", Elm.int 5 )
                                , ( "second", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                                , ( "first2", Elm.int 5 )
                                , ( "second2", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                                , ( "first3", Elm.int 5 )
                                , ( "second3", Elm.tuple (Elm.string "hello") (Elm.int 5) )
                                ]
                                |> Elm.updateRecord
                                    [ ( "first", myInt ) ]
                    )
        ]



{- HELPERS COPIED FROM GENRATED STUFF

   At some point we should just use the generated stuff directly.

-}


{-| Apply a function to every element of a list.

    map sqrt [ 1, 4, 9 ] == [ 1, 2, 3 ]

    map not [ True, False, True ] == [ False, True, False ]

So `map func [ a, b, c ]` is the same as `[ func a, func b, func c ]`

map: (a -> b) -> List a -> List b

-}
listMap : (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
listMap arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg, Elm.list arg0 ]



{- Exact output! -}


generatedCode : Test
generatedCode =
    describe "Exact Output"
        [ test "Strings" <|
            \_ ->
                Elm.Expect.renderedAs
                    (Elm.string "Hello!")
                    "\"Hello!\""
        , test "Function, arg order isn't reversed" <|
            \_ ->
                let
                    exp : Elm.Expression
                    exp =
                        Elm.function
                            [ ( "str", Just Type.string )
                            , ( "int", Just Type.int )
                            , ( "bool", Just Type.bool )
                            ]
                            (\args ->
                                case args of
                                    [ one, two, three ] ->
                                        Elm.triple one two three

                                    _ ->
                                        Elm.unit
                            )
                in
                Elm.Expect.declarationAs
                    (Elm.declaration "myFunc" exp)
                    "myFunc : String -> Int -> Bool -> ( String, Int, Bool )\nmyFunc str int bool =\n    ( str, int, bool )"
        , test "Simplified version of map generates the correct signature" <|
            \_ ->
                Elm.Expect.declarationAs
                    (Elm.declaration "map" myMap2)
                    """
                    map : (optional -> fn) -> optional -> Optional fn
                    map fn optional =
                        Present (fn optional)
                    """
        , test "Map function generates corrections " <|
            \_ ->
                (Elm.ToString.expression myMap
                    |> .signature
                )
                    |> Expect.equal
                        (String.Multiline.here
                            """
                            (a -> fn) -> Optional a -> Optional fn
                            """
                        )
        , test "Multiply used type variable in record only appears once in signature" <|
            \_ ->
                Elm.Expect.declarationAs
                    (Elm.alias "Record"
                        (Type.record
                            [ ( "a", Type.var "var" )
                            , ( "b", Type.var "var" )
                            ]
                        )
                    )
                    "type alias Record var =\n    { a : var, b : var }"
        ]


myMap2 : Elm.Expression
myMap2 =
    Elm.fn2
        (Arg.var "fn")
        (Arg.var "optional")
        (\fn a ->
            present [] (Elm.apply fn [ a ])
        )


myMap : Elm.Expression
myMap =
    Elm.fn2
        (Arg.var "fn")
        (Arg.var "optional")
        (\fn optional ->
            Elm.Case.custom optional
                (Type.namedWith [] "Optional" [ Type.var "a" ])
                [ Elm.Case.branch
                    (Arg.customType "Present" identity
                        |> Arg.item (Arg.var "a")
                    )
                    (\a ->
                        present []
                            (Elm.apply fn [ a ])
                    )
                , Elm.Case.branch
                    (Arg.customType "Null" [])
                    null
                , Elm.Case.branch
                    (Arg.customType "Absent" [])
                    absent
                ]
        )


present : List String -> Elm.Expression -> Elm.Expression
present optionalModuleName a =
    Elm.apply
        (Elm.value
            { importFrom = optionalModuleName
            , name = "Present"
            , annotation =
                Just
                    (Type.function [ Type.var "a2" ]
                        (Type.namedWith optionalModuleName "Optional" [ Type.var "a2" ])
                    )
            }
        )
        [ a ]


null : List String -> Elm.Expression
null optionalModuleName =
    Elm.value
        { importFrom = optionalModuleName
        , name = "Null"
        , annotation = Just (Type.namedWith optionalModuleName "Optional" [ Type.var "a" ])
        }


absent : List String -> Elm.Expression
absent optionalModuleName =
    Elm.value
        { importFrom = []
        , name = "Absent"
        , annotation = Just (Type.namedWith optionalModuleName "Optional" [ Type.var "a" ])
        }
