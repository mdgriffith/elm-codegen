module Elm.Case exposing
    ( maybe, result, list, string
    , tuple, triple
    , patternToBranch
    , custom
    , Branch, otherwise, branch0, branch1, branch2, branch3, branch4, branch5, branch6
    , branchWith
    , branchList
    )

{-| Generate a case expression!

Here's an example for extracting a `Maybe Int`

    Elm.Case.maybe myMaybe
        { nothing = Elm.int 0
        , just =
            ( "value"
            , \content ->
                Elm.plus (Elm.int 5) content
            )
        }

Generates

    case myMaybe of
        Nothing ->
            0

        Just value ->
            value + 5

@docs maybe, result, list, string

@docs tuple, triple


## Patterns

@docs patternToBranch


## Case on a Custom Type

    Elm.Case.custom maybeString
        (Elm.Annotation.maybe Elm.Annotation.string)
        [ Elm.Case.branch0 "Nothing"
            (Elm.string "It's nothing, I swear!")
        , Elm.Case.branch1 "Just" ( "val", Elm.Annotation.string ) <|
            \val ->
                Elm.append (Elm.string "Actually, it's: ") val
        ]

Generates

    case maybeString of
        Nothing ->
            "It's nothing, I swear!"

        Just just ->
            "Actually, it's: " ++ just

@docs custom

@docs Branch, otherwise, branch0, branch1, branch2, branch3, branch4, branch5, branch6

@docs branchWith

@docs branchList

-}

import Dict exposing (Dict)
import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Pattern
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler
import Internal.Debug as Debug
import Internal.Format as Format
import Internal.Index as Index
import Internal.Pattern exposing (Pattern(..))


{-| -}
patternToBranch : (a -> Expression) -> Elm.Pattern.Pattern a -> Branch
patternToBranch branchBody (Pattern pattern destructure) =
    Branch
        (\index ->
            ( Index.startIndex
            , pattern
            , branchBody destructure
            )
        )


captureCase :
    Compiler.Expression
    -> List String
    -> Index.Index
    -> List Branch
    ->
        ( Compiler.ExpressionDetails
        , { index : Index.Index
          , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
          , imports : List Compiler.Module
          , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
          }
        )
captureCase mainExpression mainExpressionTypeModule index branches =
    let
        -- mainExpressionTypeModule is the module name of the type of the main expression
        -- We use this to add the module name to each branch so the user doesn't have to specify that manually
        ( branchIndex, mainExpressionDetails ) =
            Compiler.toExpressionDetails index mainExpression

        caseExp =
            List.foldl
                (captureCaseHelper mainExpressionTypeModule)
                { index = branchIndex
                , cases = []
                , imports = []
                , annotation = Nothing
                }
                branches
    in
    ( mainExpressionDetails
    , { caseExp
        | annotation =
            case caseExp.annotation of
                Just (Ok inference) ->
                    case mainExpressionDetails.annotation of
                        Err err ->
                            Just (Err err)

                        Ok mainAnn ->
                            Just (Ok (inference |> Compiler.importInferences mainAnn))

                _ ->
                    caseExp.annotation
      }
    )


captureCaseHelper :
    List String
    -> Branch
    ->
        { index : Index.Index
        , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
        , imports : List Compiler.Module
        , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
        }
    ->
        { index : Index.Index
        , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
        , imports : List Compiler.Module
        , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
        }
captureCaseHelper mainCaseExpressionModule (Branch toBranch) accum =
    let
        ( branchIndex, originalPattern, caseExpression ) =
            toBranch (Index.dive accum.index)

        pattern =
            case mainCaseExpressionModule of
                [] ->
                    originalPattern

                _ ->
                    case originalPattern of
                        Pattern.NamedPattern named vars ->
                            Pattern.NamedPattern
                                { moduleName = mainCaseExpressionModule
                                , name = named.name
                                }
                                vars

                        _ ->
                            originalPattern

        ( newIndex, exp ) =
            Compiler.toExpressionDetails branchIndex caseExpression
    in
    { index = accum.index
    , cases = ( Compiler.nodify pattern, Compiler.nodify exp.expression ) :: accum.cases
    , imports = accum.imports ++ exp.imports
    , annotation =
        case accum.annotation of
            Nothing ->
                Just exp.annotation

            Just (Ok gatheredAnnotation) ->
                Compiler.unifyOn
                    (Compiler.Annotation
                        { annotation = gatheredAnnotation.type_
                        , aliases = gatheredAnnotation.aliases
                        , imports = []
                        }
                    )
                    (exp.annotation
                        |> combineInferences gatheredAnnotation.inferences
                    )
                    |> Just

            Just err ->
                Just err
    }


combineInferences :
    Dict.Dict String Annotation.TypeAnnotation
    -> Result (List Compiler.InferenceError) Compiler.Inference
    -> Result (List Compiler.InferenceError) Compiler.Inference
combineInferences infs infResult =
    case infResult of
        Ok inferred ->
            Ok { inferred | inferences = Compiler.mergeInferences infs inferred.inferences }

        Err err ->
            Err err


{-| -}
maybe :
    Expression
    ->
        { nothing : Expression
        , just : ( String, Expression -> Expression )
        }
    -> Expression
maybe mainExpression branches =
    Compiler.Expression
        (\index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        []
                        index
                        [ Branch
                            (\branchIndex ->
                                ( branchIndex
                                , Pattern.NamedPattern
                                    { moduleName = []
                                    , name = "Nothing"
                                    }
                                    []
                                , branches.nothing
                                )
                            )
                        , Branch
                            (\branchIndex ->
                                case branches.just of
                                    ( justVarName, toReturn ) ->
                                        let
                                            ( justIndex, justName, justExp ) =
                                                Compiler.var branchIndex justVarName
                                        in
                                        ( justIndex
                                        , Pattern.NamedPattern
                                            { moduleName = []
                                            , name = "Just"
                                            }
                                            [ Compiler.nodify (Pattern.VarPattern justName) ]
                                        , toReturn justExp
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

    Elm.Case.tuple myTuple
        "first"
        "second"
        (\one two ->
            Elm.plus (Elm.int 5) two
        )

Generates

    case myTuple of
        ( first, second ) ->
            5 + second

-}
tuple :
    Expression
    -> String
    -> String
    -> (Expression -> Expression -> Expression)
    -> Expression
tuple mainExpression oneName twoName branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        []
                        (Index.dive index)
                        [ Branch
                            (\branchIndex ->
                                let
                                    ( firstIndex, firstName, firstExp ) =
                                        Compiler.var branchIndex oneName

                                    ( secondIndex, secondName, secondExp ) =
                                        Compiler.var firstIndex twoName
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

    Elm.Case.triple myTriple
        "one"
        "two"
        "three"
        (\one two three ->
            Elm.plus (Elm.int 5) two
        )

Generates

    case myTriple of
        ( one, two, three ) ->
            5 + two

-}
triple :
    Expression
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression)
    -> Expression
triple mainExpression one two three branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        []
                        index
                        [ Branch
                            (\branchIndex ->
                                let
                                    ( firstIndex, firstName, firstExp ) =
                                        Compiler.var branchIndex one

                                    ( secondIndex, secondName, secondExp ) =
                                        Compiler.var firstIndex two

                                    ( thirdIndex, thirdName, thirdExp ) =
                                        Compiler.var secondIndex three
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

    Elm.Case.result myResult
        { ok =
            Tuple.pair "ok" <|
                \ok ->
                    Elm.string "No errors"
        , err =
            Tuple.pair "err" <|
                \err ->
                    err
        }

Generates

    case myResult of
        Ok ok ->
            "No errors"

        Err err ->
            err

-}
result :
    Expression
    ->
        { err : ( String, Expression -> Expression )
        , ok : ( String, Expression -> Expression )
        }
    -> Expression
result mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                ( expr, gathered ) =
                    captureCase mainExpression
                        []
                        (Index.dive index)
                        [ Branch
                            (\branchIndex ->
                                case branches.ok of
                                    ( okNameStr, toOk ) ->
                                        let
                                            ( okIndex, okName, okExp ) =
                                                Compiler.var branchIndex okNameStr
                                        in
                                        ( okIndex
                                        , Pattern.NamedPattern { moduleName = [], name = "Ok" }
                                            [ Compiler.nodify (Pattern.VarPattern okName) ]
                                        , toOk okExp
                                        )
                            )
                        , Branch
                            (\branchIndex ->
                                case branches.err of
                                    ( errNameStr, toErr ) ->
                                        let
                                            ( errIndex, errName, errExp ) =
                                                Compiler.var branchIndex errNameStr
                                        in
                                        ( errIndex
                                        , Pattern.NamedPattern { moduleName = [], name = "Err" }
                                            [ Compiler.nodify (Pattern.VarPattern errName) ]
                                        , toErr errExp
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


{-| -}
string :
    Expression
    ->
        { cases : List ( String, Expression )
        , otherwise : Expression
        }
    -> Expression
string mainExpression branches =
    Compiler.Expression <|
        \index ->
            let
                allBranches =
                    List.map
                        (\( caseString, caseExpression ) ->
                            Branch
                                (\branchIndex ->
                                    ( branchIndex
                                    , Pattern.StringPattern caseString
                                    , caseExpression
                                    )
                                )
                        )
                        branches.cases
                        ++ [ Branch
                                (\branchIndex ->
                                    ( branchIndex
                                    , Pattern.AllPattern
                                    , branches.otherwise
                                    )
                                )
                           ]

                ( expr, gathered ) =
                    captureCase mainExpression [] (Index.dive index) allBranches
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


{-| Let's unpack the first value from a list.

    Elm.Case.list myList
        { empty = Elm.int 0
        , nonEmpty =
            \top remaining ->
                Elm.plus (Elm.int 5) top
        }

Generates

    case myList of
        [] ->
            0

        top :: remaining ->
            top + 5

**Note** if you want more control over unpacking lists, check out [`branchList`](#branchList)

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
                        []
                        (Index.dive index)
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


{-| -}
custom :
    Expression
    -> Type.Annotation
    -> List Branch
    -> Expression
custom mainExpression annotation branches =
    Compiler.Expression <|
        \index ->
            let
                myMain =
                    mainExpression |> Elm.withType annotation

                ( expr, gathered ) =
                    captureCase myMain
                        (Compiler.getTypeModule annotation)
                        (Index.dive index)
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
    = Branch (Index.Index -> ( Index.Index, Pattern.Pattern, Expression ))


{-| -}
branch0 : String -> Expression -> Branch
branch0 name exp =
    Branch
        (\index ->
            ( index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } []
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
branch1 : String -> ( String, Type.Annotation ) -> (Expression -> Expression) -> Branch
branch1 name ( argName, argType ) toExp =
    Branch
        (\index ->
            let
                var =
                    Compiler.toVarWithType index argName argType
            in
            ( var.index
            , Pattern.NamedPattern
                { moduleName = []
                , name = Format.formatType name
                }
                [ Compiler.nodify (Pattern.VarPattern var.name) ]
            , toExp var.exp
            )
        )


{-| -}
branch2 : String -> ( String, Type.Annotation ) -> ( String, Type.Annotation ) -> (Expression -> Expression -> Expression) -> Branch
branch2 name ( oneName, oneType ) ( twoName, twoType ) toExp =
    Branch
        (\index ->
            let
                one =
                    Compiler.toVarWithType index oneName oneType

                two =
                    Compiler.toVarWithType one.index twoName twoType
            in
            ( two.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name }
                [ Compiler.nodify (Pattern.VarPattern one.name)
                , Compiler.nodify (Pattern.VarPattern two.name)
                ]
            , toExp one.exp two.exp
            )
        )


{-| -}
branch3 :
    String
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> (Expression -> Expression -> Expression -> Expression)
    -> Branch
branch3 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) toExp =
    Branch
        (\index ->
            let
                one =
                    Compiler.toVarWithType index oneName oneType

                two =
                    Compiler.toVarWithType one.index twoName twoType

                three =
                    Compiler.toVarWithType two.index threeName threeType
            in
            ( three.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name }
                [ Compiler.nodify (Pattern.VarPattern one.name)
                , Compiler.nodify (Pattern.VarPattern two.name)
                , Compiler.nodify (Pattern.VarPattern three.name)
                ]
            , toExp one.exp two.exp three.exp
            )
        )


{-| -}
branch4 :
    String
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    -> Branch
branch4 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) toExp =
    Branch
        (\index ->
            let
                one =
                    Compiler.toVarWithType index oneName oneType

                two =
                    Compiler.toVarWithType one.index twoName twoType

                three =
                    Compiler.toVarWithType two.index threeName threeType

                four =
                    Compiler.toVarWithType three.index fourName fourType
            in
            ( four.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name }
                [ Compiler.nodify (Pattern.VarPattern one.name)
                , Compiler.nodify (Pattern.VarPattern two.name)
                , Compiler.nodify (Pattern.VarPattern three.name)
                , Compiler.nodify (Pattern.VarPattern four.name)
                ]
            , toExp one.exp two.exp three.exp four.exp
            )
        )


{-| -}
branch5 :
    String
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    ->
        (Expression
         -> Expression
         -> Expression
         -> Expression
         -> Expression
         -> Expression
        )
    -> Branch
branch5 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) ( fiveName, fiveType ) toExp =
    Branch
        (\index ->
            let
                one =
                    Compiler.toVarWithType index oneName oneType

                two =
                    Compiler.toVarWithType one.index twoName twoType

                three =
                    Compiler.toVarWithType two.index threeName threeType

                four =
                    Compiler.toVarWithType three.index fourName fourType

                five =
                    Compiler.toVarWithType four.index fiveName fiveType
            in
            ( five.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name }
                [ Compiler.nodify (Pattern.VarPattern one.name)
                , Compiler.nodify (Pattern.VarPattern two.name)
                , Compiler.nodify (Pattern.VarPattern three.name)
                , Compiler.nodify (Pattern.VarPattern four.name)
                , Compiler.nodify (Pattern.VarPattern five.name)
                ]
            , toExp one.exp two.exp three.exp four.exp five.exp
            )
        )


{-| -}
branch6 :
    String
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    -> ( String, Type.Annotation )
    ->
        (Expression
         -> Expression
         -> Expression
         -> Expression
         -> Expression
         -> Expression
         -> Expression
        )
    -> Branch
branch6 name ( oneName, oneType ) ( twoName, twoType ) ( threeName, threeType ) ( fourName, fourType ) ( fiveName, fiveType ) ( sixName, sixType ) toExp =
    Branch
        (\index ->
            let
                one =
                    Compiler.toVarWithType index oneName oneType

                two =
                    Compiler.toVarWithType one.index twoName twoType

                three =
                    Compiler.toVarWithType two.index threeName threeType

                four =
                    Compiler.toVarWithType three.index fourName fourType

                five =
                    Compiler.toVarWithType four.index fiveName fiveType

                six =
                    Compiler.toVarWithType four.index sixName sixType
            in
            ( six.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name }
                [ Compiler.nodify (Pattern.VarPattern one.name)
                , Compiler.nodify (Pattern.VarPattern two.name)
                , Compiler.nodify (Pattern.VarPattern three.name)
                , Compiler.nodify (Pattern.VarPattern four.name)
                , Compiler.nodify (Pattern.VarPattern five.name)
                , Compiler.nodify (Pattern.VarPattern six.name)
                ]
            , toExp one.exp two.exp three.exp four.exp five.exp six.exp
            )
        )


{-| -}
branchWith : String -> Int -> (List Expression -> Expression) -> Branch
branchWith name arity toExp =
    Branch
        (\index ->
            let
                ( patterns, args ) =
                    List.range 1 arity
                        |> List.map
                            (\i ->
                                let
                                    ( _, varName, varExp ) =
                                        Compiler.var index <| "arg" ++ String.fromInt i
                                in
                                ( Compiler.nodify (Pattern.VarPattern varName)
                                , varExp
                                )
                            )
                        |> List.unzip
            in
            ( Index.next index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } patterns
            , toExp args
            )
        )


{-| -}
branchList : Int -> (List Expression -> Expression) -> Branch
branchList arity toExp =
    Branch
        (\index ->
            let
                ( pattern, args ) =
                    List.foldl
                        (\i ( listPattern, currentArgs ) ->
                            let
                                ( _, varName, varExp ) =
                                    Compiler.var index <| "arg" ++ String.fromInt i
                            in
                            ( Compiler.nodify (Pattern.VarPattern varName) :: listPattern
                            , varExp :: currentArgs
                            )
                        )
                        ( []
                        , []
                        )
                        (List.drop 1 (List.range 0 arity))
            in
            ( Index.next index
            , Pattern.ListPattern (List.reverse pattern)
            , toExp (List.reverse args)
            )
        )
