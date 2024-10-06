module Internal.Write exposing
    ( write
    , writeAnnotation
    , writeAnnotationWith
    , writeDeclarationWith
    , writeExpression
    , writeExpressionWith
    , writeImports
    , writeInference
    , writeSignatureWith
    )

{-| This is borrowed basically in it's entirety from: <https://github.com/the-sett/elm-syntax-dsl/blob/master/src/Elm/Pretty.elm>

Thank you Rupert!

-}

import Dict
import Elm.Syntax.Declaration
import Elm.Syntax.Documentation exposing (Documentation)
import Elm.Syntax.Exposing exposing (Exposing(..), TopLevelExpose(..))
import Elm.Syntax.Expression exposing (CaseBlock, Expression(..), Function, FunctionImplementation, Lambda, LetBlock, LetDeclaration(..), RecordSetter)
import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.Infix exposing (Infix, InfixDirection(..))
import Elm.Syntax.Module exposing (DefaultModuleData, EffectModuleData, Module(..))
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node exposing (Node(..))
import Elm.Syntax.Pattern exposing (Pattern(..))
import Elm.Syntax.Signature exposing (Signature)
import Elm.Syntax.Type exposing (Type, ValueConstructor)
import Elm.Syntax.TypeAlias exposing (TypeAlias)
import Elm.Syntax.TypeAnnotation exposing (RecordField, TypeAnnotation(..))
import Hex
import Internal.Comments as Comments
import Internal.Compiler as Util exposing (denode, denodeAll, denodeMaybe, nodify)
import Internal.ImportsAndExposing as ImportsAndExposing
import Pretty exposing (Doc)


type alias File =
    { moduleDefinition : Module
    , aliases : List ( Util.Module, String )
    , imports : List Import
    , declarations : List Util.RenderedDeclaration
    , comments : Maybe (Comments.Comment Comments.FileComment)
    }


type alias Aliases =
    List ( Util.Module, String )


{-| Prepares a file of Elm code for layout by the pretty printer.
Note that the `Doc` type returned by this is a `Pretty.Doc`. This can be printed
to a string by the `the-sett/elm-pretty-printer` package.
These `Doc` based functions are exposed in case you want to pretty print some
Elm inside something else with the pretty printer. The `pretty` function can be
used to go directly from a `File` to a `String`, if that is more convenient.
-}
prepareLayout : Int -> File -> Doc t
prepareLayout width file =
    prettyModule file.moduleDefinition
        |> Pretty.a Pretty.line
        |> Pretty.a Pretty.line
        |> (\doc ->
                case file.comments of
                    Nothing ->
                        doc

                    Just fileComment ->
                        let
                            ( fileCommentStr, _ ) =
                                Comments.prettyFileComment width fileComment
                        in
                        doc
                            |> Pretty.a (prettyComments [ fileCommentStr ])
                            |> Pretty.a Pretty.line
           )
        |> Pretty.a (importsPretty file.imports)
        |> Pretty.a (prettyDeclarations file.aliases file.declarations)


importsPretty : List Import -> Doc t
importsPretty imports =
    case imports of
        [] ->
            Pretty.line

        _ ->
            prettyImports imports
                |> Pretty.a Pretty.line
                |> Pretty.a Pretty.line
                |> Pretty.a Pretty.line


write : File -> String
write =
    pretty 80


writeExpression : Expression -> String
writeExpression exp =
    prettyExpression noAliases exp
        |> Pretty.pretty 80


writeExpressionWith : Aliases -> Expression -> String
writeExpressionWith aliases exp =
    prettyExpression aliases exp
        |> Pretty.pretty 80


writeSignature : Signature -> String
writeSignature sig =
    prettySignature noAliases sig
        |> Pretty.pretty 80


writeSignatureWith : Aliases -> Signature -> String
writeSignatureWith aliases sig =
    prettySignature aliases sig
        |> Pretty.pretty 80


writeAnnotation : TypeAnnotation -> String
writeAnnotation sig =
    prettyTypeAnnotation noAliases sig
        |> Pretty.pretty 80


writeAnnotationWith : Aliases -> TypeAnnotation -> String
writeAnnotationWith aliases sig =
    prettyTypeAnnotation aliases sig
        |> Pretty.pretty 80


writeInference : Util.Inference -> String
writeInference inf =
    "--TYPE:\n  "
        ++ (writeAnnotation inf.type_
                |> String.lines
                |> String.join "\n    "
           )
        ++ "\n\n-- INFERRED\n\n  "
        ++ (Dict.toList inf.inferences
                |> List.map
                    (\( key, val ) ->
                        key
                            ++ ":\n    "
                            ++ (writeAnnotation val
                                    |> String.lines
                                    |> String.join "\n      "
                               )
                    )
                |> String.join "\n\n  "
           )
        ++ "\n\n----END-----\n\n"


writeImports : List Import -> String
writeImports imports =
    prettyImports imports
        |> Pretty.pretty 80


writeDeclaration : Util.RenderedDeclaration -> String
writeDeclaration exp =
    prettyDeclaration 80 exp
        |> Pretty.pretty 80


writeDeclarationWith : Aliases -> Util.RenderedDeclaration -> String
writeDeclarationWith aliases decl =
    prettyDeclarations aliases [ decl ]
        |> Pretty.pretty 80


{-| Prints a file of Elm code to the given page width, making use of the pretty
printer.
-}
pretty : Int -> File -> String
pretty width file =
    prepareLayout width file
        |> Pretty.pretty width


prettyModule : Module -> Doc t
prettyModule mod =
    case mod of
        NormalModule defaultModuleData ->
            prettyDefaultModuleData defaultModuleData

        PortModule defaultModuleData ->
            prettyPortModuleData defaultModuleData

        EffectModule effectModuleData ->
            prettyEffectModuleData effectModuleData


prettyModuleName : ModuleName -> Doc t
prettyModuleName name =
    List.map Pretty.string name
        |> Pretty.join dot


prettyModuleNameDot : Aliases -> ModuleName -> Doc t
prettyModuleNameDot aliases name =
    case name of
        [] ->
            Pretty.empty

        _ ->
            case Util.findAlias name aliases of
                Nothing ->
                    List.map Pretty.string name
                        |> Pretty.join dot
                        |> Pretty.a dot

                Just alias ->
                    Pretty.string alias
                        |> Pretty.a dot


prettyModuleNameAlias : ModuleName -> Doc t
prettyModuleNameAlias name =
    case name of
        [] ->
            Pretty.empty

        _ ->
            Pretty.string "as "
                |> Pretty.a (List.map Pretty.string name |> Pretty.join dot)


prettyDefaultModuleData : DefaultModuleData -> Doc t
prettyDefaultModuleData moduleData =
    Pretty.words
        [ Pretty.string "module"
        , prettyModuleName (denode moduleData.moduleName)
        , prettyModuleExposing (denode moduleData.exposingList)
        ]


prettyPortModuleData : DefaultModuleData -> Doc t
prettyPortModuleData moduleData =
    Pretty.words
        [ Pretty.string "port module"
        , prettyModuleName (denode moduleData.moduleName)
        , prettyModuleExposing (denode moduleData.exposingList)
        ]


prettyEffectModuleData : EffectModuleData -> Doc t
prettyEffectModuleData moduleData =
    let
        prettyCmdAndSub : Maybe String -> Maybe String -> Maybe (Doc t)
        prettyCmdAndSub maybeCmd maybeSub =
            case ( maybeCmd, maybeSub ) of
                ( Nothing, Nothing ) ->
                    Nothing

                ( Just cmdName, Just subName ) ->
                    [ Pretty.string "where { command ="
                    , Pretty.string cmdName
                    , Pretty.string ","
                    , Pretty.string "subscription ="
                    , Pretty.string subName
                    , Pretty.string "}"
                    ]
                        |> Pretty.words
                        |> Just

                ( Just cmdName, Nothing ) ->
                    [ Pretty.string "where { command ="
                    , Pretty.string cmdName
                    , Pretty.string "}"
                    ]
                        |> Pretty.words
                        |> Just

                ( Nothing, Just subName ) ->
                    [ Pretty.string "where { subscription ="
                    , Pretty.string subName
                    , Pretty.string "}"
                    ]
                        |> Pretty.words
                        |> Just
    in
    Pretty.words
        [ Pretty.string "effect module"
        , prettyModuleName (denode moduleData.moduleName)
        , prettyCmdAndSub (denodeMaybe moduleData.command) (denodeMaybe moduleData.subscription)
            |> prettyMaybe identity
        , prettyModuleExposing (denode moduleData.exposingList)
        ]


prettyComments : List String -> Doc t
prettyComments comments =
    case comments of
        [] ->
            Pretty.empty

        _ ->
            List.map Pretty.string comments
                |> Pretty.lines
                |> Pretty.a Pretty.line
                |> Pretty.a Pretty.line


{-| Pretty prints a list of import statements.
The list will be de-duplicated and sorted.
-}
prettyImports : List Import -> Doc t
prettyImports imports =
    ImportsAndExposing.sortAndDedupImports imports
        |> List.map prettyImport
        |> Pretty.lines


prettyImport : Import -> Doc t
prettyImport import_ =
    Pretty.join Pretty.space
        [ Pretty.string "import"
        , prettyModuleName (denode import_.moduleName)
        , prettyMaybe prettyModuleNameAlias (denodeMaybe import_.moduleAlias)
        , prettyMaybe prettyExposing (denodeMaybe import_.exposingList)
        ]


{-| Pretty prints the contents of an exposing statement, as found on a module or import
statement.
The exposed values will be de-duplicated and sorted.
-}
prettyExposing : Exposing -> Doc t
prettyExposing exposing_ =
    let
        exposings : Doc t
        exposings =
            case exposing_ of
                All _ ->
                    Pretty.string ".."
                        |> Pretty.surround
                            (Pretty.string " (")
                            (Pretty.string ")")

                Explicit tll ->
                    if List.length tll <= 5 then
                        ImportsAndExposing.sortAndDedupExposings (denodeAll tll)
                            |> List.map prettyTopLevelExpose
                            |> Pretty.join (Pretty.string ", ")
                            |> Pretty.surround
                                (Pretty.string " (")
                                (Pretty.string ")")

                    else
                        ImportsAndExposing.sortAndDedupExposings (denodeAll tll)
                            |> List.map prettyTopLevelExpose
                            |> Pretty.join (Pretty.string "\n    , ")
                            |> Pretty.surround
                                (Pretty.string "\n    ( ")
                                (Pretty.string "\n    )")
    in
    Pretty.string "exposing"
        |> Pretty.a exposings


prettyModuleExposing : Exposing -> Doc t
prettyModuleExposing exposing_ =
    let
        exposings : Doc t
        exposings =
            case exposing_ of
                All _ ->
                    Pretty.string ".."
                        |> Pretty.surround
                            (Pretty.string " (")
                            (Pretty.string ")")

                Explicit tll ->
                    let
                        isIndented =
                            checkIfIsIndented tll 0

                        start =
                            if isIndented then
                                Pretty.string "\n    ( "

                            else
                                Pretty.string " ( "

                        end =
                            if isIndented then
                                Pretty.string "\n    )"

                            else
                                Pretty.string " )"
                    in
                    Pretty.append
                        (List.foldr prettyGroupedExposing
                            { firstIteration = True
                            , previousRow = 0
                            , rowCount = 0
                            , rendered = start
                            }
                            tll
                            |> .rendered
                        )
                        end
    in
    Pretty.string "exposing"
        |> Pretty.a exposings


checkIfIsIndented : List (Node TopLevelExpose) -> Int -> Bool
checkIfIsIndented tll count =
    if count >= 5 then
        True

    else
        case tll of
            [] ->
                False

            (Node range _) :: xs ->
                if range.start.row > 0 then
                    True

                else
                    checkIfIsIndented xs (count + 1)


prettyGroupedExposing :
    Node TopLevelExpose
    ->
        { previousRow : Int
        , rowCount : Int
        , rendered : Doc t
        , firstIteration : Bool
        }
    ->
        { previousRow : Int
        , rowCount : Int
        , rendered : Doc t
        , firstIteration : Bool
        }
prettyGroupedExposing (Node range exposedElement) rendered =
    let
        currentRow =
            range.start.row

        renderedTopElement =
            prettyTopLevelExpose exposedElement

        newRow =
            currentRow /= rendered.previousRow || rendered.rowCount > 5

        newRendered =
            if rendered.firstIteration then
                renderedTopElement

            else if newRow then
                Pretty.append (Pretty.string "\n    , ") renderedTopElement

            else
                Pretty.append (Pretty.string ", ") renderedTopElement
    in
    { rendered = Pretty.append rendered.rendered newRendered
    , previousRow = currentRow
    , firstIteration = False
    , rowCount =
        if newRow then
            0

        else
            rendered.rowCount + 1
    }


prettyTopLevelExpose : TopLevelExpose -> Doc t
prettyTopLevelExpose tlExpose =
    case tlExpose of
        InfixExpose val ->
            Pretty.string val
                |> Pretty.parens

        FunctionExpose val ->
            Pretty.string val

        TypeOrAliasExpose val ->
            Pretty.string val

        TypeExpose exposedType ->
            case exposedType.open of
                Nothing ->
                    Pretty.string exposedType.name

                Just _ ->
                    Pretty.string exposedType.name
                        |> Pretty.a (Pretty.string "(..)")


{-| Pretty prints a single top-level declaration.
-}
prettyDeclaration : Int -> Util.RenderedDeclaration -> Doc t
prettyDeclaration _ decl =
    case decl of
        Util.RenderedDecl innerDecl ->
            prettyElmSyntaxDeclaration noAliases innerDecl

        Util.RenderedComment content ->
            Pretty.string content

        Util.RenderedBlock source ->
            Pretty.string source


noAliases : Aliases
noAliases =
    []


{-| Pretty prints an elm-syntax declaration.
-}
prettyElmSyntaxDeclaration : Aliases -> Elm.Syntax.Declaration.Declaration -> Doc t
prettyElmSyntaxDeclaration aliases decl =
    case decl of
        Elm.Syntax.Declaration.FunctionDeclaration fn ->
            prettyFun aliases fn

        Elm.Syntax.Declaration.AliasDeclaration tAlias ->
            prettyTypeAlias aliases tAlias

        Elm.Syntax.Declaration.CustomTypeDeclaration type_ ->
            prettyCustomType aliases type_

        Elm.Syntax.Declaration.PortDeclaration sig ->
            prettyPortDeclaration aliases sig

        Elm.Syntax.Declaration.InfixDeclaration infix_ ->
            prettyInfix infix_

        Elm.Syntax.Declaration.Destructuring (Node _ pattern) (Node _ expr) ->
            prettyDestructuring aliases pattern expr


prettyDeclarations : Aliases -> List Util.RenderedDeclaration -> Doc t
prettyDeclarations aliases decls =
    decls
        |> List.concatMap
            (\decl ->
                case decl of
                    Util.RenderedComment content ->
                        [ Pretty.a (Pretty.string (content ++ "\n"))
                        , Pretty.a Pretty.line >> Pretty.a Pretty.line
                        ]

                    Util.RenderedBlock source ->
                        [ Pretty.a (Pretty.string source)
                        , Pretty.a Pretty.line >> Pretty.a Pretty.line >> Pretty.a Pretty.line
                        ]

                    Util.RenderedDecl innerDecl ->
                        [ Pretty.a (prettyElmSyntaxDeclaration aliases innerDecl)
                        , Pretty.a Pretty.line >> Pretty.a Pretty.line >> Pretty.a Pretty.line
                        ]
            )
        |> List.reverse
        |> List.drop 1
        |> List.reverse
        |> List.foldl (<|) Pretty.empty


{-| Pretty prints an Elm function, which may include documentation and a signature too.
-}
prettyFun : Aliases -> Function -> Doc t
prettyFun aliases fn =
    [ prettyMaybe prettyDocumentation (denodeMaybe fn.documentation)
    , prettyMaybe (prettySignature aliases) (denodeMaybe fn.signature)
    , prettyFunctionImplementation aliases (denode fn.declaration)
    ]
        |> Pretty.lines


{-| Pretty prints a type alias definition, which may include documentation too.
-}
prettyTypeAlias : Aliases -> TypeAlias -> Doc t
prettyTypeAlias aliases tAlias =
    let
        typeAliasPretty : Doc t
        typeAliasPretty =
            [ Pretty.string "type alias"
            , Pretty.string (denode tAlias.name)
            , List.map Pretty.string (denodeAll tAlias.generics) |> Pretty.words
            , Pretty.string "="
            ]
                |> Pretty.words
                |> Pretty.a Pretty.line
                |> Pretty.a (prettyTypeAnnotation aliases (denode tAlias.typeAnnotation))
                |> Pretty.nest 4
    in
    [ prettyMaybe prettyDocumentation (denodeMaybe tAlias.documentation)
    , typeAliasPretty
    ]
        |> Pretty.lines


{-| Pretty prints a custom type declaration, which may include documentation too.
-}
prettyCustomType : Aliases -> Type -> Doc t
prettyCustomType aliases type_ =
    let
        customTypePretty : Doc t
        customTypePretty =
            [ Pretty.string "type"
            , Pretty.string (denode type_.name)
            , List.map Pretty.string (denodeAll type_.generics) |> Pretty.words
            ]
                |> Pretty.words
                |> Pretty.a Pretty.line
                |> Pretty.a (Pretty.string "= ")
                |> Pretty.a (prettyValueConstructors aliases (denodeAll type_.constructors))
                |> Pretty.nest 4
    in
    [ prettyMaybe prettyDocumentation (denodeMaybe type_.documentation)
    , customTypePretty
    ]
        |> Pretty.lines


prettyValueConstructors : Aliases -> List ValueConstructor -> Doc t
prettyValueConstructors aliases constructors =
    List.map (prettyValueConstructor aliases) constructors
        |> Pretty.join (Pretty.line |> Pretty.a (Pretty.string "| "))


prettyValueConstructor : Aliases -> ValueConstructor -> Doc t
prettyValueConstructor aliases cons =
    [ Pretty.string (denode cons.name)
    , List.map (prettyTypeAnnotationParens aliases) (denodeAll cons.arguments) |> Pretty.lines
    ]
        |> Pretty.lines
        |> Pretty.group
        |> Pretty.nest 4


{-| Pretty prints a port declaration.
-}
prettyPortDeclaration : Aliases -> Signature -> Doc t
prettyPortDeclaration aliases sig =
    [ Pretty.string "port"
    , prettySignature aliases sig
    ]
        |> Pretty.words


prettyInfix : Infix -> Doc t
prettyInfix infix_ =
    let
        dirToString : InfixDirection -> String
        dirToString direction =
            case direction of
                Left ->
                    "left"

                Right ->
                    "right"

                Non ->
                    "non"
    in
    [ Pretty.string "infix"
    , Pretty.string (dirToString (denode infix_.direction))
    , Pretty.string (String.fromInt (denode infix_.precedence))
    , Pretty.string (denode infix_.operator) |> Pretty.parens
    , Pretty.string "="
    , Pretty.string (denode infix_.function)
    ]
        |> Pretty.words


{-| Pretty prints a desctructuring declaration.
-}
prettyDestructuring : Aliases -> Pattern -> Expression -> Doc t
prettyDestructuring aliases pattern expr =
    [ [ prettyPattern aliases pattern
      , Pretty.string "="
      ]
        |> Pretty.words
    , prettyExpression aliases expr
    ]
        |> Pretty.lines
        |> Pretty.nest 4


prettyDocumentation : Documentation -> Doc t
prettyDocumentation docs =
    if String.contains "\n" docs then
        Pretty.string ("{-| " ++ docs ++ "\n-}")

    else
        Pretty.string ("{-| " ++ docs ++ " -}")


{-| Pretty prints a type signature.
-}
prettySignature : Aliases -> Signature -> Doc t
prettySignature aliases sig =
    [ [ Pretty.string (denode sig.name)
      , Pretty.string ":"
      ]
        |> Pretty.words
    , prettyTypeAnnotation aliases (denode sig.typeAnnotation)
    ]
        |> Pretty.lines
        |> Pretty.nest 4
        |> Pretty.group


prettyFunctionImplementation : Aliases -> FunctionImplementation -> Doc t
prettyFunctionImplementation aliases impl =
    Pretty.words
        [ Pretty.string (denode impl.name)
        , prettyArgs aliases (denodeAll impl.arguments)
        , Pretty.string "="
        ]
        |> Pretty.a Pretty.line
        |> Pretty.a (prettyExpression aliases (denode impl.expression))
        |> Pretty.nest 4


prettyArgs : Aliases -> List Pattern -> Doc t
prettyArgs aliases args =
    List.map (prettyPatternInner aliases False) args
        |> Pretty.words



--== Patterns


{-| Pretty prints a pattern.
-}
prettyPattern : Aliases -> Pattern -> Doc t
prettyPattern aliases pattern =
    prettyPatternInner aliases True pattern


adjustPatternParentheses : Bool -> Pattern -> Pattern
adjustPatternParentheses isTop pattern =
    let
        addParens : Pattern -> Pattern
        addParens pat =
            case ( isTop, pat ) of
                ( False, NamedPattern _ (_ :: _) ) ->
                    nodify pat |> ParenthesizedPattern

                ( False, AsPattern _ _ ) ->
                    nodify pat |> ParenthesizedPattern

                _ ->
                    pat

        removeParens : Pattern -> Pattern
        removeParens pat =
            case pat of
                ParenthesizedPattern (Node _ innerPat) ->
                    if shouldRemove innerPat then
                        removeParens innerPat

                    else
                        pat

                _ ->
                    pat

        shouldRemove : Pattern -> Bool
        shouldRemove pat =
            case ( isTop, pat ) of
                ( False, NamedPattern _ _ ) ->
                    False

                ( _, AsPattern _ _ ) ->
                    False

                _ ->
                    isTop
    in
    removeParens pattern
        |> addParens


prettyPatternInner : Aliases -> Bool -> Pattern -> Doc t
prettyPatternInner aliases isTop pattern =
    case adjustPatternParentheses isTop pattern of
        AllPattern ->
            Pretty.string "_"

        UnitPattern ->
            Pretty.string "()"

        CharPattern val ->
            Pretty.string (escapeChar val)
                |> singleQuotes

        StringPattern val ->
            Pretty.string val
                |> quotes

        IntPattern val ->
            Pretty.string (String.fromInt val)

        HexPattern val ->
            Pretty.string (Hex.toString val)

        FloatPattern val ->
            Pretty.string (String.fromFloat val)

        TuplePattern vals ->
            Pretty.space
                |> Pretty.a
                    (List.map (prettyPatternInner aliases True) (denodeAll vals)
                        |> Pretty.join (Pretty.string ", ")
                    )
                |> Pretty.a Pretty.space
                |> Pretty.parens

        RecordPattern fields ->
            List.map Pretty.string (denodeAll fields)
                |> Pretty.join (Pretty.string ", ")
                |> Pretty.surround Pretty.space Pretty.space
                |> Pretty.braces

        UnConsPattern (Node _ hdPat) (Node _ tlPat) ->
            [ prettyPatternInner aliases False hdPat
            , Pretty.string "::"
            , prettyPatternInner aliases False tlPat
            ]
                |> Pretty.words

        ListPattern listPats ->
            case listPats of
                [] ->
                    Pretty.string "[]"

                _ ->
                    let
                        open : Doc t
                        open =
                            Pretty.a Pretty.space (Pretty.string "[")

                        close : Doc t
                        close =
                            Pretty.a (Pretty.string "]") Pretty.space
                    in
                    List.map (prettyPatternInner aliases False) (denodeAll listPats)
                        |> Pretty.join (Pretty.string ", ")
                        |> Pretty.surround open close

        VarPattern var ->
            Pretty.string var

        NamedPattern qnRef listPats ->
            (prettyModuleNameDot aliases qnRef.moduleName
                |> Pretty.a (Pretty.string qnRef.name)
            )
                :: List.map (prettyPatternInner aliases False) (denodeAll listPats)
                |> Pretty.words

        AsPattern (Node _ pat) (Node _ name) ->
            [ prettyPatternInner aliases False pat
            , Pretty.string "as"
            , Pretty.string name
            ]
                |> Pretty.words

        ParenthesizedPattern (Node _ pat) ->
            prettyPatternInner aliases True pat
                |> Pretty.parens



--== Expressions


type alias Context =
    { precedence : Int
    }


topContext : Context
topContext =
    { precedence = 0
    }


bottomContext : Context
bottomContext =
    { precedence = 11
    }


{-| Pretty prints an expression.
-}
prettyExpression : Aliases -> Expression -> Doc t
prettyExpression aliases expression =
    prettyExpressionInner aliases topContext 4 expression
        |> Tuple.first


prettyExpressionInner : Aliases -> Context -> Int -> Expression -> ( Doc t, Bool )
prettyExpressionInner aliases context indent expression =
    let
        noninfix : ( Doc t, Bool ) -> ( Doc t, Bool )
        noninfix =
            showParen (context.precedence > 10)
    in
    case expression of
        UnitExpr ->
            ( Pretty.string "()"
            , False
            )

        Application exprs ->
            noninfix <| prettyApplication aliases indent exprs

        OperatorApplication symbol dir exprl exprr ->
            showParen (context.precedence > precedence symbol) <|
                prettyOperatorApplication aliases indent symbol dir exprl exprr

        FunctionOrValue modl val ->
            ( prettyModuleNameDot aliases modl
                |> Pretty.a (Pretty.string val)
            , False
            )

        IfBlock exprBool exprTrue exprFalse ->
            noninfix <|
                prettyIfBlock aliases indent exprBool exprTrue exprFalse

        PrefixOperator symbol ->
            ( Pretty.string symbol |> Pretty.parens
            , False
            )

        Operator symbol ->
            ( Pretty.string symbol
            , False
            )

        Integer val ->
            ( Pretty.string (String.fromInt val)
            , False
            )

        Hex val ->
            ( Pretty.string (toHexString val)
            , False
            )

        Floatable val ->
            ( Pretty.string (String.fromFloat val)
            , False
            )

        Negation (Node _ expr) ->
            noninfix <|
                let
                    ( prettyExpr, alwaysBreak ) =
                        prettyExpressionInner aliases bottomContext 4 expr
                in
                ( Pretty.string "-"
                    |> Pretty.a prettyExpr
                , alwaysBreak
                )

        Literal val ->
            ( prettyLiteral val
            , False
            )

        CharLiteral val ->
            ( Pretty.string (escapeChar val)
                |> singleQuotes
            , False
            )

        TupledExpression exprs ->
            prettyTupledExpression aliases indent exprs

        ParenthesizedExpression (Node _ expr) ->
            prettyExpressionInner aliases context indent expr

        LetExpression letBlock ->
            noninfix <| prettyLetBlock aliases indent letBlock

        CaseExpression caseBlock ->
            noninfix <| prettyCaseBlock aliases indent caseBlock

        LambdaExpression lambda ->
            noninfix <| prettyLambdaExpression aliases indent lambda

        RecordExpr setters ->
            prettyRecordExpr aliases setters

        ListExpr exprs ->
            prettyList aliases indent exprs

        RecordAccess expr field ->
            prettyRecordAccess aliases expr field

        RecordAccessFunction field ->
            ( Pretty.string field
            , False
            )

        RecordUpdateExpression var setters ->
            prettyRecordUpdateExpression aliases indent var setters

        GLSLExpression _ ->
            ( Pretty.string "glsl"
            , True
            )


prettyApplication : Aliases -> Int -> List (Node Expression) -> ( Doc t, Bool )
prettyApplication aliases indent exprs =
    let
        ( prettyExpressions, alwaysBreak ) =
            List.map
                (prettyExpressionInner aliases bottomContext indent)
                (denodeAll exprs)
                |> List.unzip
                |> Tuple.mapSecond (List.any identity)
    in
    ( prettyExpressions
        |> Pretty.lines
        |> Pretty.nest indent
        |> Pretty.align
        |> optionalGroup alwaysBreak
    , alwaysBreak
    )


prettyOperatorApplication : Aliases -> Int -> String -> InfixDirection -> Node Expression -> Node Expression -> ( Doc t, Bool )
prettyOperatorApplication aliases indent symbol dir (Node _ exprl) (Node _ exprr) =
    let
        prec : Int
        prec =
            precedence symbol

        ( lprec, rprec ) =
            case dir of
                Left ->
                    ( prec, prec + 1 )

                Non ->
                    ( prec + 1, prec + 1 )

                Right ->
                    ( prec + 1, prec )

        ( left, breakLeft ) =
            prettyExpressionInner aliases { precedence = lprec } indent exprl

        ( right, breakRight ) =
            prettyExpressionInner aliases { precedence = rprec } (indent + 4) exprr

        alwaysBreak : Bool
        alwaysBreak =
            breakLeft || breakRight
    in
    ( left
        |> Pretty.a Pretty.space
        |> Pretty.a (Pretty.string symbol)
        |> Pretty.a Pretty.space
        |> Pretty.a right
        |> Pretty.align
        |> optionalGroup alwaysBreak
    , alwaysBreak
    )


prettyIfBlock : Aliases -> Int -> Node Expression -> Node Expression -> Node Expression -> ( Doc t, Bool )
prettyIfBlock aliases indent exprBool exprTrue exprFalse =
    let
        innerIfBlock : Node Expression -> Node Expression -> Node Expression -> List (Doc t)
        innerIfBlock (Node _ innerExprBool) (Node _ innerExprTrue) (Node _ innerExprFalse) =
            let
                ifPart : Doc t
                ifPart =
                    let
                        ( _, alwaysBreak ) =
                            prettyExpressionInner aliases topContext 4 innerExprBool
                    in
                    [ [ Pretty.string "if"
                      , prettyExpressionInner aliases topContext 4 innerExprBool |> Tuple.first
                      ]
                        |> Pretty.lines
                        |> optionalGroup alwaysBreak
                        |> Pretty.nest indent
                    , Pretty.string "then"
                    ]
                        |> Pretty.lines
                        |> optionalGroup alwaysBreak

                truePart : Doc t
                truePart =
                    prettyExpressionInner aliases topContext 4 innerExprTrue
                        |> Tuple.first
                        |> Pretty.indent indent

                elsePart : Doc t
                elsePart =
                    Pretty.line
                        |> Pretty.a (Pretty.string "else")

                falsePart : List (Doc t)
                falsePart =
                    case innerExprFalse of
                        IfBlock nestedExprBool nestedExprTrue nestedExprFalse ->
                            innerIfBlock nestedExprBool nestedExprTrue nestedExprFalse

                        _ ->
                            [ prettyExpressionInner aliases topContext 4 innerExprFalse
                                |> Tuple.first
                                |> Pretty.indent indent
                            ]
            in
            case falsePart of
                [] ->
                    []

                [ falseExpr ] ->
                    [ ifPart
                    , truePart
                    , elsePart
                    , falseExpr
                    ]

                hd :: tl ->
                    List.append
                        [ ifPart
                        , truePart
                        , [ elsePart, hd ] |> Pretty.words
                        ]
                        tl

        prettyExpressions : List (Doc t)
        prettyExpressions =
            innerIfBlock exprBool exprTrue exprFalse
    in
    ( prettyExpressions
        |> Pretty.lines
        |> Pretty.align
    , True
    )


prettyLiteral : String -> Doc t
prettyLiteral val =
    if String.contains "\n" val then
        Pretty.string val
            |> tripleQuotes

    else
        Pretty.string (escape val)
            |> quotes


prettyTupledExpression : Aliases -> Int -> List (Node Expression) -> ( Doc t, Bool )
prettyTupledExpression aliases indent exprs =
    case exprs of
        [] ->
            ( Pretty.string "()", False )

        _ ->
            let
                open : Doc t
                open =
                    Pretty.a Pretty.space (Pretty.string "(")

                close : Doc t
                close =
                    Pretty.a (Pretty.string ")") Pretty.line

                ( prettyExpressions, alwaysBreak ) =
                    List.map (prettyExpressionInner aliases topContext (decrementIndent indent 2)) (denodeAll exprs)
                        |> List.unzip
                        |> Tuple.mapSecond (List.any identity)
            in
            ( prettyExpressions
                |> Pretty.separators ", "
                |> Pretty.surround open close
                |> Pretty.align
                |> optionalGroup alwaysBreak
            , alwaysBreak
            )


showParen : Bool -> ( Doc t, Bool ) -> ( Doc t, Bool )
showParen show ( child, alwaysBreak ) =
    if show then
        let
            open : Doc t
            open =
                Pretty.string "("

            close : Doc t
            close =
                Pretty.a (Pretty.string ")") Pretty.tightline
        in
        ( child
            |> Pretty.nest 1
            |> Pretty.surround open close
            |> Pretty.align
            |> optionalGroup alwaysBreak
        , alwaysBreak
        )

    else
        ( child, alwaysBreak )


prettyLetBlock : Aliases -> Int -> LetBlock -> ( Doc t, Bool )
prettyLetBlock aliases indent letBlock =
    ( [ Pretty.string "let"
      , List.map (prettyLetDeclaration aliases indent) (denodeAll letBlock.declarations)
            |> doubleLines
            |> Pretty.indent indent
      , Pretty.string "in"
      , prettyExpressionInner aliases topContext 4 (denode letBlock.expression) |> Tuple.first
      ]
        |> Pretty.lines
        |> Pretty.align
    , True
    )


prettyLetDeclaration : Aliases -> Int -> LetDeclaration -> Doc t
prettyLetDeclaration aliases indent letDecl =
    case letDecl of
        LetFunction fn ->
            prettyFun aliases fn

        LetDestructuring (Node _ pattern) (Node _ expr) ->
            [ prettyPatternInner aliases False pattern
            , Pretty.string "="
            ]
                |> Pretty.words
                |> Pretty.a Pretty.line
                |> Pretty.a
                    (prettyExpressionInner aliases topContext 4 expr
                        |> Tuple.first
                        |> Pretty.indent indent
                    )


prettyCaseBlock : Aliases -> Int -> CaseBlock -> ( Doc t, Bool )
prettyCaseBlock aliases indent caseBlock =
    let
        casePart : Doc t
        casePart =
            let
                ( caseExpression, alwaysBreak ) =
                    prettyExpressionInner aliases topContext 4 (denode caseBlock.expression)
            in
            [ [ Pretty.string "case"
              , caseExpression
              ]
                |> Pretty.lines
                |> optionalGroup alwaysBreak
                |> Pretty.nest indent
            , Pretty.string "of"
            ]
                |> Pretty.lines
                |> optionalGroup alwaysBreak

        prettyCase : Elm.Syntax.Expression.Case -> Doc t
        prettyCase ( Node _ pattern, Node _ expr ) =
            prettyPattern aliases pattern
                |> Pretty.a (Pretty.string " ->")
                |> Pretty.a Pretty.line
                |> Pretty.a (prettyExpressionInner aliases topContext 4 expr |> Tuple.first |> Pretty.indent 4)
                |> Pretty.indent indent

        patternsPart : Doc t
        patternsPart =
            List.map prettyCase caseBlock.cases
                |> doubleLines
    in
    ( [ casePart, patternsPart ]
        |> Pretty.lines
        |> Pretty.align
    , True
    )


prettyLambdaExpression : Aliases -> Int -> Lambda -> ( Doc t, Bool )
prettyLambdaExpression aliases indent lambda =
    let
        ( prettyExpr, alwaysBreak ) =
            prettyExpressionInner aliases topContext 4 (denode lambda.expression)
    in
    ( [ Pretty.string "\\"
            |> Pretty.a (List.map (prettyPatternInner aliases False) (denodeAll lambda.args) |> Pretty.words)
            |> Pretty.a (Pretty.string " ->")
      , prettyExpr
      ]
        |> Pretty.lines
        |> Pretty.nest indent
        |> Pretty.align
        |> optionalGroup alwaysBreak
    , alwaysBreak
    )


prettyRecordExpr : Aliases -> List (Node RecordSetter) -> ( Doc t, Bool )
prettyRecordExpr aliases setters =
    case setters of
        [] ->
            ( Pretty.string "{}", False )

        _ ->
            let
                open : Doc t
                open =
                    Pretty.a Pretty.space (Pretty.string "{")

                close : Doc t
                close =
                    Pretty.a (Pretty.string "}")
                        Pretty.line

                ( prettyExpressions, alwaysBreak ) =
                    List.map (prettySetter aliases) (denodeAll setters)
                        |> List.unzip
                        |> Tuple.mapSecond (List.any identity)
            in
            ( prettyExpressions
                |> Pretty.separators ", "
                |> Pretty.surround open close
                |> Pretty.align
                |> optionalGroup alwaysBreak
            , alwaysBreak
            )


prettySetter : Aliases -> ( Node String, Node Expression ) -> ( Doc t, Bool )
prettySetter aliases ( Node _ fld, Node _ val ) =
    let
        ( prettyExpr, alwaysBreak ) =
            prettyExpressionInner aliases topContext 4 val
    in
    ( [ [ Pretty.string fld
        , Pretty.string "="
        ]
            |> Pretty.words
      , prettyExpr
      ]
        |> Pretty.lines
        |> optionalGroup alwaysBreak
        |> Pretty.nest 4
    , alwaysBreak
    )


prettyList : Aliases -> Int -> List (Node Expression) -> ( Doc t, Bool )
prettyList aliases indent exprs =
    case exprs of
        [] ->
            ( Pretty.string "[]", False )

        _ ->
            let
                open : Doc t
                open =
                    Pretty.a Pretty.space (Pretty.string "[")

                close : Doc t
                close =
                    Pretty.a (Pretty.string "]") Pretty.line

                ( prettyExpressions, alwaysBreak ) =
                    List.map (prettyExpressionInner aliases topContext (decrementIndent indent 2)) (denodeAll exprs)
                        |> List.unzip
                        |> Tuple.mapSecond (List.any identity)
            in
            ( prettyExpressions
                |> Pretty.separators ", "
                |> Pretty.surround open close
                |> Pretty.align
                |> optionalGroup alwaysBreak
            , alwaysBreak
            )


prettyRecordAccess : Aliases -> Node Expression -> Node String -> ( Doc t, Bool )
prettyRecordAccess aliases (Node _ expr) (Node _ field) =
    let
        ( prettyExpr, alwaysBreak ) =
            prettyExpressionInner aliases bottomContext 4 expr
    in
    ( prettyExpr
        |> Pretty.a dot
        |> Pretty.a (Pretty.string field)
    , alwaysBreak
    )


prettyRecordUpdateExpression : Aliases -> Int -> Node String -> List (Node RecordSetter) -> ( Doc t, Bool )
prettyRecordUpdateExpression aliases indent (Node _ var) setters =
    let
        addBarToFirst : List (Doc t) -> List (Doc t)
        addBarToFirst exprs =
            case exprs of
                [] ->
                    []

                hd :: tl ->
                    Pretty.a hd (Pretty.string "| ") :: tl
    in
    case setters of
        [] ->
            ( Pretty.string "{}", False )

        _ ->
            let
                open : Doc t
                open =
                    [ Pretty.string "{"
                    , Pretty.string var
                    ]
                        |> Pretty.words
                        |> Pretty.a Pretty.line

                close : Doc t
                close =
                    Pretty.a (Pretty.string "}")
                        Pretty.line

                ( prettyExpressions, alwaysBreak ) =
                    List.map (prettySetter aliases) (denodeAll setters)
                        |> List.unzip
                        |> Tuple.mapSecond (List.any identity)
            in
            ( open
                |> Pretty.a
                    (prettyExpressions
                        |> addBarToFirst
                        |> Pretty.separators ", "
                    )
                |> Pretty.nest indent
                |> Pretty.surround Pretty.empty close
                |> Pretty.align
                |> optionalGroup alwaysBreak
            , alwaysBreak
            )



--== Type Annotations


{-| Pretty prints a type annotation.
-}
prettyTypeAnnotation : Aliases -> TypeAnnotation -> Doc t
prettyTypeAnnotation aliases typeAnn =
    case typeAnn of
        GenericType val ->
            Pretty.string val

        Typed fqName anns ->
            prettyTyped aliases fqName anns

        Unit ->
            Pretty.string "()"

        Tupled anns ->
            prettyTupled aliases anns

        Record recordDef ->
            prettyRecord aliases (denodeAll recordDef)

        GenericRecord (Node _ paramName) (Node _ recordDef) ->
            prettyGenericRecord aliases paramName (denodeAll recordDef)

        FunctionTypeAnnotation fromAnn toAnn ->
            prettyFunctionTypeAnnotation aliases fromAnn toAnn


prettyTyped : Aliases -> Node ( ModuleName, String ) -> List (Node TypeAnnotation) -> Doc t
prettyTyped aliases (Node _ ( moduleName, typeName )) anns =
    let
        typeDoc : Doc t
        typeDoc =
            prettyModuleNameDot aliases moduleName
                |> Pretty.a (Pretty.string typeName)

        argsDoc : Doc t
        argsDoc =
            List.map (prettyTypeAnnotationParens aliases) (denodeAll anns)
                |> Pretty.words
    in
    [ typeDoc
    , argsDoc
    ]
        |> Pretty.words


prettyTupled : Aliases -> List (Node TypeAnnotation) -> Doc t
prettyTupled aliases anns =
    Pretty.space
        |> Pretty.a
            (List.map (prettyTypeAnnotation aliases) (denodeAll anns)
                |> Pretty.join (Pretty.string ", ")
            )
        |> Pretty.a Pretty.space
        |> Pretty.parens


prettyTypeAnnotationParens : Aliases -> TypeAnnotation -> Doc t
prettyTypeAnnotationParens aliases typeAnn =
    if isNakedCompound typeAnn then
        prettyTypeAnnotation aliases typeAnn |> Pretty.parens

    else
        prettyTypeAnnotation aliases typeAnn


prettyRecord : Aliases -> List RecordField -> Doc t
prettyRecord aliases fields =
    case fields of
        [] ->
            Pretty.string "{}"

        _ ->
            let
                open : Doc t
                open =
                    Pretty.a Pretty.space (Pretty.string "{")

                close : Doc t
                close =
                    Pretty.a (Pretty.string "}") Pretty.line
            in
            fields
                |> List.map (Tuple.mapBoth denode denode)
                |> List.map (prettyFieldTypeAnn aliases)
                |> Pretty.separators ", "
                |> Pretty.surround open close
                |> Pretty.group


prettyGenericRecord : Aliases -> String -> List RecordField -> Doc t
prettyGenericRecord aliases paramName fields =
    let
        addBarToFirst : List (Doc t) -> List (Doc t)
        addBarToFirst exprs =
            case exprs of
                [] ->
                    []

                hd :: tl ->
                    Pretty.a hd (Pretty.string "| ") :: tl
    in
    case fields of
        [] ->
            Pretty.string "{}"

        _ ->
            let
                open : Doc t
                open =
                    [ Pretty.string "{"
                    , Pretty.string paramName
                    ]
                        |> Pretty.words
                        |> Pretty.a Pretty.line

                close : Doc t
                close =
                    Pretty.a (Pretty.string "}")
                        Pretty.line
            in
            open
                |> Pretty.a
                    (fields
                        |> List.map (Tuple.mapBoth denode denode)
                        |> List.map (prettyFieldTypeAnn aliases)
                        |> addBarToFirst
                        |> Pretty.separators ", "
                    )
                |> Pretty.nest 4
                |> Pretty.surround Pretty.empty close
                |> Pretty.group


prettyFieldTypeAnn : Aliases -> ( String, TypeAnnotation ) -> Doc t
prettyFieldTypeAnn aliases ( name, ann ) =
    [ [ Pretty.string name
      , Pretty.string ":"
      ]
        |> Pretty.words
    , prettyTypeAnnotation aliases ann
    ]
        |> Pretty.lines
        |> Pretty.nest 4
        |> Pretty.group


prettyFunctionTypeAnnotation : Aliases -> Node TypeAnnotation -> Node TypeAnnotation -> Doc t
prettyFunctionTypeAnnotation aliases left right =
    let
        expandLeft : TypeAnnotation -> Doc t
        expandLeft ann =
            case ann of
                FunctionTypeAnnotation _ _ ->
                    prettyTypeAnnotationParens aliases ann

                _ ->
                    prettyTypeAnnotation aliases ann

        expandRight : TypeAnnotation -> List (Doc t)
        expandRight ann =
            case ann of
                FunctionTypeAnnotation innerLeft innerRight ->
                    innerFnTypeAnn innerLeft innerRight

                _ ->
                    [ prettyTypeAnnotation aliases ann ]

        innerFnTypeAnn : Node TypeAnnotation -> Node TypeAnnotation -> List (Doc t)
        innerFnTypeAnn (Node _ innerLeft) (Node _ innerRight) =
            let
                rightSide : List (Doc t)
                rightSide =
                    innerRight |> expandRight
            in
            case rightSide of
                hd :: tl ->
                    (innerLeft |> expandLeft)
                        :: ([ Pretty.string "->", hd ] |> Pretty.words)
                        :: tl

                [] ->
                    []
    in
    innerFnTypeAnn left right
        |> Pretty.lines
        |> Pretty.group


{-| A type annotation is a naked compound if it is made up of multiple parts that
are not enclosed in brackets or braces. This means either a type or type alias with
arguments or a function type; records and tuples are compound but enclosed in brackets
or braces.
Naked type annotations need to be bracketed in situations type argument bindings are
ambiguous otherwise.
-}
isNakedCompound : TypeAnnotation -> Bool
isNakedCompound typeAnn =
    case typeAnn of
        Typed _ [] ->
            False

        Typed _ _ ->
            True

        FunctionTypeAnnotation _ _ ->
            True

        _ ->
            False



--== Helpers


prettyMaybe : (a -> Doc t) -> Maybe a -> Doc t
prettyMaybe prettyFn maybeVal =
    Maybe.map prettyFn maybeVal
        |> Maybe.withDefault Pretty.empty


decrementIndent : Int -> Int -> Int
decrementIndent currentIndent spaces =
    let
        modded : Int
        modded =
            modBy 4 (currentIndent - spaces)
    in
    if modded == 0 then
        4

    else
        modded


dot : Doc t
dot =
    Pretty.string "."


quotes : Doc t -> Doc t
quotes doc =
    Pretty.surround (Pretty.char '"') (Pretty.char '"') doc


tripleQuotes : Doc t -> Doc t
tripleQuotes doc =
    Pretty.surround (Pretty.string "\"\"\"") (Pretty.string "\"\"\"") doc


singleQuotes : Doc t -> Doc t
singleQuotes doc =
    Pretty.surround (Pretty.char '\'') (Pretty.char '\'') doc


sqParens : Doc t -> Doc t
sqParens doc =
    Pretty.surround (Pretty.string "[") (Pretty.string "]") doc


doubleLines : List (Doc t) -> Doc t
doubleLines =
    Pretty.join (Pretty.a Pretty.line Pretty.line)


escape : String -> String
escape val =
    val
        |> String.replace "\\" "\\\\"
        |> String.replace "\"" "\\\""
        |> String.replace "\n" "\\n"
        |> String.replace "\t" "\\t"


escapeChar : Char -> String
escapeChar val =
    case val of
        '\\' ->
            "\\\\"

        '\'' ->
            "\\'"

        '\t' ->
            "\\t"

        '\n' ->
            "\\n"

        c ->
            String.fromChar c


optionalGroup : Bool -> Doc t -> Doc t
optionalGroup flag doc =
    if flag then
        doc

    else
        Pretty.group doc


optionalParens : Bool -> Doc t -> Doc t
optionalParens flag doc =
    if flag then
        Pretty.parens doc

    else
        doc


toHexString : Int -> String
toHexString val =
    let
        padWithZeros : String -> String
        padWithZeros str =
            let
                length : Int
                length =
                    String.length str
            in
            if length < 2 then
                String.padLeft 2 '0' str

            else if length > 2 && length < 4 then
                String.padLeft 4 '0' str

            else if length > 4 && length < 8 then
                String.padLeft 8 '0' str

            else
                str
    in
    "0x" ++ (Hex.toString val |> String.toUpper |> padWithZeros)


{-| Calculate a precedence for any operator to be able to know when
parenthesis are needed or not.
When a lower precedence expression appears beneath a higher one, its needs
parenthesis.
When a higher precedence expression appears beneath a lower one, if should
not have parenthesis.
-}
precedence : String -> Int
precedence symbol =
    case symbol of
        ">>" ->
            9

        "<<" ->
            9

        "^" ->
            8

        "*" ->
            7

        "/" ->
            7

        "//" ->
            7

        "%" ->
            7

        "rem" ->
            7

        "+" ->
            6

        "-" ->
            6

        "++" ->
            5

        "::" ->
            5

        "==" ->
            4

        "/=" ->
            4

        "<" ->
            4

        ">" ->
            4

        "<=" ->
            4

        ">=" ->
            4

        "&&" ->
            3

        "||" ->
            2

        "|>" ->
            0

        "<|" ->
            0

        _ ->
            0
