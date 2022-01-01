module Elm.Case exposing
    ( maybe, result, list
    , tuple, triple
    , custom
    , Branch, otherwise, branch, branch2, branch3, branch4, branch5
    )

{-|

@docs maybe, result, list

@docs tuple, triple

@docs custom

@docs Branch, otherwise, branch, branch2, branch3, branch4, branch5

-}

import Elm exposing (Expression)
import Elm.Annotation as Type
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
captureCaseHelper (Branch toBranch) accum =
    let
        ( branchIndex, pattern, caseExpression ) =
            toBranch accum.index

        ( newIndex, exp ) =
            Compiler.toExpressionDetails branchIndex caseExpression
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


{-|

    Elm.fn "myMaybe" <|
        \myMaybe ->
            Elm.Case.list myMaybe
                { nothing = Elm.int 0
                , just =
                    \content ->
                        Elm.plus (Elm.int 5) content
                }

Generates

    \myMaybe ->
        case myMaybe of
            Nothing ->
                0

            Just just ->
                just + 5

-}
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
                            (\branchIndex ->
                                ( branchIndex
                                , Pattern.NamedPattern { moduleName = [], name = "Nothing" } []
                                , branches.nothing
                                )
                            )
                        , Branch
                            (\branchIndex ->
                                let
                                    ( justIndex, justName, justExp ) =
                                        Compiler.var branchIndex "just"
                                in
                                ( justIndex
                                , Pattern.NamedPattern { moduleName = [], name = "Just" } [ Compiler.nodify (Pattern.VarPattern justName) ]
                                , branches.just justExp
                                )
                            )
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


{-|

    Elm.fn "myTuple" <|
        \myTuple ->
            Elm.Case.tuple myTuple
                { nothing = Elm.int 0
                , just =
                    \one two ->
                        Elm.plus (Elm.int 5) two
                }

Generates

    \myTuple ->
        case myTuple of
            ( one, two ) ->
                5 + two

-}
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
                        (Compiler.dive index)
                        [ Branch
                            (\branchIndex ->
                                let
                                    ( firstIndex, firstName, firstExp ) =
                                        Compiler.var branchIndex "first"

                                    ( secondIndex, secondName, secondExp ) =
                                        Compiler.var firstIndex "second"
                                in
                                ( secondIndex
                                , Pattern.TuplePattern
                                    [ Compiler.nodify (Pattern.VarPattern firstName)
                                    , Compiler.nodify (Pattern.VarPattern secondName)
                                    ]
                                , branches firstExp secondExp
                                )
                            )
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


{-|

    Elm.fn "myTriple" <|
        \myTriple ->
            Elm.Case.triple myTriple
                { nothing = Elm.int 0
                , just =
                    \one two three ->
                        Elm.plus (Elm.int 5) two
                }

Generates

    \myTriple ->
        case myTriple of
            ( one, two, three ) ->
                5 + two

-}
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
                            (\branchIndex ->
                                let
                                    ( firstIndex, firstName, firstExp ) =
                                        Compiler.var branchIndex "first"

                                    ( secondIndex, secondName, secondExp ) =
                                        Compiler.var firstIndex "second"

                                    ( thirdIndex, thirdName, thirdExp ) =
                                        Compiler.var secondIndex "third"
                                in
                                ( thirdIndex
                                , Pattern.TuplePattern
                                    [ Compiler.nodify (Pattern.VarPattern firstName)
                                    , Compiler.nodify (Pattern.VarPattern secondName)
                                    , Compiler.nodify (Pattern.VarPattern thirdName)
                                    ]
                                , branches firstExp secondExp thirdExp
                                )
                            )
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


{-|

    Elm.fn "myResult" <|
        \myResult ->
            Elm.Case.triple myResult
                { ok =
                    \ok ->
                        Elm.string "No errors"
                , err =
                    \err ->
                        err
                }

Generates

    \myResult ->
        case myResult of
            Ok ok ->
                "No errors"

            Err err ->
                err

-}
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
                        (Compiler.dive index)
                        [ Branch
                            (\branchIndex ->
                                let
                                    ( okIndex, okName, okExp ) =
                                        Compiler.var branchIndex "ok"
                                in
                                ( okIndex
                                , Pattern.NamedPattern { moduleName = [], name = "Ok" }
                                    [ Compiler.nodify (Pattern.VarPattern okName) ]
                                , branches.err okExp
                                )
                            )
                        , Branch
                            (\branchIndex ->
                                let
                                    ( errIndex, errName, errExp ) =
                                        Compiler.var branchIndex "err"
                                in
                                ( errIndex
                                , Pattern.NamedPattern { moduleName = [], name = "Err" }
                                    [ Compiler.nodify (Pattern.VarPattern errName) ]
                                , branches.ok errExp
                                )
                            )
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


{-|

    Elm.fn "myList" <|
        \myList ->
            Elm.Case.list myList
                { empty = Elm.int 0
                , nonEmpty =
                    \top remaining ->
                        Elm.plus (Elm.int 5) top
                }

Generates

    \myList ->
        case myList of
            [] ->
                0

            top :: remaining ->
                top + 5

-}
list :
    Expression
    ->
        { empty : Expression
        , nonEmpty : Expression -> Expression -> Expression
        }
    -> Expression
list mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        (Compiler.dive index)
                        [ Branch
                            (\branchIndex ->
                                ( branchIndex
                                , Pattern.ListPattern []
                                , branches.empty
                                )
                            )
                        , Branch
                            (\branchIndex ->
                                let
                                    ( topIndex, topName, topExp ) =
                                        Compiler.var branchIndex "top"

                                    ( remainIndex, remainName, remainExp ) =
                                        Compiler.var topIndex "remaining"
                                in
                                ( remainIndex
                                , Pattern.UnConsPattern
                                    (Compiler.nodify (Pattern.VarPattern topName))
                                    (Compiler.nodify (Pattern.VarPattern remainName))
                                , branches.nonEmpty
                                    topExp
                                    remainExp
                                )
                            )
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


{-|

    Elm.fn "maybeString" <|
        \maybeString ->
            Elm.Case.custom maybeString
                [ Elm.Case.branch [ "Maybe" ]
                    "Nothing"
                    (Elm.string "It's nothing, I swear!")
                , Elm.Case.branch2 [ "Maybe" ] "Just" <|
                    \just ->
                        Elm.append (Elm.string "Actually, it's: ") just
                ]

Generates

    \maybeString ->
        case maybeString of
            Nothing ->
                "It's nothing, I swear!"

            Just just ->
                "Actually, it's " ++ just

-}
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
                        (Compiler.dive index)
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
    = Branch (Compiler.Index -> ( Compiler.Index, Pattern.Pattern, Expression ))


{-| -}
branch : List String -> String -> Expression -> Branch
branch mod name exp =
    Branch
        (\index ->
            ( index
            , Pattern.NamedPattern { moduleName = mod, name = name } []
            , exp
            )
        )


{-| A catchall branch in case you want the case to be nonexhaustive.
-}
otherwise : (Expression -> Expression) -> Branch
otherwise toExp =
    Branch
        (\index ->
            let
                ( otherwiseIndex, otherwiseName, otherwiseExp ) =
                    Compiler.var index "otherwise"
            in
            ( otherwiseIndex
            , Pattern.VarPattern otherwiseName
            , toExp otherwiseExp
            )
        )


{-| -}
branch2 : String -> (Expression -> Expression) -> Branch
branch2 name toExp =
    Branch
        (\index ->
            let
                ( oneIndex, oneName, oneExp ) =
                    Compiler.var index "one"
            in
            ( oneIndex
            , Pattern.NamedPattern { moduleName = [], name = name }
                [ Compiler.nodify (Pattern.VarPattern oneName) ]
            , toExp oneExp
            )
        )


{-| -}
branch3 : String -> (Expression -> Expression -> Expression) -> Branch
branch3 name toExp =
    Branch
        (\index ->
            let
                ( oneIndex, oneName, oneExp ) =
                    Compiler.var index "one"

                ( twoIndex, twoName, twoExp ) =
                    Compiler.var oneIndex "two"
            in
            ( oneIndex
            , Pattern.NamedPattern { moduleName = [], name = name }
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                ]
            , toExp oneExp twoExp
            )
        )


{-| -}
branch4 : String -> (Expression -> Expression -> Expression -> Expression) -> Branch
branch4 name toExp =
    Branch
        (\index ->
            let
                ( oneIndex, oneName, oneExp ) =
                    Compiler.var index "one"

                ( twoIndex, twoName, twoExp ) =
                    Compiler.var oneIndex "two"

                ( threeIndex, threeName, threeExp ) =
                    Compiler.var twoIndex "three"
            in
            ( oneIndex
            , Pattern.NamedPattern { moduleName = [], name = name }
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                ]
            , toExp oneExp twoExp threeExp
            )
        )


{-| -}
branch5 : String -> (Expression -> Expression -> Expression -> Expression -> Expression) -> Branch
branch5 name toExp =
    -- Branch
    --     (Pattern.NamedPattern { moduleName = [], name = name }
    --         [ Compiler.nodify (Pattern.VarPattern "a")
    --         , Compiler.nodify (Pattern.VarPattern "b")
    --         , Compiler.nodify (Pattern.VarPattern "c")
    --         , Compiler.nodify (Pattern.VarPattern "d")
    --         ]
    --     )
    --     (toExp (Elm.value "a") (Elm.value "b") (Elm.value "c") (Elm.value "d"))
    Branch
        (\index ->
            let
                ( oneIndex, oneName, oneExp ) =
                    Compiler.var index "one"

                ( twoIndex, twoName, twoExp ) =
                    Compiler.var oneIndex "two"

                ( threeIndex, threeName, threeExp ) =
                    Compiler.var twoIndex "three"

                ( fourIndex, fourName, fourExp ) =
                    Compiler.var threeIndex "four"
            in
            ( oneIndex
            , Pattern.NamedPattern { moduleName = [], name = name }
                [ Compiler.nodify (Pattern.VarPattern oneName)
                , Compiler.nodify (Pattern.VarPattern twoName)
                , Compiler.nodify (Pattern.VarPattern threeName)
                , Compiler.nodify (Pattern.VarPattern fourName)
                ]
            , toExp oneExp twoExp threeExp fourExp
            )
        )
