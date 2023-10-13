module Declare exposing (suite)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Declare
import Elm.Expect
import Elm.Op
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Elm.Declare"
        [ declarations
        , aliasTest
        , aliasWithTest
        , customTypeTest
        , customTypeWithTest
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


aliasTest : Test
aliasTest =
    test "Elm.alias" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.alias "MyAlias"
                    (Type.record
                        [ ( "one", Type.var "oneVar" )
                        , ( "two", Type.var "twoVar" )
                        , ( "three", Type.var "threeVar" )
                        ]
                    )
                )
                """
type alias MyAlias oneVar twoVar threeVar =
    { one : oneVar, two : twoVar, three : threeVar }
"""


aliasWithTest : Test
aliasWithTest =
    test "Elm.aliasWith" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.aliasWith "MyAlias"
                    [ "twoVar", "nonexistingVar", "oneVar" ]
                    (Type.record
                        [ ( "one", Type.var "oneVar" )
                        , ( "two", Type.var "twoVar" )
                        , ( "three", Type.var "threeVar" )
                        ]
                    )
                )
                """
type alias MyAlias twoVar oneVar threeVar =
    { one : oneVar, two : twoVar, three : threeVar }
"""


customTypeTest : Test
customTypeTest =
    test "Elm.customType" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.customType "MyType"
                    [ Elm.variantWith "One"
                        [ Type.var "oneVar" ]
                    , Elm.variantWith "Two"
                        [ Type.var "twoVar" ]
                    ]
                )
                """
type MyType oneVar twoVar
    = One oneVar
    | Two twoVar
"""


customTypeWithTest : Test
customTypeWithTest =
    test "Elm.customTypeWith" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.customTypeWith "MyType"
                    [ "addVar", "twoVar" ]
                    [ Elm.variantWith "One"
                        [ Type.var "oneVar" ]
                    , Elm.variantWith "Two"
                        [ Type.var "twoVar" ]
                    ]
                )
                """
type MyType addVar twoVar oneVar
    = One oneVar
    | Two twoVar
"""
