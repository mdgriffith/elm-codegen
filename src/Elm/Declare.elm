module Elm.Declare exposing
    ( fn, fn2, fn3, fn4, fn5, fn6
    , value
    , function
    )

{-| You may run into situations where you want to generate a function, and then call that generated function somewhere else.

This module will help you do that.

Here's an example, let's define a new function called `add42`

    renderFile =
        let
            add42 =
                Elm.Declare.fn "add42"
                    ( "firstInt", Nothing )
                    (\firstArgument ->
                        Elm.plus
                            (Elm.int 42)
                            firstArgument
                    )
        in
        Elm.file [ "MyFile" ]
            -- add our declaration to our file
            [ add42.declaration

            -- and another place where we call that function!
            , Elm.declaration "mySweetNumber"
                (add42.call (Elm.int 82))
            ]

Depending on your situation, you may want to define a function in one file, but call it from another.

In that case you can do something like this using `callFrom`:

    renderFileList =
        let
            add42 =
                Elm.Declare.fn "add42"
                    ( "firstInt", Nothing )
                    (\firstArgument ->
                        Elm.plus
                            (Elm.int 42)
                            firstArgument
                    )
        in
        [ Elm.file [ "MyFile" ]
            -- add our declaration to our file
            [ add42.declaration
            ]
        , Elm.file [ "MyOtherFile" ]
            -- and call from another file
            [ Elm.declaration "mySweetNumber"
                (add42.callFrom [ "MyFile" ] (Elm.int 82))
            ]
        ]

@docs fn, fn2, fn3, fn4, fn5, fn6

@docs value

@docs function

-}

import Elm exposing (Declaration, Expression)
import Elm.Annotation
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Internal.Compiler as Compiler
import Internal.Format as Format


{-| -}
fn :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression
        , callFrom : List String -> Expression -> Expression
        , value : List String -> Expression
        }
fn name one toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn one toExp
    in
    innerFunction name funcExp <|
        \call argOne ->
            call [ argOne ]


{-| -}
fn2 :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression -> Expression
        , callFrom : List String -> Expression -> Expression -> Expression
        , value : List String -> Expression
        }
fn2 name one two toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn2 one two toExp
    in
    innerFunction name funcExp <|
        \call argOne argTwo ->
            call [ argOne, argTwo ]


{-| -}
fn3 :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression -> Expression -> Expression
        , callFrom : List String -> Expression -> Expression -> Expression -> Expression
        , value : List String -> Expression
        }
fn3 name one two three toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn3 one two three toExp
    in
    innerFunction name funcExp <|
        \call argOne argTwo argThree ->
            call [ argOne, argTwo, argThree ]


{-| -}
fn4 :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression -> Expression -> Expression -> Expression
        , callFrom : List String -> Expression -> Expression -> Expression -> Expression -> Expression
        , value : List String -> Expression
        }
fn4 name one two three four toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn4 one two three four toExp
    in
    innerFunction name funcExp <|
        \call argOne argTwo argThree argFour ->
            call [ argOne, argTwo, argThree, argFour ]


{-| -}
fn5 :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression -> Expression -> Expression -> Expression -> Expression
        , callFrom : List String -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression
        , value : List String -> Expression
        }
fn5 name one two three four five toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn5 one two three four five toExp
    in
    innerFunction name funcExp <|
        \call argOne argTwo argThree argFour argFive ->
            call [ argOne, argTwo, argThree, argFour, argFive ]


{-| -}
fn6 :
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
    ->
        { declaration : Declaration
        , call : Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression
        , callFrom : List String -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression
        , value : List String -> Expression
        }
fn6 name one two three four five six toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fn6 one two three four five six toExp
    in
    innerFunction name funcExp <|
        \call argOne argTwo argThree argFour argFive argSix ->
            call [ argOne, argTwo, argThree, argFour, argFive, argSix ]


{-| -}
function :
    String
    -> List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Expression -> Expression)
    ->
        { declaration : Declaration
        , call : List Expression -> Expression
        , callFrom : List String -> List Expression -> Expression
        , value : List String -> Expression
        }
function name params toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.function params toExp
    in
    innerFunction name funcExp identity


innerFunction :
    String
    -> Expression
    -> ((List Expression -> Expression) -> a)
    ->
        { declaration : Declaration
        , call : a
        , callFrom : ModuleName.ModuleName -> a
        , value : ModuleName.ModuleName -> Expression
        }
innerFunction name funcExp collectArgs =
    let
        valueFrom : ModuleName.ModuleName -> Expression
        valueFrom importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp : Compiler.ExpressionDetails
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation = fnExp.annotation
                            , imports = fnExp.imports
                            }

        call : ModuleName.ModuleName -> a
        call importFrom =
            collectArgs
                (Elm.apply
                    (valueFrom importFrom)
                )
    in
    { declaration = Elm.declaration name funcExp
    , call = call []
    , callFrom = call
    , value = valueFrom
    }


{-| -}
value :
    String
    -> Elm.Expression
    ->
        { declaration : Elm.Declaration
        , value : Elm.Expression
        , valueFrom : List String -> Elm.Expression
        }
value name expression =
    let
        declaration_ :
            { declaration : Elm.Declaration
            , call : List Elm.Expression -> Elm.Expression
            , callFrom : List String -> List Elm.Expression -> Elm.Expression
            , value : List String -> Elm.Expression
            }
        declaration_ =
            function name [] (\_ -> expression)
    in
    { declaration = declaration_.declaration
    , value = declaration_.call []
    , valueFrom = \from -> declaration_.callFrom from []
    }
