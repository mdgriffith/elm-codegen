module Declare exposing (suite)

{-| -}

import Elm
import Elm.Declare
import Elm.Expect
import Elm.Op
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Elm.Declare"
        [ declarations
        ]


myFn : { declaration : Elm.Declaration, call : Elm.Expression -> Elm.Expression, callFrom : List String -> Elm.Expression -> Elm.Expression, value : List String -> Elm.Expression }
myFn =
    Elm.Declare.fn "myFn"
        ( "myInt", Nothing )
        (Elm.Op.plus (Elm.int 5))


declarations : Test
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
