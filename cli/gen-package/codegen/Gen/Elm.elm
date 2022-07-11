module Gen.Elm exposing (alias, annotation_, apply, bool, call_, char, comment, customType, declaration, docs, expose, exposeWith, file, fileWith, float, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, get, hex, ifThen, int, just, letIn, list, make_, maybe, moduleName_, nothing, parse, portIncoming, portOutgoing, record, string, toString, triple, tuple, unit, unsafe, unwrap, unwrapper, updateRecord, value, values_, variant, variantWith, withDocumentation, withType)

{-| 
@docs moduleName_, file, toString, bool, int, float, char, string, hex, unit, maybe, just, nothing, list, tuple, triple, withType, record, get, updateRecord, letIn, ifThen, comment, declaration, withDocumentation, expose, exposeWith, fileWith, docs, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, customType, variant, variantWith, alias, portIncoming, portOutgoing, parse, unsafe, apply, value, unwrap, unwrapper, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Tuple


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm" ]


{-| Build a file!

    Elm.file [ "My", "Module" ]
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

file: List String -> List Elm.Declaration -> Elm.File
-}
file : List String -> List Elm.Expression -> Elm.Expression
file arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "file"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                        ]
                        (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
        )
        [ Elm.list (List.map Elm.string arg), Elm.list arg0 ]


{-| See what code this expression would generate!

**Note** - Check out the `Elm.ToString` module if this doesn't quite meet your needs!

toString: Elm.Expression -> String
-}
toString : Elm.Expression -> Elm.Expression
toString arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
        )
        [ arg ]


{-| bool: Bool -> Elm.Expression -}
bool : Bool -> Elm.Expression
bool arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "bool"
            , annotation =
                Just
                    (Type.function
                        [ Type.bool ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.bool arg ]


{-| int: Int -> Elm.Expression -}
int : Int -> Elm.Expression
int arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.int arg ]


{-| float: Float -> Elm.Expression -}
float : Float -> Elm.Expression
float arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                        [ Type.float ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.float arg ]


{-| char: Char.Char -> Elm.Expression -}
char : Char.Char -> Elm.Expression
char arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "char"
            , annotation =
                Just
                    (Type.function
                        [ Type.char ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.char arg ]


{-| string: String -> Elm.Expression -}
string : String -> Elm.Expression
string arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.string arg ]


{-| hex: Int -> Elm.Expression -}
hex : Int -> Elm.Expression
hex arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "hex"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.int arg ]


{-| unit: Elm.Expression -}
unit : Elm.Expression
unit =
    Elm.value
        { importFrom = [ "Elm" ]
        , name = "unit"
        , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
        }


{-| maybe: Maybe Elm.Expression -> Elm.Expression -}
maybe : Elm.Expression -> Elm.Expression
maybe arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.maybe (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg ]


{-| just: Elm.Expression -> Elm.Expression -}
just : Elm.Expression -> Elm.Expression
just arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "just"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg ]


{-| nothing: Elm.Expression -}
nothing : Elm.Expression
nothing =
    Elm.value
        { importFrom = [ "Elm" ]
        , name = "nothing"
        , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
        }


{-| list: List Elm.Expression -> Elm.Expression -}
list : List Elm.Expression -> Elm.Expression
list arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Elm" ] "Expression" []) ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg ]


{-| tuple: Elm.Expression -> Elm.Expression -> Elm.Expression -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| triple: Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg arg0 arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0, arg1 ]


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType Type.string

Though be sure `elm-codegen` isn't already doing this automatically for you!

withType: Elm.Annotation.Annotation -> Elm.Expression -> Elm.Expression
-}
withType : Elm.Expression -> Elm.Expression -> Elm.Expression
withType arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "withType"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0 ]


{-| Elm.record
        [ ( "name", Elm.string "Elm" )
        , ( "designation", Elm.string "Pretty fabulous" )
        ]

record: List ( String, Elm.Expression ) -> Elm.Expression
-}
record : List Elm.Expression -> Elm.Expression
record arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg ]


{-| record
        |> Elm.get "field"

results in

    record.field

get: String -> Elm.Expression -> Elm.Expression
-}
get : String -> Elm.Expression -> Elm.Expression
get arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.string arg, arg0 ]


{-| updateRecord: Elm.Expression -> List ( String, Elm.Expression ) -> Elm.Expression -}
updateRecord : Elm.Expression -> List Elm.Expression -> Elm.Expression
updateRecord arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, Elm.list arg0 ]


{-| A let block.

    import Elm


    Elm.letIn
        [ ("one", (Elm.int 5))
        , ("two", (Elm.int 10))
        ]
        (Elm.add (Elm.value "one") (Elm.value "two"))

letIn: List ( String, Elm.Expression ) -> Elm.Expression -> Elm.Expression
-}
letIn : List Elm.Expression -> Elm.Expression -> Elm.Expression
letIn arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg, arg0 ]


{-| ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

Will generate

    if True then
        "yes"

    else
        "no"

ifThen: Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
-}
ifThen : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
ifThen arg arg0 arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "ifThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, arg0, arg1 ]


{-| comment: String -> Elm.Declaration -}
comment : String -> Elm.Expression
comment arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "comment"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg ]


{-| declaration: String -> Elm.Expression -> Elm.Declaration -}
declaration : String -> Elm.Expression -> Elm.Expression
declaration arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, arg0 ]


{-| Add a documentation comment to a declaration!

withDocumentation: String -> Elm.Declaration -> Elm.Declaration
-}
withDocumentation : String -> Elm.Expression -> Elm.Expression
withDocumentation arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "withDocumentation"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, arg0 ]


{-| By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

expose: Elm.Declaration -> Elm.Declaration
-}
expose : Elm.Expression -> Elm.Expression
expose arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "expose"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ arg ]


{-| You can also add a group tag to an exposed value. This will automatically group the `docs` statements in the module docs.

For precise control over what is rendered for the module comment, use [fileWith](#fileWith)

exposeWith: 
    { exposeConstructor : Bool, group : Maybe String }
    -> Elm.Declaration
    -> Elm.Declaration
-}
exposeWith :
    { exposeConstructor : Bool, group : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
exposeWith arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "exposeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "exposeConstructor", Type.bool )
                            , ( "group", Type.maybe Type.string )
                            ]
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "exposeConstructor" (Elm.bool arg.exposeConstructor)
            , Tuple.pair "group" arg.group
            ]
        , arg0
        ]


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@doc` comment.

Each exposed item is grouped based on the string used in [exposeWith](#exposeWith).

**aliases** allow you to specify a module alias to be used.

    aliases =
        [ (["Json", "Encode"), "Encode")
        ]

would make an import statement like

    import Json.Encode as Encode

All values rendered in this file that are from this module would also automatically respect this alias as well.

fileWith: 
    List String
    -> { docs : List { group : Maybe String, members : List String } -> List String
    , aliases : List ( List String, String )
    }
    -> List Elm.Declaration
    -> Elm.File
-}
fileWith :
    List String
    -> { docs : Elm.Expression -> Elm.Expression
    , aliases : List Elm.Expression
    }
    -> List Elm.Expression
    -> Elm.Expression
fileWith arg arg0 arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fileWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.record
                            [ ( "docs"
                              , Type.function
                                    [ Type.list
                                        (Type.record
                                            [ ( "group"
                                              , Type.maybe Type.string
                                              )
                                            , ( "members"
                                              , Type.list Type.string
                                              )
                                            ]
                                        )
                                    ]
                                    (Type.list Type.string)
                              )
                            , ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                        ]
                        (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
        )
        [ Elm.list (List.map Elm.string arg)
        , Elm.record
            [ Tuple.pair "docs" (Elm.functionReduced "unpack" arg0.docs)
            , Tuple.pair "aliases" (Elm.list arg0.aliases)
            ]
        , Elm.list arg1
        ]


{-| Render a standard docstring.

    @docs one, two, three

If a `group` has been given, it will be rendered as a second level header.

```markdown
## Group name

@docs one, two, three
```

docs: { group : Maybe String, members : List String } -> String
-}
docs : { group : Elm.Expression, members : List String } -> Elm.Expression
docs arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "docs"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "group", Type.maybe Type.string )
                            , ( "members", Type.list Type.string )
                            ]
                        ]
                        Type.string
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "group" arg.group
            , Tuple.pair "members" (Elm.list (List.map Elm.string arg.members))
            ]
        ]


{-| Create a function with a single argument.

This may seem a little weird the first time you encounter it, so let's break it down.

Here's what's happening for the `fn*` functions —

  - The `String` arguments are the **names of the arguments** for the generated function.
  - The attached `Maybe Annotation` is the type annotation. If you provide `Nothing`, then `elm-codegen` will infer the type for you!
  - The `(Expression -> Expression)` function is where we're providing you an `Expression` that represents an argument coming in to the generated function.

So, this

    Elm.fn ( "firstInt", Nothing )
        (\firstArgument ->
            Elm.plus
                (Elm.int 42)
                firstArgument
        )

Generates

    \firstInt -> 42 + firstInt

If you want to generate a **top level** function instead of an anonymous function, use `Elm.declaration`.

    Elm.declaration "add42" <|
        Elm.fn ( "firstInt", Nothing )
            (\firstArgument ->
                Elm.plus
                    (Elm.int 42)
                    firstArgument
            )

Results in

    add42 : Int -> Int
    add42 firstInt =
        42 + firstInt

**Note** — Elm CodeGen will protect variable names if they're used in a nested `fn*` by adding a string of numbers to the end of the name. So, you may see a variable name be something like `myVariable_0_1`.

If you absolutely don't want this behavior, you'll need to use [`functionAdvanced`](#functionAdvanced).

fn: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
fn : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
fn arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, Elm.functionReduced "unpack" arg0 ]


{-| fn2: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
fn2 :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 arg arg0 arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg
        , arg0
        , Elm.functionReduced
            "unpack"
            (\unpack -> Elm.functionReduced "unpack" (arg1 unpack))
        ]


{-| fn3: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
fn3 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn3 arg arg0 arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg
        , arg0
        , arg1
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced "unpack" (arg2 unpack unpack0)
                    )
            )
        ]


{-| fn4: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
-}
fn4 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn4 arg arg0 arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg
        , arg0
        , arg1
        , arg2
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_4_3_7_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (arg3 unpack unpack0 unpack_4_3_7_3_0)
                            )
                    )
            )
        ]


{-| fn5: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
-}
fn5 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn5 arg arg0 arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg
        , arg0
        , arg1
        , arg2
        , arg3
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_4_3_8_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_4_4_3_8_3_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (arg4 unpack unpack0
                                                 unpack_4_3_8_3_0
                                                unpack_4_4_3_8_3_0
                                            )
                                    )
                            )
                    )
            )
        ]


{-| fn6: 
    ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
-}
fn6 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn6 arg arg0 arg1 arg2 arg3 arg4 arg5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg
        , arg0
        , arg1
        , arg2
        , arg3
        , arg4
        , Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_4_3_9_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_4_4_3_9_3_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\unpack_4_4_4_3_9_3_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (arg5 unpack unpack0
                                                         unpack_4_3_9_3_0
                                                         unpack_4_4_3_9_3_0
                                                        unpack_4_4_4_3_9_3_0
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| You may run into situations where you don't know the number of arguments for a function at compile-time.

In that case you can use `function`. It follows the same pattern as the `fn*` functions.

Provide it with —

  - A list of argument names and an optional type
  - A function which will be given all the input arguments as `Expression`s.

function: 
    List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Elm.Expression -> Elm.Expression)
    -> Elm.Expression
-}
function :
    List Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
function arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                )
                            )
                        , Type.function
                            [ Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg, Elm.functionReduced "unpack" arg0 ]


{-| This is a special case of function declaration which will _reduce_ itself if possible.

Meaning, if this would generate the following code

    \myArg -> someOtherFunction myArg

Then it will replace itself with just

    someOtherFunction

**Note** you likely won't need this! It's generally used by the package-helper generator, but that might be a relatively special case.

functionReduced: String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
-}
functionReduced : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
functionReduced arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.string arg, Elm.functionReduced "unpack" arg0 ]


{-| A custom type declaration.

    Elm.customType "MyType"
        [ Elm.variant "One"
        , Elm.variantWith "Two"
            [ Elm.Annotation.list Elm.Annotation.string ]
        ]

Will result in

    type MyType
        = One
        | Two (List String)

customType: String -> List Elm.Variant -> Elm.Declaration
-}
customType : String -> List Elm.Expression -> Elm.Expression
customType arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, Elm.list arg0 ]


{-| variant: String -> Elm.Variant -}
variant : String -> Elm.Expression
variant arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "variant"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Variant" [])
                    )
            }
        )
        [ Elm.string arg ]


{-| variantWith: String -> List Elm.Annotation.Annotation -> Elm.Variant -}
variantWith : String -> List Elm.Expression -> Elm.Expression
variantWith arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "variantWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Variant" [])
                    )
            }
        )
        [ Elm.string arg, Elm.list arg0 ]


{-| A custom type declaration.

    import Elm.Annotation as Type

    Elm.alias "MyAlias"
        (Type.record
            [ ( "one", Type.string )
            , ( "two", Type.int )
            , ( "three", Type.var "content" )
            ]
        )

Should result in

    type alias MyAlias content =
        { one : String
        , two : Int
        , three : content
        }

alias: String -> Elm.Annotation.Annotation -> Elm.Declaration
-}
alias : String -> Elm.Expression -> Elm.Expression
alias arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "alias"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, arg0 ]


{-| import Elm.Annotation as Type

    Elm.portIncoming "receiveMessageFromTheWorld"
        [ Type.string
        , Type.int
        ]

Results in

    port receiveMessageFromTheWorld :
        (String -> Int -> msg)
        -> Sub msg

**Note** You generally only need one incoming and one outgoing port!

If you want to vary the messages going in and out of your app, don't use a huge number of ports, instead write Json encoders and decoders.

This will give you more flexibility in the future and save you having to wire up a bunch of stuff.

**Another note** - You may need to expose your port explicitly using `Elm.expose`

portIncoming: String -> List Elm.Annotation.Annotation -> Elm.Declaration
-}
portIncoming : String -> List Elm.Expression -> Elm.Expression
portIncoming arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "portIncoming"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, Elm.list arg0 ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

portOutgoing: String -> Elm.Annotation.Annotation -> Elm.Declaration
-}
portOutgoing : String -> Elm.Expression -> Elm.Expression
portOutgoing arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "portOutgoing"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg, arg0 ]


{-| parse: String -> Result.Result String { declarations : List Elm.Declaration } -}
parse : String -> Elm.Expression
parse arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.string
                            , Type.record
                                [ ( "declarations"
                                  , Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                        )
                                  )
                                ]
                            ]
                        )
                    )
            }
        )
        [ Elm.string arg ]


{-| unsafe: String -> Elm.Declaration -}
unsafe : String -> Elm.Expression
unsafe arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string arg ]


{-| apply: Elm.Expression -> List Elm.Expression -> Elm.Expression -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "apply"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg, Elm.list arg0 ]


{-| value: 
    { importFrom : List String
    , name : String
    , annotation : Maybe Elm.Annotation.Annotation
    }
    -> Elm.Expression
-}
value :
    { importFrom : List String, name : String, annotation : Elm.Expression }
    -> Elm.Expression
value arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "importFrom", Type.list Type.string )
                            , ( "name", Type.string )
                            , ( "annotation"
                              , Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair
                "importFrom"
                (Elm.list (List.map Elm.string arg.importFrom))
            , Tuple.pair "name" (Elm.string arg.name)
            , Tuple.pair "annotation" arg.annotation
            ]
        ]


{-| Unwraps a single-variant type

    Elm.declaration "myFunction" <|
        Elm.fn "val"
            (\\val ->
                Elm.unwrap "MyType" val
            )

Results in the following lambda

    myFunction val =
        (\(MyType val) -> val) val

unwrap: List String -> String -> Elm.Expression -> Elm.Expression
-}
unwrap : List String -> String -> Elm.Expression -> Elm.Expression
unwrap arg arg0 arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "unwrap"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list (List.map Elm.string arg), Elm.string arg0, arg1 ]


{-| Generate a lambda which unwraps a single-variant type.

    Elm.unwrapper [ "MyModule" ] "MyType"

Results in the following lambda

    \(MyModule.MyType val) -> val

**Note** This needs to be a type with only a single variant

unwrapper: List String -> String -> Elm.Expression
-}
unwrapper : List String -> String -> Elm.Expression
unwrapper arg arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "unwrapper"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list (List.map Elm.string arg), Elm.string arg0 ]


annotation_ :
    { file : Type.Annotation
    , expression : Type.Annotation
    , declaration : Type.Annotation
    , variant : Type.Annotation
    }
annotation_ =
    { file =
        Type.alias
            moduleName_
            "File"
            []
            (Type.record
                [ ( "path", Type.string ), ( "contents", Type.string ) ]
            )
    , expression =
        Type.alias
            moduleName_
            "Expression"
            []
            (Type.namedWith [ "Internal", "Compiler" ] "Expression" [])
    , declaration =
        Type.alias
            moduleName_
            "Declaration"
            []
            (Type.namedWith [ "Internal", "Compiler" ] "Declaration" [])
    , variant = Type.namedWith moduleName_ "Variant" []
    }


make_ :
    { file :
        { path : Elm.Expression, contents : Elm.Expression } -> Elm.Expression
    }
make_ =
    { file =
        \file_args ->
            Elm.withType
                (Type.alias
                    [ "Elm" ]
                    "File"
                    []
                    (Type.record
                        [ ( "path", Type.string ), ( "contents", Type.string ) ]
                    )
                )
                (Elm.record
                    [ Tuple.pair "path" file_args.path
                    , Tuple.pair "contents" file_args.contents
                    ]
                )
    }


call_ :
    { file : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    , bool : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    , char : Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , hex : Elm.Expression -> Elm.Expression
    , maybe : Elm.Expression -> Elm.Expression
    , just : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , record : Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , updateRecord : Elm.Expression -> Elm.Expression -> Elm.Expression
    , letIn : Elm.Expression -> Elm.Expression -> Elm.Expression
    , ifThen :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , comment : Elm.Expression -> Elm.Expression
    , declaration : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expose : Elm.Expression -> Elm.Expression
    , exposeWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fileWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , docs : Elm.Expression -> Elm.Expression
    , fn : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn2 : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , function : Elm.Expression -> Elm.Expression -> Elm.Expression
    , functionReduced : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant : Elm.Expression -> Elm.Expression
    , variantWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , alias : Elm.Expression -> Elm.Expression -> Elm.Expression
    , portIncoming : Elm.Expression -> Elm.Expression -> Elm.Expression
    , portOutgoing : Elm.Expression -> Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression
    , unsafe : Elm.Expression -> Elm.Expression
    , apply : Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : Elm.Expression -> Elm.Expression
    , unwrap :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , unwrapper : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { file =
        \arg arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "file"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Declaration" [])
                                ]
                                (Type.namedWith [ "Elm" ] "File" [])
                            )
                    }
                )
                [ arg, arg0 ]
    , toString =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "toString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                Type.string
                            )
                    }
                )
                [ arg ]
    , bool =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "bool"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.bool ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , int =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "int"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , float =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "float"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.float ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , char =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "char"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.char ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , string =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , hex =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "hex"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , maybe =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "maybe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.maybe
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , just =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "just"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , list =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "list"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , tuple =
        \arg arg11 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "tuple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg11 ]
    , triple =
        \arg arg12 arg13 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "triple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg12, arg13 ]
    , withType =
        \arg arg13 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "withType"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg13 ]
    , record =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "record"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    )
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , get =
        \arg arg15 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg15 ]
    , updateRecord =
        \arg arg16 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "updateRecord"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    )
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg16 ]
    , letIn =
        \arg arg17 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "letIn"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    )
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg17 ]
    , ifThen =
        \arg arg18 arg19 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "ifThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg18, arg19 ]
    , comment =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "comment"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg ]
    , declaration =
        \arg arg20 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "declaration"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg20 ]
    , withDocumentation =
        \arg arg21 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "withDocumentation"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg21 ]
    , expose =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "expose"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg ]
    , exposeWith =
        \arg arg23 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "exposeWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "exposeConstructor", Type.bool )
                                    , ( "group", Type.maybe Type.string )
                                    ]
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg23 ]
    , fileWith =
        \arg arg24 arg25 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fileWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.record
                                    [ ( "docs"
                                      , Type.function
                                            [ Type.list
                                                (Type.record
                                                    [ ( "group"
                                                      , Type.maybe Type.string
                                                      )
                                                    , ( "members"
                                                      , Type.list Type.string
                                                      )
                                                    ]
                                                )
                                            ]
                                            (Type.list Type.string)
                                      )
                                    , ( "aliases"
                                      , Type.list
                                            (Type.tuple
                                                (Type.list Type.string)
                                                Type.string
                                            )
                                      )
                                    ]
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Declaration" [])
                                ]
                                (Type.namedWith [ "Elm" ] "File" [])
                            )
                    }
                )
                [ arg, arg24, arg25 ]
    , docs =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "docs"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "group", Type.maybe Type.string )
                                    , ( "members", Type.list Type.string )
                                    ]
                                ]
                                Type.string
                            )
                    }
                )
                [ arg ]
    , fn =
        \arg arg26 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg26 ]
    , fn2 =
        \arg arg27 arg28 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg27, arg28 ]
    , fn3 =
        \arg arg28 arg29 arg30 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg28, arg29, arg30 ]
    , fn4 =
        \arg arg29 arg30 arg31 arg32 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg29, arg30, arg31, arg32 ]
    , fn5 =
        \arg arg30 arg31 arg32 arg33 arg34 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg30, arg31, arg32, arg33, arg34 ]
    , fn6 =
        \arg arg31 arg32 arg33 arg34 arg35 arg36 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "fn6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg31, arg32, arg33, arg34, arg35, arg36 ]
    , function =
        \arg arg32 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "function"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.maybe
                                            (Type.namedWith
                                                [ "Elm", "Annotation" ]
                                                "Annotation"
                                                []
                                            )
                                        )
                                    )
                                , Type.function
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg32 ]
    , functionReduced =
        \arg arg33 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "functionReduced"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg33 ]
    , customType =
        \arg arg34 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "customType"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Variant" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg34 ]
    , variant =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "variant"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Variant" [])
                            )
                    }
                )
                [ arg ]
    , variantWith =
        \arg arg36 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "variantWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                ]
                                (Type.namedWith [ "Elm" ] "Variant" [])
                            )
                    }
                )
                [ arg, arg36 ]
    , alias =
        \arg arg37 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "alias"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg37 ]
    , portIncoming =
        \arg arg38 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "portIncoming"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg38 ]
    , portOutgoing =
        \arg arg39 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "portOutgoing"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg, arg39 ]
    , parse =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "parse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.string
                                    , Type.record
                                        [ ( "declarations"
                                          , Type.list
                                                (Type.namedWith
                                                    [ "Elm" ]
                                                    "Declaration"
                                                    []
                                                )
                                          )
                                        ]
                                    ]
                                )
                            )
                    }
                )
                [ arg ]
    , unsafe =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "unsafe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ arg ]
    , apply =
        \arg arg42 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "apply"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg42 ]
    , value =
        \arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "value"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "importFrom", Type.list Type.string )
                                    , ( "name", Type.string )
                                    , ( "annotation"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "Elm", "Annotation" ]
                                                "Annotation"
                                                []
                                            )
                                      )
                                    ]
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg ]
    , unwrap =
        \arg arg44 arg45 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "unwrap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg44, arg45 ]
    , unwrapper =
        \arg arg45 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "unwrapper"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string, Type.string ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg, arg45 ]
    }


values_ :
    { file : Elm.Expression
    , toString : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , char : Elm.Expression
    , string : Elm.Expression
    , hex : Elm.Expression
    , unit : Elm.Expression
    , maybe : Elm.Expression
    , just : Elm.Expression
    , nothing : Elm.Expression
    , list : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , withType : Elm.Expression
    , record : Elm.Expression
    , get : Elm.Expression
    , updateRecord : Elm.Expression
    , letIn : Elm.Expression
    , ifThen : Elm.Expression
    , comment : Elm.Expression
    , declaration : Elm.Expression
    , withDocumentation : Elm.Expression
    , expose : Elm.Expression
    , exposeWith : Elm.Expression
    , fileWith : Elm.Expression
    , docs : Elm.Expression
    , fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fn4 : Elm.Expression
    , fn5 : Elm.Expression
    , fn6 : Elm.Expression
    , function : Elm.Expression
    , functionReduced : Elm.Expression
    , customType : Elm.Expression
    , variant : Elm.Expression
    , variantWith : Elm.Expression
    , alias : Elm.Expression
    , portIncoming : Elm.Expression
    , portOutgoing : Elm.Expression
    , parse : Elm.Expression
    , unsafe : Elm.Expression
    , apply : Elm.Expression
    , value : Elm.Expression
    , unwrap : Elm.Expression
    , unwrapper : Elm.Expression
    }
values_ =
    { file =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "file"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                        ]
                        (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
    , bool =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "bool"
            , annotation =
                Just
                    (Type.function
                        [ Type.bool ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , float =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                        [ Type.float ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , char =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "char"
            , annotation =
                Just
                    (Type.function
                        [ Type.char ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , hex =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "hex"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , unit =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "unit"
            , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
            }
    , maybe =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.maybe (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , just =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "just"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , nothing =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "nothing"
            , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
            }
    , list =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Elm" ] "Expression" []) ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , tuple =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , triple =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , withType =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "withType"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , record =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , get =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , updateRecord =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , letIn =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , ifThen =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "ifThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , comment =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "comment"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , declaration =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , withDocumentation =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "withDocumentation"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , expose =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "expose"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , exposeWith =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "exposeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "exposeConstructor", Type.bool )
                            , ( "group", Type.maybe Type.string )
                            ]
                        , Type.namedWith [ "Elm" ] "Declaration" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , fileWith =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fileWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.record
                            [ ( "docs"
                              , Type.function
                                    [ Type.list
                                        (Type.record
                                            [ ( "group"
                                              , Type.maybe Type.string
                                              )
                                            , ( "members"
                                              , Type.list Type.string
                                              )
                                            ]
                                        )
                                    ]
                                    (Type.list Type.string)
                              )
                            , ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                        ]
                        (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
    , docs =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "docs"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "group", Type.maybe Type.string )
                            , ( "members", Type.list Type.string )
                            ]
                        ]
                        Type.string
                    )
            }
    , fn =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fn2 =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fn3 =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fn4 =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fn5 =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fn6 =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , function =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                                )
                            )
                        , Type.function
                            [ Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , functionReduced =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , customType =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , variant =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "variant"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Variant" [])
                    )
            }
    , variantWith =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "variantWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Variant" [])
                    )
            }
    , alias =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "alias"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , portIncoming =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "portIncoming"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , portOutgoing =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "portOutgoing"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , parse =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.string
                            , Type.record
                                [ ( "declarations"
                                  , Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                        )
                                  )
                                ]
                            ]
                        )
                    )
            }
    , unsafe =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , apply =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "apply"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , value =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "importFrom", Type.list Type.string )
                            , ( "name", Type.string )
                            , ( "annotation"
                              , Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                              )
                            ]
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , unwrap =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "unwrap"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , unwrapper =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "unwrapper"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    }


