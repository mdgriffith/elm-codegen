module RedundantQualification exposing (suite)

import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Avoid redundant imports"
        [ inTypeAliases
        , inAnnotation
        ]


inTypeAliases : Test
inTypeAliases =
    test "In type aliases" <|
        \_ ->
            Elm.file [ "Foo" ]
                [ Elm.alias "Bar" (Elm.Annotation.named [ "Foo" ] "Baz") ]
                |> Elm.Expect.fileContentAs
                    """
                    module Foo exposing (..)


                    type alias Bar =
                        Baz
                    """


inAnnotation : Test
inAnnotation =
    test "In annotation" <|
        \_ ->
            Elm.file [ "Foo" ]
                [ Elm.fn
                    (Elm.Arg.varWith "v" (Elm.Annotation.named [ "Foo" ] "Baz"))
                    identity
                    |> Elm.declaration "id"
                ]
                |> Elm.Expect.fileContentAs
                    """
                    module Foo exposing (..)


                    id : Baz -> Baz
                    id v =
                        v
                    """
