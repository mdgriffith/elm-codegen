module Internal.Compiler exposing (..)

import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation


type Annotation
    = Annotation AnnotationDetails


noImports tipe =
    Annotation
        { annotation = tipe
        , imports = []
        }


getInnerAnnotation (Annotation details) =
    details.annotation


getAnnotationImports (Annotation details) =
    details.imports


type alias AnnotationDetails =
    { imports : List Module
    , annotation : Annotation.TypeAnnotation
    }


{-| -}
type Expression
    = Expression ExpressionDetails


type alias ExpressionDetails =
    { skip : Bool
    , expression : Exp.Expression
    , annotation : Result (List InferenceError) Annotation.TypeAnnotation
    , imports : List Module
    }


{-| -}
skip : Expression
skip =
    Expression
        { skip = True
        , expression = Exp.UnitExpr
        , annotation = Err []
        , imports = []
        }


type InferenceError
    = MismatchedList Annotation.TypeAnnotation Annotation.TypeAnnotation
    | SomeOtherIssue
    | EmptyCaseStatement
    | ThisIsntARecord String
    | FunctionAppliedToTooManyArgs
    | DuplicateFieldInRecord String
    | CaseBranchesReturnDifferentTypes


{-| -}
type LetDeclaration
    = LetDeclaration (List Module) Exp.LetDeclaration


type Declaration
    = Declaration Expose (List Module) Declaration.Declaration


documentation : String -> Declaration -> Declaration
documentation doc ((Declaration exp imports body) as decl) =
    let
        str =
            "{-|" ++ doc ++ "-}"
    in
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


makeImport :
    Module
    ->
        Maybe
            (Node
                { moduleName : Node ModuleName.ModuleName
                , moduleAlias : Maybe (Node (List String))
                , exposingList : Maybe a
                }
            )
makeImport (Module name maybeAlias) =
    case name of
        [] ->
            Nothing

        _ ->
            Just
                (nodify
                    { moduleName = nodify name
                    , moduleAlias =
                        Maybe.map
                            (\al ->
                                nodify [ al ]
                            )
                            maybeAlias
                    , exposingList = Nothing
                    }
                )


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

                        Declaration.InfixDeclaration inf ->
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


getTypeAnnotation : Expression -> Maybe Annotation.TypeAnnotation
getTypeAnnotation (Expression exp) =
    case exp.annotation of
        Err _ ->
            Nothing

        Ok ann ->
            Just ann


extractListAnnotation :
    List Expression
    -> List Annotation.TypeAnnotation
    -> Result (List InferenceError) (List Annotation.TypeAnnotation)
extractListAnnotation expressions annotations =
    case expressions of
        [] ->
            Ok (List.reverse annotations)

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    extractListAnnotation remain (ann :: annotations)

                Err err ->
                    Err err


{-| -}
applyType : Expression -> List Expression -> Result (List InferenceError) Annotation.TypeAnnotation
applyType (Expression exp) args =
    case exp.annotation of
        Err err ->
            let
                _ =
                    Debug.log "NO TOP"
                        args
            in
            Err err

        Ok topAnnotation ->
            case extractListAnnotation args [] of
                Ok types ->
                    applyTypeHelper topAnnotation types

                Err err ->
                    let
                        _ =
                            Debug.log "LIST FAILED TO EXTRACT" "pleasse"
                    in
                    Err err



--Debug.log "result" <|
--    case args of
--        [] ->
--            exp.annotation
--
--        (Expression top) :: rest ->
--            case top.annotation of
--                Err err ->
--                    Err err
--
--                Ok topAnnotation ->
--                    let
--                        _ =
--                            Debug.log "arg" topAnnotation
--                    in
--                    case exp.annotation of
--                        Ok (Annotation.FunctionTypeAnnotation one two) ->
--                            -- if one and top match ->
--                            case unifiable topAnnotation (denode one) of
--                                Ok _ ->
--                                    case rest of
--                                        [] ->
--                                            Ok (denode two)
--
--                                        _ ->
--                                            applyType two rest
--
--                                Err err ->
--                                    Err []
--
--                        Ok final ->
--                            Err [ FunctionAppliedToTooManyArgs ]
--
--                        Err err ->
--                            Err err


{-| -}
applyTypeHelper : Annotation.TypeAnnotation -> List Annotation.TypeAnnotation -> Result (List InferenceError) Annotation.TypeAnnotation
applyTypeHelper fn args =
    case fn of
        Annotation.FunctionTypeAnnotation one two ->
            case args of
                [] ->
                    Ok fn

                top :: rest ->
                    -- if one and top match ->
                    case unifiable (denode one) top of
                        Ok _ ->
                            case rest of
                                [] ->
                                    Ok (denode two)

                                _ ->
                                    applyTypeHelper (denode two) rest

                        Err err ->
                            Err []

        final ->
            case args of
                [] ->
                    Ok fn

                _ ->
                    Err [ FunctionAppliedToTooManyArgs ]


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

    type TypeAnnotation
        = GenericType String
        | Typed (Node ( ModuleName, String )) (List (Node TypeAnnotation))
        | Unit
        | Tupled (List (Node TypeAnnotation))
        | Record RecordDefinition
        | GenericRecord (Node String) (Node RecordDefinition)
        | FunctionTypeAnnotation (Node TypeAnnotation) (Node TypeAnnotation)

-}
unifiable :
    Annotation.TypeAnnotation
    -> Annotation.TypeAnnotation
    -> Result String Annotation.TypeAnnotation
unifiable one two =
    let
        result =
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

        _ =
            case result of
                Ok _ ->
                    ( one, two )

                Err _ ->
                    Debug.log "       Failed to unify"
                        ( one, two )
    in
    result
