module Declare exposing (argMap, makeAndCaseGeneration, makeAndCaseGenerationFullyDynamic, suite)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Declare
import Elm.Expect
import Elm.Op
import Expect
import Gen.Basics
import Gen.Debug
import Gen.Maybe
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Elm.Declare"
        [ declarations
        , aliasTest
        , aliasWithTest
        , customTypeTest
        , customTypeWithTest
        , newStyleTest
        , ports
        ]


newStyleTest : Test
newStyleTest =
    describe "New style"
        [ test "usage" <|
            \_ ->
                inner
                    |> Elm.Expect.renderedAs
                        """\\( a, b ) c -> ( a, b, c )"""
        , test "fnDone == body" <|
            \_ ->
                innerViaBody
                    |> Elm.Expect.equal inner
        , test "declaration" <|
            \_ ->
                newStyle.declaration
                    |> Elm.Expect.declarationAs
                        """
                        name : ( a, b ) -> c -> ( a, b, c )
                        name ( a, b ) c =
                            ( a, b, c )
                        """
        ]


inner : Elm.Expression
inner =
    Elm.fnBuilder (\( a, b ) c -> Elm.triple a b c)
        |> Elm.fnArg (Elm.Arg.tuple (Elm.Arg.var "a") (Elm.Arg.var "b"))
        |> Elm.fnArg (Elm.Arg.var "c")
        |> Elm.fnDone


innerViaBody : Elm.Expression
innerViaBody =
    Elm.fnBuilder Tuple.pair
        |> Elm.fnArg (Elm.Arg.tuple (Elm.Arg.var "a") (Elm.Arg.var "b"))
        |> Elm.fnArg (Elm.Arg.var "c")
        |> Elm.body
            (\( ( a, b ), c ) ->
                Elm.triple a b c
            )


newStyle : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
newStyle =
    Elm.Declare.fnBuilder "name" (\( a, b ) c -> Elm.triple a b c)
        |> Elm.Declare.fnArg (Elm.Arg.tuple (Elm.Arg.var "a") (Elm.Arg.var "b"))
        |> Elm.Declare.fnArg (Elm.Arg.var "c")
        |> Elm.Declare.fnDone


myFn : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
myFn =
    Elm.Declare.fn "myFn"
        (Elm.Arg.var "myInt")
        (\num -> Elm.Op.plus (Elm.int 5) num)


declarations : Test
declarations =
    describe "declarations"
        [ test "Basic function dec" <|
            \_ ->
                myFn.declaration
                    |> Elm.Expect.declarationAs
                        """
                        myFn : Int -> Int
                        myFn myInt =
                            5 + myInt
                        """
        , test "Call correctly" <|
            \_ ->
                Elm.declaration "mySweetNumber"
                    (myFn.call (Elm.int 82))
                    |> Elm.Expect.declarationAs
                        """
                        mySweetNumber : Int
                        mySweetNumber =
                            myFn 82
                        """
        ]


aliasTest : Test
aliasTest =
    test "Elm.alias" <|
        \_ ->
            Elm.alias "MyAlias"
                (Type.record
                    [ ( "one", Type.var "oneVar" )
                    , ( "two", Type.var "twoVar" )
                    , ( "three", Type.var "threeVar" )
                    ]
                )
                |> Elm.Expect.declarationAs
                    """
                    type alias MyAlias oneVar twoVar threeVar =
                        { one : oneVar, two : twoVar, three : threeVar }
                    """


aliasWithTest : Test
aliasWithTest =
    test "Elm.aliasWith" <|
        \_ ->
            Elm.aliasWith "MyAlias"
                [ "twoVar", "nonexistingVar", "oneVar" ]
                (Type.record
                    [ ( "one", Type.var "oneVar" )
                    , ( "two", Type.var "twoVar" )
                    , ( "three", Type.var "threeVar" )
                    ]
                )
                |> Elm.Expect.declarationAs
                    """
                    type alias MyAlias twoVar oneVar threeVar =
                        { one : oneVar, two : twoVar, three : threeVar }
                    """


customTypeTest : Test
customTypeTest =
    test "Elm.customType" <|
        \_ ->
            Elm.customType "MyType"
                [ Elm.variantWith "One"
                    [ Type.var "oneVar" ]
                , Elm.variantWith "Two"
                    [ Type.var "twoVar" ]
                ]
                |> Elm.Expect.declarationAs
                    """
                    type MyType oneVar twoVar
                        = One oneVar
                        | Two twoVar
                    """


customTypeWithTest : Test
customTypeWithTest =
    test "Elm.customTypeWith" <|
        \_ ->
            Elm.customTypeWith "MyType"
                [ "addVar", "twoVar" ]
                [ Elm.variantWith "One"
                    [ Type.var "oneVar" ]
                , Elm.variantWith "Two"
                    [ Type.var "twoVar" ]
                ]
                |> Elm.Expect.declarationAs
                    """
                    type MyType addVar twoVar oneVar
                        = One oneVar
                        | Two twoVar
                    """


type alias MyMaybe =
    { maybe :
        { annotation : Type.Annotation
        , case_ :
            Elm.Expression
            ->
                { just : Elm.Expression -> Elm.Expression
                , nothing : Elm.Expression
                }
            -> Elm.Expression
        , make_ :
            { just : Elm.Expression -> Elm.Expression
            , nothing : Elm.Expression
            }
        }
    }


makeAndCaseGeneration : Test
makeAndCaseGeneration =
    test "Elm.Declare.customTypeAdvanced" <|
        \_ ->
            let
                maybe :
                    Elm.Declare.CustomType
                        { just : Elm.Expression -> Elm.Expression
                        , nothing : Elm.Expression
                        }
                maybe =
                    Elm.Declare.customTypeAdvanced "Maybe"
                        { exposeConstructor = True }
                        (\nothing just -> { nothing = nothing, just = just })
                        |> Elm.Declare.variant0 "Nothing" .nothing
                        |> Elm.Declare.variant1 "Just" .just (Type.var "a")
                        |> Elm.Declare.finishCustomType

                external : Elm.Declare.Module MyMaybe
                external =
                    Elm.Declare.module_ [ "MyMaybe" ] MyMaybe
                        |> Elm.Declare.with maybe
            in
            Expect.all
                [ \_ ->
                    maybe.declaration
                        |> Elm.Expect.declarationAs
                            """
                            type Maybe a
                                = Nothing
                                | Just a
                            """
                , \_ ->
                    maybe.make_.nothing
                        |> Elm.Expect.renderedAs "Nothing"
                , \_ ->
                    maybe.make_.just Elm.unit
                        |> Elm.Expect.renderedAs "Just ()"
                , \_ ->
                    maybe.case_ (Elm.val "a")
                        { just = \a -> a
                        , nothing = Elm.string ""
                        }
                        |> Elm.Expect.renderedAs
                            """
                            case a of
                                Nothing ->
                                    ""

                                Just arg0 ->
                                    arg0
                            """
                , \_ ->
                    external.call.maybe.make_.nothing
                        |> Elm.Expect.renderedAs
                            "MyMaybe.Nothing"
                , \_ ->
                    external.call.maybe.make_.just Elm.unit
                        |> Elm.Expect.renderedAs
                            "MyMaybe.Just ()"
                , \_ ->
                    external.call.maybe.case_ (Elm.val "a")
                        { just = \a -> a
                        , nothing = Elm.string ""
                        }
                        |> Elm.Expect.renderedAs
                            """
                            case a of
                                MyMaybe.Nothing ->
                                    ""

                                MyMaybe.Just arg0 ->
                                    arg0
                            """
                ]
                ()


argMap : Test
argMap =
    test "Elm.Arg.map" <|
        \_ ->
            let
                -- myMap : Elm.Declare.Function ((Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression)
                call_myMap =
                    Elm.Declare.fnBuilder "myMap" (\fn maybe -> Gen.Maybe.call_.map fn maybe)
                        |> Elm.Declare.fnArg (Elm.Arg.var "fn")
                        |> Elm.Declare.fnArg (Elm.Arg.var "maybe")
                        |> Elm.Declare.fnDone
            in
            Expect.all
                [ \_ ->
                    Elm.Expect.declarationAs
                        """
                        myMap : (a -> b) -> Maybe a -> Maybe b
                        myMap fn maybe =
                            Maybe.map fn maybe
                        """
                        call_myMap.declaration
                , \_ ->
                    Elm.Expect.renderedAs
                        "myMap Basics.identity Nothing"
                        (call_myMap.call Gen.Basics.values_.identity Gen.Maybe.make_.nothing)
                , \_ ->
                    Elm.Expect.renderedAs
                        "myMap (\\i -> i * i) Nothing"
                        (call_myMap.call (Elm.functionReduced "i" <| \i -> Elm.Op.multiply i i) Gen.Maybe.make_.nothing)
                ]
                ()


makeAndCaseGenerationFullyDynamic : Test
makeAndCaseGenerationFullyDynamic =
    test "Elm.Declare.customTypeAdvanced - fully dynamic" <|
        \_ ->
            let
                semaphore : Elm.Declare.CustomType (String -> Elm.Expression)
                semaphore =
                    List.foldl
                        (\name ->
                            Elm.Declare.customVariant name
                                []
                                (\dict -> dict name)
                                identity
                                (\ctor dict valueName ->
                                    if name == valueName then
                                        ctor []

                                    else
                                        dict valueName
                                )
                        )
                        (Elm.Declare.customTypeAdvanced "Semaphore"
                            { exposeConstructor = True }
                            (\_ -> Elm.unit)
                        )
                        [ "Red", "Yellow", "Green" ]
                        |> Elm.Declare.finishCustomType

                external =
                    Elm.Declare.module_ [ "Semaphore" ] identity
                        |> Elm.Declare.with semaphore
            in
            Expect.all
                [ \_ ->
                    semaphore.declaration
                        |> Elm.Expect.declarationAs
                            """
                            type Semaphore
                                = Red
                                | Yellow
                                | Green
                            """
                , \_ ->
                    semaphore.make_ "Red"
                        |> Elm.Expect.renderedAs "Red"
                , \_ ->
                    semaphore.make_ "Yellow"
                        |> Elm.Expect.renderedAs "Yellow"
                , \_ ->
                    semaphore.make_ "Green"
                        |> Elm.Expect.renderedAs "Green"
                , \_ ->
                    semaphore.case_ (Elm.val "a")
                        (\color ->
                            case color of
                                "Red" ->
                                    Elm.string "Red"

                                "Green" ->
                                    Elm.string "Green"

                                "Yellow" ->
                                    Elm.string "Yellow"

                                _ ->
                                    Gen.Debug.todo "This doesn't happen"
                        )
                        |> Elm.Expect.renderedAs
                            """
                            case a of
                                Red ->
                                    "Red"

                                Yellow ->
                                    "Yellow"

                                Green ->
                                    "Green"
                            """
                , \_ ->
                    external.call.make_ "Red"
                        |> Elm.Expect.renderedAs "Semaphore.Red"
                , \_ ->
                    external.call.make_ "Yellow"
                        |> Elm.Expect.renderedAs "Semaphore.Yellow"
                , \_ ->
                    external.call.make_ "Green"
                        |> Elm.Expect.renderedAs "Semaphore.Green"
                , \_ ->
                    external.call.case_ (Elm.val "a")
                        (\color ->
                            case color of
                                "Red" ->
                                    Elm.string "Red"

                                "Green" ->
                                    Elm.string "Green"

                                "Yellow" ->
                                    Elm.string "Yellow"

                                _ ->
                                    Gen.Debug.todo "This doesn't happen"
                        )
                        |> Elm.Expect.renderedAs
                            """
                            case a of
                                Semaphore.Red ->
                                    "Red"

                                Semaphore.Yellow ->
                                    "Yellow"

                                Semaphore.Green ->
                                    "Green"
                            """
                ]
                ()


ports : Test
ports =
    describe "ports"
        [ test "incoming" <|
            \_ ->
                Elm.portIncoming "receive" Type.int
                    |> Elm.Expect.declarationAs
                        "port receive : (Int -> msg) -> Sub msg"
        , test "outgoing" <|
            \_ ->
                Elm.portOutgoing "send" Type.int
                    |> Elm.Expect.declarationAs
                        "port send : Int -> Cmd msg"
        ]
