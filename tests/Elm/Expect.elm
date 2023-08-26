module Elm.Expect exposing (declarationAs, equal, fileContentAs, importAs, renderedAs)

import Elm
import Elm.ToString
import Expect exposing (Expectation)
import Internal.Compiler as Compiler
import Internal.Index as Index


renderedAs : Elm.Expression -> String -> Expectation
renderedAs expression str =
    (Elm.ToString.expression expression
        |> .body
    )
        |> Expect.equal
            (String.trim str)


importAs : Elm.Expression -> String -> Expectation
importAs expression str =
    Expect.equal
        (Elm.ToString.expression expression
            |> .imports
        )
        (String.trim str)


declarationAs : Elm.Declaration -> String -> Expectation
declarationAs decl str =
    Expect.equal
        (Elm.ToString.declaration decl
            |> .body
            |> String.trim
        )
        (String.trim str)


fileContentAs : Elm.File -> String -> Expectation
fileContentAs file str =
    Expect.equal
        (file
            |> .contents
            |> String.trim
        )
        (String.trim str)


infersType : Elm.Expression -> Expectation
infersType expression =
    let
        ( _, details ) =
            Compiler.toExpressionDetails Index.startIndex expression
    in
    case details.annotation of
        Ok _ ->
            Expect.pass

        Err errs ->
            Expect.fail
                ("Failed to typecheck"
                    ++ String.join "\n"
                        (List.map Compiler.inferenceErrorToString errs)
                )


equal : Elm.Expression -> Elm.Expression -> Expectation
equal one two =
    Expect.equal
        (Elm.ToString.expression one
            |> .body
        )
        (Elm.ToString.expression two
            |> .body
        )
