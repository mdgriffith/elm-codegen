module Pattern exposing (suite)

import Elm exposing (Expression)
import Elm.Annotation as Type exposing (Annotation)
import Elm.Case
import Elm.Expect
import Elm.Let
import Elm.Op
import Elm.Pattern as Pattern
import Elm.ToString
import Expect
import Gen.Maybe
import Gen.String
import Internal.Compiler as Compiler
import Internal.Index as Index
import Set
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Case expressions"
        [ test "Simple" <|
            \() ->
                Elm.Expect.renderedAs
                    (Elm.Case.maybe Elm.nothing
                        { nothing = Elm.unit
                        , just = ( "_", \_ -> Elm.unit )
                        }
                    )
                    """case Nothing of
    Nothing ->
        ()

    Just __1 ->
        ()"""
        , test "Nothing with uncons" <|
            \() ->
                let
                    inner : Elm.Case.Branch
                    inner =
                        Pattern.initSequence
                            (\_ _ ->
                                Elm.unit
                            )
                            |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                            |> Pattern.toUncons (Pattern.var "rest") Type.unit
                            |> Elm.Case.patternToBranch identity

                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.list
                                [ Elm.nothing
                                , Elm.string "hello" |> Elm.just
                                ]
                            )
                            Type.unit
                            [ inner
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case [ Nothing, Just "hello" ] of
    Nothing :: rest ->
        ()"""
        , test "list pattern" <|
            \() ->
                let
                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.list
                                [ Elm.nothing
                                , Elm.string "hello" |> Elm.just
                                ]
                            )
                            Type.unit
                            [ Pattern.initSequence
                                (\left () ->
                                    left
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.initSequence
                                (\() right ->
                                    right
                                )
                                |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.initSequence
                                (\left right ->
                                    -- TODO this causes an issue because the `Index.startIndex` is hardcoded
                                    --    Elm.Op.append left right
                                    Elm.string "todo"
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toListPattern
                                |> Elm.Case.patternToBranch identity
                            , Pattern.initSequence
                                (\left right rest ->
                                    Elm.Op.append
                                        (Elm.Op.append left right)
                                        (Elm.string "And there's more!")
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toUncons (Pattern.var "rest") (Type.maybe Type.string)
                                |> Elm.Case.patternToBranch identity
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case [ Nothing, Just "hello" ] of
    [ Nothing, (Just left) ] ->
        left

    [ (Just right), Nothing ] ->
        right

    [ (Just right), (Just left) ] ->
        "todo"

    (Just left) :: (Just right) :: rest ->
        (left ++ right) ++ "And there's more!\""""
        , test "tuple destructuring" <|
            \() ->
                let
                    expression : Elm.Expression
                    expression =
                        Elm.Case.custom
                            (Elm.tuple
                                (Elm.just (Elm.int 1))
                                (Elm.just (Elm.int 2))
                            )
                            (Type.maybe Type.int)
                            [ Pattern.tuple
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.int 1)
                                    |> Pattern.buildCustom
                                )
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.int 2)
                                    |> Pattern.buildCustom
                                )
                                |> Elm.Case.patternToBranch
                                    (\( left, right ) ->
                                        Elm.int (left + right)
                                    )
                            , Pattern.tuple
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.var "left")
                                    |> Pattern.buildCustom
                                )
                                (Pattern.initCustom
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.customWithParam (Pattern.var "right")
                                    |> Pattern.buildCustom
                                )
                                |> Elm.Case.patternToBranch
                                    (\( left, right ) ->
                                        Elm.Op.plus left right
                                    )
                            , Elm.Case.otherwise (\_ -> Elm.int 0)
                            ]
                in
                Elm.Expect.renderedAs
                    expression
                    """case ( Just 1, Just 2 ) of
    ( Just 1, Just 2 ) ->
        3

    ( Just left, Just right ) ->
        left + right

    otherwise_1_0 ->
        0"""
        , test "triple" <|
            \() ->
                Elm.Case.custom (Elm.val "foo")
                    Type.unit
                    [ Pattern.triple Pattern.unit (Pattern.var "name") (Pattern.int 123)
                        |> Elm.Case.patternToBranch
                            (\( (), name, literalInt ) ->
                                Elm.unit
                            )
                    ]
                    |> renderedAs
                        """
case foo of
    ( (), name, 123 ) ->
        ()
"""
        , test "record destructure" <|
            \() ->
                Elm.Case.custom
                    (Elm.record
                        [ ( "first", Elm.string "Jane" )
                        , ( "last", Elm.string "Doe" )
                        ]
                    )
                    Type.unit
                    [ Pattern.initRecordDestructure
                        (\first last ->
                            Elm.Op.append first last
                        )
                        |> Pattern.withField "first"
                        |> Pattern.withField "last"
                        |> Pattern.buildRecordDestructure
                        |> Elm.Case.patternToBranch identity
                    ]
                    |> renderedAs
                        """
case { first = "Jane", last = "Doe" } of
    { first, last } ->
        first ++ last
"""
        , test "record in a let binding" <|
            \() ->
                Elm.Let.letIn
                    (\( first, last ) ->
                        Elm.Op.append first last
                    )
                    |> Elm.Let.destructure
                        (Pattern.initRecordDestructure Tuple.pair
                            |> Pattern.withField "first"
                            |> Pattern.withField "last"
                            |> Pattern.buildRecordDestructure
                        )
                        (Elm.record
                            [ ( "first", Elm.string "Jane" )
                            , ( "last", Elm.string "Doe" )
                            ]
                        )
                    |> Elm.Let.toExpression
                    |> renderedAs
                        """
let
    { first, last } =
        { first = "Jane", last = "Doe" }
in
first ++ last
"""
        , test "record destructure with as alias" <|
            \() ->
                Elm.Case.custom
                    (Elm.record
                        [ ( "first", Elm.string "Jane" )
                        , ( "last", Elm.string "Doe" )
                        ]
                    )
                    Type.unit
                    [ Pattern.initRecordDestructure Tuple.pair
                        |> Pattern.withField "first"
                        |> Pattern.withField "last"
                        |> Pattern.buildRecordDestructure
                        |> Pattern.aliasAs "record"
                            (\record ( first, last ) ->
                                Elm.tuple record
                                    (Elm.Op.append first last)
                            )
                        |> Elm.Case.patternToBranch identity
                    ]
                    |> renderedAs
                        """
case { first = "Jane", last = "Doe" } of
    { first, last } as record ->
        ( record, first ++ last )
"""
        , test "custom type helpers" <|
            \() ->
                Elm.Case.custom
                    Elm.nothing
                    Type.unit
                    [ Pattern.variant1 "Just"
                        (Pattern.int 1)
                        |> Elm.Case.patternToBranch
                            (\_ ->
                                Elm.string "There is 1 item"
                            )
                    , Pattern.variant1 "Just"
                        (Pattern.var "n")
                        |> Elm.Case.patternToBranch
                            (\n ->
                                Elm.Op.append
                                    (Elm.Op.append
                                        (Elm.string "There are ")
                                        (Gen.String.call_.fromInt n)
                                    )
                                    (Elm.string " items")
                            )
                    , Pattern.variant0 "Nothing"
                        |> Elm.Case.patternToBranch
                            (\() ->
                                Elm.string "Oh, it's nothing."
                            )
                    ]
                    |> renderedAs
                        """
case Nothing of
    Just 1 ->
        "There is 1 item"

    Just n ->
        ("There are " ++ String.fromInt n) ++ " items"

    Nothing ->
        "Oh, it's nothing."
"""
        , describe "literal patterns"
            [ test "unit" <|
                \() ->
                    Elm.Case.custom Elm.unit
                        Type.unit
                        [ Pattern.unit
                            |> Elm.Case.patternToBranch
                                (\() ->
                                    Elm.unit
                                )
                        ]
                        |> renderedAs
                            """
case () of
    () ->
        ()
"""
            , test "string" <|
                \() ->
                    Elm.Case.custom (Elm.string "Hi!")
                        Type.unit
                        [ Pattern.string "Hi!"
                            |> Elm.Case.patternToBranch
                                (\_ ->
                                    Elm.string "Hello to you!"
                                )
                        , Pattern.ignore
                            |> Elm.Case.patternToBranch
                                (\() ->
                                    Elm.string "Excuse me?"
                                )
                        ]
                        |> renderedAs
                            """
case "Hi!" of
    "Hi!" ->
        "Hello to you!"

    _ ->
        "Excuse me?"
"""
            , test "char" <|
                \() ->
                    Elm.Case.custom (Elm.char 'z')
                        Type.unit
                        [ Pattern.char 'z'
                            |> Elm.Case.patternToBranch
                                (\_ ->
                                    Elm.int 26
                                )
                        , Pattern.ignore
                            |> Elm.Case.patternToBranch
                                (\() ->
                                    Elm.int 0
                                )
                        ]
                        |> renderedAs
                            """
case 'z' of
    'z' ->
        26

    _ ->
        0
"""
            ]
        , describe "imports"
            [ test "let destructure" <|
                \() ->
                    Elm.Let.letIn (\myThing -> myThing)
                        |> Elm.Let.destructure (Pattern.var "myThing")
                            (Elm.record
                                [ ( "foo"
                                  , Elm.string "foo" |> Elm.just |> Gen.Maybe.map fromString
                                  )
                                ]
                            )
                        |> Elm.Let.toExpression
                        |> expectImports
                            [ [ "Maybe" ]
                            , [ "QueryParams" ]
                            ]
            ]
        ]


expectImports :
    List (List String)
    -> Compiler.Expression
    -> Expect.Expectation
expectImports expectedImports expression =
    expression
        |> Compiler.toExpressionDetails Index.startIndex
        |> Tuple.second
        |> Compiler.getImports
        |> List.filter (not << List.isEmpty)
        |> Set.fromList
        |> Expect.equal (Set.fromList expectedImports)


fromString =
    \fromStringArg ->
        Elm.apply
            (Elm.value
                { importFrom = [ "QueryParams" ]
                , name = "fromString"
                , annotation =
                    Just
                        (Type.function
                            [ Type.string ]
                            (Type.namedWith [] "QueryParams" [])
                        )
                }
            )
            [ fromStringArg ]


renderedAs : String -> Expression -> Expect.Expectation
renderedAs expected actual =
    (Elm.ToString.expression actual
        |> .body
    )
        |> Expect.equal
            (String.trim expected)
