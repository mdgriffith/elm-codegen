module Elm exposing
    ( file, render
    , int, float, char, string, hex, unit
    , value, valueFrom
    , list, tuple, triple
    , record, get
    , apply, applyFrom
    , lambda
    , declaration, function, functionWith
    , Module, moduleName, moduleAs
    , expose, exposeConstructor
    , power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, pipe, pipeLeft, compose, composeLeft
    )

{-|

@docs file, render


# Primitives

@docs int, float, char, string, hex, unit

@docs value, valueFrom

@docs list, tuple, triple

@docs record, get

@docs apply, applyFrom

@docs lambda


# Top level

@docs declaration, function, functionWith

@docs Module, moduleName, moduleAs

@docs expose, exposeConstructor


# Operators

@docs power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, pipe, pipeLeft, compose, composeLeft

-}

import Elm.Syntax.Declaration as Declaration exposing (Declaration(..))
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Module
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Type
import Internal.Util as Util
import Internal.Write
import Set


{-| -}
type alias Module =
    Util.Module


{-| -}
type Expression
    = Expression ExpressionDetails


type alias ExpressionDetails =
    { expression : Exp.Expression
    , annotation : Result (List InferenceError) Elm.Type.Annotation
    , imports : List Util.Module
    }


type InferenceError
    = MismatchedList Elm.Type.Annotation Elm.Type.Annotation
    | SomeOtherIssue
    | ThisIsntARecord String
    | DuplicateFieldInRecord String


{-| -}
filename : File -> String
filename (File fileDetails) =
    ""


{-| Turn the AST into a pretty printed file
-}
render : File -> { path : String, contents : String }
render (File fileDetails) =
    let
        mod =
            Util.getModule fileDetails.moduleDefinition

        body =
            Internal.Write.write
                { moduleDefinition =
                    Util.nodify
                        (Elm.Syntax.Module.NormalModule
                            { moduleName = Util.nodify mod
                            , exposingList = Util.nodify (Expose.All Range.emptyRange)
                            }
                        )
                , imports =
                    List.map Util.makeImport fileDetails.imports
                , declarations = fileDetails.body
                , comments = Nothing --: Maybe (Comments.Comment Comments.FileComment)
                }
    in
    { path =
        String.join "/" mod ++ ".elm"
    , contents = body
    }


{-| Build a file!

    Elm.file (Elm.moduleName [ "My", "Module" ])
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

Once you have a file, you can render it using `Elm.toString`.

-}
file : Module -> List Declaration -> File
file mod decs =
    File
        { moduleDefinition = mod
        , imports =
            reduceDeclarationImports decs ( Set.empty, [] )
                |> Tuple.second
        , body = decs
        }


reduceDeclarationImports : List Declaration -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
reduceDeclarationImports decs imports =
    case decs of
        [] ->
            imports

        (Util.Declaration _ newImports body) :: remain ->
            reduceDeclarationImports remain
                (addImports newImports imports)


addImports : List Module -> ( Set.Set String, List Module ) -> ( Set.Set String, List Module )
addImports newImports ( set, deduped ) =
    case newImports of
        [] ->
            ( set, deduped )

        new :: remain ->
            let
                full =
                    Util.fullModName new
            in
            if Set.member full set then
                addImports remain ( set, deduped )

            else
                addImports remain
                    ( Set.insert full set, new :: deduped )


{-| -}
type File
    = File FileDetails


type alias FileDetails =
    { moduleDefinition : Module
    , imports : List Module
    , body : List Declaration

    -- , comments : Maybe (Comment FileComment)
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
    Util.inModule


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
    Util.moduleAs


{-| -}
value : String -> Expression
value =
    valueFrom Util.emptyModule


{-| -}
valueFrom : Module -> String -> Expression
valueFrom mod name =
    Expression
        { expression = Exp.FunctionOrValue (Util.unpack mod) name
        , annotation = Ok Elm.Type.unit
        , imports = [ mod ]
        }


{-| -}
unit : Expression
unit =
    Expression
        { expression = Exp.UnitExpr
        , annotation = Ok Elm.Type.unit
        , imports = []
        }


{-| -}
int : Int -> Expression
int intVal =
    Expression
        { expression = Exp.Integer intVal
        , annotation = Ok Elm.Type.int
        , imports = []
        }


{-| -}
hex : Int -> Expression
hex hexVal =
    Expression
        { expression = Exp.Hex hexVal
        , annotation = Ok Elm.Type.int
        , imports = []
        }


{-| -}
float : Float -> Expression
float floatVal =
    Expression
        { expression = Exp.Floatable floatVal
        , annotation = Ok Elm.Type.float
        , imports = []
        }


{-| -}
string : String -> Expression
string literal =
    Expression
        { expression = Exp.Literal literal
        , annotation = Ok Elm.Type.string
        , imports = []
        }


{-| -}
char : Char -> Expression
char charVal =
    Expression
        { expression = Exp.CharLiteral charVal
        , annotation = Ok Elm.Type.char
        , imports = []
        }



-- {-|
-- -}
-- glsl : String -> Expression
-- glsl expr =
--     Exp.GLSLExpression expr


{-| -}
tuple : Expression -> Expression -> Expression
tuple (Expression one) (Expression two) =
    Expression
        { expression = Exp.TupledExpression (Util.nodifyAll [ one.expression, two.expression ])
        , annotation = Result.map2 Elm.Type.tuple one.annotation two.annotation
        , imports = one.imports ++ two.imports
        }


{-| -}
triple : Expression -> Expression -> Expression -> Expression
triple (Expression one) (Expression two) (Expression three) =
    Expression
        { expression = Exp.TupledExpression (Util.nodifyAll [ one.expression, two.expression, three.expression ])
        , annotation =
            Result.map3 Elm.Type.triple
                one.annotation
                two.annotation
                three.annotation
        , imports = one.imports ++ two.imports ++ three.imports
        }


{-| -}
list : List Expression -> Expression
list exprs =
    Expression
        { expression = Exp.ListExpr (List.map toList exprs)
        , annotation = unify exprs
        , imports = []
        }


toList : Expression -> Node.Node Exp.Expression
toList (Expression exp) =
    Util.nodify exp.expression


unify : List Expression -> Result (List InferenceError) Elm.Type.Annotation
unify exps =
    case exps of
        [] ->
            Ok (Elm.Type.var "a")

        (Expression top) :: remain ->
            case top.annotation of
                Ok ann ->
                    unifyHelper remain ann

                Err err ->
                    Err err


unifyHelper : List Expression -> Elm.Type.Annotation -> Result (List InferenceError) Elm.Type.Annotation
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
unifiable : Annotation.TypeAnnotation -> Annotation.TypeAnnotation -> Result String Annotation.TypeAnnotation
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


{-| -}
record : List ( String, Expression ) -> Expression
record fields =
    let
        unified =
            fields
                |> List.foldl
                    (\( fieldName, Expression exp ) found ->
                        { fields =
                            ( Util.nodify fieldName
                            , Util.nodify exp.expression
                            )
                                :: found.fields
                        , errors =
                            if Set.member fieldName found.passed then
                                DuplicateFieldInRecord fieldName :: found.errors

                            else
                                found.errors
                        , fieldAnnotations =
                            case exp.annotation of
                                Err err ->
                                    found.fieldAnnotations

                                Ok ann ->
                                    ( fieldName, ann )
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
    Expression
        { expression =
            unified.fields
                |> List.reverse
                |> Util.nodifyAll
                |> Exp.RecordExpr
        , annotation =
            case unified.errors of
                [] ->
                    Ok (Elm.Type.record unified.fieldAnnotations)

                errs ->
                    Err errs
        , imports = unified.imports
        }


{-|

    record
        |> Elm.get "field"

    ->

    record.field

_Note_ -

-}
get : String -> Expression -> Expression
get selector (Expression expr) =
    Expression
        { expression =
            Exp.RecordAccess (Util.nodify expr.expression) (Util.nodify selector)
        , annotation =
            Err [ SomeOtherIssue ]
        , imports = expr.imports
        }


{-| Not exposed, this should be done automatically!
-}
parens : Exp.Expression -> Exp.Expression
parens expr =
    Exp.ParenthesizedExpression (Util.nodify expr)


{-| -}
apply : String -> List Expression -> Expression
apply name args =
    Expression
        { expression =
            Exp.Application (Util.nodifyAll (getExpression (value name) :: List.map (parens << getExpression) args))
        , annotation =
            Err [ SomeOtherIssue ]
        , imports = List.concatMap getImports args
        }


getExpression : Expression -> Exp.Expression
getExpression (Expression exp) =
    exp.expression


getImports : Expression -> List Util.Module
getImports (Expression exp) =
    exp.imports


{-| -}
applyFrom : Module -> String -> List Expression -> Expression
applyFrom mod name args =
    Expression
        { expression =
            Exp.Application (Util.nodifyAll (getExpression (valueFrom mod name) :: List.map (parens << getExpression) args))
        , annotation =
            Err [ SomeOtherIssue ]
        , imports = mod :: List.concatMap getImports args
        }


{-| -}
type alias Pattern =
    Pattern.Pattern


{-| LambdaExpression Lambda
-}
lambda : List Pattern -> Expression -> Expression
lambda args (Expression expr) =
    Expression
        { expression =
            Exp.LambdaExpression
                { args = Util.nodifyAll args
                , expression = Util.nodify expr.expression
                }
        , annotation =
            expr.annotation
        , imports = expr.imports
        }


type alias Declaration =
    Util.Declaration


{-| -}
declaration : String -> Expression -> Declaration
declaration name body =
    function name [] body


{-| -}
function : String -> List Pattern -> Expression -> Declaration
function name args (Expression body) =
    { documentation = Util.nodifyMaybe Nothing
    , signature = Util.nodifyMaybe Nothing
    , declaration =
        Util.nodify
            { name = Util.nodify name
            , arguments = Util.nodifyAll args
            , expression = Util.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Util.Declaration Util.NotExposed body.imports


{-| -}
functionWith : String -> List ( Elm.Type.Annotation, Pattern ) -> Expression -> Declaration
functionWith name args (Expression body) =
    { documentation = Util.nodifyMaybe Nothing
    , signature = Util.nodifyMaybe Nothing
    , declaration =
        Util.nodify
            { name = Util.nodify name
            , arguments = Util.nodifyAll (List.map Tuple.second args)
            , expression = Util.nodify body.expression
            }
    }
        |> Declaration.FunctionDeclaration
        |> Util.Declaration Util.NotExposed body.imports


{-| -}
expose : Declaration -> Declaration
expose =
    Util.expose


{-| -}
exposeConstructor : Declaration -> Declaration
exposeConstructor =
    Util.exposeConstructor



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
    applyBinOp (BinOp "^" Infix.Right 8)


{-| `*`.
-}
multiply : Expression -> Expression -> Expression
multiply =
    applyBinOp (BinOp "*" Infix.Left 7)


{-| `/`.
-}
divide : Expression -> Expression -> Expression
divide =
    applyBinOp (BinOp "/" Infix.Left 7)


{-| `//`.
-}
intDivide : Expression -> Expression -> Expression
intDivide =
    applyBinOp (BinOp "//" Infix.Left 7)


{-| `%`.
-}
modulo : Expression -> Expression -> Expression
modulo =
    applyBinOp (BinOp "%" Infix.Left 7)


{-| `rem`.
-}
rem : Expression -> Expression -> Expression
rem =
    applyBinOp (BinOp "rem" Infix.Left 7)


{-| `+`.
-}
plus : Expression -> Expression -> Expression
plus =
    applyBinOp (BinOp "+" Infix.Left 6)


{-| `-`
-}
minus : Expression -> Expression -> Expression
minus =
    applyBinOp (BinOp "-" Infix.Left 6)


{-| `++`
-}
append : Expression -> Expression -> Expression
append =
    applyBinOp (BinOp "++" Infix.Right 5)


{-| `::`
-}
cons : Expression -> Expression -> Expression
cons =
    applyBinOp (BinOp "::" Infix.Right 5)


{-| `==`
-}
equal : Expression -> Expression -> Expression
equal =
    applyBinOp (BinOp "==" Infix.Left 4)


{-| `/=`
-}
notEqual : Expression -> Expression -> Expression
notEqual =
    applyBinOp (BinOp "/=" Infix.Left 4)


{-| `<`
-}
lt : Expression -> Expression -> Expression
lt =
    applyBinOp (BinOp "<" Infix.Non 4)


{-| `>`
-}
gt : Expression -> Expression -> Expression
gt =
    applyBinOp (BinOp ">" Infix.Non 4)


{-| `<=`
-}
lte : Expression -> Expression -> Expression
lte =
    applyBinOp (BinOp "<=" Infix.Non 4)


{-| `>=`
-}
gte : Expression -> Expression -> Expression
gte =
    applyBinOp (BinOp ">=" Infix.Non 4)


{-| `&&`
-}
and : Expression -> Expression -> Expression
and =
    applyBinOp (BinOp "&&" Infix.Right 3)


{-| `||`
-}
or : Expression -> Expression -> Expression
or =
    applyBinOp (BinOp "||" Infix.Right 2)


{-| `|>`

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
applyBinOp (BinOp symbol dir _) (Expression exprl) (Expression exprr) =
    Expression
        { expression =
            Exp.OperatorApplication symbol dir (Util.nodify exprl.expression) (Util.nodify exprr.expression)
        , annotation = Err [ SomeOtherIssue ]
        , imports = exprl.imports ++ exprr.imports
        }
