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
        -- Let.unpack with tuple destructuring
        (letUnpackGenerator baseIndex)
        -- Expression-level fn2/fn3 (not Declare.fn2)
        (exprLambdaGenerator baseIndex)
        -- Expose + exposeConstructor
        (exposedDeclGenerator baseIndex)
        -- withDocumentation
        (documentedDeclGenerator baseIndex)
        -- Comment declarations
        (Random.constant [ Elm.comment "Generated comment" ])


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
