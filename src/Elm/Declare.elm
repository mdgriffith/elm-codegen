module Elm.Declare exposing
    ( Decl, fn, fn2, fn3, fn4, fn5, fn6
    , value
    , function
    , Module, module_
    , with, placeholder
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

@docs Decl, fn, fn2, fn3, fn4, fn5, fn6

@docs value

@docs function

@docs Module, module_

@docs with, placeholder, alias

-}

import Elm exposing (Expression)
import Elm.Annotation
import Elm.Arg
import Elm.Syntax.Expression as Exp
import Elm.Syntax.ModuleName as ModuleName
import Internal.Compiler as Compiler
import Internal.Format as Format


type alias Module val =
    { name : List String
    , declarations : List Elm.Declaration
    , call : val
    }


{-| -}
module_ : List String -> val -> Module val
module_ name call =
    { name = name
    , call = call
    , declarations = []
    }


{-| -}
alias : String -> Elm.Annotation.Annotation -> Module (Elm.Annotation.Annotation -> val) -> Module val
alias name annotation mod =
    { name = mod.name
    , declarations = Elm.alias name annotation :: mod.declarations
    , call = mod.call (Elm.Annotation.var name)
    }


{-| -}
with : Decl required -> Module (required -> val) -> Module val
with decl mod =
    { name = mod.name
    , declarations = decl.declaration :: mod.declarations
    , call = mod.call (decl.call mod.name)
    }


type alias Decl value =
    { declaration : Elm.Declaration
    , call : List String -> value
    , value : List String -> Expression
    }


{-| -}
fn :
    String
    -> Elm.Arg.Arg value
    -> (value -> Expression)
    -> Decl (Expression -> Expression)
fn name one toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.fnDone
    in
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
fn2 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> (one -> two -> Expression)
    -> Decl (Expression -> Expression -> Expression)
fn2 name one two toExp =
    let
        funcExp : Expression
        funcExp =
            -- Elm.fn2 one two toExp
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.arg two
                |> Elm.fnDone
    in
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne argTwo ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                , argTwo
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
fn3 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> (one -> two -> three -> Expression)
    -> Decl (Expression -> Expression -> Expression -> Expression)
fn3 name one two three toExp =
    let
        funcExp : Expression
        funcExp =
            -- Elm.fn3 one two three toExp
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.arg two
                |> Elm.arg three
                |> Elm.fnDone
    in
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne argTwo argThree ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                , argTwo
                , argThree
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
fn4 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> (one -> two -> three -> four -> Expression)
    -> Decl (Expression -> Expression -> Expression -> Expression -> Expression)
fn4 name one two three four toExp =
    let
        funcExp : Expression
        funcExp =
            -- Elm.fn4 one two three four toExp
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.arg two
                |> Elm.arg three
                |> Elm.arg four
                |> Elm.fnDone
    in
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne argTwo argThree argFour ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                , argTwo
                , argThree
                , argFour
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
fn5 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> Elm.Arg.Arg five
    -> (one -> two -> three -> four -> five -> Expression)
    -> Decl (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
fn5 name one two three four five toExp =
    let
        funcExp : Expression
        funcExp =
            -- Elm.fn5 one two three four five toExp
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.arg two
                |> Elm.arg three
                |> Elm.arg four
                |> Elm.arg five
                |> Elm.fnDone
    in
    -- innerFunction name funcExp <|
    --     \call argOne argTwo argThree argFour argFive ->
    --         call [ argOne, argTwo, argThree, argFour, argFive ]
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne argTwo argThree argFour argFive ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                , argTwo
                , argThree
                , argFour
                , argFive
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
fn6 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> Elm.Arg.Arg five
    -> Elm.Arg.Arg six
    -> (one -> two -> three -> four -> five -> six -> Expression)
    -> Decl (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
fn6 name one two three four five six toExp =
    let
        funcExp : Expression
        funcExp =
            -- Elm.fn6 one two three four five six toExp
            Elm.fnBuilder toExp
                |> Elm.arg one
                |> Elm.arg two
                |> Elm.arg three
                |> Elm.arg four
                |> Elm.arg five
                |> Elm.arg six
                |> Elm.fnDone
    in
    -- innerFunction name funcExp <|
    --     \call argOne argTwo argThree argFour argFive argSix ->
    -- call [ argOne, argTwo, argThree, argFour, argFive, argSix ]
    { declaration = Elm.declaration name funcExp
    , call =
        \modName argOne argTwo argThree argFour argFive argSix ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                [ argOne
                , argTwo
                , argThree
                , argFour
                , argFive
                , argSix
                ]
    , value = \modName -> toValueFrom modName name funcExp
    }


{-| -}
function :
    String
    -> List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Expression -> Expression)
    ->
        { declaration : Elm.Declaration
        , call : List String -> List Expression -> Expression
        , value : List String -> Expression
        }
function name params toExp =
    let
        funcExp : Expression
        funcExp =
            Elm.function params toExp
    in
    -- innerFunction name funcExp identity
    { declaration = Elm.declaration name funcExp
    , call =
        \modName args ->
            Elm.apply
                (Elm.value
                    { importFrom = modName
                    , name = Format.sanitize name
                    , annotation = Nothing
                    }
                )
                args
    , value = \modName -> toValueFrom modName name funcExp
    }


toValueFrom : ModuleName.ModuleName -> String -> Expression -> Expression
toValueFrom importFrom name funcExp =
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


{-| -}
value :
    String
    -> Elm.Expression
    -> Decl Elm.Expression
value name expression =
    let
        declaration_ :
            { declaration : Elm.Declaration
            , call : List String -> List Elm.Expression -> Elm.Expression
            , value : List String -> Elm.Expression
            }
        declaration_ =
            function name [] (\_ -> expression)
    in
    { declaration = declaration_.declaration
    , call = \from -> declaration_.call from []
    , value = \from -> declaration_.call from []
    }


{-| You may want a placeholder function body if you're defining a function using `Declare` with the intention of _calling_ the function instead of defining it.

In that case you can use `placeholder`!

Of note, if you generate the actual body of `placeholder`, it'll generate `Debug.todo "Placeholder function body"`.

-}
placeholder : Elm.Expression
placeholder =
    Elm.apply
        (Elm.value
            { importFrom = [ "Debug" ]
            , name = "todo"
            , annotation = Just (Elm.Annotation.var "a")
            }
        )
        [ Elm.string "Placeholder function body" ]
