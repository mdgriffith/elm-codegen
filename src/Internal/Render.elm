module Internal.Render exposing (render)

{-| -}

import Elm.Syntax.Declaration
import Elm.Syntax.Documentation
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Module
import Elm.Syntax.Range as Range
import Internal.Comments
import Internal.Compiler as Compiler
import Internal.Index as Index
import Internal.Write
import Set


{-| -}
type alias File =
    { path : String
    , contents : String
    , warnings :
        List
            { declaration : String
            , warning : String
            }
    }


type alias Module =
    List String


type alias FileDetails =
    { moduleName : Module
    , aliases : List ( Module, String )
    , declarations : List Compiler.Declaration
    , index : Index.Index
    }


getExposedGroups : Compiler.Declaration -> List ExposedGroup -> List ExposedGroup
getExposedGroups decl groups =
    case decl of
        Compiler.Declaration decDetails ->
            case decDetails.exposed of
                Compiler.NotExposed ->
                    groups

                Compiler.Exposed _ ->
                    Exposed decDetails.name :: groups

        Compiler.Group group ->
            ExposedGroup
                { title = group.title
                , docs = group.docs
                , items = List.foldl getExposedGroups [] group.decls
                }
                :: groups

        _ ->
            groups


renderDecls :
    FileDetails
    -> Compiler.Declaration
    ->
        { declarations : List Compiler.RenderedDeclaration
        , imports : List Compiler.Module
        , exposed : List Expose.TopLevelExpose
        , hasPorts : Bool
        , warnings : List Compiler.Warning
        }
    ->
        { declarations : List Compiler.RenderedDeclaration
        , imports : List Compiler.Module
        , exposed : List Expose.TopLevelExpose
        , hasPorts : Bool
        , warnings : List Compiler.Warning
        }
renderDecls fileDetails decl gathered =
    case decl of
        Compiler.Comment comm ->
            { gathered | declarations = Compiler.RenderedComment comm :: gathered.declarations }

        Compiler.Block block ->
            { gathered | declarations = Compiler.RenderedBlock block :: gathered.declarations }

        Compiler.Declaration decDetails ->
            let
                result :
                    { declaration : Elm.Syntax.Declaration.Declaration
                    , additionalImports : List Compiler.Module
                    , warning : Maybe Compiler.Warning
                    }
                result =
                    decDetails.toBody fileDetails.index
            in
            { declarations =
                Compiler.RenderedDecl (addDocs decDetails.docs result.declaration) :: gathered.declarations
            , imports =
                result.additionalImports ++ decDetails.imports ++ gathered.imports
            , exposed =
                addExposed decDetails.exposed result.declaration gathered.exposed
            , hasPorts =
                if gathered.hasPorts then
                    gathered.hasPorts

                else
                    case result.declaration of
                        Elm.Syntax.Declaration.PortDeclaration _ ->
                            True

                        _ ->
                            False
            , warnings =
                case result.warning of
                    Nothing ->
                        gathered.warnings

                    Just warn ->
                        warn :: gathered.warnings
            }

        Compiler.Group group ->
            List.foldl (renderDecls fileDetails)
                gathered
                group.decls


type ExposedGroup
    = Exposed String
    | ExposedGroup
        { title : String
        , docs : String
        , items : List ExposedGroup
        }


{-| -}
render :
    String
    -> FileDetails
    -> File
render initialDocs fileDetails =
    let
        rendered :
            { declarations : List Compiler.RenderedDeclaration
            , imports : List Compiler.Module
            , exposed : List Expose.TopLevelExpose
            , hasPorts : Bool
            , warnings : List Compiler.Warning
            }
        rendered =
            List.foldl
                (renderDecls fileDetails)
                { imports = []
                , hasPorts = False
                , exposed = []
                , declarations = []
                , warnings = []
                }
                fileDetails.declarations

        body : String
        body =
            Internal.Write.write
                { moduleDefinition =
                    (if rendered.hasPorts then
                        Elm.Syntax.Module.PortModule

                     else
                        Elm.Syntax.Module.NormalModule
                    )
                        { moduleName = Compiler.nodify fileDetails.moduleName
                        , exposingList =
                            case rendered.exposed of
                                [] ->
                                    Compiler.nodify
                                        (Expose.All Range.emptyRange)

                                _ ->
                                    Compiler.nodify
                                        (Expose.Explicit
                                            (Compiler.nodifyAll rendered.exposed)
                                        )
                        }
                , aliases = fileDetails.aliases
                , imports =
                    rendered.imports
                        |> dedupImports
                        |> List.filterMap (Compiler.makeImport fileDetails.moduleName fileDetails.aliases)
                , declarations =
                    List.reverse rendered.declarations
                , comments =
                    let
                        exposedGroups : List ExposedGroup
                        exposedGroups =
                            List.foldl getExposedGroups [] fileDetails.declarations

                        docCommentString : String
                        docCommentString =
                            exposedGroupToMarkdown
                                (case rendered.exposed of
                                    [] ->
                                        OnlyGroups

                                    _ ->
                                        Everything
                                )
                                (List.reverse exposedGroups)
                                Normal
                                initialDocs
                    in
                    if String.trim docCommentString == "" then
                        Nothing

                    else
                        Just
                            (Internal.Comments.addPart
                                Internal.Comments.emptyComment
                                (Internal.Comments.Markdown
                                    (docCommentString ++ "\n")
                                )
                            )
                }
    in
    { path =
        String.join "/" fileDetails.moduleName ++ ".elm"
    , contents = body
    , warnings = rendered.warnings
    }


type RenderingMode
    = Normal
    | RenderingDocsLine


type DocMode
    = Everything
    | OnlyGroups


exposedGroupToMarkdown : DocMode -> List ExposedGroup -> RenderingMode -> String -> String
exposedGroupToMarkdown docMode groups mode rendered =
    case groups of
        [] ->
            case mode of
                Normal ->
                    rendered

                RenderingDocsLine ->
                    rendered

        (Exposed exposedName) :: rest ->
            case docMode of
                Everything ->
                    case mode of
                        Normal ->
                            if String.isEmpty rendered then
                                exposedGroupToMarkdown docMode rest RenderingDocsLine ("\n@docs " ++ exposedName)

                            else
                                exposedGroupToMarkdown docMode rest RenderingDocsLine (rendered ++ "\n\n@docs " ++ exposedName)

                        RenderingDocsLine ->
                            exposedGroupToMarkdown docMode rest mode (rendered ++ ", " ++ exposedName)

                OnlyGroups ->
                    exposedGroupToMarkdown docMode rest mode rendered

        (ExposedGroup group) :: rest ->
            let
                renderedSection =
                    exposedGroupToMarkdown docMode
                        (List.reverse group.items)
                        Normal
                        (let
                            hasTitle =
                                not (String.isEmpty group.title)

                            title =
                                if hasTitle then
                                    "## " ++ group.title

                                else
                                    ""

                            docsString =
                                if String.isEmpty group.docs then
                                    ""

                                else if hasTitle then
                                    "\n\n" ++ group.docs

                                else
                                    group.docs
                         in
                         title ++ docsString
                        )

                separator =
                    if String.isEmpty rendered then
                        "\n"

                    else
                        case mode of
                            Normal ->
                                "\n\n"

                            RenderingDocsLine ->
                                "\n\n"
            in
            exposedGroupToMarkdown docMode
                rest
                Normal
                (rendered
                    ++ separator
                    ++ renderedSection
                )


dedupImports : List Module -> List Module
dedupImports mods =
    List.foldl
        (\mod ( set, gathered ) ->
            let
                stringName : String
                stringName =
                    Compiler.fullModName mod
            in
            if Set.member stringName set then
                ( set, gathered )

            else
                ( Set.insert stringName set
                , mod :: gathered
                )
        )
        ( Set.empty, [] )
        mods
        |> Tuple.second
        |> List.sortBy Compiler.fullModName


addDocs : Maybe Elm.Syntax.Documentation.Documentation -> Elm.Syntax.Declaration.Declaration -> Elm.Syntax.Declaration.Declaration
addDocs maybeDoc decl =
    case maybeDoc of
        Nothing ->
            decl

        Just doc ->
            case decl of
                Elm.Syntax.Declaration.FunctionDeclaration func ->
                    Elm.Syntax.Declaration.FunctionDeclaration
                        { func
                            | documentation =
                                Just (Compiler.nodify doc)
                        }

                Elm.Syntax.Declaration.AliasDeclaration typealias ->
                    Elm.Syntax.Declaration.AliasDeclaration
                        { typealias
                            | documentation =
                                Just (Compiler.nodify doc)
                        }

                Elm.Syntax.Declaration.CustomTypeDeclaration typeDecl ->
                    Elm.Syntax.Declaration.CustomTypeDeclaration
                        { typeDecl
                            | documentation =
                                Just
                                    (Compiler.nodify doc)
                        }

                Elm.Syntax.Declaration.PortDeclaration _ ->
                    decl

                Elm.Syntax.Declaration.InfixDeclaration _ ->
                    decl

                Elm.Syntax.Declaration.Destructuring _ _ ->
                    decl


addExposed : Compiler.Expose -> Elm.Syntax.Declaration.Declaration -> List Expose.TopLevelExpose -> List Expose.TopLevelExpose
addExposed exposed declaration otherExposes =
    case exposed of
        Compiler.NotExposed ->
            otherExposes

        Compiler.Exposed details ->
            case declaration of
                Elm.Syntax.Declaration.FunctionDeclaration fn ->
                    let
                        fnName : String
                        fnName =
                            Compiler.denode (.name (Compiler.denode fn.declaration))
                    in
                    Expose.FunctionExpose fnName
                        :: otherExposes

                Elm.Syntax.Declaration.AliasDeclaration synonym ->
                    let
                        aliasName : String
                        aliasName =
                            Compiler.denode synonym.name
                    in
                    Expose.TypeOrAliasExpose aliasName
                        :: otherExposes

                Elm.Syntax.Declaration.CustomTypeDeclaration myType ->
                    let
                        typeName : String
                        typeName =
                            Compiler.denode myType.name
                    in
                    if details.exposeConstructor then
                        Expose.TypeExpose
                            { name = typeName
                            , open = Just Range.emptyRange
                            }
                            :: otherExposes

                    else
                        Expose.TypeOrAliasExpose typeName
                            :: otherExposes

                Elm.Syntax.Declaration.PortDeclaration myPort ->
                    let
                        typeName : String
                        typeName =
                            Compiler.denode myPort.name
                    in
                    Expose.FunctionExpose typeName
                        :: otherExposes

                Elm.Syntax.Declaration.InfixDeclaration _ ->
                    otherExposes

                Elm.Syntax.Declaration.Destructuring _ _ ->
                    otherExposes
