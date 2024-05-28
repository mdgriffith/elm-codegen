module Elm.Op exposing
    ( equal, notEqual, and, or
    , append, cons
    , plus, minus, multiply, divide, intDivide, power
    , lt, gt, lte, gte
    , pipe, pipeLeft
    , parens
    , keep, skip
    , slash, query
    )

{-| This module helps generate operators!

So, this

    Elm.Op.equal (Elm.bool True) (Elm.bool False)

Would generate

    True == False


## Equality

@docs equal, notEqual, and, or


## Lists and strings

@docs append, cons


## Math

@docs plus, minus, multiply, divide, intDivide, power


## Comparisons

@docs lt, gt, lte, gte

@docs pipe, pipeLeft

@docs parens


## Parsing

@docs keep, skip


## Url parsing

@docs slash, query

-}

import Dict
import Elm exposing (Expression)
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Node exposing (Node(..))
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler
import Internal.Index as Index
import Internal.Types



{- Infix operators!

   The goal is to make the following work


       one
           |> Elm.Op.or two
           |> Elm.Op.or three


       Elm.Op.or one two




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


{-| `==`
-}
equal : Expression -> Expression -> Expression
equal =
    applyInfix []
        (BinOp "==" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.var "a"
            , Internal.Types.var "a"
            ]
            Internal.Types.bool
        )


{-| `/=`
-}
notEqual : Expression -> Expression -> Expression
notEqual =
    applyInfix []
        (BinOp "/=" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.var "a"
            , Internal.Types.var "a"
            ]
            Internal.Types.bool
        )


{-| `<`
-}
lt : Expression -> Expression -> Expression
lt =
    applyInfix []
        (BinOp "<" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.comparable
            , Internal.Types.comparable
            ]
            Internal.Types.bool
        )


{-| `>`
-}
gt : Expression -> Expression -> Expression
gt =
    applyInfix []
        (BinOp ">" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.comparable
            , Internal.Types.comparable
            ]
            Internal.Types.bool
        )


{-| `<=`
-}
lte : Expression -> Expression -> Expression
lte =
    applyInfix []
        (BinOp "<=" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.comparable
            , Internal.Types.comparable
            ]
            Internal.Types.bool
        )


{-| `>=`
-}
gte : Expression -> Expression -> Expression
gte =
    applyInfix []
        (BinOp ">=" Infix.Non 4)
        (Internal.Types.function
            [ Internal.Types.comparable
            , Internal.Types.comparable
            ]
            Internal.Types.bool
        )


{-| `&&`
-}
and : Expression -> Expression -> Expression
and =
    applyInfix []
        (BinOp "&&" Infix.Right 3)
        (Internal.Types.function
            [ Internal.Types.bool
            , Internal.Types.bool
            ]
            Internal.Types.bool
        )


{-| `||`
-}
or : Expression -> Expression -> Expression
or =
    applyInfix []
        (BinOp "||" Infix.Right 2)
        (Internal.Types.function
            [ Internal.Types.bool
            , Internal.Types.bool
            ]
            Internal.Types.bool
        )


{-| The to-the-power-of operator `^`
-}
power : Expression -> Expression -> Expression
power =
    applyNumber "^" Infix.Right


{-| `*`
-}
multiply : Expression -> Expression -> Expression
multiply =
    applyNumber "*" Infix.Left


{-| `/`
-}
divide : Expression -> Expression -> Expression
divide =
    applyInfix []
        (BinOp "/" Infix.Left 7)
        (Internal.Types.function
            [ Internal.Types.float
            , Internal.Types.float
            ]
            Internal.Types.float
        )


{-| `//`
-}
intDivide : Expression -> Expression -> Expression
intDivide =
    applyInfix []
        (BinOp "//" Infix.Left 7)
        (Internal.Types.function
            [ Internal.Types.int
            , Internal.Types.int
            ]
            Internal.Types.int
        )


{-| `+`
-}
plus : Expression -> Expression -> Expression
plus =
    applyNumber "+" Infix.Left


{-| `-`
-}
minus : Expression -> Expression -> Expression
minus =
    applyNumber "-" Infix.Left


{-| `::`
-}
cons : Expression -> Expression -> Expression
cons =
    applyInfix []
        (BinOp "::" Infix.Right 5)
        (Internal.Types.function
            [ Internal.Types.var "a"
            , Internal.Types.list (Internal.Types.var "a")
            ]
            (Internal.Types.list (Internal.Types.var "a"))
        )


{-| `++`
-}
append : Expression -> Expression -> Expression
append =
    applyInfix []
        (BinOp "++" Infix.Right 5)
        (Internal.Types.function
            [ Internal.Types.appendable
            , Internal.Types.appendable
            ]
            Internal.Types.appendable
        )


{-| used in the `elm/parser` library

`|=`

-}
keep : Expression -> Expression -> Expression
keep =
    applyInfix []
        (BinOp "|=" Infix.Left 5)
        -- Parser (a -> b) -> Parser a -> Parser b
        (Internal.Types.function
            [ Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                , Internal.Types.var "b"
                ]
            , Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                ]
            ]
            (Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "b"
                ]
            )
        )


{-| `|.`
-}
skip : Expression -> Expression -> Expression
skip =
    applyInfix []
        (BinOp "|." Infix.Left 6)
        (Internal.Types.function
            [ Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "keep"
                ]
            , Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "ignore"
                ]
            ]
            (Internal.Types.custom [ "Parser" ]
                "Parser"
                [ Internal.Types.var "keep"
                ]
            )
        )


{-| `</>` used in url parsing
-}
slash : Expression -> Expression -> Expression
slash =
    applyInfix [ [ "Url", "Parser" ] ]
        (BinOp "</>" Infix.Right 7)
        --  Parser a b -> Parser b c -> Parser a c
        (Internal.Types.function
            [ Internal.Types.custom [ "Url", "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                , Internal.Types.var "b"
                ]
            , Internal.Types.custom [ "Url", "Parser" ]
                "Parser"
                [ Internal.Types.var "b"
                , Internal.Types.var "c"
                ]
            ]
            (Internal.Types.custom [ "Url", "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                , Internal.Types.var "c"
                ]
            )
        )


{-| `<?>` used in url parsing
-}
query : Expression -> Expression -> Expression
query =
    applyInfix [ [ "Url", "Parser" ] ]
        (BinOp "<?>" Infix.Left 8)
        -- Parser a (query -> b) -> Parser query -> Parser a b
        (Internal.Types.function
            [ Internal.Types.custom [ "Url", "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                , Internal.Types.function
                    [ Internal.Types.var "query"
                    ]
                    (Internal.Types.var "b")
                ]
            , Internal.Types.custom [ "Url", "Parser", "Query" ]
                "Parser"
                [ Internal.Types.var "query"
                ]
            ]
            (Internal.Types.custom [ "Url", "Parser" ]
                "Parser"
                [ Internal.Types.var "a"
                , Internal.Types.var "b"
                ]
            )
        )



-- {-| `>>`
-- -}
-- compose : Expression -> Expression -> Expression
-- compose =
--     applyBinOp (BinOp ">>" Infix.Right 9)
-- {-| `<<`
-- -}
-- composeLeft : Expression -> Expression -> Expression
-- composeLeft =
--     applyBinOp (BinOp "<<" Infix.Left 9)


{-| `|>`

    Elm.value
        { importFrom = []
        , name = "thang"
        , annotation = Nothing
        }
        |> Elm.Op.pipe (Elm.value "thang2")
        |> Elm.Op.pipe (Elm.value "thang3")

Results in

    thang
        |> thang2
        |> thang3

-}
pipe : Expression -> Expression -> Expression
pipe r l =
    applyPipe (BinOp "|>" Infix.Left 0)
        (Internal.Types.function
            [ Internal.Types.var "a"
            , Internal.Types.function
                [ Internal.Types.var "a"
                ]
                (Internal.Types.var "b")
            ]
            (Internal.Types.var "b")
        )
        l
        r


{-| `<|`
-}
pipeLeft : Expression -> Expression -> Expression
pipeLeft =
    applyPipe (BinOp "<|" Infix.Right 0)
        (Internal.Types.function
            [ Internal.Types.function
                [ Internal.Types.var "a"
                ]
                (Internal.Types.var "b")
            , Internal.Types.var "a"
            ]
            (Internal.Types.var "b")
        )


{-| Like applyInfix, but without parens
-}
applyPipe : BinOp -> Annotation.TypeAnnotation -> Expression -> Expression -> Expression
applyPipe (BinOp symbol dir _) infixAnnotation l r =
    Compiler.Expression <|
        \index ->
            let
                ( leftIndex, left ) =
                    Compiler.toExpressionDetails index l

                ( _, right ) =
                    Compiler.toExpressionDetails leftIndex r
            in
            { expression =
                Exp.OperatorApplication symbol
                    dir
                    (Compiler.nodify left.expression)
                    (Compiler.nodify right.expression)
            , annotation =
                Compiler.applyType index
                    (Ok
                        { type_ = infixAnnotation
                        , inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        }
                    )
                    [ left
                    , right
                    ]
            , imports = left.imports ++ right.imports
            }


{-| Wrap an expression in parentheses.

Generally you won't need this as `elm-codegen` handles parens for you, but it can be useful to semantically group operations from this module.

-}
parens : Expression -> Expression
parens (Compiler.Expression toExp) =
    Compiler.Expression
        (\index ->
            let
                exp : Compiler.ExpressionDetails
                exp =
                    toExp index
            in
            { exp
                | expression =
                    Compiler.parens exp.expression
            }
        )


applyInfix : List Compiler.Module -> BinOp -> Annotation.TypeAnnotation -> Expression -> Expression -> Expression
applyInfix extraImports (BinOp symbol dir _) infixAnnotation l r =
    Compiler.Expression <|
        \index ->
            let
                ( leftIndex, left ) =
                    Compiler.toExpressionDetails index l

                ( _, right ) =
                    Compiler.toExpressionDetails leftIndex r
            in
            { expression =
                Exp.OperatorApplication symbol
                    dir
                    (Compiler.nodify (Compiler.parens left.expression))
                    (Compiler.nodify (Compiler.parens right.expression))
            , annotation =
                Compiler.applyType index
                    (Ok
                        { type_ = infixAnnotation
                        , inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        }
                    )
                    [ left
                    , right
                    ]
            , imports = extraImports ++ left.imports ++ right.imports
            }


applyNumber : String -> Infix.InfixDirection -> Expression -> Expression -> Expression
applyNumber symbol dir l r =
    Compiler.Expression <|
        \index ->
            let
                ( leftIndex, left ) =
                    Compiler.toExpressionDetails index l

                ( rightIndex, right ) =
                    Compiler.toExpressionDetails leftIndex r

                annotationIndex : Index.Index
                annotationIndex =
                    Index.next rightIndex

                numberTypeName : String
                numberTypeName =
                    Index.protectTypeName
                        "number"
                        annotationIndex
            in
            { expression =
                Exp.OperatorApplication symbol
                    dir
                    (Compiler.nodify left.expression)
                    (Compiler.nodify right.expression)
            , annotation =
                Compiler.applyType index
                    (Ok
                        { inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        , type_ =
                            Annotation.FunctionTypeAnnotation
                                (Compiler.nodify
                                    (Annotation.GenericType numberTypeName)
                                )
                                (Compiler.nodify
                                    (Annotation.FunctionTypeAnnotation
                                        (Compiler.nodify
                                            (Annotation.GenericType numberTypeName)
                                        )
                                        (Compiler.nodify
                                            (Annotation.GenericType numberTypeName)
                                        )
                                    )
                                )
                        }
                    )
                    [ left
                    , right
                    ]
            , imports = left.imports ++ right.imports
            }
