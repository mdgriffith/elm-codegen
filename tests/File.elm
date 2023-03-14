module File exposing (suite)

{-| -}

import Dict
import Elm
import Elm.Annotation as Type
import Elm.Declare
import Elm.Expect
import Elm.Let
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


testFn1 =
    Elm.declaration "testFn1" <|
        Elm.fn ( "arg", Nothing ) <|
            \arg ->
                arg


testFn2 =
    Elm.declaration "testFn2" <|
        Elm.fn ( "arg", Nothing ) <|
            \arg ->
                arg


suite : Test
suite =
    describe "Elm.file"
        [ describe "module doc"
            [ test "present when has content" <|
                \_ ->
                    Elm.Expect.fileContentAs (Elm.file [ "Test" ] [ Elm.expose testFn1 ])
                        """
module Test exposing (testFn1)

{-| 
@docs testFn1
-}



testFn1 : arg -> arg
testFn1 arg =
    arg
"""
            , test "absent when has no content" <|
                \_ ->
                    Elm.Expect.fileContentAs (Elm.file [ "Test" ] [ testFn1 ])
                        """
module Test exposing (..)


testFn1 : arg -> arg
testFn1 arg =
    arg
"""
            , test "declaration are in the correct order" <|
                \_ ->
                    Elm.Expect.fileContentAs (Elm.file [ "Test" ] [ Elm.expose testFn1, Elm.expose testFn2 ])
                        """
module Test exposing (testFn1, testFn2)

{-| 
@docs testFn1, testFn2
-}



testFn1 : arg -> arg
testFn1 arg =
    arg


testFn2 : arg -> arg
testFn2 arg =
    arg
"""
            ]
        , describe "trailing lines"
            [ test "no extra lines at the end of the file" <|
                \_ ->
                    Elm.Expect.fileContentAs (Elm.file [ "Test" ] [ testFn1, testFn2 ])
                        """
module Test exposing (..)


testFn1 : arg -> arg
testFn1 arg =
    arg


testFn2 : arg -> arg
testFn2 arg =
    arg
"""
            ]
        ]
