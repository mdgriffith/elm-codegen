module Elm.Declare exposing
    ( Function, fn, fn2, fn3, fn4, fn5, fn6
    , withDocumentation
    , fnBuilder, fnArg, fnDone, fnBody, placeholder
    , Value, value
    , function
    , Module, module_, with, withUnexposed
    , Annotation, alias, customType
    , toFile, include, withSubmodule
    , customTypeAdvanced, CustomType
    , variant0, variant1, variant2, variant3, variant4
    , CustomTypeBuilder, customVariant, finishCustomType
    , Internal
    )

{-| You may run into situations where you want to generate a function, and then call that generated function somewhere else.

This module will help you do that.

Here's an example, let's define a new function called `add42`

    import Elm.Arg as Arg
    import Elm.Declare as Declare

    renderFile =
        let
            add42 =
                Declare.fn "add42"
                    (Arg.value "firstInt")
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

@docs Function, fn, fn2, fn3, fn4, fn5, fn6

@docs withDocumentation

@docs fnBuilder, fnArg, fnDone, fnBody, placeholder

@docs Value, value

@docs function


# Virtual Modules

It's very common to have some modules that you both need to _generate_ and _use_ in your generated Elm code.

Here's an example, let's define a new module called `MyModule`:

    import Elm
    import Elm.Annotation
    import Elm.Declare
    import Elm.Op

    type alias MyModule =
        { runCalculation : Elm.Expression -> Elm.Expression
        , myType : Elm.Annotation.Annotation
        }

    myModule =
        Elm.Declare.module_ [ "MyModule" ] MyModule
            |> Elm.Declare.with
                (Elm.Declare.fn "runCalculation"
                    (Elm.Arg.var "input")
                    (\input -> Elm.Op.plus input (Elm.int 42))
                )
            |> Elm.Declare.with
                (Elm.Declare.customType "MyType"
                    [ Elm.variant "One"
                    , Elm.variant "Two"
                    ]
                )

Once we've declared our module, we can do 2 things.

First, we can generate the Elm code for the module:

    Elm.toFile myModule

Or we can include it in another module:

    Elm.file [ "MyInternalFile" ]
        [ Elm.include myModule

        --... Whatever other declarations you want in this file.
        ]

Secondly, we can use the virtual module in our Elm code:

    myModule.call.runCalculation (Elm.int 42)

Which will generate

    MyModule.runCalculation 42

And handle the imports and everything.

@docs Module, module_, with, withUnexposed

@docs Annotation, alias, customType

@docs toFile, include, withSubmodule


## Advanced Custom Types

In some cases you may want to generate a custom type and also have some helpers to

1.  Create an instance of that type
2.  Pattern match on that type

`customTypeAdvanced` is a helper function that will let you do that!

But it does get a little involved, so if you don't need it, trying something simpler may be the way to go.

As an example, here's how to create a helper for the `Maybe` type.

    maybe =
        Elm.Declare.customTypeAdvanced "Maybe"
            { exposeConstructor = True }
            (\nothing just ->
                { nothing = nothing
                , just = just
                }
            )
            |> Elm.Declare.variant0 "Nothing" .nothing
            |> Elm.Declare.variant1 "Just" (Elm.Annotation.var "a") .just
            |> Elm.Declare.finishCustomType

    -- Which then allows you to create an instance of the type via
    maybe.make_.just (Elm.int 42)
    -- Which would generate `Just 42`

    -- And if you want to use it as a case expression, you can do this:

    maybe.case_ (Elm.val "a")
        { just = \a -> a
        , nothing = Elm.string ""
        }

    -- Which would generate
    case a of
       Just a -> a
       Nothing -> ""

@docs customTypeAdvanced, CustomType

@docs variant0, variant1, variant2, variant3, variant4

@docs CustomTypeBuilder, customVariant, finishCustomType


## Internal things

@docs Internal

-}

import Elm exposing (Expression)
import Elm.Annotation
import Elm.Arg
import Elm.Case
import Elm.Syntax.Expression as Exp
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index


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
type alias CustomType make_ =
    { declaration : Elm.Declaration
    , annotation : Elm.Annotation.Annotation
    , make_ : make_
    , case_ : Expression -> make_ -> Expression
    , internal :
        Internal
            { annotation : Elm.Annotation.Annotation
            , make_ : make_
            , case_ : Expression -> make_ -> Expression
            }
    }


{-| -}
type alias Function tipe =
    { call : tipe
    , value : Expression
    , declaration : Elm.Declaration
    , internal : Internal tipe
    }


{-| -}
type alias Value =
    { value : Expression
    , declaration : Elm.Declaration
    , internal : Internal Expression
    }


{-| You can safely ignore this type. It's used internally for some type bookkeeping, but you should never have it in your type signatures or anything.
-}
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
type CustomTypeBuilder case_ make_
    = CustomTypeBuilder
        { exposeConstructor : Bool
        , name : String
        , variants : List Elm.Variant
        , make_ : make_
        , case_ : case_ -> List Elm.Case.Branch
        , internal : Internal make_
        }


{-| -}
customTypeAdvanced : String -> { exposeConstructor : Bool } -> make_ -> CustomTypeBuilder case_ make_
customTypeAdvanced name { exposeConstructor } make_ =
    CustomTypeBuilder
        { exposeConstructor = exposeConstructor
        , name = name
        , variants = []
        , make_ = make_
        , case_ = \_ -> []
        , internal = Internal (\_ -> make_)
        }


{-| -}
finishCustomType : CustomTypeBuilder make_ make_ -> CustomType make_
finishCustomType (CustomTypeBuilder custom) =
    let
        annotation : Elm.Annotation.Annotation
        annotation =
            Elm.Annotation.named [] custom.name

        declaration : Elm.Declaration
        declaration =
            Elm.customType custom.name (List.reverse custom.variants)
    in
    { declaration =
        if custom.exposeConstructor then
            Elm.exposeConstructor declaration

        else
            declaration
    , annotation = annotation
    , make_ = custom.make_
    , case_ =
        \expr case_ ->
            Elm.Case.custom
                expr
                annotation
                (List.reverse (custom.case_ case_))
    , internal =
        Internal
            (\mod ->
                let
                    (Internal internal) =
                        custom.internal

                    externalAnnotation : Elm.Annotation.Annotation
                    externalAnnotation =
                        Elm.Annotation.named mod custom.name
                in
                { annotation = externalAnnotation
                , make_ = internal mod
                , case_ =
                    \expr case_ ->
                        Elm.Case.custom
                            expr
                            externalAnnotation
                            (List.reverse (custom.case_ case_))
                }
            )
    }


{-| -}
variant0 :
    String
    -> (case_ -> Expression)
    -> CustomTypeBuilder case_ (Expression -> make_)
    -> CustomTypeBuilder case_ make_
variant0 name toBranch custom =
    let
        make : (List Expression -> Expression) -> Expression
        make makeValue =
            makeValue []
    in
    standardVariant name [] toBranch identity make custom


{-| -}
variant1 :
    String
    -> (case_ -> (Expression -> Expression))
    -> Elm.Annotation.Annotation
    -> CustomTypeBuilder case_ ((Expression -> Expression) -> make_)
    -> CustomTypeBuilder case_ make_
variant1 name toBranch type0 custom =
    let
        args : Elm.Arg (Expression -> Expression) -> Elm.Arg Expression
        args record =
            record
                |> Elm.Arg.item (Elm.Arg.varWith "arg0" type0)

        make : (List Expression -> Expression) -> Expression -> Expression
        make makeValue arg0 =
            makeValue [ arg0 ]
    in
    standardVariant name [ type0 ] toBranch args make custom


{-| -}
variant2 :
    String
    -> (case_ -> (Expression -> Expression -> Expression))
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> CustomTypeBuilder case_ ((Expression -> Expression -> Expression) -> make_)
    -> CustomTypeBuilder case_ make_
variant2 name toBranch type0 type1 custom =
    let
        args : Elm.Arg (Expression -> Expression -> Expression) -> Elm.Arg Expression
        args record =
            record
                |> Elm.Arg.item (Elm.Arg.varWith "arg0" type0)
                |> Elm.Arg.item (Elm.Arg.varWith "arg1" type1)

        make : (List Expression -> Expression) -> Expression -> Expression -> Expression
        make makeValue arg0 arg1 =
            makeValue [ arg0, arg1 ]
    in
    standardVariant name [ type0, type1 ] toBranch args make custom


{-| -}
variant3 :
    String
    -> (case_ -> (Expression -> Expression -> Expression -> Expression))
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> CustomTypeBuilder case_ ((Expression -> Expression -> Expression -> Expression) -> make_)
    -> CustomTypeBuilder case_ make_
variant3 name toBranch type0 type1 type2 custom =
    let
        args : Elm.Arg (Expression -> Expression -> Expression -> Expression) -> Elm.Arg Expression
        args record =
            record
                |> Elm.Arg.item (Elm.Arg.varWith "arg0" type0)
                |> Elm.Arg.item (Elm.Arg.varWith "arg1" type1)
                |> Elm.Arg.item (Elm.Arg.varWith "arg2" type2)

        make : (List Expression -> Expression) -> Expression -> Expression -> Expression -> Expression
        make makeValue arg0 arg1 arg2 =
            makeValue [ arg0, arg1, arg2 ]
    in
    standardVariant name [ type0, type1, type2 ] toBranch args make custom


{-| -}
variant4 :
    String
    -> (case_ -> (Expression -> Expression -> Expression -> Expression -> Expression))
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> CustomTypeBuilder case_ ((Expression -> Expression -> Expression -> Expression -> Expression) -> make_)
    -> CustomTypeBuilder case_ make_
variant4 name toBranch type0 type1 type2 type3 custom =
    let
        args : Elm.Arg (Expression -> Expression -> Expression -> Expression -> Expression) -> Elm.Arg Expression
        args record =
            record
                |> Elm.Arg.item (Elm.Arg.varWith "arg0" type0)
                |> Elm.Arg.item (Elm.Arg.varWith "arg1" type1)
                |> Elm.Arg.item (Elm.Arg.varWith "arg2" type2)
                |> Elm.Arg.item (Elm.Arg.varWith "arg3" type3)

        make : (List Expression -> Expression) -> Expression -> Expression -> Expression -> Expression -> Expression
        make makeValue arg0 arg1 arg2 arg3 =
            makeValue [ arg0, arg1, arg2, arg3 ]
    in
    standardVariant name [ type0, type1, type2, type3 ] toBranch args make custom


standardVariant :
    String
    -> List Elm.Annotation.Annotation
    -> (case_ -> branch)
    -> (Elm.Arg branch -> Elm.Arg Expression)
    -> ((List Expression -> Expression) -> branch)
    -> CustomTypeBuilder case_ (branch -> make_)
    -> CustomTypeBuilder case_ make_
standardVariant name types branch args make custom =
    customVariant name types branch args (\mod previous -> previous (make mod)) custom


{-| -}
customVariant :
    String
    -> List Elm.Annotation.Annotation
    -> (case_ -> branch)
    -> (Elm.Arg branch -> Elm.Arg Expression)
    -> ((List Expression -> Expression) -> previousMake_ -> make_)
    -> CustomTypeBuilder case_ previousMake_
    -> CustomTypeBuilder case_ make_
customVariant name types branch arg make (CustomTypeBuilder custom) =
    let
        makeValue : List String -> List Expression -> Expression
        makeValue mod list =
            Elm.apply
                (Elm.value
                    { importFrom = mod
                    , name = name
                    , annotation = Nothing
                    }
                )
                list
                |> Elm.withType (Elm.Annotation.named mod custom.name)
    in
    CustomTypeBuilder
        { exposeConstructor = custom.exposeConstructor
        , name = custom.name
        , variants = Elm.variantWith name types :: custom.variants
        , make_ = make (makeValue []) custom.make_
        , case_ =
            \record ->
                Elm.Case.branch
                    (branch record
                        |> Elm.Arg.customType name
                        |> arg
                    )
                    identity
                    :: custom.case_ record
        , internal =
            Internal
                (\mod ->
                    let
                        (Internal internal) =
                            custom.internal
                    in
                    make (makeValue mod) (internal mod)
                )
        }


{-| -}
with :
    { a
        | declaration : Elm.Declaration
        , internal : Internal required
    }
    -> Module (required -> val)
    -> Module val
with decl mod =
    let
        (Internal call) =
            decl.internal
    in
    { name = mod.name
    , declarations = Elm.expose decl.declaration :: mod.declarations
    , call = mod.call (call mod.name)
    }


{-| -}
withUnexposed : { a | declaration : Elm.Declaration } -> Module val -> Module val
withUnexposed { declaration } mod =
    { mod | declarations = declaration :: mod.declarations }


{-| -}
fn :
    String
    -> Elm.Arg value
    -> (value -> Expression)
    -> Function (Expression -> Expression)
fn name one toExp =
    fnBuilder name toExp
        |> fnArg one
        |> fnDone


{-| -}
fn2 :
    String
    -> Elm.Arg one
    -> Elm.Arg two
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
    -> Elm.Arg five
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
    -> Elm.Arg five
    -> Elm.Arg six
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
    Elm.Arg arg
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
    let
        functionVal =
            valWithType [] name funcExp
    in
    { value = functionVal
    , call = call functionVal
    , declaration = Elm.declaration name funcExp
    , internal =
        Internal
            (\modName ->
                call (valWithType modName name funcExp)
            )
    }


valWithType :
    List String
    -> String
    -> Expression
    -> Expression
valWithType importFrom name fnExp =
    Compiler.Expression
        (\index ->
            let
                ( oneIndex, one ) =
                    Compiler.toExpressionDetails index fnExp

                qualifiedImport =
                    Index.getImport oneIndex importFrom
            in
            { expression =
                -- This *must* be an un-protected name, where we only use
                -- literally what the dev gives us, because we are trying
                -- to refer to something that already exists.
                Exp.FunctionOrValue qualifiedImport
                    (Format.sanitize name)
            , annotation = one.annotation
            , imports =
                case qualifiedImport of
                    [] ->
                        one.imports

                    qual ->
                        one.imports ++ [ qual ]
            }
        )


{-| -}
value :
    String
    -> Expression
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
placeholder : Expression
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


{-| Add a module as a "submodule".

This can be useful for organizing particularly complex modules.

The only thing to be aware of here is that the module name for both of these modules must be the same or you're going to have a bad time.

-}
withSubmodule : Module submod -> Module (submod -> mod) -> Module mod
withSubmodule submod mod =
    { name = mod.name
    , declarations = mod.declarations ++ [ include submod ]
    , call = mod.call submod.call
    }


{-| Include a module as a declaration in another module.

**Note** - Be aware that the modulename of the included module must match the module name of the module you're including it in!

-}
include : Module val -> Elm.Declaration
include mod =
    Compiler.Group mod.declarations


{-| Add documentation to a function or value declared using this module.
-}
withDocumentation :
    String
    -> { a | declaration : Elm.Declaration }
    -> { a | declaration : Elm.Declaration }
withDocumentation doc val =
    { val
        | declaration = val.declaration |> Elm.withDocumentation doc
    }
