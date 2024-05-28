module Module exposing (suite)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Arg as Arg
import Elm.Declare as Declare
import Elm.Expect
import Elm.Op
import Expect
import Test exposing (Test, describe, test)


type alias Mod =
    { myInt : Type.Annotation
    , myType : Type.Annotation
    , myFn : Elm.Expression -> Elm.Expression -> Elm.Expression
    }


mod =
    Declare.module_ [ "Virtual", "Module" ] Mod
        |> Declare.with (Declare.alias "MyInt" Type.int)
        |> Declare.with (Declare.customType "MyType" [ Elm.variant "MyType" ])
        |> Declare.with
            (Declare.fn2 "myFn"
                (Arg.varWith "a" Type.int)
                (Arg.varWith "b" Type.int)
                (\a b -> Elm.Op.plus a b)
            )



{-


-}


suite : Test
suite =
    Test.only <|
        describe "Virtual modules"
            [ fileGeneration
            , usageInsideModule
            , usageOutsideModule
            ]


usageInsideModule : Test
usageInsideModule =
    describe "Usage inside module is unqualified"
        [ test "Type reference" <|
            \_ ->
                let
                    file =
                        Elm.file [ "Virtual", "Module" ]
                            [ Elm.declaration "test"
                                (Elm.fn
                                    (Arg.varWith "a" mod.call.myType)
                                    (\a ->
                                        a
                                    )
                                )
                            ]
                in
                Expect.equal file.contents """module Virtual.Module exposing (..)


test : MyType -> MyType
test a =
    a"""
        , test "Function" <|
            \_ ->
                let
                    file =
                        Elm.file [ "Virtual", "Module" ]
                            [ Elm.declaration "test"
                                (Elm.fn
                                    (Arg.var "a")
                                    (\a -> mod.call.myFn a a)
                                )
                            ]
                in
                Expect.equal file.contents """module Virtual.Module exposing (..)


test : Int -> Int
test a =
    myFn a a"""
        ]


usageOutsideModule : Test
usageOutsideModule =
    describe "Usage outside module is qualified"
        [ test "Type reference" <|
            \_ ->
                let
                    file =
                        Elm.file [ "My", "Module" ]
                            [ Elm.declaration "test"
                                (Elm.fn
                                    (Arg.varWith "a" mod.call.myType)
                                    (\a ->
                                        a
                                    )
                                )
                            ]
                in
                Expect.equal file.contents """module My.Module exposing (..)

import Virtual.Module


test : Virtual.Module.MyType -> Virtual.Module.MyType
test a =
    a"""
        , test "Function" <|
            \_ ->
                let
                    file =
                        Elm.file [ "My", "Module" ]
                            [ Elm.declaration "test"
                                (Elm.fn
                                    (Arg.var "a")
                                    (\a -> mod.call.myFn a a)
                                )
                            ]
                in
                Expect.equal file.contents """module My.Module exposing (..)


test : Int -> Int
test a =
    Virtual.Module.myFn a a"""
        ]


fileGeneration : Test
fileGeneration =
    test "File Generation" <|
        \_ ->
            Expect.equal (Declare.toFile mod |> .contents)
                (String.trim """

module Virtual.Module exposing (MyInt, MyType, myFn)

{-|
@docs MyInt, MyType, myFn
-}



type alias MyInt =
    Int


type MyType
    = MyType


myFn : Int -> Int -> Int
myFn a b =
    a + b""")
