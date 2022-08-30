module Elm.ToString exposing
    ( expression, annotation, declaration
    , expressionWith, annotationWith, declarationWith
    )

{-| Convert values to a string!

This can be useful if you're generating examples or just playing with the library and want to get an intuition for it.

@docs expression, annotation, declaration


## With Import Aliases

If you want further control over import aliases,

@docs expressionWith, annotationWith, declarationWith

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
expression =
    expressionWith noAliases


noAliases : { aliases : List ( List String, String ) }
noAliases =
    { aliases = [] }


{-| -}
expressionWith :
    { aliases : List ( List String, String ) }
    -> Expression
    ->
        { imports : String
        , body : String
        , signature : String
        }
expressionWith options (Compiler.Expression toExp) =
    let
        expresh =
            toExp Compiler.startIndex
    in
    { imports =
        expresh
            |> Compiler.getImports
            |> List.filterMap (Compiler.makeImport options.aliases)
            |> Internal.Write.writeImports
    , body = Internal.Write.writeExpressionWith options.aliases expresh.expression
    , signature =
        case expresh.annotation of
            Ok sig ->
                case Compiler.resolve Compiler.startIndex sig.inferences sig.type_ of
                    Ok finalType ->
                        Internal.Write.writeAnnotationWith options.aliases finalType

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
declaration =
    declarationWith noAliases


{-| -}
declarationWith :
    { aliases : List ( List String, String ) }
    -> Declaration
    ->
        { imports : String
        , docs : String
        , signature : String
        , body : String
        }
declarationWith options decl =
    { imports =
        case decl of
            Compiler.Declaration _ imps _ ->
                List.filterMap (Compiler.makeImport options.aliases) imps
                    |> Internal.Write.writeImports

            Compiler.Comment _ ->
                ""

            Compiler.Block _ ->
                ""
    , body = Internal.Write.writeDeclarationWith options.aliases decl
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
                        Internal.Write.writeSignatureWith options.aliases sig

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
annotation =
    annotationWith noAliases


{-| -}
annotationWith :
    { aliases : List ( List String, String ) }
    -> Annotation
    ->
        { imports : String
        , signature : String
        }
annotationWith options (Compiler.Annotation ann) =
    { imports =
        List.filterMap (Compiler.makeImport options.aliases) ann.imports
            |> Internal.Write.writeImports
    , signature =
        Internal.Write.writeAnnotationWith options.aliases ann.annotation
    }
