module Elm.Declare exposing
    ( Function, fn, fn2, fn3, fn4, fn5, fn6
    , fnBuilder, fnArg, fnDone, placeholder
    , Value, value
    , function
    , Module, module_, with, withUnexposed
    , Annotation, alias, customType
    , toFile, include
    , Internal
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
                    (Elm.Arg.var "firstInt")
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
                (add42.call (Elm.int 82))
            ]
        ]

@docs Function, fn, fn2, fn3, fn4, fn5, fn6

@docs fnBuilder, fnArg, fnDone, placeholder

@docs Value, value

@docs function

@docs Module, module_, with, withUnexposed

@docs Annotation, alias, customType

@docs toFile, include

@docs Internal

-}

import Elm exposing (Expression)
import Elm.Annotation
import Elm.Arg
import Internal.Compiler as Compiler
import Internal.Format as Format


{-| -}
type alias Module val =
    { name : List String
    , declarations : List Elm.Declaration
    , call : val
    }


{-| -}
type alias Annotation =
    { annotation : Elm.Annotation.Annotation
    , declaration : Elm.Declaration
    , internal : Internal Elm.Annotation.Annotation
    }


{-| -}
type alias Function tipe =
    { call : tipe
    , value : Elm.Expression
    , declaration : Elm.Declaration
    , internal : Internal tipe
    }


{-| -}
type alias Value =
    { value : Elm.Expression
    , declaration : Elm.Declaration
    , internal : Internal Elm.Expression
    }


{-| -}
type Internal val
    = Internal (List String -> val)


{-| -}
module_ : List String -> val -> Module val
module_ name call =
    { name = name
    , call = call
    , declarations = []
    }


{-| -}
alias : String -> Elm.Annotation.Annotation -> Annotation
alias name annotation =
    { annotation = Elm.Annotation.named [] name
    , declaration = Elm.alias name annotation
    , internal = Internal (\mod -> Elm.Annotation.named mod name)
    }


{-| -}
customType : String -> List Elm.Variant -> Annotation
customType name variants =
    { annotation = Elm.Annotation.named [] name
    , declaration = Elm.customType name variants
    , internal = Internal (\mod -> Elm.Annotation.named mod name)
    }


{-| -}
with : { a | declaration : Elm.Declaration, internal : Internal required } -> Module (required -> val) -> Module val
with decl mod =
    let
        (Internal call) =
            decl.internal
    in
    { name = mod.name
    , declarations = decl.declaration :: mod.declarations
    , call = mod.call (call mod.name)
    }


{-| -}
withUnexposed : { a | declaration : Elm.Declaration } -> Module val -> Module val
withUnexposed { declaration } mod =
    { mod | declarations = declaration :: mod.declarations }


{-| -}
fn :
    String
    -> Elm.Arg.Arg value
    -> (value -> Expression)
    -> Function (Expression -> Expression)
fn name one toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnDone


{-| -}
fn2 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> (one -> two -> Expression)
    -> Function (Expression -> Expression -> Expression)
fn2 name one two toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnArg two
        |> fnDone


{-| -}
fn3 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> (one -> two -> three -> Expression)
    -> Function (Expression -> Expression -> Expression -> Expression)
fn3 name one two three toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnArg two
        |> fnArg three
        |> fnDone


{-| -}
fn4 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> (one -> two -> three -> four -> Expression)
    -> Function (Expression -> Expression -> Expression -> Expression -> Expression)
fn4 name one two three four toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnArg two
        |> fnArg three
        |> fnArg four
        |> fnDone


{-| -}
fn5 :
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> Elm.Arg.Arg five
    -> (one -> two -> three -> four -> five -> Expression)
    -> Function (Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
fn5 name one two three four five toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnArg two
        |> fnArg three
        |> fnArg four
        |> fnArg five
        |> fnDone


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
    -> Function (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression)
fn6 name one two three four five six toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnArg two
        |> fnArg three
        |> fnArg four
        |> fnArg five
        |> fnArg six
        |> fnDone


{-| -}
fnBuilder :
    String
    -> res
    ->
        { name : String
        , builder : Elm.Fn res
        , call : Expression -> List Expression -> Expression
        }
fnBuilder name fun =
    { name = name
    , builder = Elm.fnBuilder fun
    , call = \expr args -> Elm.apply expr (List.reverse args)
    }


{-| -}
fnArg :
    Elm.Arg.Arg arg
    ->
        { name : String
        , builder : Elm.Fn (arg -> value)
        , call : Expression -> List Expression -> e
        }
    ->
        { name : String
        , builder : Elm.Fn value
        , call : Expression -> List Expression -> Expression -> e
        }
fnArg arg builder =
    { name = builder.name
    , builder = builder.builder |> Elm.fnArg arg
    , call = \expr args p -> builder.call expr (p :: args)
    }


{-| -}
fnBody :
    (args -> Expression)
    ->
        { name : String
        , builder : Elm.Fn args
        , call : Expression -> List Expression -> res
        }
    -> Function res
fnBody renderer builder =
    innerFunction builder.name
        (Elm.body renderer builder.builder)
        (\expr -> builder.call expr [])


{-| -}
fnDone :
    { name : String
    , builder : Elm.Fn Expression
    , call : Expression -> List Expression -> res
    }
    -> Function res
fnDone builder =
    innerFunction builder.name
        (Elm.fnDone builder.builder)
        (\expr -> builder.call expr [])


{-| -}
function :
    String
    -> List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Expression -> Expression)
    -> Function (List Expression -> Expression)
function name params toExp =
    innerFunction name (Elm.function params toExp) Elm.apply


innerFunction :
    String
    -> Expression
    -> (Expression -> tipe)
    -> Function tipe
innerFunction name funcExp call =
    { value = Elm.val name
    , call = call (Elm.val name)
    , declaration = Elm.declaration name funcExp
    , internal =
        Internal
            (\modName ->
                call
                    (Elm.value
                        { importFrom = modName
                        , name = Format.sanitize name
                        , annotation = Nothing
                        }
                    )
            )
    }


{-| -}
value :
    String
    -> Elm.Expression
    -> Value
value name expression =
    { value = Elm.val name
    , declaration = Elm.declaration name expression
    , internal =
        Internal
            (\modName ->
                Elm.value
                    { importFrom = modName
                    , name = name
                    , annotation = Nothing
                    }
            )
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


{-| -}
toFile : Module val -> Elm.File
toFile mod =
    Elm.file mod.name
        (List.reverse mod.declarations)


{-| -}
include : { title : String, docs : String } -> Module val -> Elm.Declaration
include docs mod =
    Compiler.Group
        { title = docs.title
        , docs = docs.docs
        , decls = mod.declarations
        }
