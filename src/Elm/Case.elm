module Elm.Case exposing
    ( maybe, result, list, list2, list3
    , tuple, triple
    , custom
    , Branch, otherwise, branch, branch2, branch3, branch4, branch5
    )

{-|

@docs maybe, result, list, list2, list3

@docs tuple, triple

@docs custom

@docs Branch, otherwise, branch, branch2, branch3, branch4, branch5

-}

import Elm exposing (Expression)
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Internal.Compiler as Compiler


captureCase :
    Compiler.Expression
    -> Compiler.Index
    -> List Branch
    ->
        ( Compiler.ExpressionDetails
        , { index : Compiler.Index
          , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
          , imports : List Compiler.Module
          , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
          }
        )
captureCase mainExpression index branches =
    let
        ( branchIndex, mainExpressionDetails ) =
            Compiler.toExpressionDetails index mainExpression
    in
    ( mainExpressionDetails
    , List.foldl
        captureCaseHelper
        { index = branchIndex
        , cases = []
        , imports = []
        , annotation = Nothing
        }
        branches
    )


captureCaseHelper :
    Branch
    ->
        { index : Compiler.Index
        , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
        , imports : List Compiler.Module
        , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
        }
    ->
        { index : Compiler.Index
        , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
        , imports : List Compiler.Module
        , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
        }
captureCaseHelper (Branch pattern caseExpression) accum =
    let
        ( newIndex, exp ) =
            Compiler.toExpressionDetails accum.index caseExpression
    in
    { index = newIndex
    , cases = ( Compiler.nodify pattern, Compiler.nodify exp.expression ) :: accum.cases
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


{-| -}
maybe :
    Expression
    ->
        { nothing : Expression
        , just : Expression -> Expression
        }
    -> Expression
maybe mainExpression branches =
    Compiler.Expression
        (\index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch
                            (Pattern.NamedPattern { moduleName = [], name = "Nothing" } [])
                            branches.nothing
                        , Branch
                            (Pattern.NamedPattern { moduleName = [], name = "Just" } [ Compiler.nodify (Pattern.VarPattern "a") ])
                            (branches.just (Elm.value "a"))
                        ]
            in
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
            }
        )


{-| -}
tuple :
    Expression
    -> (Expression -> Expression -> Expression)
    -> Expression
tuple mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch
                            (Pattern.TuplePattern
                                [ Compiler.nodify (Pattern.VarPattern "first")
                                , Compiler.nodify (Pattern.VarPattern "second")
                                ]
                            )
                            (branches (Elm.value "first") (Elm.value "second"))
                        ]
            in
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
            }


{-| -}
triple :
    Expression
    -> (Expression -> Expression -> Expression -> Expression)
    -> Expression
triple mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch
                            (Pattern.TuplePattern
                                [ Compiler.nodify (Pattern.VarPattern "first")
                                , Compiler.nodify (Pattern.VarPattern "second")
                                , Compiler.nodify (Pattern.VarPattern "third")
                                ]
                            )
                            (branches (Elm.value "first") (Elm.value "second") (Elm.value "third"))
                        ]
            in
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
            }


{-| -}
result :
    Expression
    ->
        { err : Expression -> Expression
        , ok : Expression -> Expression
        }
    -> Expression
result mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch
                            (Pattern.NamedPattern { moduleName = [], name = "Err" } [ Compiler.nodify (Pattern.VarPattern "a") ])
                            (branches.err (Elm.value "a"))
                        , Branch
                            (Pattern.NamedPattern { moduleName = [], name = "Ok" } [ Compiler.nodify (Pattern.VarPattern "a") ])
                            (branches.ok (Elm.value "a"))
                        ]
            in
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
            }


{-| -}
list :
    Expression
    ->
        { empty : Expression
        , remaining : Expression -> Expression
        }
    -> Expression
list mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch
                            (Pattern.ListPattern [])
                            branches.empty
                        , Branch (Pattern.VarPattern "a")
                            (branches.remaining (Elm.value "a"))
                        ]
            in
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
            }


{-| -}
list2 :
    Expression
    ->
        { empty : Expression
        , one : Expression -> Expression
        , remaining : Expression -> Expression
        }
    -> Expression
list2 mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch (Pattern.ListPattern []) branches.empty
                        , Branch
                            (Pattern.ListPattern [ Compiler.nodify (Pattern.VarPattern "a") ])
                            (branches.one (Elm.value "a"))
                        , Branch
                            (Pattern.VarPattern "a")
                            (branches.remaining (Elm.value "a"))
                        ]
            in
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
            }


{-| -}
list3 :
    Expression
    ->
        { empty : Expression
        , one : Expression -> Expression
        , two : Expression -> Expression -> Expression
        , remaining : Expression -> Expression
        }
    -> Expression
list3 mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        [ Branch (Pattern.ListPattern []) branches.empty
                        , Branch (Pattern.ListPattern [ Compiler.nodify (Pattern.VarPattern "a") ])
                            (branches.one (Elm.value "a"))
                        , Branch (Pattern.ListPattern [ Compiler.nodify (Pattern.VarPattern "a"), Compiler.nodify (Pattern.VarPattern "b") ])
                            (branches.two (Elm.value "a") (Elm.value "b"))
                        , Branch (Pattern.VarPattern "a")
                            (branches.remaining (Elm.value "a"))
                        ]
            in
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
            }


{-| -}
custom :
    Expression
    -> List Branch
    -> Expression
custom mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        index
                        branches
            in
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
            }


{-| -}
type Branch
    = Branch Pattern.Pattern Expression


{-| -}
branch : String -> Expression -> Branch
branch name exp =
    Branch
        (Pattern.NamedPattern { moduleName = [], name = name } [])
        exp


{-|

    A catchall branch in case you want the case to be nonexhaustive.

-}
otherwise : (Expression -> Expression) -> Branch
otherwise toExp =
    Branch
        (Pattern.VarPattern "otherwise")
        (toExp (Elm.value "otherwise"))


{-| -}
branch2 : String -> (Expression -> Expression) -> Branch
branch2 name toExp =
    Branch
        (Pattern.NamedPattern { moduleName = [], name = name }
            [ Compiler.nodify (Pattern.VarPattern "a") ]
        )
        (toExp (Elm.value "a"))


{-| -}
branch3 : String -> (Expression -> Expression -> Expression) -> Branch
branch3 name toExp =
    Branch
        (Pattern.NamedPattern { moduleName = [], name = name }
            [ Compiler.nodify (Pattern.VarPattern "a")
            , Compiler.nodify (Pattern.VarPattern "b")
            ]
        )
        (toExp (Elm.value "a") (Elm.value "b"))


{-| -}
branch4 : String -> (Expression -> Expression -> Expression -> Expression) -> Branch
branch4 name toExp =
    Branch
        (Pattern.NamedPattern { moduleName = [], name = name }
            [ Compiler.nodify (Pattern.VarPattern "a")
            , Compiler.nodify (Pattern.VarPattern "b")
            , Compiler.nodify (Pattern.VarPattern "c")
            ]
        )
        (toExp (Elm.value "a") (Elm.value "b") (Elm.value "c"))


{-| -}
branch5 : String -> (Expression -> Expression -> Expression -> Expression -> Expression) -> Branch
branch5 name toExp =
    Branch
        (Pattern.NamedPattern { moduleName = [], name = name }
            [ Compiler.nodify (Pattern.VarPattern "a")
            , Compiler.nodify (Pattern.VarPattern "b")
            , Compiler.nodify (Pattern.VarPattern "c")
            , Compiler.nodify (Pattern.VarPattern "d")
            ]
        )
        (toExp (Elm.value "a") (Elm.value "b") (Elm.value "c") (Elm.value "d"))
