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
import Internal.Clean as Clean
import Internal.Compiler as Compiler
import Internal.Index as Index
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
        index =
            Index.startIndex Nothing

        expresh : Compiler.ExpressionDetails
        expresh =
            toExp index
    in
    { imports =
        expresh
            |> Compiler.getImports
            |> List.filterMap (Compiler.makeImport [] options.aliases)
            |> Internal.Write.writeImports
    , body = Internal.Write.writeExpressionWith options.aliases expresh.expression
    , signature =
        case expresh.annotation of
            Ok sig ->
                case Compiler.resolve (Index.startIndex Nothing) sig.inferences sig.type_ of
                    Ok finalType ->
                        Internal.Write.writeAnnotationWith options.aliases (Clean.clean index finalType)

                    Err errMsg ->
                        errMsg

            Err inferenceError ->
                "Err: "
                    ++ String.join
                        "\n\n"
                        (List.map Compiler.inferenceErrorToString inferenceError)
    }


{-| -}
declaration :
    Declaration
    ->
        List
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
        List
            { imports : String
            , docs : String
            , signature : String
            , body : String
            }
declarationWith options decl =
    case decl of
        Compiler.Group group ->
            List.concatMap (declarationWith options) group.decls

        Compiler.Declaration { imports, docs, toBody } ->
            let
                index =
                    Index.startIndex Nothing

                rendered :
                    { declaration : Declaration.Declaration
                    , additionalImports : List Compiler.Module
                    , warning : Maybe Compiler.Warning
                    }
                rendered =
                    toBody index
            in
            [ { imports =
                    imports
                        ++ rendered.additionalImports
                        |> List.filterMap (Compiler.makeImport [] options.aliases)
                        |> Internal.Write.writeImports
              , body = Internal.Write.writeDeclarationWith options.aliases (Compiler.RenderedDecl rendered.declaration)
              , docs =
                    Maybe.withDefault "" docs
              , signature =
                    case rendered.declaration of
                        Declaration.FunctionDeclaration func ->
                            case func.signature of
                                Nothing ->
                                    ""

                                Just (Node _ sig) ->
                                    Internal.Write.writeSignatureWith options.aliases
                                        { name = sig.name
                                        , typeAnnotation = Node.map (Clean.clean index) sig.typeAnnotation
                                        }

                        _ ->
                            ""
              }
            ]

        Compiler.Comment comm ->
            [ { imports =
                    ""
              , body = Internal.Write.writeDeclarationWith options.aliases (Compiler.RenderedComment comm)
              , docs =
                    ""
              , signature =
                    ""
              }
            ]

        Compiler.Block block ->
            [ { imports =
                    ""
              , body = Internal.Write.writeDeclarationWith options.aliases (Compiler.RenderedBlock block)
              , docs =
                    ""
              , signature =
                    ""
              }
            ]


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
        List.filterMap (Compiler.makeImport [] options.aliases) ann.imports
            |> Internal.Write.writeImports
    , signature =
        Internal.Write.writeAnnotationWith options.aliases ann.annotation
    }
