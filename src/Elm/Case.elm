module Elm.Case exposing
    ( maybe, result, list, string
    , tuple, triple
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

import Dict
import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Branch as Branch exposing (Branch, Pattern(..))
import Internal.Compiler as Compiler
import Internal.Format as Format
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
                                let
                                    ( justVarName, toReturn ) =
                                        branches.just

                                    just : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    just =
                                        Compiler.toVarMaybeType branchIndex justVarName Nothing
                                in
                                ( just.index
                                , Pattern.NamedPattern
                                    { moduleName = []
                                    , name = "Just"
                                    }
                                    [ Compiler.nodify (Pattern.VarPattern just.name) ]
                                , toReturn just.val
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
                                    first : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    first =
                                        Compiler.toVarMaybeType branchIndex oneName Nothing

                                    second : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    second =
                                        Compiler.toVarMaybeType first.index twoName Nothing
                                in
                                ( second.index
                                , Pattern.TuplePattern <|
                                    Compiler.nodifyAll
                                        [ Pattern.VarPattern first.name
                                        , Pattern.VarPattern second.name
                                        ]
                                , branches first.val second.val
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
                                    first : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    first =
                                        Compiler.toVarMaybeType branchIndex one Nothing

                                    second : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    second =
                                        Compiler.toVarMaybeType first.index two Nothing

                                    third : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    third =
                                        Compiler.toVarMaybeType second.index three Nothing
                                in
                                ( third.index
                                , Pattern.TuplePattern <|
                                    Compiler.nodifyAll
                                        [ Pattern.VarPattern first.name
                                        , Pattern.VarPattern second.name
                                        , Pattern.VarPattern third.name
                                        ]
                                , branches first.val second.val third.val
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
                                let
                                    ( okNameStr, toOk ) =
                                        branches.ok

                                    ok : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    ok =
                                        Compiler.toVarMaybeType branchIndex okNameStr Nothing
                                in
                                ( ok.index
                                , Pattern.NamedPattern { moduleName = [], name = "Ok" }
                                    [ Compiler.nodify (Pattern.VarPattern ok.name) ]
                                , toOk ok.val
                                )
                            )
                        , Branch
                            (\branchIndex ->
                                let
                                    ( errNameStr, toErr ) =
                                        branches.err

                                    err : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    err =
                                        Compiler.toVarMaybeType branchIndex errNameStr Nothing
                                in
                                ( err.index
                                , Pattern.NamedPattern { moduleName = [], name = "Err" }
                                    [ Compiler.nodify (Pattern.VarPattern err.name) ]
                                , toErr err.val
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
                allBranches : List (Pattern Expression)
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
                                    top : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    top =
                                        Compiler.toVarMaybeType branchIndex "top" Nothing

                                    remaining : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    remaining =
                                        Compiler.toVarMaybeType branchIndex "remaining" Nothing
                                in
                                ( remaining.index
                                , Pattern.UnConsPattern
                                    (Compiler.nodify (Pattern.VarPattern top.name))
                                    (Compiler.nodify (Pattern.VarPattern remaining.name))
                                , branches.nonEmpty
                                    top.val
                                    remaining.val
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
                other : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                other =
                    Compiler.toVarMaybeType index "otherwise" Nothing
            in
            ( other.index
            , Pattern.VarPattern other.name
            , toExp other.val
            )
        )


{-| -}
branch1 : String -> ( String, Type.Annotation ) -> (Expression -> Expression) -> Branch
branch1 name ( argName, argType ) toExp =
    Branch
        (\index ->
            let
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index argName argType
            in
            ( one.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name ]
            , toExp one.exp
            )
        )


{-| -}
branch2 : String -> ( String, Type.Annotation ) -> ( String, Type.Annotation ) -> (Expression -> Expression -> Expression) -> Branch
branch2 name ( oneName, oneType ) ( twoName, twoType ) toExp =
    Branch
        (\index ->
            let
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index oneName oneType

                two : { name : String, exp : Expression, index : Index.Index }
                two =
                    Compiler.toVarWithType one.index twoName twoType
            in
            ( two.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name
                    , Pattern.VarPattern two.name
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
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index oneName oneType

                two : { name : String, exp : Expression, index : Index.Index }
                two =
                    Compiler.toVarWithType one.index twoName twoType

                three : { name : String, exp : Expression, index : Index.Index }
                three =
                    Compiler.toVarWithType two.index threeName threeType
            in
            ( three.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name
                    , Pattern.VarPattern two.name
                    , Pattern.VarPattern three.name
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
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index oneName oneType

                two : { name : String, exp : Expression, index : Index.Index }
                two =
                    Compiler.toVarWithType one.index twoName twoType

                three : { name : String, exp : Expression, index : Index.Index }
                three =
                    Compiler.toVarWithType two.index threeName threeType

                four : { name : String, exp : Expression, index : Index.Index }
                four =
                    Compiler.toVarWithType three.index fourName fourType
            in
            ( four.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name
                    , Pattern.VarPattern two.name
                    , Pattern.VarPattern three.name
                    , Pattern.VarPattern four.name
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
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index oneName oneType

                two : { name : String, exp : Expression, index : Index.Index }
                two =
                    Compiler.toVarWithType one.index twoName twoType

                three : { name : String, exp : Expression, index : Index.Index }
                three =
                    Compiler.toVarWithType two.index threeName threeType

                four : { name : String, exp : Expression, index : Index.Index }
                four =
                    Compiler.toVarWithType three.index fourName fourType

                five : { name : String, exp : Expression, index : Index.Index }
                five =
                    Compiler.toVarWithType four.index fiveName fiveType
            in
            ( five.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name
                    , Pattern.VarPattern two.name
                    , Pattern.VarPattern three.name
                    , Pattern.VarPattern four.name
                    , Pattern.VarPattern five.name
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
                one : { name : String, exp : Expression, index : Index.Index }
                one =
                    Compiler.toVarWithType index oneName oneType

                two : { name : String, exp : Expression, index : Index.Index }
                two =
                    Compiler.toVarWithType one.index twoName twoType

                three : { name : String, exp : Expression, index : Index.Index }
                three =
                    Compiler.toVarWithType two.index threeName threeType

                four : { name : String, exp : Expression, index : Index.Index }
                four =
                    Compiler.toVarWithType three.index fourName fourType

                five : { name : String, exp : Expression, index : Index.Index }
                five =
                    Compiler.toVarWithType four.index fiveName fiveType

                six : { name : String, exp : Expression, index : Index.Index }
                six =
                    Compiler.toVarWithType four.index sixName sixType
            in
            ( six.index
            , Pattern.NamedPattern { moduleName = [], name = Format.formatType name } <|
                Compiler.nodifyAll
                    [ Pattern.VarPattern one.name
                    , Pattern.VarPattern two.name
                    , Pattern.VarPattern three.name
                    , Pattern.VarPattern four.name
                    , Pattern.VarPattern five.name
                    , Pattern.VarPattern six.name
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
                                    var : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                    var =
                                        Compiler.toVarMaybeType index ("arg" ++ String.fromInt i) Nothing
                                in
                                ( Compiler.nodify (Pattern.VarPattern var.name)
                                , var.val
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
                                var : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                                var =
                                    Compiler.toVarMaybeType index ("arg" ++ String.fromInt i) Nothing
                            in
                            ( Compiler.nodify (Pattern.VarPattern var.name) :: listPattern
                            , var.val :: currentArgs
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
