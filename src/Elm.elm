module Elm exposing (..)

{-|


# Primitives

@docs int, float, char, string, hex, unit


@docs value, valueFrom

@docs parens

@docs list, tuple, triple

@docs record, get

@docs glsl

@docs apply, applyFrom

@docs function functionWith


@docs lambda

@docs inModule


@docs expose, exposeConstructor


@docs power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, pipe, pipeLeft, compose, composeLeft

-}

import Elm.Syntax.Declaration  as Declaration exposing (Declaration(..))
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.File as File
import Elm.Syntax.Import as Import
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Module as Module
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.Range as Range
import Elm.Syntax.Signature as Signature
import Elm.Syntax.Type as Type
import Elm.Syntax.TypeAlias as TypeAlias
import Internal.Util as Util
import Elm.Type
import Internal.Prepare as Prepare

{-|-}
type alias Expression = 
    -- TODO: match each expression with their type and bubble it up! 
    -- { expression : Exp.Expression
    -- , annotation : Elm.Type.Annotation
    -- }
    Exp.Expression



{-|-}
file : Module -> List Declaration -> File
file mod decs =
    File 
        { moduleDefinition = mod
        , imports = []
        , body = decs
        }


{-|
A file with aliases for various libraries

-}
fileWith : Module -> List (Module, String) -> List Declaration -> File
fileWith mod aliases decs =
    File 
        { moduleDefinition = mod
        , imports = []
        , body = decs
        }




{-|-}
type File =
    File FileDetails


type alias FileDetails =
    { moduleDefinition : Module
    , imports : List (Node.Node Import.Import)
    , body : List Declaration
    -- , comments : Maybe (Comment FileComment)
    }




type alias Module =
    Util.Module


{-| A modules name

        Elm.inModule 
            [ "Html"
            , "Attributes"
            ]
    
    will refer to

        Html.Attributes

Note also that this will force capitalization on each segment to prevent silly errors.

-}
inModule : List String -> Module
inModule =
    Util.inModule 



{-|-}
value : String -> Expression
value =
    valueFrom Util.emptyModule


{-| 
-}
valueFrom : Module -> String -> Expression
valueFrom mod name =
    Exp.FunctionOrValue (Util.unpack mod) name



{-| 
-}
unit : Expression
unit =
    Exp.UnitExpr


{-| 
-}
int : Int -> Expression
int intVal =
    Exp.Integer intVal


{-| 
-}
hex : Int -> Expression
hex hexVal =
    Exp.Hex hexVal


{-| 
-}
float : Float -> Expression
float floatVal =
    Exp.Floatable floatVal



{-| 
-}
string : String -> Expression
string literal =
    Exp.Literal literal


{-| 
-}
char : Char -> Expression
char charVal =
    Exp.CharLiteral charVal



{-| 
-}
glsl : String -> Expression
glsl expr =
    Exp.GLSLExpression expr


{-| 
-}
tuple : Expression -> Expression -> Expression
tuple one two =
    Exp.TupledExpression (Util.nodifyAll [one, two])



{-| 
-}
triple : Expression -> Expression -> Expression -> Expression
triple one two three =
    Exp.TupledExpression (Util.nodifyAll [one, two, three])

{-|-}
list : List Expression -> Expression
list exprs =
    Exp.ListExpr (Util.nodifyAll exprs)


{-| 
-}
record : List ( String, Expression ) -> Expression
record setters =
     setters
        |> List.map 
            (\( fieldName, expr ) -> 
                ( Util.nodify fieldName, Util.nodify expr )
            )
        |> Util.nodifyAll
        |> Exp.RecordExpr



{-| 
    record
        |> Elm.get "field"

    ->

    record.field

-}
get : String -> Expression ->  Expression
get selector expr =
    Exp.RecordAccess (Util.nodify expr) (Util.nodify selector)



{-|-}
parens : Expression -> Expression
parens expr =
    Exp.ParenthesizedExpression (Util.nodify expr)






{-| 
-}
apply : String -> List Expression -> Expression
apply name args =
    Exp.Application (Util.nodifyAll (value name :: args))





{-| 
-}
applyFrom : Module -> String -> List Expression -> Expression
applyFrom (modName) name args =
    Exp.Application (Util.nodifyAll (valueFrom modName name :: args))





{-|-}
type alias Pattern = Pattern.Pattern




{-| LambdaExpression Lambda
-}
lambda : List Pattern -> Expression -> Expression
lambda args expr =
    Exp.LambdaExpression
        { args = Util.nodifyAll args
        , expression = Util.nodify expr
        }
        

type alias Declaration = Util.Declaration



{-|-}
function : String ->  List Pattern -> Expression -> Declaration
function name args body =
    { documentation = Util.nodifyMaybe Nothing
    , signature = Util.nodifyMaybe Nothing
    , declaration = 
        Util.nodify 
            { name = Util.nodify name
            , arguments = Util.nodifyAll args
            , expression = Util.nodify body
            }
    }
    |> Declaration.FunctionDeclaration
    |> Util.Declaration Util.NotExposed



{-|-}
functionWith : String ->  List (Elm.Type.Annotation , Pattern) -> Expression -> Declaration
functionWith  name args body =
    { documentation = Util.nodifyMaybe Nothing
    , signature = Util.nodifyMaybe Nothing
    , declaration = 
        Util.nodify 
            { name = Util.nodify name
            , arguments = Util.nodifyAll (List.map Tuple.second args)
            , expression = Util.nodify body
            }
    }
    |> Declaration.FunctionDeclaration
    |> Util.Declaration Util.NotExposed




{-|-}
expose : Declaration -> Declaration
expose =
    Util.expose 



{-|-}
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


{-|  `>>`.
-}
compose : Expression -> Expression -> Expression
compose =
    applyBinOp (BinOp ">>" Infix.Left 9)


{-|  `<<`
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


{-|  `/`.
-}
divide : Expression -> Expression -> Expression
divide =
    applyBinOp (BinOp "/" Infix.Left 7)


{-|  `//`.
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


{-|  `|>`

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


{-|  `<|`
-}
pipeLeft : Expression -> Expression -> Expression
pipeLeft =
    applyBinOp (BinOp "<|" Infix.Right 0)



applyBinOp :  BinOp -> Expression -> Expression -> Expression
applyBinOp  (BinOp symbol dir _) exprl exprr =
    Exp.OperatorApplication symbol dir (Util.nodify exprl) (Util.nodify exprr)
