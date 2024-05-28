module Elm.Case exposing
    ( maybe, result
    , custom
    , Branch, branch
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

@docs maybe, result


## Case on a Custom Type

    Elm.Case.custom maybeString
        (Elm.Annotation.maybe Elm.Annotation.string)
        [ Elm.Case.branch (Arg.customType "Nothing" ())
            (\_ ->
                Elm.string "It's nothing, I swear!"
            )
        , Elm.Case.branch
            (Arg.customType "Just" identity
                |> Arg.item (Arg.string "val"
            )
            (\val ->
                Elm.append (Elm.string "Actually, it's: ") val
            )
        ]

Generates

    case maybeString of
        Nothing ->
            "It's nothing, I swear!"

        Just just ->
            "Actually, it's: " ++ just

@docs custom

@docs Branch, branch

-}

import Dict
import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Arg
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Arg
import Internal.Branch as Branch exposing (Branch, Pattern(..))
import Internal.Compiler as Compiler
import Internal.Index as Index


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

        caseExp :
            { index : Index.Index
            , cases : List ( Node.Node Pattern.Pattern, Node.Node Exp.Expression )
            , imports : List Compiler.Module
            , annotation : Maybe (Result (List Compiler.InferenceError) Compiler.Inference)
            }
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

        pattern : Pattern.Pattern
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

        ( _, exp ) =
            Compiler.toExpressionDetails branchIndex caseExpression
    in
    { index = Index.next accum.index
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
    custom mainExpression
        (Type.maybe (Type.var "a"))
        [ branch (Elm.Arg.customType "Nothing" ())
            (\_ ->
                branches.nothing
            )
        , branch
            (Elm.Arg.customType "Just" identity
                |> Elm.Arg.item (Elm.Arg.var (Tuple.first branches.just))
            )
            (\val ->
                Tuple.second branches.just val
            )
        ]


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
    custom mainExpression
        (Type.result (Type.var "err") (Type.var "result"))
        [ branch
            (Elm.Arg.customType "Ok" identity
                |> Elm.Arg.item (Elm.Arg.var (Tuple.first branches.ok))
            )
            (\val ->
                Tuple.second branches.ok val
            )
        , branch
            (Elm.Arg.customType "Err" identity
                |> Elm.Arg.item (Elm.Arg.var (Tuple.first branches.err))
            )
            (\val ->
                Tuple.second branches.err val
            )
        ]


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
                myMain : Expression
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
type alias Branch =
    Branch.Branch


{-| -}
branch : Elm.Arg.Arg val -> (val -> Expression) -> Branch
branch arg toBody =
    Branch
        (\index ->
            let
                argDetails =
                    Internal.Arg.toDetails index arg
            in
            ( argDetails.index
            , Compiler.denode argDetails.details.pattern
            , toBody argDetails.value
            )
        )
