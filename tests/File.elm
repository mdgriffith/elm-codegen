module File exposing (suite)

{-| -}

import Elm
import Elm.Arg as Arg
import Elm.Expect
import Test exposing (Test, describe, test)


testFn1 : Elm.Declaration
testFn1 =
    Elm.declaration "testFn1" <|
        Elm.fn (Arg.var "arg") <|
            \arg ->
                arg


placeholder : String -> Elm.Declaration
placeholder name =
    Elm.declaration name <|
        Elm.fn (Arg.var "arg") <|
            \arg ->
                arg


testFn2 : Elm.Declaration
testFn2 =
    Elm.declaration "testFn2" <|
        Elm.fn (Arg.var "arg") <|
            \arg ->
                arg


suite : Test
suite =
    describe "Elm.file"
        [ grouping
        , describe "module doc"
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


grouping : Test
grouping =
    Test.only <|
        describe "Grouping exposed"
            [ test "no extra lines at the end of the file" <|
                \_ ->
                    Elm.Expect.fileContentAs
                        (Elm.file [ "Test" ]
                            [ placeholder "one"
                            , placeholder "two"
                            , Elm.group { title = "My group", docs = "Here's how to use it" }
                                [ placeholder "three"
                                , placeholder "four"
                                ]
                            , placeholder "five"
                            , placeholder "six"
                            ]
                        )
                        """module Test exposing (..)

{-|@docs one, two

## My group

Here's how to use it

@docs three, four

@docs five, six
-}



one : arg -> arg
one arg =
    arg


two : arg -> arg
two arg =
    arg


three : arg -> arg
three arg =
    arg


four : arg -> arg
four arg =
    arg


five : arg -> arg
five arg =
    arg


six : arg -> arg
six arg =
    arg
"""
            ]
