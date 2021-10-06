module DocsFromSource exposing (fromSource)

{-|

Given an elm module, parse it and generate a Docs Module: https://package.elm-lang.org/packages/elm/project-metadata-utils/latest/Elm-Docs#Module

-}

import Elm.Docs
import Elm.Parser
import Elm.Processing
import Elm.Syntax.File
import Internal.Compiler as Compiler
import Elm.Syntax.Module
import Elm.Syntax.Declaration
import Elm.Syntax.Node as Node
import Elm.Syntax.TypeAlias
import Elm.Type
import Elm.Syntax.TypeAnnotation
import Elm.Syntax.Type
import Elm.Syntax.Expression
import Elm.Syntax.Signature


fromSource : String -> Result String Elm.Docs.Module
fromSource source =
    case Elm.Parser.parse source of
        Err deadends ->
            Err "Unable to parse"

        Ok raw ->
            raw
                |> Elm.Processing.process Elm.Processing.init
                |> toDocs
                |> Ok


toDocs : Elm.Syntax.File.File  -> Elm.Docs.Module
toDocs file =
    let
        gathered =
            List.foldl gather
                { values = []
                , unions = []
                , aliases = []
                }
                file.declarations

    in
    { name =
        case Compiler.denode file.moduleDefinition of
            Elm.Syntax.Module.NormalModule mod ->
                Compiler.denode mod.moduleName
                    |> String.join "."

            Elm.Syntax.Module.PortModule mod ->
                Compiler.denode mod.moduleName
                    |> String.join "."

            Elm.Syntax.Module.EffectModule mod ->
                Compiler.denode mod.moduleName
                    |> String.join "."
    , comment = ""
    , unions = gathered.unions
    , aliases = gathered.aliases
    , values = gathered.values
    , binops = []
    }


gather : Node.Node Elm.Syntax.Declaration.Declaration
    ->
        { values : List Elm.Docs.Value
        , aliases : List Elm.Docs.Alias
        , unions : List Elm.Docs.Union
        }
    ->
        { values : List Elm.Docs.Value
        , aliases : List Elm.Docs.Alias
        , unions : List Elm.Docs.Union
        }
gather node found =
    case Compiler.denode node of
        Elm.Syntax.Declaration.FunctionDeclaration fn ->
            case toDocValue fn of
                Nothing ->
                    found

                Just val ->
                    { found
                        | values = val :: found.values
                    }

        Elm.Syntax.Declaration.AliasDeclaration alias ->
            { found
                | aliases = toDocAlias alias :: found.aliases
            }

        Elm.Syntax.Declaration.CustomTypeDeclaration type_ ->
            { found
                | unions = toDocUnion type_ :: found.unions
            }

        Elm.Syntax.Declaration.PortDeclaration portSignature ->
            { found
                | values = portToValue portSignature :: found.values
            }

        Elm.Syntax.Declaration.InfixDeclaration inf ->
            found

        Elm.Syntax.Declaration.Destructuring _ _ ->
            found


portToValue : Elm.Syntax.Signature.Signature -> Elm.Docs.Value
portToValue signature =
     { name =
        Compiler.denode signature.name
    , comment = ""
    , tipe =
        (signature.typeAnnotation
            |> Compiler.denode
            |> toDocType
        )

    }

toDocValue : Elm.Syntax.Expression.Function -> Maybe Elm.Docs.Value
toDocValue fn =
    case fn.signature of
        Nothing ->
            Nothing

        Just signature ->
            Just
                { name =
                    case Compiler.denode fn.declaration of
                        implementation ->
                            Compiler.denode implementation.name
                , comment =
                    case fn.documentation of
                        Nothing ->
                            ""
                        Just doc ->
                            Compiler.denode doc
                , tipe =
                    (Compiler.denode signature
                        |> .typeAnnotation
                        |> Compiler.denode
                        |> toDocType
                    )

                }



toDocUnion : Elm.Syntax.Type.Type -> Elm.Docs.Union
toDocUnion type_ =
    { name = Compiler.denode type_.name
    , comment =
        case type_.documentation of
            Nothing ->
                ""
            Just doc ->
                Compiler.denode doc
    , args =  List.map Compiler.denode type_.generics
    , tags =
        List.map
            (\const ->
                case Compiler.denode const of
                    node ->
                        ( Compiler.denode node.name
                        , List.map (Compiler.denode >> toDocType) node.arguments
                        )
            )
            type_.constructors
    }




toDocAlias : Elm.Syntax.TypeAlias.TypeAlias -> Elm.Docs.Alias
toDocAlias typeAlias =
    { name = Compiler.denode typeAlias.name
    , comment =
        case typeAlias.documentation of
            Nothing ->
                ""
            Just str ->
                Compiler.denode str
    , args = List.map Compiler.denode typeAlias.generics
    , tipe =
        typeAlias.typeAnnotation
            |> Compiler.denode
            |> toDocType
    }


toDocType : Elm.Syntax.TypeAnnotation.TypeAnnotation -> Elm.Type.Type
toDocType annotation =
    case annotation of
        Elm.Syntax.TypeAnnotation.GenericType var ->
            Elm.Type.Var var

        Elm.Syntax.TypeAnnotation.Typed modName inner ->
            let
                typeName =
                    case Compiler.denode modName of
                        ([], valName) ->
                            valName

                        (mod, valName) ->
                            String.join "." mod ++ "." ++ valName
            in
            Elm.Type.Type typeName
                (List.map (Compiler.denode >> toDocType) inner)

        Elm.Syntax.TypeAnnotation.Unit ->
            Elm.Type.Tuple []

        Elm.Syntax.TypeAnnotation.Tupled inner ->
            Elm.Type.Tuple (List.map (toDocType << Compiler.denode) inner)

        Elm.Syntax.TypeAnnotation.Record fields ->
            Elm.Type.Record
                (List.map
                    (\f ->
                        case Compiler.denode f of
                            (name, fieldAnnotation) ->
                                ( Compiler.denode name
                                , toDocType
                                    (Compiler.denode fieldAnnotation)
                                )
                    )
                    fields
                )
                Nothing

        Elm.Syntax.TypeAnnotation.GenericRecord recordName fields ->
             Elm.Type.Record
                (List.map
                    (\f ->
                        case Compiler.denode f of
                            (name, fieldAnnotation) ->
                                ( Compiler.denode name
                                , toDocType
                                    (Compiler.denode fieldAnnotation)
                                )
                    )
                    (Compiler.denode fields)
                )
                (Just (Compiler.denode recordName))

        Elm.Syntax.TypeAnnotation.FunctionTypeAnnotation one two ->
            Elm.Type.Lambda
                (toDocType (Compiler.denode one))
                (toDocType (Compiler.denode two))


