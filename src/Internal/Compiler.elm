module Internal.Compiler exposing (..)

import Dict
import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation


type Annotation
    = Annotation AnnotationDetails


getGenerics : Annotation -> List (Node String)
getGenerics (Annotation details) =
    getGenericsHelper details.annotation


getGenericsHelper : Annotation.TypeAnnotation -> List (Node String)
getGenericsHelper ann =
    case ann of
        Annotation.GenericType str ->
            [ nodify str ]

        Annotation.Typed modName anns ->
            List.concatMap (getGenericsHelper << denode) anns

        Annotation.Unit ->
            []

        Annotation.Tupled tupled ->
            List.concatMap (getGenericsHelper << denode) tupled

        Annotation.Record recordDefinition ->
            List.concatMap
                (\nodedField ->
                    case denode nodedField of
                        (name, field) ->
                            getGenericsHelper  (denode field)

                )
                (recordDefinition)

        Annotation.GenericRecord recordName recordDefinition ->
            List.concatMap
                (\nodedField ->
                    case denode nodedField of
                        (name, field) ->
                            getGenericsHelper  (denode field)

                )
                (denode recordDefinition)

        Annotation.FunctionTypeAnnotation one two ->
            List.concatMap getGenericsHelper
                [ denode one
                , denode two
                ]


noImports : Annotation.TypeAnnotation -> Annotation
noImports tipe =
    Annotation
        { annotation = tipe
        , imports = []
        }


getInnerAnnotation : Annotation -> Annotation.TypeAnnotation
getInnerAnnotation (Annotation details) =
    details.annotation


getAnnotationImports : Annotation -> List Module
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


getImports : Expression -> List Module
getImports (Expression exp) =
    exp.imports


getInnerExpression : Expression -> Exp.Expression
getInnerExpression (Expression exp) =
    exp.expression


getAnnotation : Expression -> Result (List InferenceError) Annotation.TypeAnnotation
getAnnotation (Expression exp) =
    exp.annotation


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
    | CouldNotFindField String


{-| -}
type LetDeclaration
    = LetDeclaration (List Module) Exp.LetDeclaration


type Declaration
    = Declaration Expose (List Module) Declaration.Declaration
    | Comment String


documentation : String -> Declaration -> Declaration
documentation doc decl =
    case decl of
        Comment _ ->
            decl

        Declaration exp imports body ->
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
expose decl =
    case decl of
        Comment _ ->
            decl

        Declaration _ imports body ->
            Declaration (Exposed { group = Nothing, exposeConstructor = False }) imports body


{-| -}
exposeAndGroup : String -> Declaration -> Declaration
exposeAndGroup group decl =
    case decl of
        Comment _ ->
            decl

        Declaration _ imports body ->
            Declaration (Exposed { group = Just group, exposeConstructor = False }) imports body


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor decl =
    case decl of
        Comment _ ->
            decl

        Declaration metadata imports body ->
            Declaration (Exposed { group = Nothing, exposeConstructor = True }) imports body


{-| -}
exposeConstructorAndGroup : String -> Declaration -> Declaration
exposeConstructorAndGroup group decl =
    case decl of
        Comment _ ->
            decl

        Declaration _ imports body ->
            Declaration (Exposed { group = Just group, exposeConstructor = True }) imports body


type Module
    = Module ModuleName.ModuleName (Maybe String)


makeImport :
    Module
    ->
        Maybe
            { moduleName : Node ModuleName.ModuleName
            , moduleAlias : Maybe (Node (List String))
            , exposingList : Maybe a
            }
makeImport (Module name maybeAlias) =
    case name of
        [] ->
            Nothing

        _ ->
            if builtIn name && maybeAlias == Nothing then
                Nothing

            else
                Just
                    { moduleName = nodify name
                    , moduleAlias =
                        Maybe.map
                            (\al ->
                                nodify [ al ]
                            )
                            maybeAlias
                    , exposingList = Nothing
                    }


resolveModuleNameForValue : Module -> List String
resolveModuleNameForValue (Module mod maybeAlias) =
    case maybeAlias of
        Nothing ->
            mod

        Just aliasStr ->
            [ aliasStr ]


resolveModuleName : Module -> List String
resolveModuleName (Module mod maybeAlias) =
    --if builtIn mod then
    --    []
    --
    --else
    case maybeAlias of
        Nothing ->
            mod

        Just aliasStr ->
            [ aliasStr ]


builtIn : List String -> Bool
builtIn name =
    case name of
        [ "List" ] ->
            True

        [ "Maybe" ] ->
            True

        [ "String" ] ->
            True

        [ "Basics" ] ->
            True

        _ ->
            False


fullModName : Module -> String
fullModName (Module name _) =
    String.join "." name


{-| -}
hasPorts : List Declaration -> Bool
hasPorts decls =
    List.any
        (\decl ->
            case decl of
                Comment _ ->
                    False

                Declaration exp _ decBody ->
                    case exp of
                        NotExposed ->
                            False

                        Exposed _ ->
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
        (\decl ->
            case decl of
                Comment _ ->
                    Nothing

                Declaration exp _ decBody ->
                    case exp of
                        NotExposed ->
                            Nothing

                        Exposed details ->
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
                                    if details.exposeConstructor then
                                        Expose.TypeExpose
                                            { name = typeName
                                            , open = Just Range.emptyRange
                                            }
                                            |> Just

                                    else
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
        )
        decls


getExposedGroups :
    List Declaration
    -> List { group : Maybe String, members : List String }
getExposedGroups decls =
    List.filterMap
        (\decl ->
            case decl of
                Comment _ ->
                    Nothing

                Declaration exp _ decBody ->
                    case exp of
                        NotExposed ->
                            Nothing

                        Exposed details ->
                            case declName decl of
                                Nothing ->
                                    Nothing

                                Just name ->
                                    Just ( details.group, name )
        )
        decls
        |> List.sortBy
            (\( group, _ ) ->
                case group of
                    Nothing ->
                        "zzzzzzzzz"

                    Just name ->
                        name
            )
        |> groupExposing


matchName : Maybe a -> Maybe a -> Bool
matchName one two =
    case one of
        Nothing ->
            case two of
                Nothing ->
                    True

                _ ->
                    False

        Just oneName ->
            case two of
                Nothing ->
                    False

                Just twoName ->
                    oneName == twoName


groupExposing : List ( Maybe String, String ) -> List { group : Maybe String, members : List String }
groupExposing items =
    List.foldr
        (\( maybeGroup, name ) acc ->
            case acc of
                [] ->
                    [ { group = maybeGroup, members = [ name ] } ]

                top :: groups ->
                    if matchName maybeGroup top.group then
                        { group = top.group
                        , members = name :: top.members
                        }
                            :: groups

                    else
                        { group = maybeGroup, members = [ name ] } :: acc
        )
        []
        items


declName : Declaration -> Maybe String
declName decl =
    case decl of
        Comment _ ->
            Nothing

        Declaration exp _ decBody ->
            case decBody of
                Declaration.FunctionDeclaration fn ->
                    denode (.name (denode fn.declaration))
                        |> Just

                Declaration.AliasDeclaration synonym ->
                    denode synonym.name
                        |> Just

                Declaration.CustomTypeDeclaration myType ->
                    denode myType.name
                        |> Just

                Declaration.PortDeclaration myPort ->
                    denode myPort.name
                        |> Just

                Declaration.InfixDeclaration infix ->
                    Nothing

                Declaration.Destructuring _ _ ->
                    Nothing


getModule : Module -> ModuleName.ModuleName
getModule (Module name _) =
    name


type Expose
    = NotExposed
    | Exposed
        { group : Maybe String
        , exposeConstructor : Bool
        }


emptyModule : Module
emptyModule =
    inModule []


inModule : List String -> Module
inModule mods =
    Module (List.map formatType mods) Nothing


moduleAs : List String -> String -> Module
moduleAs mods modAlias =
    Module (List.map formatType mods) (Just (formatType modAlias))


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


{-|

    This is used as a variable or as a record field.

-}
formatValue : String -> String
formatValue str =
    let
        formatted =
            if String.toUpper str == str then
                String.toLower str

            else
                String.toLower (String.left 1 str) ++ String.dropLeft 1 str
    in
    case formatted of
        "in" ->
            "in_"

        "type" ->
            "type_"

        "case" ->
            "case_"

        "let" ->
            "let_"

        "module" ->
            "module_"

        "exposing" ->
            "exposing_"

        _ ->
            formatted


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
                    --let
                    --    _ =
                    --        Debug.log "LIST FAILED TO EXTRACT" { passed = annotations, top = top }
                    --in
                    Err err


{-| -}
applyType : Expression -> List Expression -> Result (List InferenceError) Annotation.TypeAnnotation
applyType (Expression exp) args =
    case exp.annotation of
        Err err ->
            Err err

        Ok topAnnotation ->
            case extractListAnnotation args [] of
                Ok types ->
                    applyTypeHelper topAnnotation types

                Err err ->
                    --let
                    --    _ =
                    --        Debug.log "LIST FAILED TO EXTRACT" err
                    --in
                    Err err


autoReduce : Int -> Expression -> Expression
autoReduce count ((Expression fn) as unchanged) =
    if count <= 0 then
        unchanged

    else
        case fn.annotation of
            Ok (Annotation.FunctionTypeAnnotation one two) ->
                autoReduce (count - 1)
                    (Expression { fn | annotation = Ok (denode two) })

            final ->
                unchanged


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
                            --let
                            --    _ =
                            --        Debug.log "APPLAIL"
                            --            { fn = fn
                            --            , top = top
                            --            }
                            --in
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
        ( _, result ) =
            unifiableHelper Dict.empty one two

        _ =
            case result of
                Ok _ ->
                    ( one, two )

                Err _ ->
                    --Debug.log "       Failed to unify"
                    ( one, two )
    in
    result



-- unifiableHelper :
--     Dict.Dict String Annotation.TypeAnnotation
--     -> Annotation.TypeAnnotation
--     -> Annotation.TypeAnnotation
--     -> ( Dict.Dict String Annotation.TypeAnnotation, Result String Annotation.TypeAnnotation )


unifiableHelper vars one two =
    case one of
        Annotation.GenericType varName ->
            case Dict.get varName vars of
                Nothing ->
                    ( Dict.insert varName two vars
                    , Ok two
                    )

                Just found ->
                    case two of
                        Annotation.GenericType varNameB ->
                            case Dict.get varNameB vars of
                                Nothing ->
                                    ( Dict.insert varNameB found vars
                                    , Ok two
                                    )

                                Just foundTwo ->
                                    unifiableHelper vars found foundTwo

                        _ ->
                            unifiableHelper vars found two

        Annotation.Typed oneName oneContents ->
            case two of
                Annotation.Typed twoName twoContents ->
                    if denode oneName == denode twoName then
                        case unifiableLists vars oneContents twoContents [] of
                            ( newVars, Ok unifiedContent ) ->
                                ( newVars, Ok (Annotation.Typed twoName unifiedContent) )

                            ( newVars, Err err ) ->
                                ( newVars, Err err )

                    else
                        ( vars, Err "Unable to unify container!" )

                Annotation.GenericType b ->
                    ( vars, Ok one )

                _ ->
                    ( vars, Err "Unable to unify container!" )

        Annotation.Unit ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Unit ->
                    ( vars, Ok Annotation.Unit )

                _ ->
                    ( vars, Err "Unable to unify units!" )

        Annotation.Tupled valsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Tupled valsB ->
                    case unifiableLists vars valsA valsB [] of
                        ( newVars, Ok unified ) ->
                            ( newVars
                            , Ok
                                (Annotation.Tupled unified)
                            )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                _ ->
                    ( vars, Err "Unable to unify tuples!" )

        Annotation.Record fieldsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Record fieldsB ->
                    case unifiableFields vars fieldsA fieldsB [] of
                        ( newVars, Ok unifiedFields ) ->
                            ( newVars, Ok (Annotation.Record unifiedFields) )

                        ( newVars, Err err ) ->
                            ( newVars, Err err )

                _ ->
                    ( vars, Err "Unable to unify function with non function type!" )

        Annotation.GenericRecord reVarName fieldsA ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.Record fieldsB ->
                    ( vars, Err "Unable to unify function with non function type!" )

                _ ->
                    ( vars, Err "Unable to unify function with non function type!" )

        Annotation.FunctionTypeAnnotation oneA oneB ->
            case two of
                Annotation.GenericType b ->
                    case Dict.get b vars of
                        Nothing ->
                            ( Dict.insert b one vars
                            , Ok one
                            )

                        Just foundTwo ->
                            unifiableHelper vars one foundTwo

                Annotation.FunctionTypeAnnotation twoA twoB ->
                    case unifiableHelper vars (denode oneA) (denode twoA) of
                        ( aVars, Ok unifiedA ) ->
                            case unifiableHelper aVars (denode oneB) (denode twoB) of
                                ( bVars, Ok unifiedB ) ->
                                    ( bVars
                                    , Ok
                                        (Annotation.FunctionTypeAnnotation
                                            (nodify unifiedA)
                                            (nodify unifiedB)
                                        )
                                    )

                                otherwise ->
                                    otherwise

                        otherwise ->
                            otherwise

                _ ->
                    ( vars, Err "Unable to unify function with non function type!" )


unifiableFields vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( oneX :: oneRemain, twoFields ) ->
            let
                ( oneFieldName, oneFieldVal ) =
                    denode oneX

                oneName =
                    denode oneFieldName

                oneVal =
                    denode oneFieldVal
            in
            case getField oneName oneVal twoFields [] of
                Ok ( matchingFieldVal, remainingTwo ) ->
                    let
                        ( newVars, unifiedField ) =
                            unifiableHelper vars oneVal matchingFieldVal
                    in
                    unifiableFields newVars oneRemain remainingTwo (unifiedField :: unified)

                Err notFound ->
                    ( vars, Err ("Could not find " ++ oneName) )

        _ ->
            ( vars, Err "Mismatched numbers of type variables" )


getField name val fields captured =
    case fields of
        [] ->
            Err ("Could not find " ++ name)

        top :: remain ->
            let
                ( topFieldName, topFieldVal ) =
                    denode top

                topName =
                    denode topFieldName

                topVal =
                    denode topFieldVal
            in
            if topName == name then
                Ok
                    ( topVal
                    , captured ++ remain
                    )

            else
                getField name val remain (top :: captured)


unifiableLists vars one two unified =
    case ( one, two ) of
        ( [], [] ) ->
            ( vars, Ok (nodifyAll (List.reverse unified)) )

        ( [ oneX ], [ twoX ] ) ->
            case unifiableHelper vars (denode oneX) (denode twoX) of
                ( newVars, Ok un ) ->
                    ( newVars, Ok (nodifyAll (List.reverse (un :: unified))) )

                ( newVars, Err err ) ->
                    ( newVars, Err err )

        ( oneX :: oneRemain, twoX :: twoRemain ) ->
            case unifiableHelper vars (denode oneX) (denode twoX) of
                ( newVars, Ok un ) ->
                    unifiableLists newVars oneRemain twoRemain (un :: unified)

                ( newVars, Err err ) ->
                    ( vars, Err err )

        _ ->
            ( vars, Err "Mismatched numbers of type variables" )
