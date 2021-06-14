module Elm exposing
    ( file, render
    , Expression
    , value, valueFrom, valueWith
    , int, float, char, string, hex, unit
    , list, tuple, triple
    , record, get, updateRecord
    , caseOf
    , apply
    , lambda, lambda2, lambda3, lambda4, lambda5, lambdaWith
    , withAnnotation
    , Declaration, declaration, declarationWith
    , function, functionWith, fn, fn2, fn3, fn4, fn5
    , alias, aliasWith
    , customType, customTypeWith
    , Module, local, moduleName, moduleAs
    , withDocumentation, expose, exposeConstructor
    , power, multiply, divide, intDivide, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, compose, composeLeft
    , keep, skip, slash, questionMark
    , portIncoming, portOutgoing
    , File, expressionToString, declarationToString
    , pass
    )

{-|

@docs file, render

@docs Expression

@docs value, valueFrom, valueWith


# Primitives

@docs int, float, char, string, hex, unit

@docs list, tuple, triple

@docs record, get, updateRecord

@docs caseOf

@docs apply

@docs lambda, lambda2, lambda3, lambda4, lambda5, lambdaWith

@docs withAnnotation


# Top level

@docs Declaration, declaration, declarationWith

@docs function, functionWith, fn, fn2, fn3, fn4, fn5

@docs alias, aliasWith

@docs customType, customTypeWith

@docs Module, local, moduleName, moduleAs

@docs withDocumentation, expose, exposeConstructor


# Operators

@docs power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, compose, composeLeft


# Package specific operators

@docs keep, skip, slash, questionMark


# Ports

@docs portIncoming, portOutgoing


# Util

@docs File, expressionToString, declarationToString

@docs pass

-}

import Elm.Annotation
import Elm.Let as Let
import Elm.Syntax.Declaration as Declaration exposing (Declaration(..))
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Module
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer
import Internal.Comments
import Internal.Compiler as Compiler
import Internal.Write
import Set


{-| -}
type alias Module =
    Compiler.Module


{-| -}
type alias Expression =
    Compiler.Expression


{-| -}
expressionToString : Expression -> String
expressionToString (Compiler.Expression exp) =
    Elm.Writer.writeExpression (Compiler.nodify exp.expression)
        |> Elm.Writer.write


{-| -}
declarationToString : Declaration -> String
declarationToString (Compiler.Declaration expos mods dec) =
    Elm.Writer.writeDeclaration (Compiler.nodify dec)
        |> Elm.Writer.write


{-| Turn the AST into a pretty printed file
-}
render : File -> { path : String, contents : String }
render (File fileDetails) =
    let
        mod =
            Compiler.getModule fileDetails.moduleDefinition

        exposed =
            Compiler.getExposed fileDetails.body

        body =
            Internal.Write.write
                { moduleDefinition =
                    Compiler.nodify
                        ((if Compiler.hasPorts fileDetails.body then
                            Elm.Syntax.Module.PortModule

                          else
                            Elm.Syntax.Module.NormalModule
                         )
                            { moduleName = Compiler.nodify mod
                            , exposingList =
                                case exposed of
                                    [] ->
                                        Compiler.nodify
                                            (Expose.All Range.emptyRange)

                                    _ ->
                                        Compiler.nodify
                                            (Expose.Explicit
                                                (Compiler.nodifyAll exposed)
                                            )
                            }
                        )
                , imports =
                    List.filterMap Compiler.makeImport fileDetails.imports
                , declarations = fileDetails.body
                , comments =
                    Just
                        (Internal.Comments.addPart
                            Internal.Comments.emptyComment
                            (Internal.Comments.Markdown fileDetails.moduleComment)
                        )
                }
    in
    { path =
        String.join "/" mod ++ ".elm"
    , contents = body
    }


{-| Build a file!

    Elm.file (Elm.moduleName [ "My", "Module" ])
        """Here is the module comment!
        """
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

Once you have a file, you can render it using `Elm.toString`.

-}
file : Module -> String -> List Declaration -> File
file mod docComment decs =
    File
        { moduleDefinition = mod
        , imports =
            reduceDeclarationImports mod decs ( Set.empty, [] )
                |> Tuple.second
        , body = decs
        , moduleComment = docComment
        }


reduceDeclarationImports : Module -> List Declaration -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
reduceDeclarationImports self decs imports =
    case decs of
        [] ->
            imports

        (Compiler.Declaration _ newImports body) :: remain ->
            reduceDeclarationImports self
                remain
                (addImports self newImports imports)


addImports : Module -> List Module -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
addImports self newImports ( set, deduped ) =
    case newImports of
        [] ->
            ( set, deduped )

        new :: remain ->
            let
                full =
                    Compiler.fullModName new
            in
            if Set.member full set || full == Compiler.fullModName self then
                -- skip
                addImports self remain ( set, deduped )

            else
                addImports self
                    remain
                    ( Set.insert full set, new :: deduped )


{-| -}
type File
    = File FileDetails


type alias FileDetails =
    { moduleDefinition : Module
    , imports : List Module
    , body : List Declaration
    , moduleComment : String
    }


{-| A modules name

        Elm.moduleName
            [ "Html"
            , "Attributes"
            ]

    will refer to

        Html.Attributes

Note also that this will force capitalization on each segment to prevent silly errors.

-}
moduleName : List String -> Module
moduleName =
    Compiler.inModule


{-| A modules name

        Elm.moduleAs
            [ "Html"
            , "Attributes"
            ]
            "Html"

    will refer to

        Html.Attributes as Html

-}
moduleAs : List String -> String -> Module
moduleAs =
    Compiler.moduleAs


{-| Reference values that are in the file you're working on.
-}
local : Module
local =
    Compiler.inModule []


{-| -}
value : String -> Expression
value =
    valueFrom local


{-| -}
valueFrom : Module -> String -> Expression
valueFrom mod name =
    Compiler.Expression
        { expression =
            Exp.FunctionOrValue (Compiler.resolveModuleNameForValue mod)
                name
        , annotation = Err []
        , imports = [ mod ]
        , skip = False
        }


{-| Sometimes you may need to add a manual annotation.

Though be sure elm-prefab isn't already doing this automatically for you!

-}
withAnnotation : Elm.Annotation.Annotation -> Expression -> Expression
withAnnotation ann (Compiler.Expression exp) =
    Compiler.Expression
        { exp
            | annotation = Ok (Compiler.getInnerAnnotation ann)
            , imports = exp.imports ++ Compiler.getAnnotationImports ann
        }


{-| Add an annotation to a value.

**Note** this may not _literally_ add an annotation to the code, but will inform `elm-prefab`s type inference so that top level values can be auto-annotated.

So, for example, if we have.

    Elm.list
        [ Elm.valueWith myModule "myString" Elm.Annotation.string
        , Elm.valueWith myModule "myOtherString" Elm.Annotation.string
        ]

Then, when that list is generated, it will automatically have the type signature `List String`

-}
valueWith : Module -> String -> Elm.Annotation.Annotation -> Expression
valueWith mod name ann =
    Compiler.Expression
        { expression = Exp.FunctionOrValue (Compiler.resolveModuleNameForValue mod) name
        , annotation = Ok (Compiler.getInnerAnnotation ann)
        , imports = mod :: Compiler.getAnnotationImports ann
        , skip = False
        }


{-| -}
unit : Expression
unit =
    Compiler.Expression
        { expression = Exp.UnitExpr
        , annotation = Ok Annotation.Unit
        , imports = []
        , skip = False
        }


{-| -}
int : Int -> Expression
int intVal =
    Compiler.Expression
        { expression = Exp.Integer intVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.int)
        , imports = []
        , skip = False
        }


{-| -}
hex : Int -> Expression
hex hexVal =
    Compiler.Expression
        { expression = Exp.Hex hexVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.int)
        , imports = []
        , skip = False
        }


{-| -}
float : Float -> Expression
float floatVal =
    Compiler.Expression
        { expression = Exp.Floatable floatVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.float)
        , imports = []
        , skip = False
        }


{-| -}
string : String -> Expression
string literal =
    Compiler.Expression
        { expression = Exp.Literal literal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.string)
        , imports = []
        , skip = False
        }


{-| -}
char : Char -> Expression
char charVal =
    Compiler.Expression
        { expression = Exp.CharLiteral charVal
        , annotation = Ok (Compiler.getInnerAnnotation Elm.Annotation.char)
        , imports = []
        , skip = False
        }



-- {-|
-- -}
-- glsl : String -> Expression
-- glsl expr =
--     Exp.GLSLExpression expr


{-| -}
tuple : Expression -> Expression -> Expression
tuple (Compiler.Expression one) (Compiler.Expression two) =
    Compiler.Expression
        { expression = Exp.TupledExpression (Compiler.nodifyAll [ one.expression, two.expression ])
        , annotation =
            Result.map2
                (\oneA twoA ->
                    Elm.Annotation.tuple
                        (Compiler.noImports oneA)
                        (Compiler.noImports twoA)
                        |> Compiler.getInnerAnnotation
                )
                one.annotation
                two.annotation
        , imports = one.imports ++ two.imports
        , skip = False
        }


{-| -}
triple : Expression -> Expression -> Expression -> Expression
triple (Compiler.Expression one) (Compiler.Expression two) (Compiler.Expression three) =
    Compiler.Expression
        { expression =
            Exp.TupledExpression
                (Compiler.nodifyAll
                    [ one.expression, two.expression, three.expression ]
                )
        , annotation =
            Result.map3
                (\oneA twoA threeA ->
                    Elm.Annotation.triple
                        (Compiler.noImports oneA)
                        (Compiler.noImports twoA)
                        (Compiler.noImports threeA)
                        |> Compiler.getInnerAnnotation
                )
                one.annotation
                two.annotation
                three.annotation
        , imports = one.imports ++ two.imports ++ three.imports
        , skip = False
        }


{-| -}
list : List Expression -> Expression
list exprs =
    Compiler.Expression
        { expression = Exp.ListExpr (List.map toList exprs)
        , annotation =
            Compiler.unify exprs
                |> Result.map
                    (\inner ->
                        Annotation.Typed
                            (Compiler.nodify ( [], "List" ))
                            [ Compiler.nodify inner ]
                    )
        , imports = List.concatMap getImports exprs
        , skip = False
        }


toList : Expression -> Node.Node Exp.Expression
toList (Compiler.Expression exp) =
    Compiler.nodify exp.expression


{-| -}
updateRecord : String -> List ( String, Expression ) -> Expression
updateRecord name fields =
    Compiler.Expression
        { expression =
            fields
                |> List.map
                    (\( fieldName, fieldExp ) ->
                        Compiler.nodify
                            ( Compiler.nodify fieldName
                            , Compiler.nodify (Compiler.getInnerExpression fieldExp)
                            )
                    )
                |> Exp.RecordUpdateExpression (Compiler.nodify name)
        , annotation =
            Err []
        , imports =
            List.concatMap
                (Tuple.second >> Compiler.getImports)
                fields
        , skip = False
        }


{-| -}
record : List ( String, Expression ) -> Expression
record fields =
    let
        unified =
            fields
                |> List.foldl
                    (\( unformattedFieldName, Compiler.Expression exp ) found ->
                        let
                            fieldName =
                                Compiler.formatValue unformattedFieldName
                        in
                        { fields =
                            ( Compiler.nodify fieldName
                            , Compiler.nodify exp.expression
                            )
                                :: found.fields
                        , errors =
                            if Set.member fieldName found.passed then
                                Compiler.DuplicateFieldInRecord fieldName :: found.errors

                            else
                                case exp.annotation of
                                    Err [] ->
                                        Compiler.SomeOtherIssue :: found.errors

                                    Err errs ->
                                        errs ++ found.errors

                                    Ok ann ->
                                        found.errors
                        , fieldAnnotations =
                            case exp.annotation of
                                Err err ->
                                    found.fieldAnnotations

                                Ok ann ->
                                    ( Compiler.formatValue fieldName
                                    , ann
                                    )
                                        :: found.fieldAnnotations
                        , passed = Set.insert fieldName found.passed
                        , imports = exp.imports ++ found.imports
                        }
                    )
                    { fields = []
                    , errors = []
                    , fieldAnnotations = []
                    , passed = Set.empty
                    , imports = []
                    }
    in
    Compiler.Expression
        { expression =
            unified.fields
                |> List.reverse
                |> Compiler.nodifyAll
                |> Exp.RecordExpr
        , annotation =
            case unified.errors of
                [] ->
                    List.reverse unified.fieldAnnotations
                        |> List.map
                            (\( name, ann ) ->
                                ( Compiler.nodify name
                                , Compiler.nodify ann
                                )
                            )
                        |> Compiler.nodifyAll
                        |> Annotation.Record
                        |> Ok

                errs ->
                    Err errs
        , imports =
            unified.imports
        , skip = False
        }


{-| A let block.

Check out `Elm.Let` to add things to it.

    import Elm.Let as Let

    Elm.letIn
        [ Let.value "one" (Elm.int 5)
        , Let.value "two" (Elm.int 10)
        ]
        (Elm.add (Elm.value "one) (Elm.value "two))

-}
letIn : List Let.Declaration -> Expression -> Expression
letIn decls (Compiler.Expression within) =
    let
        gathered =
            List.foldl
                (\(Compiler.LetDeclaration mods dec) accum ->
                    { declarations =
                        dec :: accum.declarations
                    , imports = accum.imports ++ mods
                    }
                )
                { declarations = []
                , imports = []
                }
                decls
    in
    Compiler.Expression
        { expression =
            Exp.LetExpression
                { declarations = Compiler.nodifyAll gathered.declarations
                , expression = Compiler.nodify within.expression
                }
        , imports = gathered.imports
        , annotation =
            within.annotation
        , skip = False
        }


{-| -}
caseOf : Expression -> List ( Pattern, Expression ) -> Expression
caseOf (Compiler.Expression expr) cases =
    let
        gathered =
            List.foldl
                (\( pattern, Compiler.Expression exp ) accum ->
                    { cases = ( Compiler.nodify pattern, Compiler.nodify exp.expression ) :: accum.cases
                    , imports = accum.imports ++ exp.imports
                    , annotation =
                        case accum.annotation of
                            Nothing ->
                                Just exp.annotation

                            Just exist ->
                                if exist == exp.annotation then
                                    accum.annotation

                                else
                                    Just (Err [ Compiler.CaseBranchesReturnDifferentTypes ])
                    }
                )
                { cases = []
                , imports = []
                , annotation = Nothing
                }
                cases

        --
    in
    Compiler.Expression
        { expression =
            Exp.CaseExpression
                { expression = Compiler.nodify expr.expression
                , cases = List.reverse gathered.cases
                }
        , annotation =
            case gathered.annotation of
                Nothing ->
                    Err [ Compiler.EmptyCaseStatement ]

                Just ann ->
                    ann
        , imports = expr.imports ++ gathered.imports
        , skip = False
        }


{-|

    record
        |> Elm.get "field"

results in

    record.field

-}
get : String -> Expression -> Expression
get selector (Compiler.Expression expr) =
    Compiler.Expression
        { expression =
            Exp.RecordAccess (Compiler.nodify expr.expression) (Compiler.nodify (Compiler.formatValue selector))
        , annotation =
            Err [ Compiler.SomeOtherIssue ]
        , imports = expr.imports
        , skip = False
        }


{-| A custom type declaration.

    Elm.customType "MyType"
        [ ( "One", [] )
        , ( "Two", [ Elm.Annotation.list Elm.Annotation.string ] )
        ]

Should result in

    type MyType
        = One
        | Two (List String)

-}
customType : String -> List ( String, List Elm.Annotation.Annotation ) -> Declaration
customType name variants =
    Compiler.Declaration Compiler.NotExposed
        (List.concatMap
            (Tuple.second >> List.concatMap Compiler.getAnnotationImports)
            variants
        )
        (Declaration.CustomTypeDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics = []
            , constructors =
                List.map
                    (\( varName, vars ) ->
                        Compiler.nodify
                            { name = Compiler.nodify varName
                            , arguments =
                                List.map
                                    (Compiler.getInnerAnnotation
                                        >> Compiler.nodify
                                    )
                                    vars
                            }
                    )
                    variants
            }
        )


{-| If you want type variables in your custom type!
-}
customTypeWith : String -> List String -> List ( String, List Elm.Annotation.Annotation ) -> Declaration
customTypeWith name args variants =
    Compiler.Declaration Compiler.NotExposed
        (List.concatMap
            (Tuple.second >> List.concatMap Compiler.getAnnotationImports)
            variants
        )
        (Declaration.CustomTypeDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics = Compiler.nodifyAll args
            , constructors =
                List.map
                    (\( varName, vars ) ->
                        Compiler.nodify
                            { name = Compiler.nodify varName
                            , arguments =
                                List.map
                                    (Compiler.getInnerAnnotation
                                        >> Compiler.nodify
                                    )
                                    vars
                            }
                    )
                    variants
            }
        )


{-| A custom type declaration.

    Elm.alias "MyAlias"
        (Elm.Annotation.record
            [ ( "one", Elm.Annotation.string )
            , ( "two", Elm.Annotation.int )
            ]
        )

Should result in

    type alias MyAlias =
        { one : String
        , two : int
        }

-}
alias : String -> Elm.Annotation.Annotation -> Declaration
alias name innerAnnotation =
    Compiler.Declaration Compiler.NotExposed
        (Compiler.getAnnotationImports innerAnnotation)
        (Declaration.AliasDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics = []
            , typeAnnotation = Compiler.nodify (Compiler.getInnerAnnotation innerAnnotation)
            }
        )


{-| You may need type variables.

Elm.aliasWith "MyMaybe" ["a"]
(Elm.Annotation.maybe (Elm.Annotation.var "a"))

-}
aliasWith : String -> List String -> Elm.Annotation.Annotation -> Declaration
aliasWith name args innerAnnotation =
    Compiler.Declaration Compiler.NotExposed
        (Compiler.getAnnotationImports innerAnnotation)
        (Declaration.AliasDeclaration
            { documentation = Nothing
            , name = Compiler.nodify (Compiler.formatType name)
            , generics = Compiler.nodifyAll args
            , typeAnnotation = Compiler.nodify (Compiler.getInnerAnnotation innerAnnotation)
            }
        )


{-| Not exposed, this should be done automatically!
-}
parens : Exp.Expression -> Exp.Expression
parens expr =
    Exp.ParenthesizedExpression (Compiler.nodify expr)


getExpression : Expression -> Exp.Expression
getExpression (Compiler.Expression exp) =
    exp.expression


getImports : Expression -> List Compiler.Module
getImports (Compiler.Expression exp) =
    exp.imports


{-| -}
apply : Expression -> List Expression -> Expression
apply ((Compiler.Expression exp) as top) allArgs =
    let
        args =
            List.filter (\(Compiler.Expression arg) -> not arg.skip) allArgs
    in
    Compiler.Expression
        { expression =
            Exp.Application (Compiler.nodifyAll (exp.expression :: List.map (parens << getExpression) args))
        , annotation =
            Compiler.applyType top args
        , imports = exp.imports ++ List.concatMap getImports args
        , skip = False
        }


{-| -}
type alias Pattern =
    Pattern.Pattern


{-| -}
lambdaWith : List ( Pattern, Elm.Annotation.Annotation ) -> Expression -> Expression
lambdaWith args (Compiler.Expression expr) =
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args = Compiler.nodifyAll (List.map Tuple.first args)
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        (List.map (Compiler.getInnerAnnotation << Tuple.second) args)
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda : String -> Elm.Annotation.Annotation -> (Expression -> Expression) -> Expression
lambda argBaseName argType toExpression =
    let
        arg1 =
            valueWith (moduleName []) argBaseName argType

        (Compiler.Expression expr) =
            toExpression arg1
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args = [ Compiler.nodify (Pattern.VarPattern argBaseName) ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation argType ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda2 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression)
    -> Expression
lambda2 argBaseName oneType twoType toExpression =
    let
        arg1 =
            valueWith (moduleName []) argBaseName oneType

        arg2 =
            valueWith (moduleName []) (argBaseName ++ "2") twoType

        (Compiler.Expression expr) =
            toExpression arg1 arg2
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda3 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda3 argBaseName oneType twoType threeType toExpression =
    let
        arg1 =
            valueWith (moduleName []) argBaseName oneType

        arg2 =
            valueWith (moduleName []) (argBaseName ++ "2") twoType

        arg3 =
            valueWith (moduleName []) (argBaseName ++ "3") threeType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda4 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda4 argBaseName oneType twoType threeType fourType toExpression =
    let
        arg1 =
            valueWith (moduleName []) argBaseName oneType

        arg2 =
            valueWith (moduleName []) (argBaseName ++ "2") twoType

        arg3 =
            valueWith (moduleName []) (argBaseName ++ "3") threeType

        arg4 =
            valueWith (moduleName []) (argBaseName ++ "4") fourType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3 arg4
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "4"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        , Compiler.getInnerAnnotation fourType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
lambda5 :
    String
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Expression
lambda5 argBaseName oneType twoType threeType fourType fiveType toExpression =
    let
        arg1 =
            valueWith (moduleName []) argBaseName oneType

        arg2 =
            valueWith (moduleName []) (argBaseName ++ "2") twoType

        arg3 =
            valueWith (moduleName []) (argBaseName ++ "3") threeType

        arg4 =
            valueWith (moduleName []) (argBaseName ++ "4") fourType

        arg5 =
            valueWith (moduleName []) (argBaseName ++ "5") fiveType

        (Compiler.Expression expr) =
            toExpression arg1 arg2 arg3 arg4 arg5
    in
    Compiler.Expression
        { expression =
            Exp.LambdaExpression
                { args =
                    [ Compiler.nodify (Pattern.VarPattern argBaseName)
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "2"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "3"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "4"))
                    , Compiler.nodify (Pattern.VarPattern (argBaseName ++ "5"))
                    ]
                , expression = Compiler.nodify expr.expression
                }
        , annotation =
            case expr.annotation of
                Err err ->
                    Err err

                Ok return ->
                    List.foldr
                        (\ann fnbody ->
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify ann)
                                (Compiler.nodify fnbody)
                        )
                        return
                        [ Compiler.getInnerAnnotation oneType
                        , Compiler.getInnerAnnotation twoType
                        , Compiler.getInnerAnnotation threeType
                        , Compiler.getInnerAnnotation fourType
                        , Compiler.getInnerAnnotation fiveType
                        ]
                        |> Ok
        , imports = expr.imports
        , skip = False
        }


{-| -}
type alias Declaration =
    Compiler.Declaration


{-| -}
declaration : String -> Expression -> Declaration
declaration name body =
    function name [] body


{-| If you have a specific type signature you would like you can add it here.

Note, this library will autocalculate many type signatures! Make sure `Elm.declaration` doesnt already do this automatically for you!

-}
declarationWith : String -> Elm.Annotation.Annotation -> Expression -> Declaration
declarationWith name annotation (Compiler.Expression body) =
    function name
        []
        -- note, we could do some type checking here
        (Compiler.Expression
            { body
                | annotation = Ok (Compiler.getInnerAnnotation annotation)
                , imports = body.imports ++ Compiler.getAnnotationImports annotation
            }
        )


{-| Declare a function. Here's an example with a let:

    import Elm.Pattern as Pattern

    Elm.function "myFunc"
        [ Pattern.var "one"
        , Pattern.var "two"
        ]
        (Elm.letIn
            [ Let.value "added"
                (Elm.add (Elm.value "one") (Elm.value "two))
            ]
            (Elm.add (Elm.value "added") (Elm.int 5))
        )

will generate

    myFunc one two =
        let
            added =
                one + two
        in
        added + 5

-}
function : String -> List Pattern -> Expression -> Declaration
function name args (Compiler.Expression body) =
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok sig ->
                case args of
                    [] ->
                        Just
                            (Compiler.nodify
                                { name = Compiler.nodify (Compiler.formatValue name)
                                , typeAnnotation =
                                    Compiler.nodify sig
                                }
                            )

                    _ ->
                        -- we dont know the types of the arguments
                        -- maybe we only allow the `functionWith` version?
                        Nothing

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments = Compiler.nodifyAll args
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed body.imports


{-| -}
functionWith : String -> List ( Elm.Annotation.Annotation, Pattern ) -> Expression -> Declaration
functionWith name args (Compiler.Expression body) =
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        (List.map Tuple.first args)
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments = Compiler.nodifyAll (List.map Tuple.second args)
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (List.concatMap
                (Tuple.first
                    >> Compiler.getAnnotationImports
                )
                args
                ++ body.imports
            )


{-| -}
fn : String -> ( String, Elm.Annotation.Annotation ) -> (Expression -> Expression) -> Declaration
fn name ( oneName, oneType ) toBody =
    let
        arg1 =
            valueWith (moduleName []) oneName oneType

        (Compiler.Expression body) =
            toBody arg1
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ body.imports
            )


{-| -}
fn2 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression)
    -> Declaration
fn2 name ( oneName, oneType ) ( twoName, twoType ) toBody =
    let
        arg1 =
            valueWith (moduleName []) oneName oneType

        arg2 =
            valueWith (moduleName []) twoName twoType

        (Compiler.Expression body) =
            toBody arg1 arg2
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ body.imports
            )


{-| -}
fn3 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn3 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) toBody =
    let
        arg1 =
            valueWith (moduleName []) oneName oneType

        arg2 =
            valueWith (moduleName []) twoName twoType

        arg3 =
            valueWith (moduleName []) threeName threeType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ body.imports
            )


{-| -}
fn4 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn4 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) toBody =
    let
        arg1 =
            valueWith (moduleName []) oneName oneType

        arg2 =
            valueWith (moduleName []) twoName twoType

        arg3 =
            valueWith (moduleName []) threeName threeType

        arg4 =
            valueWith (moduleName []) fourName fourType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3 arg4
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType, fourType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ Compiler.getAnnotationImports fourType
                ++ body.imports
            )


{-| -}
fn5 :
    String
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> ( String, Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    -> Declaration
fn5 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) ( fiveName, fiveType ) toBody =
    let
        arg1 =
            valueWith (moduleName []) oneName oneType

        arg2 =
            valueWith (moduleName []) twoName twoType

        arg3 =
            valueWith (moduleName []) threeName threeType

        arg4 =
            valueWith (moduleName []) fourName fourType

        arg5 =
            valueWith (moduleName []) fiveName fiveType

        (Compiler.Expression body) =
            toBody arg1 arg2 arg3 arg4 arg5
    in
    { documentation = Compiler.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok return ->
                Just
                    (Compiler.nodify
                        { name = Compiler.nodify (Compiler.formatValue name)
                        , typeAnnotation =
                            Compiler.nodify <|
                                Compiler.getInnerAnnotation <|
                                    Elm.Annotation.function
                                        [ oneType, twoType, threeType, fourType, fiveType ]
                                        (Compiler.noImports return)
                        }
                    )

            Err _ ->
                Nothing
    , declaration =
        Compiler.nodify
            { name = Compiler.nodify (Compiler.formatValue name)
            , arguments =
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                , Compiler.nodify (Pattern.VarPattern fiveName)
                ]
            , expression = Compiler.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (Compiler.getAnnotationImports oneType
                ++ Compiler.getAnnotationImports twoType
                ++ Compiler.getAnnotationImports threeType
                ++ Compiler.getAnnotationImports fourType
                ++ Compiler.getAnnotationImports fiveType
                ++ body.imports
            )


{-| Add documentation to a declaration!
-}
withDocumentation : String -> Declaration -> Declaration
withDocumentation =
    Compiler.documentation


{-| -}
expose : Declaration -> Declaration
expose =
    Compiler.expose


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor =
    Compiler.exposeConstructor


{-|

    import Elm.Annotation as Type

    Elm.portIncoming "receiveMessageFromTheWorld" [ Type.string, Type.int ]

Results in

    port receiveMessageFromTheWorld : (String -> Int -> msg) -> Sub msg

**Note** You generally only need one incoming and one outgoing port!

If you want to vary the messages going in and out of your app, don't use a huge number of ports, instead write Json encoders and decoders.

This will give you more flexibility in the future and save you having to wire up a bunch of stuff.

**Another note** - You may need to expose your port explicitly using `Elm.expose`

-}
portIncoming : String -> List Elm.Annotation.Annotation -> Declaration
portIncoming name args =
    { name = Compiler.nodify name
    , typeAnnotation =
        Compiler.nodify
            (case args of
                [] ->
                    Annotation.FunctionTypeAnnotation
                        (Compiler.nodify (Annotation.GenericType "msg"))
                        (Compiler.nodify sub)

                start :: remain ->
                    Annotation.FunctionTypeAnnotation
                        (groupAnn
                            (Compiler.nodify
                                (Compiler.getInnerAnnotation
                                    (Elm.Annotation.function
                                        args
                                        (Elm.Annotation.var "msg")
                                    )
                                )
                            )
                        )
                        (Compiler.nodify sub)
            )
    }
        |> Declaration.PortDeclaration
        |> Compiler.Declaration Compiler.NotExposed
            (List.concatMap Compiler.getAnnotationImports args)


groupAnn ann =
    Annotation.Tupled
        [ ann ]
        |> Compiler.nodify


sub : Annotation.TypeAnnotation
sub =
    Annotation.Typed
        (Compiler.nodify ( [ "Platform", "Sub" ], "Sub" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : String -> Elm.Annotation.Annotation -> Declaration
portOutgoing name arg =
    { name = Compiler.nodify name
    , typeAnnotation =
        Compiler.nodify
            (Annotation.FunctionTypeAnnotation
                (Compiler.nodify (Compiler.getInnerAnnotation arg))
                (Compiler.nodify cmd)
            )
    }
        |> Declaration.PortDeclaration
        |> Compiler.Declaration Compiler.NotExposed (Compiler.getAnnotationImports arg)


cmd : Annotation.TypeAnnotation
cmd =
    Annotation.Typed
        (Compiler.nodify ( [ "Platform", "Cmd" ], "Cmd" ))
        [ Compiler.nodify (Annotation.GenericType "msg") ]



{- Infix operators!

   The goal is to make the following work


       one
           |> Elm.or two
           |> Elm.or three


       Elm.or one two




   We're not really worried about allowing operators to be partially applied in a way that results in the following code.

       (<=) 5

   I mean, come on, we're generating code.  Let's make it clearer.


   We're also not worried about recreating infix notation in this lib.  So no need to do:

       applyBinOp (int 2) plus (int 3)




-}


{-| Represents all of the binary operators allowed in Elm.
-}
type BinOp
    = BinOp String Infix.InfixDirection Int


{-| `>>`.
-}
compose : Expression -> Expression -> Expression
compose =
    applyBinOp (BinOp ">>" Infix.Left 9)


{-| `<<`
-}
composeLeft : Expression -> Expression -> Expression
composeLeft =
    applyBinOp (BinOp "<<" Infix.Right 9)


{-| The to-the-power-of operator `^`
-}
power : Expression -> Expression -> Expression
power =
    applyInfix (BinOp "^" Infix.Right 8)
        (valueWith
            local
            "*"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `*`.
-}
multiply : Expression -> Expression -> Expression
multiply =
    applyInfix (BinOp "*" Infix.Left 7)
        (valueWith
            local
            "*"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `/`.
-}
divide : Expression -> Expression -> Expression
divide =
    applyInfix (BinOp "/" Infix.Left 7)
        (valueWith
            local
            "/"
            (Elm.Annotation.function
                [ Elm.Annotation.float, Elm.Annotation.float ]
                Elm.Annotation.float
            )
        )


{-| `//`.
-}
intDivide : Expression -> Expression -> Expression
intDivide =
    applyInfix (BinOp "//" Infix.Left 7)
        (valueWith
            local
            "/"
            (Elm.Annotation.function
                [ Elm.Annotation.int, Elm.Annotation.int ]
                Elm.Annotation.int
            )
        )


{-| `+`.
-}
plus : Expression -> Expression -> Expression
plus =
    applyInfix (BinOp "+" Infix.Left 6)
        (valueWith
            local
            "max"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `-`
-}
minus : Expression -> Expression -> Expression
minus =
    applyInfix (BinOp "-" Infix.Left 6)
        (valueWith
            local
            "max"
            (Elm.Annotation.function
                [ Elm.Annotation.var "number", Elm.Annotation.var "number" ]
                (Elm.Annotation.var "number")
            )
        )


{-| `++`
-}
append : Expression -> Expression -> Expression
append =
    applyInfix
        (BinOp "++" Infix.Right 5)
        (valueWith
            local
            "append"
            (Elm.Annotation.function
                [ Elm.Annotation.namedWith
                    (moduleName [])
                    "List"
                    [ Elm.Annotation.var "a" ]
                , Elm.Annotation.namedWith
                    (moduleName [])
                    "List"
                    [ Elm.Annotation.var "a" ]
                ]
                (Elm.Annotation.namedWith
                    (moduleName [])
                    "List"
                    [ Elm.Annotation.var "a" ]
                )
            )
        )


{-| `::`
-}
cons : Expression -> Expression -> Expression
cons =
    applyInfix (BinOp "::" Infix.Right 5)
        (valueWith
            local
            "cons"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a"
                , Elm.Annotation.namedWith
                    (moduleName [])
                    "List"
                    [ Elm.Annotation.var "a" ]
                ]
                (Elm.Annotation.namedWith
                    (moduleName [])
                    "List"
                    [ Elm.Annotation.var "a" ]
                )
            )
        )


{-| `==`
-}
equal : Expression -> Expression -> Expression
equal =
    applyInfix (BinOp "==" Infix.Left 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a", Elm.Annotation.var "a" ]
                Elm.Annotation.bool
            )
        )


{-| `/=`
-}
notEqual : Expression -> Expression -> Expression
notEqual =
    applyInfix (BinOp "/=" Infix.Left 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "a", Elm.Annotation.var "a" ]
                Elm.Annotation.bool
            )
        )


{-| `<`
-}
lt : Expression -> Expression -> Expression
lt =
    applyInfix (BinOp "<" Infix.Non 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `>`
-}
gt : Expression -> Expression -> Expression
gt =
    applyInfix (BinOp ">" Infix.Non 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `<=`
-}
lte : Expression -> Expression -> Expression
lte =
    applyInfix (BinOp "<=" Infix.Non 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `>=`
-}
gte : Expression -> Expression -> Expression
gte =
    applyInfix (BinOp ">=" Infix.Non 4)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.var "comparable", Elm.Annotation.var "comparable" ]
                Elm.Annotation.bool
            )
        )


{-| `&&`
-}
and : Expression -> Expression -> Expression
and =
    applyInfix (BinOp "&&" Infix.Right 3)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.bool, Elm.Annotation.bool ]
                Elm.Annotation.bool
            )
        )


{-| `||`
-}
or : Expression -> Expression -> Expression
or =
    applyInfix (BinOp "||" Infix.Right 2)
        (valueWith
            local
            "equal"
            (Elm.Annotation.function
                [ Elm.Annotation.bool, Elm.Annotation.bool ]
                Elm.Annotation.bool
            )
        )


{-| used in the `elm/parser` library

`|=`

-}
keep : Expression -> Expression -> Expression
keep =
    applyBinOp (BinOp "|=" Infix.Left 5)


{-| `|.`
-}
skip : Expression -> Expression -> Expression
skip =
    applyBinOp (BinOp "|." Infix.Left 6)


{-| `</>` used in url parsing
-}
slash : Expression -> Expression -> Expression
slash =
    applyBinOp (BinOp "</>" Infix.Right 7)


{-| `<?>` used in url parsing
-}
questionMark : Expression -> Expression -> Expression
questionMark =
    applyBinOp (BinOp "<?>" Infix.Left 8)


{-| `|>`

These arent expose on purpose.

The idea would be to do this automatically if appropriate

    Elm.value "thang"
        |> Elm.pipe (Elm.value "thang2")
        |> Elm.pipe (Elm.value "thang3")

    Results in

    thang
        |> thang2
        |> thang3

-}
pipe : Expression -> Expression -> Expression
pipe =
    applyBinOp (BinOp "|>" Infix.Left 0)


{-| `<|`
-}
pipeLeft : Expression -> Expression -> Expression
pipeLeft =
    applyBinOp (BinOp "<|" Infix.Right 0)


applyBinOp : BinOp -> Expression -> Expression -> Expression
applyBinOp (BinOp symbol dir _) (Compiler.Expression exprl) (Compiler.Expression exprr) =
    Compiler.Expression
        { expression =
            Exp.OperatorApplication symbol dir (Compiler.nodify exprl.expression) (Compiler.nodify exprr.expression)
        , annotation = Err [ Compiler.SomeOtherIssue ]
        , imports = exprl.imports ++ exprr.imports
        , skip = False
        }


applyInfix : BinOp -> Expression -> Expression -> Expression -> Expression
applyInfix (BinOp symbol dir _) fnAnnotation (Compiler.Expression left) (Compiler.Expression right) =
    Compiler.Expression
        { expression =
            Exp.OperatorApplication symbol dir (Compiler.nodify left.expression) (Compiler.nodify right.expression)
        , annotation =
            Compiler.applyType fnAnnotation
                [ Compiler.Expression left
                , Compiler.Expression right
                ]
        , imports = left.imports ++ right.imports
        , skip = False
        }


{-| -}
pass : Compiler.Expression
pass =
    Compiler.skip
