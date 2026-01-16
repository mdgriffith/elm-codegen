module Elm.Expect exposing (declarationAs, equal, expectEqualMultiline, fileContentAs, importAs, importAsWith, renderedAs, renderedAsWith)

import Ansi.Color
import Diff
import Diff.ToString
import Elm
import Elm.ToString
import Expect exposing (Expectation)
import String.Multiline


renderedAs : String -> Elm.Expression -> Expectation
renderedAs str expression =
    Elm.ToString.expression expression
        |> .body
        |> expectEqualMultiline
            (String.Multiline.here str)


renderedAsWith :
    { aliases : List ( List String, String ) }
    -> String
    -> Elm.Expression
    -> Expectation
renderedAsWith options str expression =
    Elm.ToString.expressionWith options expression
        |> .body
        |> expectEqualMultiline
            (String.Multiline.here str)


importAs : String -> Elm.Expression -> Expectation
importAs str expression =
    Elm.ToString.expression expression
        |> .imports
        |> expectEqualMultiline
            (String.Multiline.here str)


importAsWith :
    { aliases : List ( List String, String ) }
    -> String
    -> Elm.Expression
    -> Expectation
importAsWith options str expression =
    Elm.ToString.expressionWith options expression
        |> .imports
        |> expectEqualMultiline
            (String.Multiline.here str)


declarationAs : String -> Elm.Declaration -> Expectation
declarationAs str decl =
    Elm.ToString.declaration decl
        |> List.map (\{ body } -> body)
        |> String.join "\n\n"
        |> expectEqualMultiline
            (String.Multiline.here str)


fileContentAs : String -> Elm.File -> Expectation
fileContentAs str file =
    file
        |> .contents
        |> String.trim
        |> expectEqualMultiline
            (String.Multiline.here str)


equal : Elm.Expression -> Elm.Expression -> Expectation
equal one two =
    Elm.ToString.expression two
        |> .body
        |> expectEqualMultiline
            (Elm.ToString.expression one
                |> .body
            )


expectEqualMultiline : String -> String -> Expect.Expectation
expectEqualMultiline exp actual =
    let
        trimLeadingWhitespace str =
            str
                |> String.split "\n"
                |> List.map String.trimRight
                |> String.join "\n"
    in
    if trimLeadingWhitespace exp == trimLeadingWhitespace actual then
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
                        Diff.defaultOptions
                        exp
                        actual
                        |> Diff.ToString.diffToString { context = 4, color = True }
                   )
            )
