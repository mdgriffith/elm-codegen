module DocsFromSource exposing (fromSource)

{-| Given an elm module, parse it and generate a Docs Module: <https://package.elm-lang.org/packages/elm/project-metadata-utils/latest/Elm-Docs#Module>
-}

import Dict exposing (Dict)
import Elm.Docs
import Elm.Parser
import Elm.Processing
import Elm.Syntax.Declaration
import Elm.Syntax.Exposing
import Elm.Syntax.Expression
import Elm.Syntax.File
import Elm.Syntax.Import
import Elm.Syntax.Module
import Elm.Syntax.ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Signature
import Elm.Syntax.Type
import Elm.Syntax.TypeAlias
import Elm.Syntax.TypeAnnotation
import Elm.Type


fromSource : String -> Result String Elm.Docs.Module
fromSource source =
    case Elm.Parser.parse source of
        Err _ ->
            Err "Unable to parse"

        Ok raw ->
            raw
                |> Elm.Processing.process Elm.Processing.init
                |> toDocs
                |> Ok


type Exposed
    = All
    | Explicit (List ExposedValue)


type ExposedValue
    = Exposed String
    | ExposedConstructors String


toModuleNameAndExposed : { a | moduleName : Node Elm.Syntax.ModuleName.ModuleName, exposingList : Node Elm.Syntax.Exposing.Exposing } -> ( Elm.Syntax.ModuleName.ModuleName, Exposed )
toModuleNameAndExposed { moduleName, exposingList } =
    case exposingList of
        Node _ (Elm.Syntax.Exposing.All _) ->
            ( Node.value moduleName, All )

        Node _ (Elm.Syntax.Exposing.Explicit exposedVals) ->
            ( Node.value moduleName, Explicit (List.map (exposeValue << Node.value) exposedVals) )


exposeValue val =
    case val of
        Elm.Syntax.Exposing.InfixExpose str ->
            Exposed str

        Elm.Syntax.Exposing.FunctionExpose str ->
            Exposed str

        Elm.Syntax.Exposing.TypeOrAliasExpose name ->
            Exposed name

        Elm.Syntax.Exposing.TypeExpose { name, open } ->
            case open of
                Nothing ->
                    Exposed name

                Just _ ->
                    ExposedConstructors name


isExposed name exposed =
    case exposed of
        All ->
            True

        Explicit vals ->
            List.any (valueIsExposed name) vals


valueIsExposed : String -> ExposedValue -> Bool
valueIsExposed name exp =
    case exp of
        Exposed targetName ->
            name == targetName

        ExposedConstructors targetName ->
            name == targetName


isExposedConstructors : String -> Exposed -> Bool
isExposedConstructors name exposed =
    case exposed of
        All ->
            True

        Explicit vals ->
            List.any (valueIsExposedConstructors name) vals


valueIsExposedConstructors : String -> ExposedValue -> Bool
valueIsExposedConstructors name exp =
    case exp of
        Exposed _ ->
            False

        ExposedConstructors targetName ->
            name == targetName


toDocs : Elm.Syntax.File.File -> Elm.Docs.Module
toDocs file =
    let
        ( moduleName, exposingSet ) =
            case Node.value file.moduleDefinition of
                Elm.Syntax.Module.NormalModule mod ->
                    toModuleNameAndExposed mod

                Elm.Syntax.Module.PortModule mod ->
                    toModuleNameAndExposed mod

                Elm.Syntax.Module.EffectModule mod ->
                    toModuleNameAndExposed mod

        imports :
            { importedTypes : Dict String Elm.Syntax.ModuleName.ModuleName
            , aliases : Dict Elm.Syntax.ModuleName.ModuleName Elm.Syntax.ModuleName.ModuleName
            }
        imports =
            List.foldl gatherImport
                { importedTypes = Dict.empty
                , aliases = Dict.empty
                }
                file.imports

        context : Context
        context =
            { moduleName = moduleName
            , importedTypes = imports.importedTypes
            , aliases = imports.aliases
            }

        gathered =
            List.foldl (gather context exposingSet)
                { values = []
                , unions = []
                , aliases = []
                }
                file.declarations
    in
    { name =
        case Node.value file.moduleDefinition of
            Elm.Syntax.Module.NormalModule mod ->
                Node.value mod.moduleName
                    |> String.join "."

            Elm.Syntax.Module.PortModule mod ->
                Node.value mod.moduleName
                    |> String.join "."

            Elm.Syntax.Module.EffectModule mod ->
                Node.value mod.moduleName
                    |> String.join "."
    , comment =
        renderDocNames gathered.values
            ++ renderDocNames gathered.aliases
            ++ renderDocNames gathered.unions
    , unions = gathered.unions
    , aliases = gathered.aliases
    , values = gathered.values
    , binops = []
    }


gatherImport :
    Node Elm.Syntax.Import.Import
    ->
        { importedTypes : Dict String Elm.Syntax.ModuleName.ModuleName
        , aliases : Dict Elm.Syntax.ModuleName.ModuleName Elm.Syntax.ModuleName.ModuleName
        }
    ->
        { importedTypes : Dict String Elm.Syntax.ModuleName.ModuleName
        , aliases : Dict Elm.Syntax.ModuleName.ModuleName Elm.Syntax.ModuleName.ModuleName
        }
gatherImport (Node _ { moduleName, moduleAlias, exposingList }) acc =
    { importedTypes =
        case exposingList of
            Nothing ->
                acc.importedTypes

            Just (Node _ (Elm.Syntax.Exposing.All _)) ->
                -- TODO: handle this
                acc.importedTypes

            Just (Node _ (Elm.Syntax.Exposing.Explicit explicits)) ->
                List.foldl
                    (\(Node _ expose_) iacc ->
                        case expose_ of
                            Elm.Syntax.Exposing.InfixExpose _ ->
                                iacc

                            Elm.Syntax.Exposing.FunctionExpose _ ->
                                iacc

                            Elm.Syntax.Exposing.TypeOrAliasExpose name ->
                                Dict.insert name (Node.value moduleName) iacc

                            Elm.Syntax.Exposing.TypeExpose { name } ->
                                Dict.insert name (Node.value moduleName) iacc
                    )
                    acc.importedTypes
                    explicits
    , aliases =
        case moduleAlias of
            Nothing ->
                acc.aliases

            Just (Node _ aliasName) ->
                Dict.insert aliasName (Node.value moduleName) acc.aliases
    }


renderDocNames : List { whatever | name : String } -> String
renderDocNames names =
    "\n\n@docs "
        ++ (List.map .name names
                |> String.join ", "
           )


type alias Context =
    { moduleName : Elm.Syntax.ModuleName.ModuleName
    , importedTypes : Dict String Elm.Syntax.ModuleName.ModuleName
    , aliases : Dict Elm.Syntax.ModuleName.ModuleName Elm.Syntax.ModuleName.ModuleName
    }


gather :
    Context
    -> Exposed
    -> Node.Node Elm.Syntax.Declaration.Declaration
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
gather context exposed node found =
    case Node.value node of
        Elm.Syntax.Declaration.FunctionDeclaration fn ->
            let
                (Node _ fnName) =
                    Node.value fn.declaration
                        |> .name
            in
            if isExposed fnName exposed then
                case toDocValue context fn of
                    Nothing ->
                        found

                    Just val ->
                        { found
                            | values = val :: found.values
                        }

            else
                found

        Elm.Syntax.Declaration.AliasDeclaration alias ->
            let
                aliasName =
                    Node.value alias.name
            in
            if isExposed aliasName exposed then
                { found
                    | aliases = toDocAlias context alias :: found.aliases
                }

            else
                found

        Elm.Syntax.Declaration.CustomTypeDeclaration type_ ->
            let
                typeName =
                    Node.value type_.name
            in
            if isExposedConstructors typeName exposed then
                { found
                    | unions = toDocUnion context type_ :: found.unions
                }

            else if isExposed typeName exposed then
                { found
                    | unions = toDocUnionOpaque type_ :: found.unions
                }

            else
                found

        Elm.Syntax.Declaration.PortDeclaration portSignature ->
            let
                portName =
                    Node.value portSignature.name
            in
            if isExposed portName exposed then
                { found
                    | values = portToValue context portSignature :: found.values
                }

            else
                found

        Elm.Syntax.Declaration.InfixDeclaration _ ->
            found

        Elm.Syntax.Declaration.Destructuring _ _ ->
            found


portToValue : Context -> Elm.Syntax.Signature.Signature -> Elm.Docs.Value
portToValue context signature =
    { name =
        Node.value signature.name
    , comment = ""
    , tipe =
        signature.typeAnnotation
            |> toDocType context
    }


toDocValue : Context -> Elm.Syntax.Expression.Function -> Maybe Elm.Docs.Value
toDocValue context fn =
    Maybe.map
        (\signature ->
            { name =
                case Node.value fn.declaration of
                    implementation ->
                        Node.value implementation.name
            , comment =
                case fn.documentation of
                    Nothing ->
                        ""

                    Just doc ->
                        Node.value doc
            , tipe =
                Node.value signature
                    |> .typeAnnotation
                    |> toDocType context
            }
        )
        fn.signature


toDocUnion : Context -> Elm.Syntax.Type.Type -> Elm.Docs.Union
toDocUnion context type_ =
    { name = Node.value type_.name
    , comment =
        case type_.documentation of
            Nothing ->
                ""

            Just doc ->
                Node.value doc
    , args = List.map Node.value type_.generics
    , tags =
        List.map
            (\const ->
                case Node.value const of
                    node ->
                        ( Node.value node.name
                        , List.map (toDocType context) node.arguments
                        )
            )
            type_.constructors
    }


toDocUnionOpaque : Elm.Syntax.Type.Type -> Elm.Docs.Union
toDocUnionOpaque type_ =
    { name = Node.value type_.name
    , comment =
        case type_.documentation of
            Nothing ->
                ""

            Just doc ->
                Node.value doc
    , args = List.map Node.value type_.generics
    , tags =
        []
    }


toDocAlias : Context -> Elm.Syntax.TypeAlias.TypeAlias -> Elm.Docs.Alias
toDocAlias context typeAlias =
    { name = Node.value typeAlias.name
    , comment =
        case typeAlias.documentation of
            Nothing ->
                ""

            Just str ->
                Node.value str
    , args = List.map Node.value typeAlias.generics
    , tipe =
        typeAlias.typeAnnotation
            |> toDocType context
    }


toDocType : Context -> Node Elm.Syntax.TypeAnnotation.TypeAnnotation -> Elm.Type.Type
toDocType context (Node _ annotation) =
    case annotation of
        Elm.Syntax.TypeAnnotation.GenericType var ->
            Elm.Type.Var var

        Elm.Syntax.TypeAnnotation.Typed modName inner ->
            let
                typeName : String
                typeName =
                    case Node.value modName of
                        -- This is the list found at https://package.elm-lang.org/packages/elm/core/latest/
                        ( [], "List" ) ->
                            "List.List"

                        ( [], "Maybe" ) ->
                            "Maybe.Maybe"

                        ( [], "Result" ) ->
                            "Result.Result"

                        ( [], "String" ) ->
                            "String.String"

                        ( [], "Char" ) ->
                            "Char.Char"

                        -- Plus the types coming from Basics itself
                        ( [], "Int" ) ->
                            "Basics.Int"

                        ( [], "Float" ) ->
                            "Basics.Float"

                        ( [], "Bool" ) ->
                            "Basics.Bool"

                        ( [], "Order" ) ->
                            "Basics.Order"

                        ( [], "Never" ) ->
                            "Basics.Never"

                        ( [], valName ) ->
                            case Dict.get valName context.importedTypes of
                                Nothing ->
                                    String.join "." context.moduleName ++ "." ++ valName

                                Just moduleName ->
                                    String.join "." moduleName ++ "." ++ valName

                        ( mod, valName ) ->
                            case Dict.get mod context.aliases of
                                Nothing ->
                                    String.join "." mod ++ "." ++ valName

                                Just moduleName ->
                                    String.join "." moduleName ++ "." ++ valName
            in
            Elm.Type.Type typeName
                (List.map (toDocType context) inner)

        Elm.Syntax.TypeAnnotation.Unit ->
            Elm.Type.Tuple []

        Elm.Syntax.TypeAnnotation.Tupled inner ->
            Elm.Type.Tuple (List.map (toDocType context) inner)

        Elm.Syntax.TypeAnnotation.Record fields ->
            Elm.Type.Record
                (List.map
                    (\f ->
                        case Node.value f of
                            ( name, fieldAnnotation ) ->
                                ( Node.value name
                                , toDocType context fieldAnnotation
                                )
                    )
                    fields
                )
                Nothing

        Elm.Syntax.TypeAnnotation.GenericRecord recordName fields ->
            Elm.Type.Record
                (List.map
                    (\f ->
                        case Node.value f of
                            ( name, fieldAnnotation ) ->
                                ( Node.value name
                                , toDocType context fieldAnnotation
                                )
                    )
                    (Node.value fields)
                )
                (Just (Node.value recordName))

        Elm.Syntax.TypeAnnotation.FunctionTypeAnnotation one two ->
            Elm.Type.Lambda
                (toDocType context one)
                (toDocType context two)
