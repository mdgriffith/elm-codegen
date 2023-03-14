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
                        Pattern.sequence
                            (\_ _ ->
                                Elm.unit
                            )
                            |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                            |> Pattern.toUncons (Pattern.var "rest") Type.unit
                            |> Elm.Case.fromPattern

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
                            [ Pattern.sequence
                                (\left () ->
                                    left
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                                |> Pattern.toListPattern
                                |> Elm.Case.fromPattern
                            , Pattern.sequence
                                (\() right ->
                                    right
                                )
                                |> Pattern.addToSequence (Pattern.variant0 "Nothing")
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toListPattern
                                |> Elm.Case.fromPattern
                            , Pattern.sequence
                                (\left right ->
                                    -- TODO this causes an issue because the `Index.startIndex` is hardcoded
                                    --    Elm.Op.append left right
                                    Elm.string "todo"
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toListPattern
                                |> Elm.Case.fromPattern
                            , Pattern.sequence
                                (\left right rest ->
                                    Elm.Op.append
                                        (Elm.Op.append left right)
                                        (Elm.string "And there's more!")
                                )
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "left"))
                                |> Pattern.addToSequence (Pattern.variant1 "Just" (Pattern.var "right"))
                                |> Pattern.toUncons (Pattern.var "rest") (Type.maybe Type.string)
                                |> Elm.Case.fromPattern
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
                                (Pattern.customType
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.withVariantParam (Pattern.int 1)
                                    |> Pattern.buildCustomType
                                )
                                (Pattern.variant1 "Just" (Pattern.int 2))
                                |> Pattern.map
                                    (\( left, right ) ->
                                        Elm.int (left + right)
                                    )
                                |> Elm.Case.fromPattern
                            , Pattern.tuple
                                (Pattern.customType
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.withVariantParam (Pattern.var "left")
                                    |> Pattern.buildCustomType
                                )
                                (Pattern.customType
                                    (\literalInt -> literalInt)
                                    "Just"
                                    |> Pattern.withVariantParam (Pattern.var "right")
                                    |> Pattern.buildCustomType
                                )
                                |> Pattern.map
                                    (\( left, right ) ->
                                        Elm.Op.plus left right
                                    )
                                |> Elm.Case.fromPattern
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
                        |> Pattern.map
                            (\( (), name, literalInt ) ->
                                Elm.unit
                            )
                        |> Elm.Case.fromPattern
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
                    [ Pattern.record2
                        (\first last ->
                            Elm.Op.append first last
                        )
                        "first"
                        "last"
                        |> Elm.Case.fromPattern
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
                        (Pattern.record Tuple.pair
                            |> Pattern.withField "first"
                            |> Pattern.withField "last"
                            |> Pattern.buildRecord
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
                    [ Pattern.record Tuple.pair
                        |> Pattern.withField "first"
                        |> Pattern.withField "last"
                        |> Pattern.buildRecord
                        |> Pattern.aliasAs "record"
                            (\record ( first, last ) ->
                                Elm.tuple record
                                    (Elm.Op.append first last)
                            )
                        |> Elm.Case.fromPattern
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
                        |> Pattern.map
                            (\_ ->
                                Elm.string "There is 1 item"
                            )
                        |> Elm.Case.fromPattern
                    , Pattern.variant1 "Just"
                        (Pattern.var "n")
                        |> Pattern.map
                            (\n ->
                                Elm.Op.append
                                    (Elm.Op.append
                                        (Elm.string "There are ")
                                        (Gen.String.call_.fromInt n)
                                    )
                                    (Elm.string " items")
                            )
                        |> Elm.Case.fromPattern
                    , Pattern.variant0 "Nothing"
                        |> Pattern.map
                            (\() ->
                                Elm.string "Oh, it's nothing."
                            )
                        |> Elm.Case.fromPattern
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
                            |> Pattern.map
                                (\() ->
                                    Elm.unit
                                )
                            |> Elm.Case.fromPattern
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
                            |> Pattern.map
                                (\_ ->
                                    Elm.string "Hello to you!"
                                )
                            |> Elm.Case.fromPattern
                        , Pattern.ignore
                            |> Pattern.map
                                (\() ->
                                    Elm.string "Excuse me?"
                                )
                            |> Elm.Case.fromPattern
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
                            |> Pattern.map
                                (\_ ->
                                    Elm.int 26
                                )
                            |> Elm.Case.fromPattern
                        , Pattern.ignore
                            |> Pattern.map
                                (\() ->
                                    Elm.int 0
                                )
                            |> Elm.Case.fromPattern
                        ]
                        |> renderedAs
                            """
case 'z' of
    'z' ->
        26

    _ ->
        0
"""
            , test "list pattern helpers" <|
                \() ->
                    Elm.Case.custom (Elm.list [])
                        Type.unit
                        [ Pattern.list0
                            (Elm.string "Zero")
                            |> Elm.Case.fromPattern
                        , Pattern.list1 (\item -> item)
                            (Pattern.var "item")
                            |> Elm.Case.fromPattern
                        , Pattern.list2
                            (\item1 item2 ->
                                Elm.Op.append item1 item2
                            )
                            (Pattern.var "item1")
                            (Pattern.var "item2")
                            |> Elm.Case.fromPattern
                        , Pattern.ignore
                            |> Pattern.map
                                (\() ->
                                    Elm.string "Other"
                                )
                            |> Elm.Case.fromPattern
                        ]
                        |> renderedAs
                            """
case [] of
    [] ->
        "Zero"

    [ item ] ->
        item

    [ item1, item2 ] ->
        item1 ++ item2

    _ ->
        "Other"
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
