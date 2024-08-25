module Elm.Expect exposing (declarationAs, equal, fileContentAs, importAs, renderedAs)

import Elm
import Elm.ToString
import Expect exposing (Expectation)
import String.Multiline


renderedAs : Elm.Expression -> String -> Expectation
renderedAs expression str =
    (Elm.ToString.expression expression
        |> .body
    )
        |> Expect.equal
            (String.Multiline.here str)


importAs : Elm.Expression -> String -> Expectation
importAs expression str =
    Expect.equal
        (Elm.ToString.expression expression
            |> .imports
        )
        (String.Multiline.here str)


declarationAs : Elm.Declaration -> String -> Expectation
declarationAs decl str =
    Expect.equal
        (Elm.ToString.declaration decl
            |> List.map (\{ body } -> String.trim body)
            |> String.join "\n\n"
        )
        (String.Multiline.here str)


fileContentAs : Elm.File -> String -> Expectation
fileContentAs file str =
    Expect.equal
        (file
            |> .contents
            |> String.trim
        )
        (String.Multiline.here str)


equal : Elm.Expression -> Elm.Expression -> Expectation
equal one two =
    Expect.equal
        (Elm.ToString.expression one
            |> .body
        )
        (Elm.ToString.expression two
            |> .body
        )
