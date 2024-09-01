module Declare exposing (makeAndCaseGeneration, makeAndCaseGenerationFullyDynamic, suite)

{-| -}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Declare
import Elm.Expect
import Elm.Op
import Expect
import Gen.Debug
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
        ]


newStyleTest : Test
newStyleTest =
    describe "New style"
        [ test "usage" <|
            \_ ->
                Elm.Expect.renderedAs inner
                    """\\( a, b ) c -> ( a, b, c )"""
        , test "fnDone == body" <|
            \_ -> Elm.Expect.equal inner innerViaBody
        , test "declaration" <|
            \_ ->
                Elm.Expect.declarationAs newStyle.declaration
                    (String.trim """

name : ( a, b ) -> c -> ( a, b, c )
name ( a, b ) c =
    ( a, b, c )""")
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
                Elm.Expect.declarationAs myFn.declaration
                    """
                    myFn : Int -> Int
                    myFn myInt =
                        5 + myInt
                    """
        , test "Call correctly" <|
            \_ ->
                Elm.Expect.declarationAs
                    (Elm.declaration "mySweetNumber"
                        (myFn.call (Elm.int 82))
                    )
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
            Elm.Expect.declarationAs
                (Elm.alias "MyAlias"
                    (Type.record
                        [ ( "one", Type.var "oneVar" )
                        , ( "two", Type.var "twoVar" )
                        , ( "three", Type.var "threeVar" )
                        ]
                    )
                )
                """
                type alias MyAlias oneVar twoVar threeVar =
                    { one : oneVar, two : twoVar, three : threeVar }
                """


aliasWithTest : Test
aliasWithTest =
    test "Elm.aliasWith" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.aliasWith "MyAlias"
                    [ "twoVar", "nonexistingVar", "oneVar" ]
                    (Type.record
                        [ ( "one", Type.var "oneVar" )
                        , ( "two", Type.var "twoVar" )
                        , ( "three", Type.var "threeVar" )
                        ]
                    )
                )
                """
                type alias MyAlias twoVar oneVar threeVar =
                    { one : oneVar, two : twoVar, three : threeVar }
                """


customTypeTest : Test
customTypeTest =
    test "Elm.customType" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.customType "MyType"
                    [ Elm.variantWith "One"
                        [ Type.var "oneVar" ]
                    , Elm.variantWith "Two"
                        [ Type.var "twoVar" ]
                    ]
                )
                """
                type MyType oneVar twoVar
                    = One oneVar
                    | Two twoVar
                """


customTypeWithTest : Test
customTypeWithTest =
    test "Elm.customTypeWith" <|
        \_ ->
            Elm.Expect.declarationAs
                (Elm.customTypeWith "MyType"
                    [ "addVar", "twoVar" ]
                    [ Elm.variantWith "One"
                        [ Type.var "oneVar" ]
                    , Elm.variantWith "Two"
                        [ Type.var "twoVar" ]
                    ]
                )
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
                    Elm.Expect.declarationAs maybe.declaration
                        """
                        type Maybe a
                            = Nothing
                            | Just a
                        """
                , \_ ->
                    Elm.Expect.renderedAs
                        maybe.make_.nothing
                        "Nothing"
                , \_ ->
                    Elm.Expect.renderedAs
                        (maybe.make_.just Elm.unit)
                        "Just ()"
                , \_ ->
                    Elm.Expect.renderedAs
                        (maybe.case_ (Elm.val "a")
                            { just = \a -> a
                            , nothing = Elm.string ""
                            }
                        )
                        """
                        case a of
                            Nothing ->
                                ""

                            Just arg0 ->
                                arg0
                        """
                , \_ ->
                    Elm.Expect.renderedAs
                        external.call.maybe.make_.nothing
                        "MyMaybe.Nothing"
                , \_ ->
                    Elm.Expect.renderedAs
                        (external.call.maybe.make_.just Elm.unit)
                        "MyMaybe.Just ()"
                , \_ ->
                    Elm.Expect.renderedAs
                        (external.call.maybe.case_ (Elm.val "a")
                            { just = \a -> a
                            , nothing = Elm.string ""
                            }
                        )
                        """
                        case a of
                            MyMaybe.Nothing ->
                                ""

                            MyMaybe.Just arg0 ->
                                arg0
                        """
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
                    Elm.Expect.declarationAs semaphore.declaration
                        """
                        type Semaphore
                            = Red
                            | Yellow
                            | Green
                        """
                , \_ ->
                    Elm.Expect.renderedAs
                        (semaphore.make_ "Red")
                        "Red"
                , \_ ->
                    Elm.Expect.renderedAs
                        (semaphore.make_ "Yellow")
                        "Yellow"
                , \_ ->
                    Elm.Expect.renderedAs
                        (semaphore.make_ "Green")
                        "Green"
                , \_ ->
                    Elm.Expect.renderedAs
                        (semaphore.case_ (Elm.val "a")
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
                        )
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
                    Elm.Expect.renderedAs
                        (external.call.make_ "Red")
                        "Semaphore.Red"
                , \_ ->
                    Elm.Expect.renderedAs
                        (external.call.make_ "Yellow")
                        "Semaphore.Yellow"
                , \_ ->
                    Elm.Expect.renderedAs
                        (external.call.make_ "Green")
                        "Semaphore.Green"
                , \_ ->
                    Elm.Expect.renderedAs
                        (external.call.case_ (Elm.val "a")
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
                        )
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
