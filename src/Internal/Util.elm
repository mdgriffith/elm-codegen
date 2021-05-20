module Internal.Util exposing (..)

import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation


{-| -}
type Expression
    = Expression ExpressionDetails


type alias ExpressionDetails =
    { expression : Exp.Expression
    , annotation : Result (List InferenceError) Annotation.TypeAnnotation
    , imports : List Module
    }


type InferenceError
    = MismatchedList Annotation.TypeAnnotation Annotation.TypeAnnotation
    | SomeOtherIssue
    | EmptyCaseStatement
    | ThisIsntARecord String
    | DuplicateFieldInRecord String
    | CaseBranchesReturnDifferentTypes


{-| -}
type LetDeclaration
    = LetDeclaration (List Module) Exp.LetDeclaration


type Declaration
    = Declaration Expose (List Module) Declaration.Declaration


documentation : String -> Declaration -> Declaration
documentation str ((Declaration exp imports body) as decl) =
    --Declaration exp imports body
    case body of
        Declaration.FunctionDeclaration func ->
            Declaration exp
                imports
                (Declaration.FunctionDeclaration
                    { func | documentation = Just (nodify str) }
                )

        Declaration.AliasDeclaration typealias ->
            Declaration exp
                imports
                (Declaration.AliasDeclaration
                    { typealias | documentation = Just (nodify str) }
                )

        Declaration.CustomTypeDeclaration typeDecl ->
            Declaration exp
                imports
                (Declaration.CustomTypeDeclaration
                    { typeDecl | documentation = Just (nodify str) }
                )

        Declaration.PortDeclaration sig ->
            decl

        Declaration.InfixDeclaration _ ->
            decl

        Declaration.Destructuring _ _ ->
            decl


{-| -}
expose : Declaration -> Declaration
expose (Declaration _ imports body) =
    Declaration Exposed imports body


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor (Declaration metadata imports body) =
    Declaration ExposedConstructor imports body


type Module
    = Module ModuleName.ModuleName (Maybe String)


makeImport (Module name maybeAlias) =
    nodify
        { moduleName = nodify name
        , moduleAlias =
            Maybe.map
                (\al ->
                    nodify [ al ]
                )
                maybeAlias
        , exposingList = Nothing
        }


fullModName : Module -> String
fullModName (Module name _) =
    String.join "." name


{-| -}
hasPorts : List Declaration -> Bool
hasPorts decls =
    List.any
        (\(Declaration exp _ decBody) ->
            case exp of
                NotExposed ->
                    False

                Exposed ->
                    case decBody of
                        Declaration.PortDeclaration myPort ->
                            True

                        _ ->
                            False

                ExposedConstructor ->
                    case decBody of
                        Declaration.PortDeclaration myPort ->
                            True

                        _ ->
                            False
        )
        decls


getExposed : List Declaration -> List Expose.TopLevelExpose
getExposed decls =
    List.filterMap
        (\(Declaration exp _ decBody) ->
            case exp of
                NotExposed ->
                    Nothing

                Exposed ->
                    case decBody of
                        Declaration.FunctionDeclaration fn ->
                            let
                                fnName =
                                    denode (.name (denode fn.declaration))
                            in
                            Expose.FunctionExpose fnName
                                |> Just

                        Declaration.AliasDeclaration synonym ->
                            let
                                aliasName =
                                    denode synonym.name
                            in
                            Expose.TypeOrAliasExpose aliasName
                                |> Just

                        Declaration.CustomTypeDeclaration myType ->
                            let
                                typeName =
                                    denode myType.name
                            in
                            Expose.TypeOrAliasExpose typeName
                                |> Just

                        Declaration.PortDeclaration myPort ->
                            let
                                typeName =
                                    denode myPort.name
                            in
                            Expose.FunctionExpose typeName
                                |> Just

                        Declaration.InfixDeclaration infix ->
                            Nothing

                        Declaration.Destructuring _ _ ->
                            Nothing

                ExposedConstructor ->
                    case decBody of
                        Declaration.FunctionDeclaration fn ->
                            let
                                fnName =
                                    denode (.name (denode fn.declaration))
                            in
                            Expose.FunctionExpose fnName
                                |> Just

                        Declaration.AliasDeclaration synonym ->
                            let
                                aliasName =
                                    denode synonym.name
                            in
                            Expose.TypeOrAliasExpose aliasName
                                |> Just

                        Declaration.CustomTypeDeclaration myType ->
                            let
                                typeName =
                                    denode myType.name
                            in
                            Expose.TypeExpose
                                { name = typeName
                                , open = Just Range.emptyRange
                                }
                                |> Just

                        Declaration.PortDeclaration myPort ->
                            let
                                typeName =
                                    denode myPort.name
                            in
                            Expose.FunctionExpose typeName
                                |> Just

                        Declaration.InfixDeclaration infix ->
                            Nothing

                        Declaration.Destructuring _ _ ->
                            Nothing
        )
        decls


getModule : Module -> ModuleName.ModuleName
getModule (Module name _) =
    name


type Expose
    = NotExposed
    | Exposed
    | ExposedConstructor


emptyModule : Module
emptyModule =
    inModule []


inModule : List String -> Module
inModule mods =
    Module (List.map formatType mods) Nothing


moduleAs : List String -> String -> Module
moduleAs mods modAlias =
    Module (List.map formatType mods) (Just modAlias)


unpack : Module -> ModuleName.ModuleName
unpack (Module name maybeAlias) =
    case maybeAlias of
        Nothing ->
            name

        Just modAlias ->
            [ modAlias ]


denode : Node a -> a
denode =
    Node.value


denodeAll : List (Node a) -> List a
denodeAll =
    List.map denode


denodeMaybe : Maybe (Node a) -> Maybe a
denodeMaybe =
    Maybe.map denode


nodify : a -> Node a
nodify exp =
    Node Range.emptyRange exp


nodifyAll : List a -> List (Node a)
nodifyAll =
    List.map nodify


nodifyMaybe : Maybe a -> Maybe (Node a)
nodifyMaybe =
    Maybe.map nodify


nodifyTuple : ( a, b ) -> ( Node a, Node b )
nodifyTuple ( a, b ) =
    ( nodify a, nodify b )


formatValue : String -> String
formatValue str =
    String.toLower (String.left 1 str) ++ String.dropLeft 1 str


formatType : String -> String
formatType str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


unify : List Expression -> Result (List InferenceError) Annotation.TypeAnnotation
unify exps =
    case exps of
        [] ->
            Ok (Annotation.GenericType "a")

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    unifyHelper remain ann

                Err err ->
                    Err err


unifyHelper :
    List Expression
    -> Annotation.TypeAnnotation
    -> Result (List InferenceError) Annotation.TypeAnnotation
unifyHelper exps existing =
    case exps of
        [] ->
            Ok existing

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    case unifiable ann existing of
                        Err _ ->
                            Err [ MismatchedList ann existing ]

                        Ok new ->
                            unifyHelper remain new

                Err err ->
                    Err err


{-| This is definitely not correct, but will do for now!
-}
unifiable :
    Annotation.TypeAnnotation
    -> Annotation.TypeAnnotation
    -> Result String Annotation.TypeAnnotation
unifiable one two =
    case one of
        Annotation.GenericType a ->
            Ok two

        otherwise ->
            case two of
                Annotation.GenericType b ->
                    Ok one

                _ ->
                    if one == two then
                        Ok one

                    else
                        Err "Unable to unify"
