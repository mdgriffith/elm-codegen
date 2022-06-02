module Elm.ToString exposing (expression, annotation, declaration)

{-|


# Rendering to string

@docs expression, annotation, declaration

-}

import Elm exposing (Declaration, Expression)
import Elm.Annotation exposing (Annotation)
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Writer
import Internal.Compiler as Compiler
import Internal.Write


{-| -}
expression :
    Expression
    ->
        { imports : String
        , body : String
        , signature : String
        }
expression (Compiler.Expression toExp) =
    let
        expresh =
            toExp Compiler.startIndex
    in
    { imports =
        expresh
            |> Compiler.getImports
            |> List.filterMap (Compiler.makeImport [])
            |> Internal.Write.writeImports
    , body = Internal.Write.writeExpression expresh.expression
    , signature =
        case expresh.annotation of
            Ok sig ->
                case Compiler.resolve sig.inferences sig.type_ of
                    Ok finalType ->
                        Internal.Write.writeAnnotation finalType

                    Err errMsg ->
                        errMsg

            Err inferenceError ->
                List.foldl
                    (\err str ->
                        case str of
                            "" ->
                                Compiler.inferenceErrorToString err

                            _ ->
                                str ++ "\n\n" ++ Compiler.inferenceErrorToString err
                    )
                    "Err: "
                    inferenceError
    }


{-| -}
declaration :
    Declaration
    ->
        { imports : String
        , docs : String
        , signature : String
        , body : String
        }
declaration decl =
    { imports =
        case decl of
            Compiler.Declaration _ imps _ ->
                List.filterMap (Compiler.makeImport []) imps
                    |> Internal.Write.writeImports

            Compiler.Comment _ ->
                ""

            Compiler.Block _ ->
                ""
    , body = Internal.Write.writeDeclaration decl
    , docs =
        case decl of
            Compiler.Declaration _ _ (Declaration.FunctionDeclaration func) ->
                case func.documentation of
                    Nothing ->
                        ""

                    Just (Node.Node _ docs) ->
                        docs

            Compiler.Declaration _ _ _ ->
                ""

            Compiler.Comment _ ->
                ""

            Compiler.Block _ ->
                ""
    , signature =
        case decl of
            Compiler.Declaration _ _ (Declaration.FunctionDeclaration func) ->
                case func.signature of
                    Nothing ->
                        ""

                    Just (Node _ sig) ->
                        Internal.Write.writeSignature sig

            Compiler.Declaration _ _ _ ->
                ""

            Compiler.Comment _ ->
                ""

            Compiler.Block _ ->
                ""
    }


{-| -}
annotation :
    Annotation
    ->
        { imports : String
        , signature : String
        }
annotation (Compiler.Annotation ann) =
    { imports =
        List.filterMap (Compiler.makeImport []) ann.imports
            |> Internal.Write.writeImports
    , signature =
        Internal.Write.writeAnnotation ann.annotation
    }
