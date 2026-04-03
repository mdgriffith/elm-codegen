module Generate.Program exposing (programGenerator)

{-| Type-directed random generator that produces elm-codegen API calls
to build valid Elm files. Every generated file should compile — if it
doesn't, that's a real elm-codegen bug.

The key design: a `depth` parameter controls expression nesting.
At depth 0: only literals and operators (leaf nodes).
At depth 1+: compound expressions (case, let, if, pipe) whose
sub-expressions are generated at depth-1. This guarantees termination
and controls how deeply nested the output gets.
-}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case
import Elm.Declare
import Elm.Let
import Elm.Op
import Random



-- PUBLIC API


{-| Generate a complete Elm module (or pair of modules).
Returns a list because multi-file tests produce two files.
-}
programGenerator : Int -> Random.Generator (List Elm.File)
programGenerator index =
    -- ~20% of programs are multi-file
    Random.int 0 4
        |> Random.andThen
            (\choice ->
                if choice == 0 then
                    multiFileGenerator index

                else
                    singleFileGenerator index
                        |> Random.map List.singleton
            )


singleFileGenerator : Int -> Random.Generator Elm.File
singleFileGenerator index =
    let
        moduleName =
            "Test" ++ String.fromInt index
    in
    Random.map5
        (\literals records functions customTypes advanced ->
            literals ++ records ++ functions ++ customTypes ++ advanced
        )
        (literalDeclarationsGenerator index)
        (recordDeclarationsGenerator index)
        (functionDeclarationsGenerator index)
        (customTypeDeclarationsGenerator index)
        (advancedDeclarationsGenerator index)
        |> Random.andThen
            (\baseDecls ->
                coverageBoostGenerator index
                    |> Random.map
                        (\extraDecls ->
                            Elm.file [ moduleName ] (baseDecls ++ extraDecls)
                        )
            )



-- TYPES


type SimpleType
    = TInt
    | TFloat
    | TString
    | TBool
    | TChar
    | TUnit


type alias TypedExpression =
    { expr : Elm.Expression
    , simpleType : SimpleType
    }


simpleTypeGenerator : Random.Generator SimpleType
simpleTypeGenerator =
    Random.uniform TInt [ TFloat, TString, TBool, TChar, TUnit ]


numericOrStringTypeGenerator : Random.Generator SimpleType
numericOrStringTypeGenerator =
    Random.uniform TInt [ TFloat, TString ]


typeAnnotation : SimpleType -> Type.Annotation
typeAnnotation t =
    case t of
        TInt ->
            Type.int

        TFloat ->
            Type.float

        TString ->
            Type.string

        TBool ->
            Type.bool

        TChar ->
            Type.char

        TUnit ->
            Type.unit



-- ============================================================
-- EXPRESSION GENERATOR (depth-controlled)
-- ============================================================


{-| The central generator. `depth` controls nesting:
- depth 0: only literals and operators
- depth 1+: compound expressions with sub-expressions at depth-1
-}
expressionGenerator : Int -> SimpleType -> Random.Generator TypedExpression
expressionGenerator depth t =
    if depth <= 0 then
        -- Leaf only
        Random.uniform True [ False ]
            |> Random.andThen
                (\useOp ->
                    if useOp then
                        operatorExpressionGenerator t

                    else
                        literalGenerator t
                )

    else
        -- Pick from all expression forms.
        -- Slots 0-2 are leaf nodes (~15%) to bound tree size.
        Random.int 0 18
            |> Random.andThen
                (\choice ->
                    case choice of
                        0 ->
                            literalGenerator t

                        1 ->
                            operatorExpressionGenerator t

                        2 ->
                            literalGenerator t

                        3 ->
                            ifThenElseGenerator (depth - 1) t

                        4 ->
                            letExpressionGenerator (depth - 1) t

                        5 ->
                            maybeCaseGenerator (depth - 1) t

                        6 ->
                            resultCaseGenerator (depth - 1) t

                        7 ->
                            stringCaseGenerator (depth - 1) t

                        8 ->
                            caseInsideLetGenerator (depth - 1) t

                        9 ->
                            letInsideCaseGenerator (depth - 1) t

                        10 ->
                            caseInsideCaseGenerator (depth - 1) t

                        11 ->
                            recordAccessGenerator (depth - 1) t

                        12 ->
                            -- Comparison operators always produce Bool
                            if t == TBool then
                                comparisonExpressionGenerator (depth - 1)

                            else
                                withTypeGenerator (depth - 1) t

                        13 ->
                            recordUpdateGenerator (depth - 1) t

                        14 ->
                            lambdaExpressionGenerator (depth - 1) t

                        15 ->
                            -- Cons produces a list — wrap in Elm.get on a record
                            -- to extract a value of the right type
                            withTypeGenerator (depth - 1) t

                        16 ->
                            -- Maybe expressions — wrap in a case to extract the type
                            maybeCaseGenerator (depth - 1) t

                        17 ->
                            -- Another leaf slot for balance
                            operatorExpressionGenerator t

                        _ ->
                            literalGenerator t
                )



-- ============================================================
-- LEAF EXPRESSIONS
-- ============================================================


literalGenerator : SimpleType -> Random.Generator TypedExpression
literalGenerator t =
    case t of
        TInt ->
            Random.int -1000 1000
                |> Random.map (\n -> { expr = Elm.int n, simpleType = TInt })

        TFloat ->
            Random.float -1000.0 1000.0
                |> Random.map (\f -> { expr = Elm.float f, simpleType = TFloat })

        TString ->
            stringGenerator
                |> Random.map (\s -> { expr = Elm.string s, simpleType = TString })

        TBool ->
            Random.uniform True [ False ]
                |> Random.map (\b -> { expr = Elm.bool b, simpleType = TBool })

        TChar ->
            charGenerator
                |> Random.map (\c -> { expr = Elm.char c, simpleType = TChar })

        TUnit ->
            Random.constant { expr = Elm.unit, simpleType = TUnit }


stringGenerator : Random.Generator String
stringGenerator =
    Random.int 0 5
        |> Random.andThen (\len -> randomList len charGenerator |> Random.map String.fromList)


charGenerator : Random.Generator Char
charGenerator =
    Random.int 97 122 |> Random.map Char.fromCode


operatorExpressionGenerator : SimpleType -> Random.Generator TypedExpression
operatorExpressionGenerator t =
    Random.map2
        (\left right ->
            case t of
                TInt ->
                    [ Elm.Op.plus left.expr right.expr
                    , Elm.Op.minus left.expr right.expr
                    , Elm.Op.multiply left.expr right.expr
                    , Elm.Op.intDivide left.expr right.expr
                    , Elm.Op.power left.expr right.expr
                    ]

                TFloat ->
                    [ Elm.Op.plus left.expr right.expr
                    , Elm.Op.minus left.expr right.expr
                    , Elm.Op.multiply left.expr right.expr
                    ]

                TString ->
                    [ Elm.Op.append left.expr right.expr ]

                TBool ->
                    [ Elm.Op.and left.expr right.expr
                    , Elm.Op.or left.expr right.expr
                    ]

                _ ->
                    [ left.expr ]
        )
        (literalGenerator t)
        (literalGenerator t)
        |> Random.andThen
            (\options ->
                pickRandom options
                    |> Random.map (\e -> { expr = e, simpleType = t })
            )


{-| Comparison operators — produce Bool from comparable types. -}
comparisonExpressionGenerator : Int -> Random.Generator TypedExpression
comparisonExpressionGenerator depth =
    -- Pick a comparable type for the operands
    Random.uniform TInt [ TFloat, TString, TChar ]
        |> Random.andThen
            (\operandType ->
                Random.map2
                    (\left right ->
                        [ Elm.Op.equal left.expr right.expr
                        , Elm.Op.notEqual left.expr right.expr
                        , Elm.Op.lt left.expr right.expr
                        , Elm.Op.gt left.expr right.expr
                        , Elm.Op.lte left.expr right.expr
                        , Elm.Op.gte left.expr right.expr
                        ]
                    )
                    (expressionGenerator depth operandType)
                    (expressionGenerator depth operandType)
                    |> Random.andThen
                        (\options ->
                            pickRandom options
                                |> Random.map (\e -> { expr = e, simpleType = TBool })
                        )
            )


{-| List cons operator — prepend element to list. -}
consExpressionGenerator : Int -> SimpleType -> Random.Generator TypedExpression
consExpressionGenerator depth elemType =
    Random.map2
        (\item list ->
            { expr = Elm.Op.cons item.expr (Elm.list (List.map .expr list))
            , simpleType = elemType
            }
        )
        (expressionGenerator depth elemType)
        (randomList 2 (expressionGenerator depth elemType))


{-| Record update expression. Creates a record, then updates one field. -}
recordUpdateGenerator : Int -> SimpleType -> Random.Generator TypedExpression
recordUpdateGenerator depth t =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\otherType ->
                            Random.map3
                                (\fieldVal otherVal newVal ->
                                    let
                                        baseRecord =
                                            Elm.record
                                                [ ( "target", fieldVal.expr )
                                                , ( "other", otherVal.expr )
                                                ]
                                    in
                                    { expr =
                                        Elm.get "target"
                                            (Elm.updateRecord
                                                [ ( "target", newVal.expr ) ]
                                                baseRecord
                                            )
                                    , simpleType = t
                                    }
                                )
                                (expressionGenerator depth t)
                                (expressionGenerator depth otherType)
                                (expressionGenerator depth t)
                        )
            )


{-| Elm.withType — apply a known-correct type annotation to an expression.
If elm-codegen's own inference produces a different annotation, the Elm
compiler will report a type mismatch.
-}
withTypeGenerator : Int -> SimpleType -> Random.Generator TypedExpression
withTypeGenerator depth t =
    expressionGenerator depth t
        |> Random.map
            (\typed ->
                { expr = Elm.withType (typeAnnotation t) typed.expr
                , simpleType = t
                }
            )


{-| Maybe wrapper expressions — Elm.just and Elm.nothing. -}
maybeExpressionGenerator : Int -> SimpleType -> Random.Generator TypedExpression
maybeExpressionGenerator depth innerType =
    Random.uniform True [ False ]
        |> Random.andThen
            (\useJust ->
                if useJust then
                    expressionGenerator depth innerType
                        |> Random.map
                            (\inner ->
                                { expr = Elm.just inner.expr
                                , simpleType = innerType
                                }
                            )

                else
                    Random.constant
                        { expr = Elm.nothing
                        , simpleType = innerType
                        }
            )


{-| Lambda expression as a value (Elm.fn at expression level).
Immediately applied to get back to the result type.
-}
lambdaExpressionGenerator : Int -> SimpleType -> Random.Generator TypedExpression
lambdaExpressionGenerator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                expressionGenerator depth resultType
                    |> Random.map
                        (\body ->
                            { expr =
                                Elm.apply
                                    (Elm.fn
                                        (Elm.Arg.var ("la" ++ String.fromInt depth ++ "x" ++ String.fromInt uid))
                                        (\_ -> body.expr)
                                    )
                                    [ Elm.unit ]
                            , simpleType = resultType
                            }
                        )
            )



-- ============================================================
-- COMPOUND EXPRESSIONS (all take depth parameter)
-- ============================================================


ifThenElseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
ifThenElseGenerator depth t =
    Random.map3
        (\condition thenBranch elseBranch ->
            { expr = Elm.ifThen condition.expr thenBranch.expr elseBranch.expr
            , simpleType = t
            }
        )
        (expressionGenerator depth TBool)
        (expressionGenerator depth t)
        (expressionGenerator depth t)



-- LET EXPRESSIONS


letExpressionGenerator : Int -> SimpleType -> Random.Generator TypedExpression
letExpressionGenerator depth resultType =
    Random.int 1 3
        |> Random.andThen
            (\n ->
                case n of
                    1 ->
                        let1Generator depth resultType

                    2 ->
                        let2Generator depth resultType

                    _ ->
                        let3Generator depth resultType
            )


let1Generator : Int -> SimpleType -> Random.Generator TypedExpression
let1Generator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                let
                    suffix =
                        String.fromInt depth ++ "x" ++ String.fromInt uid
                in
                Random.map2
                    (\b body ->
                        { expr =
                            Elm.Let.letIn (\_ -> body.expr)
                                |> Elm.Let.value ("lA" ++ suffix) b.expr
                                |> Elm.Let.toExpression
                        , simpleType = resultType
                        }
                    )
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (expressionGenerator depth resultType)
            )


let2Generator : Int -> SimpleType -> Random.Generator TypedExpression
let2Generator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                let
                    suffix =
                        String.fromInt depth ++ "x" ++ String.fromInt uid
                in
                Random.map3
                    (\b1 b2 body ->
                        { expr =
                            Elm.Let.letIn (\_ _ -> body.expr)
                                |> Elm.Let.value ("lA" ++ suffix) b1.expr
                                |> Elm.Let.value ("lB" ++ suffix) b2.expr
                                |> Elm.Let.toExpression
                        , simpleType = resultType
                        }
                    )
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (expressionGenerator depth resultType)
            )


let3Generator : Int -> SimpleType -> Random.Generator TypedExpression
let3Generator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                let
                    suffix =
                        String.fromInt depth ++ "x" ++ String.fromInt uid
                in
                Random.map4
                    (\b1 b2 b3 body ->
                        { expr =
                            Elm.Let.letIn (\_ _ _ -> body.expr)
                                |> Elm.Let.value ("lA" ++ suffix) b1.expr
                                |> Elm.Let.value ("lB" ++ suffix) b2.expr
                                |> Elm.Let.value ("lC" ++ suffix) b3.expr
                                |> Elm.Let.toExpression
                        , simpleType = resultType
                        }
                    )
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (expressionGenerator depth resultType)
            )



-- MAYBE CASE


maybeCaseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
maybeCaseGenerator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                Random.map3
                    (\innerVal justBody nothingBody ->
                        { expr =
                            Elm.Case.maybe (Elm.just innerVal.expr)
                                { nothing = nothingBody.expr
                                , just = ( "mV" ++ String.fromInt depth ++ "x" ++ String.fromInt uid, \_ -> justBody.expr )
                                }
                        , simpleType = resultType
                        }
                    )
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (expressionGenerator depth resultType)
                    (expressionGenerator depth resultType)
            )



-- RESULT CASE


resultCaseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
resultCaseGenerator depth resultType =
    Random.int 100 999
        |> Random.andThen
            (\uid ->
                let
                    suffix =
                        String.fromInt depth ++ "x" ++ String.fromInt uid
                in
                Random.map3
                    (\innerVal okBody errBody ->
                        { expr =
                            Elm.Case.result
                                (Elm.apply
                                    (Elm.value
                                        { importFrom = []
                                        , name = "Ok"
                                        , annotation = Nothing
                                        }
                                    )
                                    [ innerVal.expr ]
                                )
                                { ok = ( "rO" ++ suffix, \_ -> okBody.expr )
                                , err = ( "rE" ++ suffix, \_ -> errBody.expr )
                                }
                        , simpleType = resultType
                        }
                    )
                    (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                    (expressionGenerator depth resultType)
                    (expressionGenerator depth resultType)
            )



-- STRING CASE


stringCaseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
stringCaseGenerator depth resultType =
    Random.map3
        (\case1Body case2Body defaultBody ->
            { expr =
                Elm.Case.string (Elm.string "hello")
                    { cases =
                        [ ( "hello", case1Body.expr )
                        , ( "world", case2Body.expr )
                        ]
                    , otherwise = defaultBody.expr
                    }
            , simpleType = resultType
            }
        )
        (expressionGenerator depth resultType)
        (expressionGenerator depth resultType)
        (expressionGenerator depth resultType)



-- PIPE CHAINS


pipeChainGenerator : Int -> SimpleType -> Random.Generator TypedExpression
pipeChainGenerator _ t =
    -- Lambda bodies must be leaf-level to avoid elm-codegen pipe rendering
    -- issues with multi-line lambda bodies (potential elm-codegen bug:
    -- lambdas on RHS of |> aren't parenthesized).
    Random.map3
        (\startVal step1Body step2Body ->
            { expr =
                startVal.expr
                    |> Elm.Op.pipe (Elm.fn (Elm.Arg.var "pipeA") (\_ -> step1Body.expr))
                    |> Elm.Op.pipe (Elm.fn (Elm.Arg.var "pipeB") (\_ -> step2Body.expr))
            , simpleType = t
            }
        )
        (expressionGenerator 0 t)
        (literalGenerator t)
        (literalGenerator t)



-- ============================================================
-- NEW COMPOSITIONAL GENERATORS (the interesting nesting patterns)
-- ============================================================


{-| Case expression inside a let body.
Stresses dive→dive Index chain.

    let bound = <expr> in
    case Just bound of
        Just inner -> <expr>
        Nothing -> <expr>
-}
caseInsideLetGenerator : Int -> SimpleType -> Random.Generator TypedExpression
caseInsideLetGenerator depth resultType =
    simpleTypeGenerator
        |> Random.andThen
            (\innerType ->
                Random.int 100 999
                    |> Random.andThen
                        (\uid ->
                            let
                                suffix =
                                    String.fromInt depth ++ "x" ++ String.fromInt uid
                            in
                            Random.map3
                                (\bindingVal justBody nothingBody ->
                                    { expr =
                                        Elm.Let.letIn
                                            (\bound ->
                                                Elm.Case.maybe (Elm.just bound)
                                                    { nothing = nothingBody.expr
                                                    , just = ( "clI" ++ suffix, \_ -> justBody.expr )
                                                    }
                                            )
                                            |> Elm.Let.value ("clB" ++ suffix) bindingVal.expr
                                            |> Elm.Let.toExpression
                                    , simpleType = resultType
                                    }
                                )
                                (expressionGenerator depth innerType)
                                (expressionGenerator depth resultType)
                                (expressionGenerator depth resultType)
                        )
            )


{-| Let expression inside a case branch.
Tests import aggregation from nested let inside case callbacks.

    case Just <expr> of
        Just val -> let y = <expr> in <expr>
        Nothing -> <expr>
-}
letInsideCaseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
letInsideCaseGenerator depth resultType =
    simpleTypeGenerator
        |> Random.andThen
            (\innerType ->
                Random.int 100 999
                    |> Random.andThen
                        (\uid ->
                            let
                                suffix =
                                    String.fromInt depth ++ "x" ++ String.fromInt uid
                            in
                            Random.map4
                                (\scrutinee letBinding letBody nothingBody ->
                                    { expr =
                                        Elm.Case.maybe (Elm.just scrutinee.expr)
                                            { nothing = nothingBody.expr
                                            , just =
                                                ( "lcV" ++ suffix
                                                , \_ ->
                                                    Elm.Let.letIn (\_ -> letBody.expr)
                                                        |> Elm.Let.value ("lcB" ++ suffix) letBinding.expr
                                                        |> Elm.Let.toExpression
                                                )
                                            }
                                    , simpleType = resultType
                                    }
                                )
                                (expressionGenerator depth innerType)
                                (simpleTypeGenerator |> Random.andThen (expressionGenerator depth))
                                (expressionGenerator depth resultType)
                                (expressionGenerator depth resultType)
                        )
            )


{-| Case inside a case branch.
Tests dive→next→dive chains in captureCaseHelper.

    case Just <expr> of
        Just outerVal ->
            case Ok <expr> of
                Ok okVal -> <expr>
                Err errVal -> <expr>
        Nothing -> <expr>
-}
caseInsideCaseGenerator : Int -> SimpleType -> Random.Generator TypedExpression
caseInsideCaseGenerator depth resultType =
    simpleTypeGenerator
        |> Random.andThen
            (\outerType ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\innerType ->
                            Random.int 100 999
                                |> Random.andThen
                                    (\uid ->
                                        let
                                            suffix =
                                                String.fromInt depth ++ "x" ++ String.fromInt uid
                                        in
                                        Random.map5
                                            (\outerScrutinee innerScrutinee okBody errBody nothingBody ->
                                                { expr =
                                                    Elm.Case.maybe (Elm.just outerScrutinee.expr)
                                                        { nothing = nothingBody.expr
                                                        , just =
                                                            ( "ccO" ++ suffix
                                                            , \_ ->
                                                                Elm.Case.result
                                                                    (Elm.apply
                                                                        (Elm.value
                                                                            { importFrom = []
                                                                            , name = "Ok"
                                                                            , annotation = Nothing
                                                                            }
                                                                        )
                                                                        [ innerScrutinee.expr ]
                                                                    )
                                                                    { ok = ( "ccK" ++ suffix, \_ -> okBody.expr )
                                                                    , err = ( "ccE" ++ suffix, \_ -> errBody.expr )
                                                                    }
                                                            )
                                                        }
                                                , simpleType = resultType
                                                }
                                            )
                                            (expressionGenerator depth outerType)
                                            (expressionGenerator depth innerType)
                                            (expressionGenerator depth resultType)
                                            (expressionGenerator depth resultType)
                                            (expressionGenerator depth resultType)
                                    )
                        )
            )


{-| Record field access on an inline record literal.
Tests record field resolution under deep Index nesting.

    { alpha = <expr> }.alpha
-}
recordAccessGenerator : Int -> SimpleType -> Random.Generator TypedExpression
recordAccessGenerator depth t =
    expressionGenerator depth t
        |> Random.map
            (\fieldVal ->
                { expr =
                    Elm.get "alpha"
                        (Elm.record [ ( "alpha", fieldVal.expr ) ])
                , simpleType = t
                }
            )



-- ============================================================
-- TUPLE / TRIPLE / LIST EXPRESSIONS
-- ============================================================


tupleDeclarationGenerator : Int -> Random.Generator Elm.Declaration
tupleDeclarationGenerator index =
    Random.map2
        (\type1 type2 ->
            Random.map2
                (\e1 e2 ->
                    Elm.declaration ("tuple" ++ String.fromInt index)
                        (Elm.tuple e1.expr e2.expr)
                )
                (expressionGenerator 1 type1)
                (expressionGenerator 1 type2)
        )
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


tripleDeclarationGenerator : Int -> Random.Generator Elm.Declaration
tripleDeclarationGenerator index =
    Random.map3
        (\type1 type2 type3 ->
            Random.map3
                (\e1 e2 e3 ->
                    Elm.declaration ("triple" ++ String.fromInt index)
                        (Elm.triple e1.expr e2.expr e3.expr)
                )
                (expressionGenerator 1 type1)
                (expressionGenerator 1 type2)
                (expressionGenerator 1 type3)
        )
        simpleTypeGenerator
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


listDeclarationGenerator : Int -> Random.Generator Elm.Declaration
listDeclarationGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\elemType ->
                Random.int 0 6
                    |> Random.andThen
                        (\len ->
                            randomList len (expressionGenerator 1 elemType)
                                |> Random.map
                                    (\items ->
                                        Elm.declaration
                                            ("list" ++ String.fromInt index)
                                            (Elm.list (List.map .expr items))
                                    )
                        )
            )



-- ============================================================
-- CUSTOM TYPE DECLARATIONS + CASE
-- ============================================================


type alias CustomTypeDef =
    { typeName : String
    , variants : List VariantDef
    }


type alias VariantDef =
    { name : String
    , payloads : List SimpleType
    }


customTypeDeclarationsGenerator : Int -> Random.Generator (List Elm.Declaration)
customTypeDeclarationsGenerator baseIndex =
    Random.int 1 2
        |> Random.andThen
            (\count ->
                randomListIndexed count
                    (\i -> customTypeWithCaseGenerator (baseIndex * 10 + i))
                    |> Random.map List.concat
            )


customTypeWithCaseGenerator : Int -> Random.Generator (List Elm.Declaration)
customTypeWithCaseGenerator index =
    Random.int 2 4
        |> Random.andThen
            (\variantCount ->
                randomListIndexed variantCount
                    (\vi ->
                        Random.int 0 2
                            |> Random.andThen
                                (\payloadCount ->
                                    randomList payloadCount simpleTypeGenerator
                                        |> Random.map
                                            (\payloads ->
                                                { name = variantName index vi
                                                , payloads = payloads
                                                }
                                            )
                                )
                    )
            )
        |> Random.andThen
            (\variants ->
                let
                    typeName =
                        "Type" ++ String.fromInt index

                    def =
                        { typeName = typeName, variants = variants }
                in
                simpleTypeGenerator
                    |> Random.andThen
                        (\resultType ->
                            -- Branch bodies at depth 1: can contain simple compound expressions
                            randomList (List.length def.variants) (expressionGenerator 1 resultType)
                                |> Random.map
                                    (\branchBodies ->
                                        [ buildCustomTypeDecl def
                                        , buildCaseFunction def resultType branchBodies
                                        ]
                                    )
                        )
            )


buildCustomTypeDecl : CustomTypeDef -> Elm.Declaration
buildCustomTypeDecl def =
    Elm.customType def.typeName
        (List.map
            (\v ->
                if List.isEmpty v.payloads then
                    Elm.variant v.name

                else
                    Elm.variantWith v.name (List.map typeAnnotation v.payloads)
            )
            def.variants
        )


buildCaseFunction : CustomTypeDef -> SimpleType -> List TypedExpression -> Elm.Declaration
buildCaseFunction def resultType branchBodies =
    let
        branches =
            List.map2
                (\variant body ->
                    case List.length variant.payloads of
                        0 ->
                            Elm.Case.branch
                                (Elm.Arg.customType variant.name ())
                                (\() -> body.expr)

                        1 ->
                            Elm.Case.branch
                                (Elm.Arg.customType variant.name identity
                                    |> Elm.Arg.item (Elm.Arg.var "p0")
                                )
                                (\_ -> body.expr)

                        _ ->
                            Elm.Case.branch
                                (Elm.Arg.customType variant.name Tuple.pair
                                    |> Elm.Arg.item (Elm.Arg.var "p0")
                                    |> Elm.Arg.item (Elm.Arg.var "p1")
                                )
                                (\_ -> body.expr)
                )
                def.variants
                branchBodies
    in
    Elm.Declare.fn ("match" ++ def.typeName)
        (Elm.Arg.var "val")
        (\val ->
            Elm.Case.custom val
                (Type.named [] def.typeName)
                branches
        )
        |> .declaration



-- ============================================================
-- DECLARE + CALL
-- ============================================================


declareAndCallGenerator : Int -> Random.Generator (List Elm.Declaration)
declareAndCallGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\argType ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\returnType ->
                            expressionGenerator 1 returnType
                                |> Random.andThen
                                    (\body ->
                                        expressionGenerator 1 argType
                                            |> Random.map
                                                (\argVal ->
                                                    let
                                                        fnName =
                                                            "declared" ++ String.fromInt index

                                                        declared =
                                                            Elm.Declare.fn fnName
                                                                (Elm.Arg.var "input")
                                                                (\_ -> body.expr)

                                                        callDecl =
                                                            Elm.declaration
                                                                ("callDeclared" ++ String.fromInt index)
                                                                (declared.call argVal.expr)
                                                    in
                                                    [ declared.declaration, callDecl ]
                                                )
                                    )
                        )
            )



-- ============================================================
-- FUNCTION DECLARATIONS
-- ============================================================


functionDeclarationsGenerator : Int -> Random.Generator (List Elm.Declaration)
functionDeclarationsGenerator baseIndex =
    Random.int 1 3
        |> Random.andThen
            (\count ->
                randomListIndexed count
                    (\i -> functionDeclarationGenerator (baseIndex * 10 + i))
            )


functionDeclarationGenerator : Int -> Random.Generator Elm.Declaration
functionDeclarationGenerator index =
    Random.int 1 5
        |> Random.andThen
            (\choice ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\returnType ->
                            case choice of
                                1 ->
                                    fn1Generator index returnType

                                2 ->
                                    fn2Generator index returnType

                                3 ->
                                    fn3Generator index returnType

                                4 ->
                                    -- Function with tuple destructuring pattern
                                    fnTuplePatternGenerator index returnType

                                _ ->
                                    -- Function with record destructuring pattern
                                    fnRecordPatternGenerator index returnType
                        )
            )


fn1Generator : Int -> SimpleType -> Random.Generator Elm.Declaration
fn1Generator index returnType =
    bodyStrategyGenerator 2 returnType
        |> Random.map
            (\strategy ->
                Elm.Declare.fn ("fn" ++ String.fromInt index)
                    (Elm.Arg.var "arg0")
                    (\arg0 -> applyBodyStrategy strategy [ arg0 ])
                    |> .declaration
            )


fn2Generator : Int -> SimpleType -> Random.Generator Elm.Declaration
fn2Generator index returnType =
    bodyStrategyGenerator 2 returnType
        |> Random.map
            (\strategy ->
                Elm.Declare.fn2 ("fn" ++ String.fromInt index)
                    (Elm.Arg.var "arg0")
                    (Elm.Arg.var "arg1")
                    (\arg0 arg1 -> applyBodyStrategy strategy [ arg0, arg1 ])
                    |> .declaration
            )


fn3Generator : Int -> SimpleType -> Random.Generator Elm.Declaration
fn3Generator index returnType =
    bodyStrategyGenerator 2 returnType
        |> Random.map
            (\strategy ->
                Elm.Declare.fn3 ("fn" ++ String.fromInt index)
                    (Elm.Arg.var "arg0")
                    (Elm.Arg.var "arg1")
                    (Elm.Arg.var "arg2")
                    (\arg0 arg1 arg2 -> applyBodyStrategy strategy [ arg0, arg1, arg2 ])
                    |> .declaration
            )


{-| Function with tuple destructuring: fn (a, b) -> <expr using a or b> -}
fnTuplePatternGenerator : Int -> SimpleType -> Random.Generator Elm.Declaration
fnTuplePatternGenerator index returnType =
    Random.map2
        (\type1 type2 ->
            bodyStrategyGenerator 2 returnType
                |> Random.map
                    (\strategy ->
                        Elm.Declare.fn ("fn" ++ String.fromInt index)
                            (Elm.Arg.tuple (Elm.Arg.var "first") (Elm.Arg.var "second"))
                            (\( first, second ) -> applyBodyStrategy strategy [ first, second ])
                            |> .declaration
                    )
        )
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


{-| Function with record destructuring: fn { alpha, beta } -> <expr> -}
fnRecordPatternGenerator : Int -> SimpleType -> Random.Generator Elm.Declaration
fnRecordPatternGenerator index returnType =
    bodyStrategyGenerator 2 returnType
        |> Random.map
            (\strategy ->
                Elm.Declare.fn ("fn" ++ String.fromInt index)
                    (Elm.Arg.record (\a b -> ( a, b ))
                        |> Elm.Arg.field "alpha"
                        |> Elm.Arg.field "beta"
                    )
                    (\( alpha, beta ) -> applyBodyStrategy strategy [ alpha, beta ])
                    |> .declaration
            )


type BodyStrategy
    = ReturnFirst
    | ReturnLast
    | ReturnLiteral TypedExpression
    | ReturnComplex TypedExpression


bodyStrategyGenerator : Int -> SimpleType -> Random.Generator BodyStrategy
bodyStrategyGenerator depth returnType =
    if depth <= 0 then
        Random.uniform ReturnFirst [ ReturnLast ]
            |> Random.andThen
                (\s ->
                    case s of
                        ReturnLast ->
                            Random.uniform True [ False ]
                                |> Random.andThen
                                    (\useLiteral ->
                                        if useLiteral then
                                            literalGenerator returnType |> Random.map ReturnLiteral

                                        else
                                            Random.constant ReturnLast
                                    )

                        _ ->
                            Random.constant ReturnFirst
                )

    else
        Random.int 0 3
            |> Random.andThen
                (\choice ->
                    case choice of
                        0 ->
                            Random.constant ReturnFirst

                        1 ->
                            Random.constant ReturnLast

                        2 ->
                            literalGenerator returnType |> Random.map ReturnLiteral

                        _ ->
                            expressionGenerator (depth - 1) returnType |> Random.map ReturnComplex
                )


applyBodyStrategy : BodyStrategy -> List Elm.Expression -> Elm.Expression
applyBodyStrategy strategy args =
    case strategy of
        ReturnFirst ->
            List.head args |> Maybe.withDefault Elm.unit

        ReturnLast ->
            listLast args |> Maybe.withDefault Elm.unit

        ReturnLiteral typed ->
            typed.expr

        ReturnComplex typed ->
            typed.expr



-- ============================================================
-- RECORD DECLARATIONS
-- ============================================================


recordDeclarationsGenerator : Int -> Random.Generator (List Elm.Declaration)
recordDeclarationsGenerator baseIndex =
    Random.int 1 3
        |> Random.andThen
            (\count ->
                randomListIndexed count
                    (\i -> recordDeclarationGenerator (baseIndex * 10 + i))
                    |> Random.map List.concat
            )


recordDeclarationGenerator : Int -> Random.Generator (List Elm.Declaration)
recordDeclarationGenerator index =
    Random.int 2 5
        |> Random.andThen
            (\fieldCount ->
                randomListIndexed fieldCount
                    (\i ->
                        simpleTypeGenerator
                            |> Random.map (\t -> ( fieldName i, t ))
                    )
                    |> Random.andThen
                        (\fields ->
                            fields
                                |> List.map
                                    (\( name, t ) ->
                                        expressionGenerator 1 t
                                            |> Random.map (\typed -> ( name, typed.expr ))
                                    )
                                |> combineGenerators
                                |> Random.map
                                    (\fieldValues ->
                                        [ Elm.alias ("Record" ++ String.fromInt index)
                                            (Type.record
                                                (List.map (\( name, t ) -> ( name, typeAnnotation t )) fields)
                                            )
                                        , Elm.declaration
                                            ("record" ++ String.fromInt index)
                                            (Elm.record fieldValues)
                                        ]
                                    )
                        )
            )



-- ============================================================
-- LITERAL (TOP-LEVEL VALUE) DECLARATIONS
-- ============================================================


{-| Top-level value declarations. Uses depth 2 so expressions can
be nested compound expressions.
-}
literalDeclarationsGenerator : Int -> Random.Generator (List Elm.Declaration)
literalDeclarationsGenerator baseIndex =
    Random.int 2 5
        |> Random.andThen
            (\count ->
                randomListIndexed count
                    (\i ->
                        simpleTypeGenerator
                            |> Random.andThen
                                (\t ->
                                    expressionGenerator 2 t
                                        |> Random.map
                                            (\typed ->
                                                Elm.declaration
                                                    ("value" ++ String.fromInt (baseIndex * 100 + i))
                                                    typed.expr
                                            )
                                )
                    )
            )



-- ============================================================
-- ADVANCED DECLARATIONS (tuples, triples, lists, pipes, declare+call)
-- ============================================================


advancedDeclarationsGenerator : Int -> Random.Generator (List Elm.Declaration)
advancedDeclarationsGenerator baseIndex =
    Random.map5
        (\tuples triples lists pipeDeclList declareCall ->
            tuples ++ triples ++ lists ++ pipeDeclList ++ declareCall
        )
        (Random.int 1 2
            |> Random.andThen
                (\n -> randomListIndexed n (\i -> tupleDeclarationGenerator (baseIndex * 100 + i)))
        )
        (Random.int 0 1
            |> Random.andThen
                (\n -> randomListIndexed n (\i -> tripleDeclarationGenerator (baseIndex * 100 + 10 + i)))
        )
        (Random.int 1 2
            |> Random.andThen
                (\n -> randomListIndexed n (\i -> listDeclarationGenerator (baseIndex * 100 + 20 + i)))
        )
        (numericOrStringTypeGenerator
            |> Random.andThen
                (\t ->
                    pipeChainGenerator 1 t
                        |> Random.map
                            (\typed ->
                                [ Elm.declaration ("piped" ++ String.fromInt baseIndex) typed.expr ]
                            )
                )
        )
        (declareAndCallGenerator baseIndex)
        |> Random.andThen
            (\batch1 ->
                -- Second batch: cons list, maybe values, withType values
                Random.map3
                    (\consList maybeVal withTypeVal ->
                        batch1 ++ consList ++ maybeVal ++ withTypeVal
                    )
                    -- Cons expression as a top-level value
                    (simpleTypeGenerator
                        |> Random.andThen
                            (\elemType ->
                                consExpressionGenerator 0 elemType
                                    |> Random.map
                                        (\typed ->
                                            [ Elm.declaration
                                                ("consList" ++ String.fromInt baseIndex)
                                                typed.expr
                                            ]
                                        )
                            )
                    )
                    -- Maybe value
                    (simpleTypeGenerator
                        |> Random.andThen
                            (\innerType ->
                                maybeExpressionGenerator 0 innerType
                                    |> Random.map
                                        (\typed ->
                                            [ Elm.declaration
                                                ("maybeVal" ++ String.fromInt baseIndex)
                                                typed.expr
                                            ]
                                        )
                            )
                    )
                    -- withType annotated value
                    (simpleTypeGenerator
                        |> Random.andThen
                            (\t ->
                                withTypeGenerator 1 t
                                    |> Random.map
                                        (\typed ->
                                            [ Elm.declaration
                                                ("annotated" ++ String.fromInt baseIndex)
                                                typed.expr
                                            ]
                                        )
                            )
                    )
            )



-- ============================================================
-- MULTI-FILE (library + consumer)
-- ============================================================


multiFileGenerator : Int -> Random.Generator (List Elm.File)
multiFileGenerator index =
    let
        libModuleName =
            "Test" ++ String.fromInt index ++ "Lib"

        consumerModuleName =
            "Test" ++ String.fromInt index
    in
    Random.int 2 4
        |> Random.andThen
            (\valueCount ->
                randomListIndexed valueCount
                    (\i ->
                        simpleTypeGenerator
                            |> Random.andThen
                                (\t ->
                                    expressionGenerator 1 t
                                        |> Random.map
                                            (\typed ->
                                                { name = "libValue" ++ String.fromInt i
                                                , typed = typed
                                                }
                                            )
                                )
                    )
            )
        |> Random.andThen
            (\libValues ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\returnType ->
                            expressionGenerator 1 returnType
                                |> Random.map
                                    (\fnBody ->
                                        let
                                            libDecls =
                                                List.map
                                                    (\v ->
                                                        Elm.declaration v.name v.typed.expr
                                                            |> Elm.expose
                                                    )
                                                    libValues

                                            libFnDeclared =
                                                Elm.Declare.fn "libHelper"
                                                    (Elm.Arg.var "x")
                                                    (\_ -> fnBody.expr)

                                            libFile =
                                                Elm.file [ libModuleName ]
                                                    (libDecls ++ [ libFnDeclared.declaration |> Elm.expose ])

                                            consumerDecls =
                                                List.map
                                                    (\v ->
                                                        Elm.declaration ("use" ++ capitalize v.name)
                                                            (Elm.value
                                                                { importFrom = [ libModuleName ]
                                                                , name = v.name
                                                                , annotation = Just (typeAnnotation v.typed.simpleType)
                                                                }
                                                            )
                                                    )
                                                    libValues

                                            fnCallDecl =
                                                Elm.declaration "useLibHelper"
                                                    (Elm.apply
                                                        (Elm.value
                                                            { importFrom = [ libModuleName ]
                                                            , name = "libHelper"
                                                            , annotation =
                                                                Just
                                                                    (Type.function
                                                                        [ Type.var "a" ]
                                                                        (typeAnnotation returnType)
                                                                    )
                                                            }
                                                        )
                                                        [ Elm.unit ]
                                                    )

                                            consumerFile =
                                                Elm.file [ consumerModuleName ]
                                                    (consumerDecls ++ [ fnCallDecl ])
                                        in
                                        [ libFile, consumerFile ]
                                    )
                        )
            )



-- ============================================================
-- COVERAGE BOOST: exercise uncovered elm-codegen APIs
-- ============================================================


{-| Additional declarations that exercise elm-codegen APIs not
covered by the main generators. Guided by coverage analysis.
-}
coverageBoostGenerator : Int -> Random.Generator (List Elm.Declaration)
coverageBoostGenerator baseIndex =
    Random.map5
        (\letUnpackDecls exprLambdaDecls exposedDecls docDecls commentDecls ->
            letUnpackDecls ++ exprLambdaDecls ++ exposedDecls ++ docDecls ++ commentDecls
        )
        (letUnpackGenerator baseIndex)
        (exprLambdaGenerator baseIndex)
        (exposedDeclGenerator baseIndex)
        (documentedDeclGenerator baseIndex)
        (Random.constant [ Elm.comment "Generated comment" ])
        |> Random.andThen
            (\batch1 ->
                Random.map5
                    (\letFnDecls groupDecls triplePatternDecls applyDecls annotationDecls ->
                        batch1 ++ letFnDecls ++ groupDecls ++ triplePatternDecls ++ applyDecls ++ annotationDecls
                    )
                    (letFnGenerator baseIndex)
                    (groupGenerator baseIndex)
                    (triplePatternFnGenerator baseIndex)
                    (applyWithAnnotationGenerator baseIndex)
                    (annotationExerciseGenerator baseIndex)
            )
        |> Random.andThen
            (\batch2 ->
                Random.map5
                    (\declareValueDecls declareFn4Decls declareAliasDecls declareCustomTypeDecls declareModuleDecls ->
                        batch2 ++ declareValueDecls ++ declareFn4Decls ++ declareAliasDecls ++ declareCustomTypeDecls ++ declareModuleDecls
                    )
                    (declareValueGenerator baseIndex)
                    (declareFn4Generator baseIndex)
                    (declareAliasGenerator baseIndex)
                    (declareCustomTypeGenerator baseIndex)
                    (declareModuleGenerator baseIndex)
            )
        |> Random.andThen
            (\batch3 ->
                Random.map4
                    (\recordAliasFieldAccess recordUpdateOnAlias appendableOps fnWithTypedArgs ->
                        batch3 ++ recordAliasFieldAccess ++ recordUpdateOnAlias ++ appendableOps ++ fnWithTypedArgs
                    )
                    (recordAliasFieldAccessGenerator baseIndex)
                    (recordUpdateOnAliasGenerator baseIndex)
                    (appendableOperatorGenerator baseIndex)
                    (fnWithTypedArgsGenerator baseIndex)
            )
        |> Random.andThen
            (\batch4 ->
                Random.map5
                    (\betaReduceDecls dynamicFnDecls complexUpdateDecls genericFieldDecls listAppendDecls ->
                        batch4 ++ betaReduceDecls ++ dynamicFnDecls ++ complexUpdateDecls ++ genericFieldDecls ++ listAppendDecls
                    )
                    (betaReduceGenerator baseIndex)
                    (dynamicFunctionGenerator baseIndex)
                    (complexRecordUpdateGenerator baseIndex)
                    (genericRecordFieldAccessGenerator baseIndex)
                    (listAppendGenerator baseIndex)
            )
        |> Random.andThen
            (\batch5 ->
                Random.map5
                    (\hexDecls literalPatternDecls portDecls customTypeAdvDecls aliasPatternDecls ->
                        batch5 ++ hexDecls ++ literalPatternDecls ++ portDecls ++ customTypeAdvDecls ++ aliasPatternDecls
                    )
                    (hexLiteralGenerator baseIndex)
                    (literalPatternCaseGenerator baseIndex)
                    (portGenerator baseIndex)
                    (customTypeAdvancedGenerator baseIndex)
                    (aliasPatternGenerator baseIndex)
            )
        |> Random.andThen
            (\batch6 ->
                Random.map5
                    (\unwrapDecls divideDecls pipeLeftDecls declareRecordDecls bodyDecls ->
                        batch6 ++ unwrapDecls ++ divideDecls ++ pipeLeftDecls ++ declareRecordDecls ++ bodyDecls
                    )
                    (unwrapGenerator baseIndex)
                    (divideGenerator baseIndex)
                    (pipeLeftGenerator baseIndex)
                    (declareRecordBuilderGenerator baseIndex)
                    (fnBodyGenerator baseIndex)
            )
        |> Random.andThen
            (\batch7 ->
                Random.map3
                    (\variant2Decls namedTypeAliasDecls recordUnifyDecls ->
                        batch7 ++ variant2Decls ++ namedTypeAliasDecls ++ recordUnifyDecls
                    )
                    (customTypeVariant2Generator baseIndex)
                    (namedTypeAliasGenerator baseIndex)
                    (recordFieldUnifyGenerator baseIndex)
            )
        |> Random.andThen
            (\batch8 ->
                Random.map5
                    (\extensibleDecls fileWithDecls listPatternDecls pipeToDecls toFileDecls ->
                        batch8 ++ extensibleDecls ++ fileWithDecls ++ listPatternDecls ++ pipeToDecls ++ toFileDecls
                    )
                    (extensibleRecordGenerator baseIndex)
                    (fileWithGenerator baseIndex)
                    (listPatternGenerator baseIndex)
                    (pipeToGenerator baseIndex)
                    (declareToFileGenerator baseIndex)
            )
        |> Random.andThen
            (\batch9 ->
                Random.map4
                    (\parseDecls variant3Decls submoduleDecls unsafeDecls ->
                        batch9 ++ parseDecls ++ variant3Decls ++ submoduleDecls ++ unsafeDecls
                    )
                    (parseGenerator baseIndex)
                    (customTypeVariant3Generator baseIndex)
                    (submoduleGenerator baseIndex)
                    (unsafeGenerator baseIndex)
            )


{-| Let.unpack with tuple destructuring — exercises Internal.Arg
and Let.unpack code paths that are otherwise 0% covered.
-}
letUnpackGenerator : Int -> Random.Generator (List Elm.Declaration)
letUnpackGenerator index =
    Random.map2
        (\type1 type2 ->
            Random.map2
                (\val1 val2 ->
                    [ Elm.declaration ("letUnpack" ++ String.fromInt index)
                        (Elm.Let.letIn
                            (\( first, second ) ->
                                first
                            )
                            |> Elm.Let.unpack
                                (Elm.Arg.tuple
                                    (Elm.Arg.var "first")
                                    (Elm.Arg.var "second")
                                )
                                (Elm.tuple val1.expr val2.expr)
                            |> Elm.Let.toExpression
                        )
                    ]
                )
                (expressionGenerator 0 type1)
                (expressionGenerator 0 type2)
        )
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


{-| Expression-level Elm.fn2 and Elm.fn3 (as opposed to Declare.fn2).
These are lambda expressions with multiple arguments.
-}
exprLambdaGenerator : Int -> Random.Generator (List Elm.Declaration)
exprLambdaGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\returnType ->
                expressionGenerator 0 returnType
                    |> Random.map
                        (\body ->
                            [ Elm.declaration ("exprFn2_" ++ String.fromInt index)
                                (Elm.fn2
                                    (Elm.Arg.var "a")
                                    (Elm.Arg.var "b")
                                    (\_ _ -> body.expr)
                                )
                            , Elm.declaration ("exprFn3_" ++ String.fromInt index)
                                (Elm.fn3
                                    (Elm.Arg.var "x")
                                    (Elm.Arg.var "y")
                                    (Elm.Arg.var "z")
                                    (\_ _ _ -> body.expr)
                                )
                            ]
                        )
            )


{-| Exposed declarations and exposeConstructor — exercises the
expose/exposeConstructor code paths in Elm.elm.
-}
exposedDeclGenerator : Int -> Random.Generator (List Elm.Declaration)
exposedDeclGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                expressionGenerator 0 t
                    |> Random.map
                        (\body ->
                            [ Elm.declaration ("exposed" ++ String.fromInt index) body.expr
                                |> Elm.expose
                            , Elm.customType ("ExposedType" ++ String.fromInt index)
                                [ Elm.variant ("ExVariantA" ++ String.fromInt index)
                                , Elm.variantWith ("ExVariantB" ++ String.fromInt index)
                                    [ typeAnnotation t ]
                                ]
                                |> Elm.exposeConstructor
                            ]
                        )
            )


{-| Declarations with documentation — exercises withDocumentation.
-}
documentedDeclGenerator : Int -> Random.Generator (List Elm.Declaration)
documentedDeclGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                expressionGenerator 0 t
                    |> Random.map
                        (\body ->
                            [ Elm.declaration ("documented" ++ String.fromInt index) body.expr
                                |> Elm.withDocumentation "This is a generated declaration."
                                |> Elm.expose
                            ]
                        )
            )


{-| Let-bound functions — exercises Elm.Let.fn which is 0% covered. -}
letFnGenerator : Int -> Random.Generator (List Elm.Declaration)
letFnGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\returnType ->
                expressionGenerator 0 returnType
                    |> Random.map
                        (\body ->
                            [ Elm.declaration ("letFn" ++ String.fromInt index)
                                (Elm.Let.letIn
                                    (\myFn ->
                                        myFn (Elm.int 1)
                                    )
                                    |> Elm.Let.fn "myFn"
                                        (Elm.Arg.var "arg")
                                        (\_ -> body.expr)
                                    |> Elm.Let.toExpression
                                )
                            ]
                        )
            )


{-| Elm.group + Elm.docs — exercises grouping and doc generation. -}
groupGenerator : Int -> Random.Generator (List Elm.Declaration)
groupGenerator index =
    Random.map2
        (\type1 type2 ->
            Random.map2
                (\val1 val2 ->
                    [ Elm.group
                        [ Elm.docs ("## Section " ++ String.fromInt index)
                        , Elm.declaration ("grouped1_" ++ String.fromInt index) val1.expr
                            |> Elm.expose
                        , Elm.declaration ("grouped2_" ++ String.fromInt index) val2.expr
                            |> Elm.expose
                        ]
                    ]
                )
                (expressionGenerator 0 type1)
                (expressionGenerator 0 type2)
        )
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


{-| Function with triple destructuring pattern — exercises Elm.Arg.triple. -}
triplePatternFnGenerator : Int -> Random.Generator (List Elm.Declaration)
triplePatternFnGenerator index =
    bodyStrategyGenerator 0 TUnit
        |> Random.map
            (\_ ->
                [ Elm.Declare.fn ("fnTriple" ++ String.fromInt index)
                    (Elm.Arg.triple
                        (Elm.Arg.var "a")
                        (Elm.Arg.var "b")
                        (Elm.Arg.var "c")
                    )
                    (\( a, _, _ ) -> a)
                    |> .declaration
                ]
            )


{-| Elm.apply with a typed value reference — exercises the apply +
type inference path more deeply.
-}
applyWithAnnotationGenerator : Int -> Random.Generator (List Elm.Declaration)
applyWithAnnotationGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\argType ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\returnType ->
                            expressionGenerator 0 argType
                                |> Random.map
                                    (\argVal ->
                                        let
                                            fnRef =
                                                Elm.value
                                                    { importFrom = []
                                                    , name = "identity"
                                                    , annotation =
                                                        Just
                                                            (Type.function
                                                                [ typeAnnotation argType ]
                                                                (typeAnnotation argType)
                                                            )
                                                    }
                                        in
                                        [ Elm.declaration ("applied" ++ String.fromInt index)
                                            (Elm.apply fnRef [ argVal.expr ])
                                        ]
                                    )
                        )
            )


{-| Exercise annotation APIs — Type.list, Type.maybe, Type.result,
Type.tuple, Type.namedWith, Type.function, Type.dict, Type.set.
These generate type aliases that exercise the annotation builders.
-}
annotationExerciseGenerator : Int -> Random.Generator (List Elm.Declaration)
annotationExerciseGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\innerType ->
                let
                    inner =
                        typeAnnotation innerType
                in
                Random.constant
                    [ Elm.alias ("AnnList" ++ String.fromInt index)
                        (Type.list inner)
                    , Elm.alias ("AnnMaybe" ++ String.fromInt index)
                        (Type.maybe inner)
                    , Elm.alias ("AnnResult" ++ String.fromInt index)
                        (Type.result Type.string inner)
                    , Elm.alias ("AnnTuple" ++ String.fromInt index)
                        (Type.tuple inner Type.int)
                    , Elm.alias ("AnnFn" ++ String.fromInt index)
                        (Type.function [ inner, Type.string ] Type.bool)
                    , Elm.alias ("AnnNamed" ++ String.fromInt index)
                        (Type.namedWith [ "Dict" ] "Dict" [ Type.string, inner ])
                    ]
            )



{-| Elm.Declare.value — a declared value with a .value reference. -}
declareValueGenerator : Int -> Random.Generator (List Elm.Declaration)
declareValueGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                expressionGenerator 0 t
                    |> Random.map
                        (\body ->
                            let
                                declaredVal =
                                    Elm.Declare.value
                                        ("declVal" ++ String.fromInt index)
                                        body.expr

                                -- Use the declared value's .value reference
                                useDecl =
                                    Elm.declaration
                                        ("useDeclVal" ++ String.fromInt index)
                                        declaredVal.value
                            in
                            [ declaredVal.declaration, useDecl ]
                        )
            )


{-| Elm.Declare.fn4 — higher arity function. -}
declareFn4Generator : Int -> Random.Generator (List Elm.Declaration)
declareFn4Generator index =
    simpleTypeGenerator
        |> Random.andThen
            (\returnType ->
                expressionGenerator 0 returnType
                    |> Random.map
                        (\body ->
                            let
                                declared =
                                    Elm.Declare.fn4
                                        ("fn4_" ++ String.fromInt index)
                                        (Elm.Arg.var "a")
                                        (Elm.Arg.var "b")
                                        (Elm.Arg.var "c")
                                        (Elm.Arg.var "d")
                                        (\_ _ _ _ -> body.expr)

                                callDecl =
                                    Elm.declaration
                                        ("callFn4_" ++ String.fromInt index)
                                        (declared.call Elm.unit Elm.unit Elm.unit Elm.unit)
                            in
                            [ declared.declaration, callDecl ]
                        )
            )


{-| Elm.Declare.alias — a typed alias declaration with .annotation. -}
declareAliasGenerator : Int -> Random.Generator (List Elm.Declaration)
declareAliasGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                let
                    declaredAlias =
                        Elm.Declare.alias
                            ("DeclAlias" ++ String.fromInt index)
                            (Type.record
                                [ ( "field1", typeAnnotation t )
                                , ( "field2", Type.string )
                                ]
                            )

                    -- Use the alias's annotation in a function signature
                    useAlias =
                        Elm.Declare.fn
                            ("useDeclAlias" ++ String.fromInt index)
                            (Elm.Arg.var "input")
                            (\input ->
                                Elm.withType declaredAlias.annotation input
                            )
                in
                Random.constant
                    [ declaredAlias.declaration
                    , useAlias.declaration
                    ]
            )


{-| Elm.Declare.customType + exposeConstructor — typed custom type with
constructor exposure.
-}
declareCustomTypeGenerator : Int -> Random.Generator (List Elm.Declaration)
declareCustomTypeGenerator index =
    let
        declaredType =
            Elm.Declare.customType
                ("DeclCustom" ++ String.fromInt index)
                [ Elm.variant ("DeclVariantA" ++ String.fromInt index)
                , Elm.variantWith ("DeclVariantB" ++ String.fromInt index)
                    [ Type.int ]
                ]
                |> Elm.Declare.exposeConstructor
    in
    Random.constant
        [ declaredType.declaration
        ]


{-| Elm.Declare.module_ + with + toFile pattern — virtual module builder.
We use include instead of toFile to embed it in the current file.
-}
declareModuleGenerator : Int -> Random.Generator (List Elm.Declaration)
declareModuleGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                expressionGenerator 0 t
                    |> Random.map
                        (\body ->
                            let
                                helperFn =
                                    Elm.Declare.fn
                                        ("modHelper" ++ String.fromInt index)
                                        (Elm.Arg.var "x")
                                        (\_ -> body.expr)

                                helperVal =
                                    Elm.Declare.value
                                        ("modVal" ++ String.fromInt index)
                                        body.expr

                                mod =
                                    Elm.Declare.module_ [] identity
                                        |> Elm.Declare.with helperFn
                                        |> Elm.Declare.with helperVal
                                        |> Elm.Declare.withDeclarations
                                            [ Elm.declaration ("modExtra" ++ String.fromInt index) (Elm.int 42) ]

                                -- Use include to embed the module's declarations
                                includeDecl =
                                    Elm.Declare.include mod
                            in
                            [ includeDecl ]
                        )
            )



{-| Record field access on a record with a type alias annotation.
Exercises inferRecordField, getField, unifiableFields, and the
alias resolution paths in Internal.Compiler.
-}
recordAliasFieldAccessGenerator : Int -> Random.Generator (List Elm.Declaration)
recordAliasFieldAccessGenerator index =
    Random.map2
        (\type1 type2 ->
            Random.map2
                (\val1 val2 ->
                    let
                        aliasName =
                            "FieldAlias" ++ String.fromInt index

                        aliasDef =
                            Elm.alias aliasName
                                (Type.record
                                    [ ( "name", typeAnnotation type1 )
                                    , ( "value", typeAnnotation type2 )
                                    ]
                                )

                        recordVal =
                            Elm.record
                                [ ( "name", val1.expr )
                                , ( "value", val2.expr )
                                ]
                                |> Elm.withType (Type.named [] aliasName)

                        -- Access a field through the alias
                        fieldAccess =
                            Elm.declaration ("aliasField" ++ String.fromInt index)
                                (Elm.get "name" recordVal)
                    in
                    [ aliasDef, fieldAccess ]
                )
                (expressionGenerator 0 type1)
                (expressionGenerator 0 type2)
        )
        simpleTypeGenerator
        simpleTypeGenerator
        |> Random.andThen identity


{-| Record update on an aliased record.
Exercises updateRecord + alias resolution paths.
-}
recordUpdateOnAliasGenerator : Int -> Random.Generator (List Elm.Declaration)
recordUpdateOnAliasGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                Random.map2
                    (\origVal newVal ->
                        let
                            aliasName =
                                "UpdAlias" ++ String.fromInt index

                            aliasDef =
                                Elm.alias aliasName
                                    (Type.record
                                        [ ( "alpha", typeAnnotation t )
                                        , ( "beta", Type.int )
                                        ]
                                    )

                            updated =
                                Elm.updateRecord
                                    [ ( "alpha", newVal.expr ) ]
                                    (Elm.record
                                        [ ( "alpha", origVal.expr )
                                        , ( "beta", Elm.int 0 )
                                        ]
                                    )
                        in
                        [ aliasDef
                        , Elm.declaration ("updAlias" ++ String.fromInt index) updated
                        ]
                    )
                    (expressionGenerator 0 t)
                    (expressionGenerator 0 t)
            )


{-| Appendable operators — exercises Elm.Op.append with list operands
which hits the isAppendable path in Internal.Compiler.
-}
appendableOperatorGenerator : Int -> Random.Generator (List Elm.Declaration)
appendableOperatorGenerator index =
    Random.constant
        [ Elm.declaration ("appendList" ++ String.fromInt index)
            (Elm.Op.append
                (Elm.list [ Elm.int 1, Elm.int 2 ])
                (Elm.list [ Elm.int 3 ])
            )
        ]


{-| Functions with explicit type annotations on arguments.
Exercises Elm.Arg.varWith and typed function signatures.
-}
fnWithTypedArgsGenerator : Int -> Random.Generator (List Elm.Declaration)
fnWithTypedArgsGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\argType ->
                simpleTypeGenerator
                    |> Random.andThen
                        (\returnType ->
                            expressionGenerator 0 returnType
                                |> Random.map
                                    (\body ->
                                        [ Elm.Declare.fn
                                            ("typedArgFn" ++ String.fromInt index)
                                            (Elm.Arg.varWith "input" (typeAnnotation argType))
                                            (\_ -> body.expr)
                                            |> .declaration
                                        ]
                                    )
                        )
            )



{-| Elm.functionReduced — triggers betaReduce.
Several patterns to exercise different reduction paths:
1. Record accessor: \r -> r.field  →  .field
2. Identity: \x -> x  →  identity-like
3. Partial application: \x -> f x  →  f
-}
betaReduceGenerator : Int -> Random.Generator (List Elm.Declaration)
betaReduceGenerator index =
    Random.constant
        [ -- Record accessor reduction: \r -> r.field → .field
          Elm.declaration ("betaAccessor" ++ String.fromInt index)
            (Elm.functionReduced "r"
                (\r -> Elm.get "name" r)
            )
        , -- Identity-like reduction: \x -> x
          Elm.declaration ("betaIdentity" ++ String.fromInt index)
            (Elm.functionReduced "x" (\x -> x))
        , -- Partial application: \x -> Elm.Op.plus x (Elm.int 1)
          Elm.declaration ("betaPartial" ++ String.fromInt index)
            (Elm.functionReduced "x"
                (\x -> Elm.Op.plus x (Elm.int 1))
            )
        ]


{-| Elm.function (dynamic arg list) — 0% covered.
Exercises function with explicit type annotations and variable arity.
-}
dynamicFunctionGenerator : Int -> Random.Generator (List Elm.Declaration)
dynamicFunctionGenerator index =
    Random.constant
        [ -- 1-arg function with type annotation
          Elm.declaration ("dynFn1_" ++ String.fromInt index)
            (Elm.function
                [ ( "x", Just Type.int ) ]
                (\args ->
                    case args of
                        [ x ] ->
                            x

                        _ ->
                            Elm.unit
                )
            )
        , -- 2-arg function with mixed annotations
          Elm.declaration ("dynFn2_" ++ String.fromInt index)
            (Elm.function
                [ ( "name", Just Type.string )
                , ( "age", Just Type.int )
                ]
                (\args ->
                    case args of
                        [ name, _ ] ->
                            name

                        _ ->
                            Elm.unit
                )
            )
        , -- 0-arg function (edge case)
          Elm.declaration ("dynFn0_" ++ String.fromInt index)
            (Elm.function []
                (\_ -> Elm.string "no args")
            )
        , -- Function with no type annotation (inferred)
          Elm.declaration ("dynFnInferred_" ++ String.fromInt index)
            (Elm.function
                [ ( "a", Nothing )
                , ( "b", Nothing )
                ]
                (\args ->
                    case args of
                        [ a, _ ] ->
                            a

                        _ ->
                            Elm.unit
                )
            )
        ]


{-| updateRecord slow path — when the record expression is complex
(not a simple variable), updateRecord creates a let binding.
-}
complexRecordUpdateGenerator : Int -> Random.Generator (List Elm.Declaration)
complexRecordUpdateGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\t ->
                Random.map2
                    (\val1 val2 ->
                        [ Elm.declaration ("complexUpdate" ++ String.fromInt index)
                            (Elm.updateRecord
                                [ ( "alpha", val2.expr ) ]
                                -- Complex expression (not a simple var) triggers
                                -- the let-binding slow path in updateRecord
                                (Elm.ifThen (Elm.bool True)
                                    (Elm.record
                                        [ ( "alpha", val1.expr )
                                        , ( "beta", Elm.int 0 )
                                        ]
                                    )
                                    (Elm.record
                                        [ ( "alpha", val1.expr )
                                        , ( "beta", Elm.int 1 )
                                        ]
                                    )
                                )
                            )
                        ]
                    )
                    (expressionGenerator 0 t)
                    (expressionGenerator 0 t)
            )


{-| Field access on a record with a type annotation.
Exercises resolveField on typed records.
Also exercises Elm.fn with record arg + field access (triggers
inferRecordField when the function arg is generic).
-}
genericRecordFieldAccessGenerator : Int -> Random.Generator (List Elm.Declaration)
genericRecordFieldAccessGenerator index =
    Random.constant
        [ -- Access field on an inline record with type annotation
          Elm.declaration ("genFieldAccess" ++ String.fromInt index)
            (Elm.get "name"
                (Elm.record
                    [ ( "name", Elm.string "test" )
                    , ( "age", Elm.int 25 )
                    ]
                    |> Elm.withType
                        (Type.record
                            [ ( "name", Type.string )
                            , ( "age", Type.int )
                            ]
                        )
                )
            )
        , -- Function that accesses a field on its argument
          -- This exercises inferRecordField when arg type is generic
          Elm.Declare.fn ("fieldAccessFn" ++ String.fromInt index)
            (Elm.Arg.var "rec")
            (\rec -> Elm.get "name" rec)
            |> .declaration
        ]


{-| List append to exercise isAppendable path.
Also exercises list type annotations.
-}
listAppendGenerator : Int -> Random.Generator (List Elm.Declaration)
listAppendGenerator index =
    simpleTypeGenerator
        |> Random.andThen
            (\elemType ->
                Random.map2
                    (\item1 item2 ->
                        [ -- List ++ List
                          Elm.declaration ("listAppend" ++ String.fromInt index)
                            (Elm.Op.append
                                (Elm.list [ item1.expr ])
                                (Elm.list [ item2.expr ])
                            )
                        , -- String ++ String (appendable)
                          Elm.declaration ("strAppend" ++ String.fromInt index)
                            (Elm.Op.append
                                (Elm.string "hello")
                                (Elm.string "world")
                            )
                        ]
                    )
                    (expressionGenerator 0 elemType)
                    (expressionGenerator 0 elemType)
            )



{-| Elm.hex — exercises hex literal rendering (toHexString in Write.elm). -}
hexLiteralGenerator : Int -> Random.Generator (List Elm.Declaration)
hexLiteralGenerator index =
    Random.int 0 65535
        |> Random.map
            (\n ->
                [ Elm.declaration ("hexVal" ++ String.fromInt index) (Elm.hex n)
                ]
            )


{-| Case expressions with literal patterns — exercises Elm.Arg.unit,
Elm.Arg.int, Elm.Arg.char which are all 0% covered.
-}
literalPatternCaseGenerator : Int -> Random.Generator (List Elm.Declaration)
literalPatternCaseGenerator index =
    Random.constant
        [ -- Unit pattern
          Elm.declaration ("unitCase" ++ String.fromInt index)
            (Elm.Case.custom Elm.unit
                Type.unit
                [ Elm.Case.branch Elm.Arg.unit
                    (\_ -> Elm.string "unit matched")
                ]
            )
        , -- Int literal pattern
          Elm.declaration ("intCase" ++ String.fromInt index)
            (Elm.Case.custom (Elm.int 42)
                Type.int
                [ Elm.Case.branch (Elm.Arg.int 42)
                    (\_ -> Elm.string "forty-two")
                , Elm.Case.branch (Elm.Arg.var "other")
                    (\_ -> Elm.string "something else")
                ]
            )
        , -- Char literal pattern
          Elm.declaration ("charCase" ++ String.fromInt index)
            (Elm.Case.custom (Elm.char 'a')
                Type.char
                [ Elm.Case.branch (Elm.Arg.char 'a')
                    (\_ -> Elm.bool True)
                , Elm.Case.branch (Elm.Arg.var "other")
                    (\_ -> Elm.bool False)
                ]
            )
        ]


{-| Port declarations — exercises portIncoming, portOutgoing,
and prettyPortDeclaration in Write.elm. Note: ports make the
module a port module which changes the module declaration.
-}
portGenerator : Int -> Random.Generator (List Elm.Declaration)
portGenerator index =
    Random.constant
        [ Elm.portIncoming ("receive" ++ String.fromInt index)
            Type.string
        , Elm.portOutgoing ("send" ++ String.fromInt index)
            Type.string
        ]


{-| Declare.customTypeAdvanced with variant0/variant1 + make_ + case_.
Exercises the entire custom type builder pipeline which is 0% covered.
-}
customTypeAdvancedGenerator : Int -> Random.Generator (List Elm.Declaration)
customTypeAdvancedGenerator index =
    let
        typeName =
            "AdvType" ++ String.fromInt index

        advType =
            Elm.Declare.customTypeAdvanced typeName
                { exposeConstructor = True }
                (\none some -> { none = none, some = some })
                |> Elm.Declare.variant0 ("None" ++ String.fromInt index) .none
                |> Elm.Declare.variant1 ("Some" ++ String.fromInt index) .some Type.int
                |> Elm.Declare.finishCustomType

        -- Use make_ to construct values
        makeNone =
            Elm.declaration ("makeNone" ++ String.fromInt index)
                advType.make_.none

        makeSome =
            Elm.declaration ("makeSome" ++ String.fromInt index)
                (advType.make_.some (Elm.int 42))

        -- Use case_ to pattern match
        caseExpr =
            Elm.declaration ("matchAdv" ++ String.fromInt index)
                (advType.case_ (advType.make_.some (Elm.int 1))
                    { none = Elm.int 0
                    , some = \val -> val
                    }
                )
    in
    Random.constant
        [ advType.declaration
        , makeNone
        , makeSome
        , caseExpr
        ]


{-| Elm.Arg.aliasAs — pattern alias like `pattern as name`.
Exercises the aliasAs path in Internal.Arg.
-}
aliasPatternGenerator : Int -> Random.Generator (List Elm.Declaration)
aliasPatternGenerator index =
    Random.constant
        [ Elm.Declare.fn ("aliasPattern" ++ String.fromInt index)
            (Elm.Arg.record (\a b -> ( a, b ))
                |> Elm.Arg.field "name"
                |> Elm.Arg.field "age"
                |> Elm.Arg.aliasAs "person"
            )
            (\( ( name, _ ), person ) ->
                -- Use both the destructured field and the alias
                Elm.tuple name person
            )
            |> .declaration
        ]



{-| Elm.unwrap / Elm.unwrapper — exercises single-variant type
pattern matching and lambda generation. Uses a custom type we
define in the same module.
-}
unwrapGenerator : Int -> Random.Generator (List Elm.Declaration)
unwrapGenerator index =
    let
        wrapperName =
            "Wrapper" ++ String.fromInt index

        typeDef =
            Elm.customType wrapperName
                [ Elm.variantWith wrapperName [ Type.int ] ]
                |> Elm.exposeConstructor

        -- Use unwrapper to create the extraction function
        extractDecl =
            Elm.declaration ("extract" ++ String.fromInt index)
                (Elm.unwrapper [] wrapperName)

        -- Use unwrap to apply it
        unwrapDecl =
            Elm.declaration ("unwrapped" ++ String.fromInt index)
                (Elm.unwrap [] wrapperName
                    (Elm.apply
                        (Elm.value
                            { importFrom = []
                            , name = wrapperName
                            , annotation = Just (Type.function [ Type.int ] (Type.named [] wrapperName))
                            }
                        )
                        [ Elm.int 42 ]
                    )
                )
    in
    Random.constant [ typeDef, extractDecl, unwrapDecl ]


{-| Elm.Op.divide — float division, 0% covered. -}
divideGenerator : Int -> Random.Generator (List Elm.Declaration)
divideGenerator index =
    Random.constant
        [ Elm.declaration ("divided" ++ String.fromInt index)
            (Elm.Op.divide (Elm.float 10.0) (Elm.float 3.0))
        ]


{-| Elm.Op.pipeLeft — left pipe operator, 0% covered.
Has the same rendering concerns as pipe (right operand parens).
-}
pipeLeftGenerator : Int -> Random.Generator (List Elm.Declaration)
pipeLeftGenerator index =
    Random.constant
        [ Elm.declaration ("pipeLeft" ++ String.fromInt index)
            (Elm.Op.pipeLeft
                (Elm.fn (Elm.Arg.var "x") (\x -> x))
                (Elm.string "hello")
            )
        ]


{-| Declare.record + withField + buildRecord — the record builder
pattern. Exercises field ordering and record constructor generation.
-}
declareRecordBuilderGenerator : Int -> Random.Generator (List Elm.Declaration)
declareRecordBuilderGenerator index =
    let
        recName =
            "BuiltRecord" ++ String.fromInt index

        builtRecord =
            Elm.Declare.record recName
                |> Elm.Declare.withField "name" .name Type.string
                |> Elm.Declare.withField "age" .age Type.int
                |> Elm.Declare.buildRecord

        -- Use the record maker
        makeDecl =
            Elm.declaration ("makeBuiltRec" ++ String.fromInt index)
                (builtRecord.make
                    { name = Elm.string "Alice"
                    , age = Elm.int 30
                    }
                )
    in
    Random.constant
        [ builtRecord.declaration
        , makeDecl
        ]


{-| Elm.body / Declare.fnBody — the custom body renderer for
function builders. Exercises a different code path than fnDone.
-}
fnBodyGenerator : Int -> Random.Generator (List Elm.Declaration)
fnBodyGenerator index =
    Random.constant
        [ -- Elm.body on a fnBuilder — body receives the accumulated
          -- result of applying args through the builder function
          Elm.declaration ("bodyFn" ++ String.fromInt index)
            (Elm.fnBuilder (\a b -> ( a, b ))
                |> Elm.fnArg (Elm.Arg.var "x")
                |> Elm.fnArg (Elm.Arg.var "y")
                |> Elm.body
                    (\( x, y ) ->
                        Elm.tuple x y
                    )
            )
        ]



{-| Declare.customTypeAdvanced with variant2 — multi-payload variants
are 0% covered. Exercises variant2, standardVariant, customVariant,
and the make_/case_ generation for multi-arg constructors.
-}
customTypeVariant2Generator : Int -> Random.Generator (List Elm.Declaration)
customTypeVariant2Generator index =
    let
        typeName =
            "Pair" ++ String.fromInt index

        pairType =
            Elm.Declare.customTypeAdvanced typeName
                { exposeConstructor = True }
                (\empty pair -> { empty = empty, pair = pair })
                |> Elm.Declare.variant0 ("Empty" ++ String.fromInt index) .empty
                |> Elm.Declare.variant2 ("MkPair" ++ String.fromInt index)
                    .pair
                    Type.int
                    Type.string
                |> Elm.Declare.finishCustomType

        -- Exercise make_ with 2 args
        makePairDecl =
            Elm.declaration ("mkPair" ++ String.fromInt index)
                (pairType.make_.pair (Elm.int 1) (Elm.string "hello"))

        -- Exercise case_ with 2-arg pattern
        casePairDecl =
            Elm.declaration ("matchPair" ++ String.fromInt index)
                (pairType.case_
                    (pairType.make_.pair (Elm.int 1) (Elm.string "hello"))
                    { empty = Elm.string "empty"
                    , pair = \n s -> s
                    }
                )
    in
    Random.constant
        [ pairType.declaration
        , makePairDecl
        , casePairDecl
        ]


{-| Use Elm.withType with a namedWith alias to trigger unifyWithAlias.
This exercises the alias type parameter substitution path.
-}
namedTypeAliasGenerator : Int -> Random.Generator (List Elm.Declaration)
namedTypeAliasGenerator index =
    let
        aliasName =
            "Container" ++ String.fromInt index

        -- Define a type alias: type alias Container a = { value : a }
        aliasDef =
            Elm.alias aliasName
                (Type.record
                    [ ( "value", Type.var "a" ) ]
                )

        -- Create a record and annotate it with the parameterized alias
        -- This triggers unifyWithAlias when the annotation is resolved
        valueDecl =
            Elm.declaration ("container" ++ String.fromInt index)
                (Elm.record [ ( "value", Elm.int 42 ) ]
                    |> Elm.withType
                        (Type.namedWith [] aliasName [ Type.int ])
                )

        -- Access a field through the alias — triggers resolveField Typed branch
        fieldDecl =
            Elm.declaration ("containerVal" ++ String.fromInt index)
                (Elm.get "value"
                    (Elm.record [ ( "value", Elm.string "test" ) ]
                        |> Elm.withType
                            (Type.namedWith [] aliasName [ Type.string ])
                    )
                )
    in
    Random.constant [ aliasDef, valueDecl, fieldDecl ]


{-| Force record field unification by passing a record to a function
that expects a record with the same fields in different order.
This triggers unifiableFields in Internal.Compiler.
-}
recordFieldUnifyGenerator : Int -> Random.Generator (List Elm.Declaration)
recordFieldUnifyGenerator index =
    let
        -- Function expects { b : String, a : Int } (b first)
        fnDecl =
            Elm.Declare.fn ("recUnify" ++ String.fromInt index)
                (Elm.Arg.var "rec")
                (\rec ->
                    Elm.get "a"
                        (Elm.withType
                            (Type.record
                                [ ( "b", Type.string )
                                , ( "a", Type.int )
                                ]
                            )
                            rec
                        )
                )

        -- Call it with { a : Int, b : String } (a first)
        callDecl =
            Elm.declaration ("callRecUnify" ++ String.fromInt index)
                (fnDecl.call
                    (Elm.record
                        [ ( "a", Elm.int 1 )
                        , ( "b", Elm.string "hi" )
                        ]
                    )
                )
    in
    Random.constant [ fnDecl.declaration, callDecl ]



{-| Elm.Annotation.extensible — extensible record types.
Exercises the GenericRecord annotation path which is 0% covered.
This is one of the trickiest type features in Elm.
-}
extensibleRecordGenerator : Int -> Random.Generator (List Elm.Declaration)
extensibleRecordGenerator index =
    Random.constant
        [ -- Type alias with extensible record
          Elm.alias ("Named" ++ String.fromInt index)
            (Type.extensible "a"
                [ ( "name", Type.string )
                ]
            )
        , -- Function taking extensible record
          Elm.Declare.fn ("getName" ++ String.fromInt index)
            (Elm.Arg.var "rec")
            (\rec ->
                Elm.get "name"
                    (Elm.withType
                        (Type.extensible "a" [ ( "name", Type.string ) ])
                        rec
                    )
            )
            |> .declaration
        , -- Call it with a concrete record that satisfies the constraint
          Elm.declaration ("gotName" ++ String.fromInt index)
            (Elm.apply
                (Elm.val ("getName" ++ String.fromInt index))
                [ Elm.record
                    [ ( "name", Elm.string "Alice" )
                    , ( "age", Elm.int 30 )
                    ]
                ]
            )
        ]


{-| Elm.fileWith — exercises the alias rendering path and module docs.
We generate a separate file using fileWith with import aliases.
Note: returns as declarations in the main file since we can't nest
files, but the fileWith call itself exercises the code path.
-}
fileWithGenerator : Int -> Random.Generator (List Elm.Declaration)
fileWithGenerator index =
    let
        -- Generate a file using fileWith just to exercise the code path.
        -- We don't use the file itself, just exercise the function.
        _ =
            Elm.fileWith [ "FileWith" ++ String.fromInt index ]
                { docs = "Module generated with fileWith"
                , aliases = [ ( [ "Dict" ], "D" ) ]
                }
                [ Elm.declaration "val" (Elm.int 42)
                    |> Elm.expose
                ]
    in
    -- Return a marker declaration so we know this ran
    Random.constant
        [ Elm.declaration ("fileWithExercised" ++ String.fromInt index) (Elm.bool True) ]


{-| Elm.Arg.list + Elm.Arg.items + Elm.Arg.listRemaining —
list pattern matching in case expressions.
Exercises Internal.Arg.list, items, listRemaining, toUncons.
-}
listPatternGenerator : Int -> Random.Generator (List Elm.Declaration)
listPatternGenerator index =
    Random.constant
        [ -- Match specific list items
          Elm.declaration ("listItems" ++ String.fromInt index)
            (Elm.Case.custom
                (Elm.list [ Elm.int 1, Elm.int 2, Elm.int 3 ])
                (Type.list Type.int)
                [ Elm.Case.branch
                    (Elm.Arg.list identity
                        |> Elm.Arg.items
                            [ Elm.Arg.var "first"
                            , Elm.Arg.var "second"
                            ]
                    )
                    (\items ->
                        case items of
                            [ first, _ ] ->
                                first

                            _ ->
                                Elm.int 0
                    )
                , Elm.Case.branch Elm.Arg.ignore
                    (\_ -> Elm.int 0)
                ]
            )
        , -- Match head :: tail pattern
          Elm.declaration ("listUncons" ++ String.fromInt index)
            (Elm.Case.custom
                (Elm.list [ Elm.string "a", Elm.string "b" ])
                (Type.list Type.string)
                [ Elm.Case.branch
                    (Elm.Arg.list Tuple.pair
                        |> Elm.Arg.items [ Elm.Arg.var "head" ]
                        |> Elm.Arg.listRemaining "tail"
                    )
                    (\( items, tail ) ->
                        case items of
                            [ head ] ->
                                head

                            _ ->
                                Elm.string ""
                    )
                , Elm.Case.branch Elm.Arg.ignore
                    (\_ -> Elm.string "empty")
                ]
            )
        ]


{-| Elm.Op.pipeTo — the advanced pipe that accepts a function builder.
Internally calls functionReduced, so may hit finding #5 annotation bugs.
-}
pipeToGenerator : Int -> Random.Generator (List Elm.Declaration)
pipeToGenerator index =
    Random.constant
        [ Elm.declaration ("pipedTo" ++ String.fromInt index)
            (Elm.string "hello"
                |> Elm.Op.pipeTo
                    (\x ->
                        Elm.Op.append x (Elm.string " world")
                    )
            )
        ]


{-| Elm.Declare.toFile — convert a virtual module to a file.
Exercises the toFile path and virtual module rendering.
We generate the file just to exercise the code but don't use the output.
-}
declareToFileGenerator : Int -> Random.Generator (List Elm.Declaration)
declareToFileGenerator index =
    let
        helperFn =
            Elm.Declare.fn ("toFileHelper" ++ String.fromInt index)
                (Elm.Arg.var "x")
                (\x -> x)

        mod =
            Elm.Declare.module_ [ "Virtual" ++ String.fromInt index ] identity
                |> Elm.Declare.with helperFn

        -- Exercise toFile
        _ =
            Elm.Declare.toFile mod
    in
    Random.constant
        [ Elm.declaration ("toFileExercised" ++ String.fromInt index)
            (Elm.bool True)
        ]



{-| Elm.parse — parse raw Elm source and include as declarations.
This is complex and fragile — the parsed AST goes through
Elm.Processing and exposure resolution.
-}
parseGenerator : Int -> Random.Generator (List Elm.Declaration)
parseGenerator index =
    let
        -- Parse a simple Elm module and extract its declarations
        parsed =
            Elm.parse
                (String.join "\n"
                    [ "module Parsed" ++ String.fromInt index ++ " exposing (..)"
                    , ""
                    , "parsedValue : Int"
                    , "parsedValue = 42"
                    , ""
                    , "parsedFn : Int -> Int"
                    , "parsedFn x = x + 1"
                    ]
                )
    in
    case parsed of
        Ok { declarations } ->
            Random.constant declarations

        Err _ ->
            -- If parse fails, just generate a marker
            Random.constant
                [ Elm.declaration ("parseFailed" ++ String.fromInt index) (Elm.bool False) ]


{-| Declare.customTypeAdvanced with variant3 — 3-arg constructor.
Exercises the variant3 builder and 3-arg pattern matching.
-}
customTypeVariant3Generator : Int -> Random.Generator (List Elm.Declaration)
customTypeVariant3Generator index =
    let
        typeName =
            "Triple" ++ String.fromInt index

        tripleType =
            Elm.Declare.customTypeAdvanced typeName
                { exposeConstructor = True }
                (\empty triple -> { empty = empty, triple = triple })
                |> Elm.Declare.variant0 ("NoTriple" ++ String.fromInt index) .empty
                |> Elm.Declare.variant3 ("MkTriple" ++ String.fromInt index)
                    .triple
                    Type.int
                    Type.string
                    Type.bool
                |> Elm.Declare.finishCustomType

        makeDecl =
            Elm.declaration ("mkTriple" ++ String.fromInt index)
                (tripleType.make_.triple (Elm.int 1) (Elm.string "hi") (Elm.bool True))

        caseDecl =
            Elm.declaration ("matchTriple" ++ String.fromInt index)
                (tripleType.case_
                    (tripleType.make_.triple (Elm.int 1) (Elm.string "hi") (Elm.bool True))
                    { empty = Elm.string "empty"
                    , triple = \a b c -> b
                    }
                )
    in
    Random.constant [ tripleType.declaration, makeDecl, caseDecl ]


{-| Declare.fn5 — 5-arg function builder.
Exercises higher-arity function declaration + call generation.
-}
submoduleGenerator : Int -> Random.Generator (List Elm.Declaration)
submoduleGenerator index =
    let
        declared =
            Elm.Declare.fn5 ("fn5_" ++ String.fromInt index)
                (Elm.Arg.var "a")
                (Elm.Arg.var "b")
                (Elm.Arg.var "c")
                (Elm.Arg.var "d")
                (Elm.Arg.var "e")
                (\a _ _ _ _ -> a)

        callDecl =
            Elm.declaration ("callFn5_" ++ String.fromInt index)
                (declared.call Elm.unit Elm.unit Elm.unit Elm.unit Elm.unit)
    in
    Random.constant [ declared.declaration, callDecl ]


{-| Elm.unsafe — raw code injection. Exercises the Block rendering
path in Internal/Render.elm and Write.elm (prettyDeclaration).
-}
unsafeGenerator : Int -> Random.Generator (List Elm.Declaration)
unsafeGenerator index =
    Random.constant
        [ Elm.unsafe
            ("unsafeVal"
                ++ String.fromInt index
                ++ " : Int\nunsafeVal"
                ++ String.fromInt index
                ++ " = 99"
            )
        ]



-- ============================================================
-- HELPERS
-- ============================================================


fieldName : Int -> String
fieldName i =
    case i of
        0 -> "alpha"
        1 -> "beta"
        2 -> "gamma"
        3 -> "delta"
        4 -> "epsilon"
        5 -> "zeta"
        6 -> "eta"
        _ -> "theta" ++ String.fromInt i


variantName : Int -> Int -> String
variantName typeIndex variantIndex =
    let
        prefix =
            case variantIndex of
                0 -> "Alpha"
                1 -> "Beta"
                2 -> "Gamma"
                _ -> "Delta"
    in
    prefix ++ String.fromInt typeIndex


capitalize : String -> String
capitalize s =
    case String.uncons s of
        Just ( first, rest ) ->
            String.fromChar (Char.toUpper first) ++ rest

        Nothing ->
            s


pickRandom : List a -> Random.Generator a
pickRandom items =
    case items of
        first :: rest ->
            Random.uniform first rest

        [] ->
            pickRandom items


randomList : Int -> Random.Generator a -> Random.Generator (List a)
randomList count gen =
    if count <= 0 then
        Random.constant []

    else
        Random.map2 (::) gen (randomList (count - 1) gen)


randomListIndexed : Int -> (Int -> Random.Generator a) -> Random.Generator (List a)
randomListIndexed count genFn =
    List.range 0 (count - 1)
        |> List.map genFn
        |> combineGenerators


combineGenerators : List (Random.Generator a) -> Random.Generator (List a)
combineGenerators generators =
    case generators of
        [] ->
            Random.constant []

        first :: rest ->
            Random.map2 (::) first (combineGenerators rest)


listLast : List a -> Maybe a
listLast list =
    case list of
        [] ->
            Nothing

        [ x ] ->
            Just x

        _ :: rest ->
            listLast rest
