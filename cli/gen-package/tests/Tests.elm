module Tests exposing (suite)

import Ansi.Color
import Diff
import Diff.ToString
import DocsFromSource
import Expect
import Generate
import Test exposing (Test, test)


suite : Test
suite =
    testBinding "Parser" parserModule parserBindings


testBinding : String -> String -> String -> Test
testBinding label input output =
    test ("Produces the right bindings for " ++ label) <|
        \_ ->
            case DocsFromSource.fromSource input of
                Err e ->
                    Expect.fail e

                Ok parsed ->
                    (Generate.moduleToFile parsed).contents
                        |> expectEqualMultiline output


expectEqualMultiline : String -> String -> Expect.Expectation
expectEqualMultiline exp actual =
    if exp == actual then
        Expect.pass

    else
        let
            header : String
            header =
                Ansi.Color.fontColor Ansi.Color.blue "Diff from expected to actual:"
        in
        Expect.fail
            (header
                ++ "\n"
                ++ (Diff.diffLinesWith
                        (Diff.defaultOptions
                            |> Diff.ignoreLeadingWhitespace
                        )
                        exp
                        actual
                        |> Diff.ToString.diffToString { context = 4, color = True }
                   )
            )


parserModule : String
parserModule =
    """module Parser exposing (Trailing(..))

type Trailing
    = Optional
    | Forbidden
"""


parserBindings : String
parserBindings =
    """module Gen.Parser exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Parser

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Parser" ]


annotation_ : { trailing : Type.Annotation }
annotation_ =
    { trailing = Type.namedWith [ "Parser" ] "Trailing" [] }


make_ : { optional : Elm.Expression, forbidden : Elm.Expression }
make_ =
    { optional =
        Elm.value
            { importFrom = [ "Parser" ]
            , name = "Optional"
            , annotation = Just (Type.namedWith [ "Parser" ] "Trailing" [])
            }
    , forbidden =
        Elm.value
            { importFrom = [ "Parser" ]
            , name = "Forbidden"
            , annotation = Just (Type.namedWith [ "Parser" ] "Trailing" [])
            }
    }


caseOf_ :
    { trailing :
        Elm.Expression
        -> { optional : Elm.Expression, forbidden : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { trailing =
        \\trailingExpression trailingTags ->
            Elm.Case.custom
                trailingExpression
                (Type.namedWith [ "Parser" ] "Trailing" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Optional" trailingTags.optional)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Forbidden" trailingTags.forbidden)
                    Basics.identity
                ]
    }"""
