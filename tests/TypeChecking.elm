module TypeChecking exposing (generatedCode, suite)

import Elm
import Elm.Annotation as Type
import Elm.Arg as Arg
import Elm.Case
import Elm.Declare
import Elm.Expect
import Elm.Op
import Elm.ToString
import Expect
import Internal.Compiler as Compiler
import Internal.Index as Index
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
                Elm.string "Hello!"
                    |> Elm.Expect.renderedAs
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
                Elm.declaration "myFunc" exp
                    |> Elm.Expect.declarationAs
                        """
                        myFunc : String -> Int -> Bool -> ( String, Int, Bool )
                        myFunc str int bool =
                            ( str, int, bool )
                        """
        , test "Simplified version of map generates the correct signature" <|
            \_ ->
                Elm.declaration "map" myMap2
                    |> Elm.Expect.declarationAs
                        """
                        map : (optional -> fn) -> optional -> Optional fn
                        map fn optional =
                            Present (fn optional)
                        """
        , test "Map function generates corrections " <|
            \_ ->
                Elm.ToString.expression myMap
                    |> .signature
                    |> Elm.Expect.expectEqualMultiline
                        "(a -> fn) -> Optional a -> Optional fn"
        , test "Multiply used type variable in record only appears once in signature" <|
            \_ ->
                Elm.alias "Record"
                    (Type.record
                        [ ( "a", Type.var "var" )
                        , ( "b", Type.var "var" )
                        ]
                    )
                    |> Elm.Expect.declarationAs
                        """
                        type alias Record var =
                            { a : var, b : var }
                        """
        , test "Record with mixed Float and Int fields infers correct types" <|
            \_ ->
                Elm.declaration "myRecord"
                    (Elm.record
                        [ ( "alpha", Elm.Op.plus (Elm.int 1) (Elm.int 2) )
                        , ( "beta", Elm.unit )
                        , ( "gamma", Elm.Op.gt (Elm.int 3) (Elm.int 4) )
                        , ( "delta", Elm.Op.minus (Elm.float 10.5) (Elm.float 3.2) )
                        , ( "epsilon", Elm.Op.multiply (Elm.int 5) (Elm.int 6) )
                        ]
                    )
                    |> Elm.Expect.declarationAs
                        """
                        myRecord :
                            { alpha : Int, beta : (), gamma : Bool, delta : Float, epsilon : Int }
                        myRecord =
                            { alpha = 1 + 2
                            , beta = ()
                            , gamma = 3 > 4
                            , delta = 10.5 - 3.2
                            , epsilon = 5 * 6
                            }
                        """
        , test "Tuple with Float and Int arithmetic infers correct types" <|
            \_ ->
                Elm.declaration "myTuple"
                    (Elm.tuple
                        (Elm.Op.plus (Elm.float 1.5) (Elm.float 2.5))
                        (Elm.Op.plus (Elm.int 1) (Elm.int 2))
                    )
                    |> Elm.Expect.declarationAs
                        """
                        myTuple : ( Float, Int )
                        myTuple =
                            ( 1.5 + 2.5, 1 + 2 )
                        """
        , describe "Number type resolution doesn't disturb polymorphic variables"
            [ test "Arithmetic on polymorphic arg resolves to concrete type" <|
                \_ ->
                    Elm.Declare.fn "addOne"
                        (Arg.var "x")
                        (\x -> Elm.Op.plus x (Elm.int 1))
                        |> .declaration
                        |> Elm.Expect.declarationAs
                            """
                            addOne : Int -> Int
                            addOne x =
                                x + 1
                            """
            , test "Float arithmetic next to polymorphic value in tuple" <|
                \_ ->
                    Elm.Declare.fn "mixedTuple"
                        (Arg.var "x")
                        (\x ->
                            Elm.tuple
                                (Elm.Op.plus (Elm.float 1.0) (Elm.float 2.0))
                                x
                        )
                        |> .declaration
                        |> Elm.Expect.declarationAs
                            """
                            mixedTuple : x -> ( Float, x )
                            mixedTuple x =
                                ( 1 + 2, x )
                            """
            ]
        , test "Elm.unwrapper omits annotation to let Elm infer it" <|
            -- unwrapper creates `\(Wrapper val) -> val` but can't
            -- derive a valid type annotation because it doesn't know
            -- the inner type of Wrapper. Any annotation we could
            -- generate (like `Wrapper -> a`) would be rejected by Elm
            -- because the extracted value has a concrete type, not a
            -- polymorphic one. So we omit the annotation and let Elm
            -- infer it from the custom type definition.
            \_ ->
                Elm.declaration "extract"
                    (Elm.unwrapper [] "Wrapper")
                    |> Elm.Expect.declarationAs
                        """
                        extract (Wrapper val) =
                            val
                        """
        , test "Elm.unwrapper respects withType when caller provides an annotation" <|
            \_ ->
                Elm.declaration "extract"
                    (Elm.unwrapper [] "Wrapper"
                        |> Elm.withType (Type.function [ Type.named [] "Wrapper" ] Type.string)
                    )
                    |> Elm.Expect.declarationAs
                        """
                        extract : Wrapper -> String
                        extract (Wrapper val) =
                            val
                        """
        , test "Elm.unwrap result propagates through downstream inference" <|
            -- Even though unwrapper itself can't produce a type
            -- annotation, `apply` synthesizes a fresh generic return
            -- type when the function's type is unknown, so outer
            -- expressions can still unify and infer correctly.
            \_ ->
                Elm.declaration "foo"
                    (Elm.Op.plus (Elm.int 1)
                        (Elm.unwrap [] "Wrapper" (Elm.val "wrapped"))
                    )
                    |> Elm.Expect.declarationAs
                        """
                        foo : Int
                        foo =
                            1 + (\\(Wrapper val) -> val) wrapped
                        """
        , test "Triple with mixed Float and Int infers correct types" <|
            \_ ->
                Elm.declaration "myTriple"
                    (Elm.triple
                        (Elm.Op.minus (Elm.float 10.5) (Elm.float 3.2))
                        Elm.unit
                        (Elm.Op.plus (Elm.int 1) (Elm.int 2))
                    )
                    |> Elm.Expect.declarationAs
                        """
                        myTriple : ( Float, (), Int )
                        myTriple =
                            ( 10.5 - 3.2, (), 1 + 2 )
                        """
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
