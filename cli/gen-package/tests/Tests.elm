module Tests exposing (suite)

import DocsFromSource
import Expect
import Generate
import Test exposing (Test, test)


source : String
source =
    """module Foo exposing (a)

import Imported exposing (Foo(..))


type alias Foo a =
    Imported.Foo a


a : Foo Int
a =
    Debug.todo ""
"""


expected : String
expected =
    """module Gen.Foo exposing ( moduleName_, a, values_ )

{-|
# Generated bindings for Foo

@docs moduleName_, a, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Foo" ]


{-| a: Foo.Foo Int -}
a : Elm.Expression
a =
    Elm.value
        { importFrom = [ "Foo" ]
        , name = "a"
        , annotation = Just (Type.namedWith [ "Foo" ] "Foo" [ Type.int ])
        }


values_ : { a : Elm.Expression }
values_ =
    { a =
        Elm.value
            { importFrom = [ "Foo" ]
            , name = "a"
            , annotation = Just (Type.namedWith [ "Foo" ] "Foo" [ Type.int ])
            }
    }"""


suite : Test
suite =
    test "Aliases are codegenned properly" <|
        \_ ->
            case DocsFromSource.fromSource source of
                Err _ ->
                    Expect.fail "Could not parse source"

                Ok file ->
                    Generate.moduleToFile file
                        |> Expect.equal
                            { path = "Gen/Foo.elm"
                            , contents = expected
                            , warnings = []
                            }
