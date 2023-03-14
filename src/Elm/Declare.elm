module Elm.Declare exposing
    ( fn, fn2, fn3, fn4, fn5, fn6
    , topLevelValue
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

@docs topLevelValue

@docs function

-}

import Elm exposing (Declaration, Expression)
import Elm.Annotation
import Elm.Syntax.Expression as Exp
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
        funcExp =
            Elm.fn one toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne =
            Elm.apply
                (value importFrom)
                [ argOne ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


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
        funcExp =
            Elm.fn2 one two toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne argTwo =
            Elm.apply
                (value importFrom)
                [ argOne, argTwo ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


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
        funcExp =
            Elm.fn3 one two three toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne argTwo argThree =
            Elm.apply
                (value importFrom)
                [ argOne, argTwo, argThree ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


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
        funcExp =
            Elm.fn4 one two three four toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne argTwo argThree argFour =
            Elm.apply
                (value importFrom)
                [ argOne, argTwo, argThree, argFour ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


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
        funcExp =
            Elm.fn5 one two three four five toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne argTwo argThree argFour argFive =
            Elm.apply
                (value importFrom)
                [ argOne, argTwo, argThree, argFour, argFive ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


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
        funcExp =
            Elm.fn6 one two three four five six toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom argOne argTwo argThree argFour argFive argSix =
            Elm.apply
                (value importFrom)
                [ argOne, argTwo, argThree, argFour, argFive, argSix ]
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }


{-| -}
topLevelValue :
    String
    -> Elm.Expression
    ->
        { declaration : Elm.Declaration
        , value : Elm.Expression
        , valueFrom : List String -> Elm.Expression
        }
topLevelValue name expression =
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
        funcExp =
            Elm.function params toExp

        value importFrom =
            Compiler.Expression <|
                \index ->
                    case funcExp of
                        Compiler.Expression toFnExp ->
                            let
                                fnExp =
                                    toFnExp index
                            in
                            { expression =
                                -- This *must* be an un-protected name, where we only use
                                -- literally what the dev gives us, because we are trying
                                -- to refer to something that already exists.
                                Exp.FunctionOrValue importFrom
                                    (Format.sanitize name)
                            , annotation =
                                fnExp.annotation
                            , imports =
                                fnExp.imports
                            }

        call importFrom args =
            Elm.apply (value importFrom) args
    in
    { declaration =
        Elm.declaration name
            funcExp
    , call =
        call []
    , callFrom =
        call
    , value =
        value
    }
