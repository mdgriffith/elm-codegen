module Elm exposing
    ( file, render
    , Expression
    , value, valueFrom
    , int, float, char, string, hex, unit
    , list, tuple, triple
    , record, get
    , caseOn
    , apply, applyFrom
    , lambda
    , declaration, declarationWith, function, functionWith
    , Module, moduleName, moduleAs
    , expose, exposeConstructor
    , power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, pipe, pipeLeft, compose, composeLeft
    , portIncoming, portOutgoing
    , File
    )

{-|

@docs file, render

@docs Expression

@docs value, valueFrom


# Primitives

@docs int, float, char, string, hex, unit

@docs list, tuple, triple

@docs record, get

@docs caseOn

@docs apply, applyFrom

@docs lambda


# Top level

@docs declaration, declarationWith, function, functionWith

@docs Module, moduleName, moduleAs

@docs expose, exposeConstructor


# Operators

@docs power, multiply, divide, intDivide, modulo, rem, plus, minus, append, cons, equal, notEqual, lt, gt, lte, gte, and, or, pipe, pipeLeft, compose, composeLeft


# Ports

@docs portIncoming, portOutgoing


# Util

@docs File

-}

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
import Elm.Type
import Internal.Util as Util
import Internal.Write
import Set


{-| -}
type alias Module =
    Util.Module


{-| -}
type alias Expression =
    Util.Expression


{-| Turn the AST into a pretty printed file
-}
render : File -> { path : String, contents : String }
render (File fileDetails) =
    let
        mod =
            Util.getModule fileDetails.moduleDefinition

        exposed =
            Util.getExposed fileDetails.body

        body =
            Internal.Write.write
                { moduleDefinition =
                    Util.nodify
                        ((if Util.hasPorts fileDetails.body then
                            Elm.Syntax.Module.PortModule

                          else
                            Elm.Syntax.Module.NormalModule
                         )
                            { moduleName = Util.nodify mod
                            , exposingList =
                                case exposed of
                                    [] ->
                                        Util.nodify
                                            (Expose.All Range.emptyRange)

                                    _ ->
                                        Util.nodify
                                            (Expose.Explicit
                                                (Util.nodifyAll exposed)
                                            )
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
    Util.Expression
        { expression = Exp.FunctionOrValue (Util.unpack mod) name
        , annotation = Err []
        , imports = [ mod ]
        }


{-| -}
unit : Expression
unit =
    Util.Expression
        { expression = Exp.UnitExpr
        , annotation = Ok Elm.Type.unit
        , imports = []
        }


{-| -}
int : Int -> Expression
int intVal =
    Util.Expression
        { expression = Exp.Integer intVal
        , annotation = Ok Elm.Type.int
        , imports = []
        }


{-| -}
hex : Int -> Expression
hex hexVal =
    Util.Expression
        { expression = Exp.Hex hexVal
        , annotation = Ok Elm.Type.int
        , imports = []
        }


{-| -}
float : Float -> Expression
float floatVal =
    Util.Expression
        { expression = Exp.Floatable floatVal
        , annotation = Ok Elm.Type.float
        , imports = []
        }


{-| -}
string : String -> Expression
string literal =
    Util.Expression
        { expression = Exp.Literal literal
        , annotation = Ok Elm.Type.string
        , imports = []
        }


{-| -}
char : Char -> Expression
char charVal =
    Util.Expression
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
tuple (Util.Expression one) (Util.Expression two) =
    Util.Expression
        { expression = Exp.TupledExpression (Util.nodifyAll [ one.expression, two.expression ])
        , annotation = Result.map2 Elm.Type.tuple one.annotation two.annotation
        , imports = one.imports ++ two.imports
        }


{-| -}
triple : Expression -> Expression -> Expression -> Expression
triple (Util.Expression one) (Util.Expression two) (Util.Expression three) =
    Util.Expression
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
    Util.Expression
        { expression = Exp.ListExpr (List.map toList exprs)
        , annotation = Util.unify exprs
        , imports = []
        }


toList : Expression -> Node.Node Exp.Expression
toList (Util.Expression exp) =
    Util.nodify exp.expression


{-| -}
record : List ( String, Expression ) -> Expression
record fields =
    let
        unified =
            fields
                |> List.foldl
                    (\( fieldName, Util.Expression exp ) found ->
                        { fields =
                            ( Util.nodify fieldName
                            , Util.nodify exp.expression
                            )
                                :: found.fields
                        , errors =
                            if Set.member fieldName found.passed then
                                Util.DuplicateFieldInRecord fieldName :: found.errors

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
    Util.Expression
        { expression =
            unified.fields
                |> List.reverse
                |> Util.nodifyAll
                |> Exp.RecordExpr
        , annotation =
            case unified.errors of
                [] ->
                    Ok (Elm.Type.record (List.reverse unified.fieldAnnotations))

                errs ->
                    Err errs
        , imports = unified.imports
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
letIn decls (Util.Expression within) =
    let
        gathered =
            List.foldl
                (\(Util.LetDeclaration mods dec) accum ->
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
    Util.Expression
        { expression =
            Exp.LetExpression
                { declarations = Util.nodifyAll gathered.declarations
                , expression = Util.nodify within.expression
                }
        , imports = gathered.imports
        , annotation =
            within.annotation
        }


{-| -}
caseOn : Expression -> List ( Pattern, Expression ) -> Expression
caseOn (Util.Expression expr) cases =
    let
        gathered =
            List.foldl
                (\( pattern, Util.Expression exp ) accum ->
                    { cases = ( Util.nodify pattern, Util.nodify exp.expression ) :: accum.cases
                    , imports = accum.imports ++ exp.imports
                    , annotation =
                        case accum.annotation of
                            Nothing ->
                                Just exp.annotation

                            Just exist ->
                                if exist == exp.annotation then
                                    accum.annotation

                                else
                                    Just (Err [ Util.CaseBranchesReturnDifferentTypes ])
                    }
                )
                { cases = []
                , imports = []
                , annotation = Nothing
                }
                cases

        --
    in
    Util.Expression
        { expression =
            Exp.CaseExpression
                { expression = Util.nodify expr.expression
                , cases = List.reverse gathered.cases
                }
        , annotation =
            case gathered.annotation of
                Nothing ->
                    Err [ Util.EmptyCaseStatement ]

                Just ann ->
                    ann
        , imports = expr.imports ++ gathered.imports
        }


{-|

    record
        |> Elm.get "field"

    ->

    record.field

_Note_ -

-}
get : String -> Expression -> Expression
get selector (Util.Expression expr) =
    Util.Expression
        { expression =
            Exp.RecordAccess (Util.nodify expr.expression) (Util.nodify selector)
        , annotation =
            Err [ Util.SomeOtherIssue ]
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
    Util.Expression
        { expression =
            Exp.Application (Util.nodifyAll (getExpression (value name) :: List.map (parens << getExpression) args))
        , annotation =
            Err [ Util.SomeOtherIssue ]
        , imports = List.concatMap getImports args
        }


getExpression : Expression -> Exp.Expression
getExpression (Util.Expression exp) =
    exp.expression


getImports : Expression -> List Util.Module
getImports (Util.Expression exp) =
    exp.imports


{-| -}
applyFrom : Module -> String -> List Expression -> Expression
applyFrom mod name args =
    Util.Expression
        { expression =
            Exp.Application (Util.nodifyAll (getExpression (valueFrom mod name) :: List.map (parens << getExpression) args))
        , annotation =
            Err [ Util.SomeOtherIssue ]
        , imports = mod :: List.concatMap getImports args
        }


{-| -}
type alias Pattern =
    Pattern.Pattern


{-| LambdaExpression Lambda
-}
lambda : List Pattern -> Expression -> Expression
lambda args (Util.Expression expr) =
    Util.Expression
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


{-| If you have a specific type signature you would like you can add it here.

Note, this library will autocalculate many type signatures! Make sure `Elm.declaration` doesnt already do this automatically for you!

-}
declarationWith : String -> Elm.Type.Annotation -> Expression -> Declaration
declarationWith name annotation (Util.Expression body) =
    function name
        []
        -- note, we could do some type checking here
        (Util.Expression { body | annotation = Ok annotation })


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
function name args (Util.Expression body) =
    { documentation = Util.nodifyMaybe Nothing
    , signature =
        case body.annotation of
            Ok sig ->
                Just
                    (Util.nodify
                        { name = Util.nodify name
                        , typeAnnotation = Util.nodify sig
                        }
                    )

            Err _ ->
                Util.nodifyMaybe Nothing
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
functionWith name args (Util.Expression body) =
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


{-|

    import Elm.Type as Type

    Elm.portIncoming "receiveMessageFromTheWorld" [ Type.string, Type.int ]

Results in

    port receiveMessageFromTheWorld : (String -> Int -> msg) -> Sub msg

**Note** You generally only need one incoming and one outgoing port!

If you want to vary the messages going in and out of your app, don't use a huge number of ports, instead write Json encoders and decoders.

This will give you more flexibility in the future and save you having to wire up a bunch of stuff.

**Another note** - You may need to expose your port explicityly using `Elm.expose`

-}
portIncoming : String -> List Elm.Type.Annotation -> Declaration
portIncoming name args =
    { name = Util.nodify name
    , typeAnnotation =
        Util.nodify
            (case args of
                [] ->
                    Annotation.FunctionTypeAnnotation
                        (Util.nodify (Annotation.GenericType "msg"))
                        (Util.nodify sub)

                start :: remain ->
                    Annotation.FunctionTypeAnnotation
                        (groupAnn (Util.nodify (functionAnnotation start (remain ++ [ Annotation.GenericType "msg" ]))))
                        (Util.nodify sub)
            )
    }
        |> Declaration.PortDeclaration
        |> Util.Declaration Util.NotExposed []


groupAnn ann =
    Annotation.Tupled
        [ ann ]
        |> Util.nodify


sub : Annotation.TypeAnnotation
sub =
    Annotation.Typed
        (Util.nodify ( [], "Sub" ))
        [ Util.nodify (Annotation.GenericType "msg") ]


{-| Create a port that can send messages to the outside world!

    import Elm.Type as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : String -> Elm.Type.Annotation -> Declaration
portOutgoing name arg =
    { name = Util.nodify name
    , typeAnnotation =
        Util.nodify
            (Annotation.FunctionTypeAnnotation
                (Util.nodify arg)
                (Util.nodify cmd)
            )
    }
        |> Declaration.PortDeclaration
        |> Util.Declaration Util.NotExposed []


cmd : Annotation.TypeAnnotation
cmd =
    Annotation.Typed
        (Util.nodify ( [], "Cmd" ))
        [ Util.nodify (Annotation.GenericType "msg") ]


functionAnnotation : Elm.Type.Annotation -> List Elm.Type.Annotation -> Elm.Type.Annotation
functionAnnotation start args =
    case args of
        [] ->
            start

        next :: remain ->
            functionAnnotation
                (Annotation.FunctionTypeAnnotation
                    (Util.nodify start)
                    (Util.nodify next)
                )
                remain



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
applyBinOp (BinOp symbol dir _) (Util.Expression exprl) (Util.Expression exprr) =
    Util.Expression
        { expression =
            Exp.OperatorApplication symbol dir (Util.nodify exprl.expression) (Util.nodify exprr.expression)
        , annotation = Err [ Util.SomeOtherIssue ]
        , imports = exprl.imports ++ exprr.imports
        }
