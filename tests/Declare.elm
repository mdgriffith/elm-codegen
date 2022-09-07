module Declare exposing (suite)

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


suite : Test
suite =
    describe "Elm.Declare"
        [ declarations
        ]


myFn =
    Elm.Declare.fn "myFn"
        ( "myInt", Nothing )
        (Elm.Op.plus (Elm.int 5))


declarations =
    describe "declarations"
        [ test "Basic function dec" <|
            \_ ->
                Elm.Expect.declarationAs myFn.declaration
                    """
myFn : Int -> Int
myFn myInt =
    5 + myInt
"""
        , test "Call correctly" <|
            \_ ->
                Elm.Expect.declarationAs
                    (Elm.declaration "mySweetNumber"
                        (myFn.call (Elm.int 82))
                    )
                    """
mySweetNumber : Int
mySweetNumber =
    myFn 82

"""
            ]
