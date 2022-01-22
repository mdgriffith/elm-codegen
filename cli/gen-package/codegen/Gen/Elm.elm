module Gen.Elm exposing (alias, and, append, apply, bool, call_, char, comment, cons, customType, declaration, declarationImports, declarationToString, divide, docs, equal, expose, exposeWith, expressionImports, field, file, fileWith, float, fn, fn2, fn3, fn4, fn5, fn6, function, functionAdvanced, functionReduced, get, gt, gte, hex, ifThen, int, intDivide, keep, letIn, list, lt, lte, maybe, minus, moduleName_, multiply, notEqual, or, parse, plus, portIncoming, portOutgoing, power, query, record, signature, skip, slash, string, toString, triple, tuple, types_, unit, unsafe, updateRecord, value, valueFrom, valueWith, values_, variant, variantWith, withDocumentation, withType)

{-| 
@docs moduleName_, file, bool, int, float, char, string, hex, unit, maybe, list, tuple, triple, withType, record, field, get, updateRecord, letIn, ifThen, comment, declaration, withDocumentation, expose, exposeWith, fileWith, docs, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, functionAdvanced, customType, variant, variantWith, alias, equal, notEqual, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, and, or, keep, skip, slash, query, portIncoming, portOutgoing, parse, unsafe, toString, signature, expressionImports, declarationToString, declarationImports, apply, value, valueFrom, valueWith, types_, values_, call_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm" ]


{-| Build a file!

    Elm.file [ "My", "Module" ]
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

-}
file : List Elm.Expression -> List Elm.Expression -> Elm.Expression
file arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1, Elm.list arg2 ]


{-| -}
bool : Elm.Expression -> Elm.Expression
bool arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
int : Elm.Expression -> Elm.Expression
int arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
float : Elm.Expression -> Elm.Expression
float arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
char : Elm.Expression -> Elm.Expression
char arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
string : Elm.Expression -> Elm.Expression
string arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
hex : Elm.Expression -> Elm.Expression
hex arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
unit : Elm.Expression
unit =
    Elm.valueWith
        { importFrom = [ "Elm" ]
        , name = "unit"
        , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
        }


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
list : List Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType (Type.string)

Though be sure `elm-codegen` isn't already doing this automatically for you!

-}
withType : Elm.Expression -> Elm.Expression -> Elm.Expression
withType arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-|

    Elm.record
        [ Elm.field "name" (Elm.string "Elm")
        , Elm.field "designation" (Elm.string "Pretty fabulous")
        ]

-}
record : List Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Elm" ] "Field" []) ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg1 ]


{-| -}
field : Elm.Expression -> Elm.Expression -> Elm.Expression
field arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Field" [])
                    )
            }
        )
        [ arg1, arg2 ]


{-|

    record
        |> Elm.get "field"

results in

    record.field

-}
get : Elm.Expression -> Elm.Expression -> Elm.Expression
get arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| -}
updateRecord : Elm.Expression -> List Elm.Expression -> Elm.Expression
updateRecord arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list (Type.namedWith [ "Elm" ] "Field" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| A let block.

    import Elm


    Elm.letIn
        [ ("one", (Elm.int 5))
        , ("two", (Elm.int 10))
        ]
        (Elm.add (Elm.value "one") (Elm.value "two"))

-}
letIn : List Elm.Expression -> Elm.Expression -> Elm.Expression
letIn arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1, arg2 ]


{-|

    ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

Will generate

    if True then
        "yes"

    else
        "no"

-}
ifThen : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
ifThen arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2, arg3 ]


{-| -}
comment : Elm.Expression -> Elm.Expression
comment arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
declaration : Elm.Expression -> Elm.Expression -> Elm.Expression
declaration arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| Add a documentation comment to a declaration!
-}
withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
withDocumentation arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

-}
expose : Elm.Expression -> Elm.Expression
expose arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| You can also add a group tag to an exposed value. This will automatically group the `docs` statements in the module docs.

For precise control over what is rendered for the module comment, use [fileWith](#fileWith)

-}
exposeWith :
    { exposeConstructor : Elm.Expression, group : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
exposeWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
            [ Elm.field "exposeConstructor" arg1.exposeConstructor
            , Elm.field "group" arg1.group
            ]
        , arg2
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

-}
fileWith :
    List Elm.Expression
    -> { docs : Elm.Expression -> Elm.Expression
    , aliases : List Elm.Expression
    }
    -> List Elm.Expression
    -> Elm.Expression
fileWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1
        , Elm.record
            [ Elm.field
                "docs"
                (Elm.functionAdvanced
                    [ ( "ar0"
                      , Type.list
                            (Type.record
                                [ ( "group", Type.maybe Type.string )
                                , ( "members", Type.list Type.string )
                                ]
                            )
                      )
                    ]
                    (arg2.docs
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar0"
                            , annotation =
                                Just
                                    (Type.list
                                        (Type.record
                                            [ ( "group"
                                              , Type.maybe Type.string
                                              )
                                            , ( "members"
                                              , Type.list Type.string
                                              )
                                            ]
                                        )
                                    )
                            }
                        )
                    )
                )
            , Elm.field "aliases" (Elm.list arg2.aliases)
            ]
        , Elm.list arg3
        ]


{-| Render a standard docstring.

    @docs one, two, three

If a `group` has been given, it will be rendered as a second level header.

```markdown
## Group name

@docs one, two, three
```

-}
docs :
    { group : Elm.Expression, members : List Elm.Expression } -> Elm.Expression
docs arg1 =
    Elm.apply
        (Elm.valueWith
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
            [ Elm.field "group" arg1.group
            , Elm.field "members" (Elm.list arg1.members)
            ]
        ]


{-| Create a function with a single argument.

This may seem a little weird the first time you encounter it, so let's break it down.

Here's what's happening for the `fn*` functions —

  - The `String` arguments are the **names of the arguments** for the generated function.
  - The `(Expression -> Expression)` function is where we're providing you an `Expression` that represents an argument coming in to the generated function.

So, this

    Elm.fn "firstInt"
        (\firstArgument ->
            Elm.plus
                (Elm.int 42)
                firstArgument
        )

Generates

    \firstInt -> 42 + firstInt

If you want to generate a **top level** function instead of an anonymous function, use `Elm.declaration`.

    Elm.declaration "add42" <|
        Elm.fn "firstInt"
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

**Another Note** — There may be situations where `elm-codegen` is unable to infer the type of one of the parameters. This is especially the case if you are using type aliases.

In this case you can use [`withType`](#withType) to manually attach a type to a value. That looks like this:

    import Elm
    import Elm.Annotation

    Elm.fn "firstInt"
        (\firstArgument ->
            (firstArgument
                |> Elm.withType
                    (Elm.Annotation.named ["MyOwnModule"] "MyCustomType")
            )
        )

-}
fn : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
fn arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn"
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
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
fn2 :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
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
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
fn3 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn3 arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
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
        [ arg1
        , arg2
        , arg3
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg4
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
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
fn4 arg1 arg2 arg3 arg4 arg5 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        [ arg1
        , arg2
        , arg3
        , arg4
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar3", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg5
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
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
fn5 arg1 arg2 arg3 arg4 arg5 arg6 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        [ arg1
        , arg2
        , arg3
        , arg4
        , arg5
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar3", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar4", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg6
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| -}
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
fn6 arg1 arg2 arg3 arg4 arg5 arg6 arg7 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        [ arg1
        , arg2
        , arg3
        , arg4
        , arg5
        , arg6
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar1", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar2", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar3", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar4", Type.namedWith [ "Elm" ] "Expression" [] )
            , ( "ar5", Type.namedWith [ "Elm" ] "Expression" [] )
            ]
            (arg7
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar5"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| You may run into situations where you don't know the number of arguments for a function at compile-time.

In that case you can use `function`. It follows the same pattern as the `fn*` functions.

Provide it with —

  - A list of argument names and an optional type
  - A function which will be given all the input arguments as `Expression`s.

-}
function :
    List Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
function arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ Elm.list arg1
        , Elm.functionAdvanced
            [ ( "ar0", Type.list (Type.namedWith [ "Elm" ] "Expression" []) ) ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just
                            (Type.list
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
            )
        ]


{-| This is a special case of function declaration which will _reduce_ itself if possible.

Meaning, if this would generate the following code

    \myArg -> someOtherFunction myArg

Then it will replace itself with just

    someOtherFunction

**Note** you likely won't need this! It's generally used by the package-helper generator, but that might be a relatively special case.

-}
functionReduced :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
functionReduced arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar0", Type.namedWith [ "Elm" ] "Expression" [] ) ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just (Type.namedWith [ "Elm" ] "Expression" [])
                    }
                )
            )
        ]


{-| For when you want the most control over a function being generated.

This is for when:

1.  You want your variable names to be exactly as provided
    (i.e. you don't want the variable name collision protection)
2.  You know exactly what type each variable should be.

-}
functionAdvanced : List Elm.Expression -> Elm.Expression -> Elm.Expression
functionAdvanced arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionAdvanced"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


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

-}
customType : Elm.Expression -> List Elm.Expression -> Elm.Expression
customType arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, Elm.list arg2 ]


{-| -}
variant : Elm.Expression -> Elm.Expression
variant arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
variantWith : Elm.Expression -> List Elm.Expression -> Elm.Expression
variantWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, Elm.list arg2 ]


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

-}
alias : Elm.Expression -> Elm.Expression -> Elm.Expression
alias arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| `==`
-}
equal : Elm.Expression -> Elm.Expression -> Elm.Expression
equal arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "equal"
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
        [ arg1, arg2 ]


{-| `/=`
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "notEqual"
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
        [ arg1, arg2 ]


{-| `++`
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "append"
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
        [ arg1, arg2 ]


{-| `::`
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "cons"
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
        [ arg1, arg2 ]


{-| `+`
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "plus"
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
        [ arg1, arg2 ]


{-| `-`
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "minus"
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
        [ arg1, arg2 ]


{-| `*`
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "multiply"
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
        [ arg1, arg2 ]


{-| `/`
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "divide"
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
        [ arg1, arg2 ]


{-| `//`
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "intDivide"
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
        [ arg1, arg2 ]


{-| The to-the-power-of operator `^`
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "power"
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
        [ arg1, arg2 ]


{-| `<`
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lt"
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
        [ arg1, arg2 ]


{-| `>`
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gt"
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
        [ arg1, arg2 ]


{-| `<=`
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lte"
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
        [ arg1, arg2 ]


{-| `>=`
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gte"
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
        [ arg1, arg2 ]


{-| `&&`
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "and"
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
        [ arg1, arg2 ]


{-| `||`
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "or"
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
        [ arg1, arg2 ]


{-| used in the `elm/parser` library

`|=`

-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "keep"
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
        [ arg1, arg2 ]


{-| `|.`
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "skip"
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
        [ arg1, arg2 ]


{-| `</>` used in url parsing
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "slash"
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
        [ arg1, arg2 ]


{-| `<?>` used in url parsing
-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "query"
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
        [ arg1, arg2 ]


{-|

    import Elm.Annotation as Type

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

-}
portIncoming : Elm.Expression -> List Elm.Expression -> Elm.Expression
portIncoming arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, Elm.list arg2 ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : Elm.Expression -> Elm.Expression -> Elm.Expression
portOutgoing arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, arg2 ]


{-| -}
parse : Elm.Expression -> Elm.Expression
parse arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
unsafe : Elm.Expression -> Elm.Expression
unsafe arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1 ]


{-| -}
signature : Elm.Expression -> Elm.Expression
signature arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "signature"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
expressionImports : Elm.Expression -> Elm.Expression
expressionImports arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expressionImports"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
declarationToString : Elm.Expression -> Elm.Expression
declarationToString arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
declarationImports : Elm.Expression -> Elm.Expression
declarationImports arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationImports"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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
        [ arg1, Elm.list arg2 ]


{-| -}
value : Elm.Expression -> Elm.Expression
value arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ arg1 ]


{-| -}
valueFrom : List Elm.Expression -> Elm.Expression -> Elm.Expression
valueFrom arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueFrom"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-| -}
valueWith :
    { importFrom : List Elm.Expression
    , name : Elm.Expression
    , annotation : Elm.Expression
    }
    -> Elm.Expression
valueWith arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueWith"
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
            [ Elm.field "importFrom" (Elm.list arg1.importFrom)
            , Elm.field "name" arg1.name
            , Elm.field "annotation" arg1.annotation
            ]
        ]


types_ :
    { file :
        { annotation : Type.Annotation
        , create :
            { path : Elm.Expression, contents : Elm.Expression }
            -> Elm.Expression
        }
    , expression : { annotation : Type.Annotation }
    , field : { annotation : Type.Annotation }
    , declaration : { annotation : Type.Annotation }
    , variant : { annotation : Type.Annotation }
    }
types_ =
    { file =
        { annotation = Type.namedWith moduleName_ "File" []
        , create =
            \arg_0_0 ->
                Elm.record
                    [ Elm.field "path" arg_0_0.path
                    , Elm.field "contents" arg_0_0.contents
                    ]
        }
    , expression = { annotation = Type.namedWith moduleName_ "Expression" [] }
    , field = { annotation = Type.namedWith moduleName_ "Field" [] }
    , declaration = { annotation = Type.namedWith moduleName_ "Declaration" [] }
    , variant = { annotation = Type.namedWith moduleName_ "Variant" [] }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { file : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , char : Elm.Expression
    , string : Elm.Expression
    , hex : Elm.Expression
    , unit : Elm.Expression
    , maybe : Elm.Expression
    , list : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , withType : Elm.Expression
    , record : Elm.Expression
    , field : Elm.Expression
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
    , functionAdvanced : Elm.Expression
    , customType : Elm.Expression
    , variant : Elm.Expression
    , variantWith : Elm.Expression
    , alias : Elm.Expression
    , equal : Elm.Expression
    , notEqual : Elm.Expression
    , append : Elm.Expression
    , cons : Elm.Expression
    , plus : Elm.Expression
    , minus : Elm.Expression
    , multiply : Elm.Expression
    , divide : Elm.Expression
    , intDivide : Elm.Expression
    , power : Elm.Expression
    , lt : Elm.Expression
    , gt : Elm.Expression
    , lte : Elm.Expression
    , gte : Elm.Expression
    , and : Elm.Expression
    , or : Elm.Expression
    , keep : Elm.Expression
    , skip : Elm.Expression
    , slash : Elm.Expression
    , query : Elm.Expression
    , portIncoming : Elm.Expression
    , portOutgoing : Elm.Expression
    , parse : Elm.Expression
    , unsafe : Elm.Expression
    , toString : Elm.Expression
    , signature : Elm.Expression
    , expressionImports : Elm.Expression
    , declarationToString : Elm.Expression
    , declarationImports : Elm.Expression
    , apply : Elm.Expression
    , value : Elm.Expression
    , valueFrom : Elm.Expression
    , valueWith : Elm.Expression
    }
values_ =
    { file =
        Elm.valueWith
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
    , bool =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "unit"
            , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
            }
    , maybe =
        Elm.valueWith
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
    , list =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Elm" ] "Field" []) ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , field =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Field" [])
                    )
            }
    , get =
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.list (Type.namedWith [ "Elm" ] "Field" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , letIn =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn"
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
    , fn2 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , functionAdvanced =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionAdvanced"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , customType =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
    , equal =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "equal"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , notEqual =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "notEqual"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , append =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , cons =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "cons"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , plus =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , minus =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , multiply =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "multiply"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , divide =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "divide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , intDivide =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "intDivide"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , power =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "power"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , lt =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , gt =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gt"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , lte =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , gte =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gte"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , and =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "and"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , or =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "or"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , keep =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "keep"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , skip =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "skip"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , slash =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , query =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" []
                        , Type.namedWith [ "Elm" ] "Expression" []
                        ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , portIncoming =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , toString =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
    , signature =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "signature"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
    , expressionImports =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expressionImports"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        Type.string
                    )
            }
    , declarationToString =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        Type.string
                    )
            }
    , declarationImports =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationImports"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                        Type.string
                    )
            }
    , apply =
        Elm.valueWith
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
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , valueFrom =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueFrom"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , valueWith =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueWith"
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
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
call_ :
    { file : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bool : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    , char : Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , hex : Elm.Expression -> Elm.Expression
    , maybe : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , record : Elm.Expression -> Elm.Expression
    , field : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    , functionReduced :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , functionAdvanced : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant : Elm.Expression -> Elm.Expression
    , variantWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , alias : Elm.Expression -> Elm.Expression -> Elm.Expression
    , equal : Elm.Expression -> Elm.Expression -> Elm.Expression
    , notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cons : Elm.Expression -> Elm.Expression -> Elm.Expression
    , plus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , minus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
    , divide : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
    , power : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lte : Elm.Expression -> Elm.Expression -> Elm.Expression
    , gte : Elm.Expression -> Elm.Expression -> Elm.Expression
    , and : Elm.Expression -> Elm.Expression -> Elm.Expression
    , or : Elm.Expression -> Elm.Expression -> Elm.Expression
    , keep : Elm.Expression -> Elm.Expression -> Elm.Expression
    , skip : Elm.Expression -> Elm.Expression -> Elm.Expression
    , slash : Elm.Expression -> Elm.Expression -> Elm.Expression
    , query : Elm.Expression -> Elm.Expression -> Elm.Expression
    , portIncoming : Elm.Expression -> Elm.Expression -> Elm.Expression
    , portOutgoing : Elm.Expression -> Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression
    , unsafe : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    , signature : Elm.Expression -> Elm.Expression
    , expressionImports : Elm.Expression -> Elm.Expression
    , declarationToString : Elm.Expression -> Elm.Expression
    , declarationImports : Elm.Expression -> Elm.Expression
    , apply : Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : Elm.Expression -> Elm.Expression
    , valueFrom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , valueWith : Elm.Expression -> Elm.Expression
    }
call_ =
    { file =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , bool =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , int =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , float =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , char =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , string =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , hex =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , maybe =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , list =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , tuple =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , triple =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , withType =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , record =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "record"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith [ "Elm" ] "Field" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0 ]
    , field =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "field"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Field" [])
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , get =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , updateRecord =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "updateRecord"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" []
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Field" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , letIn =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , ifThen =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , comment =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , declaration =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , withDocumentation =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , expose =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , exposeWith =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , fileWith =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0, arg3_0 ]
    , docs =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , fn =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn"
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
                [ arg1_0, arg2_0 ]
    , fn2 =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
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
                [ arg1_0, arg2_0, arg3_0 ]
    , fn3 =
        \arg1_0 arg2_0 arg3_0 arg4_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.string
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
                [ arg1_0, arg2_0, arg3_0, arg4_0 ]
    , fn4 =
        \arg1_0 arg2_0 arg3_0 arg4_0 arg5_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.string
                                , Type.string
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
                [ arg1_0, arg2_0, arg3_0, arg4_0, arg5_0 ]
    , fn5 =
        \arg1_0 arg2_0 arg3_0 arg4_0 arg5_0 arg6_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
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
                [ arg1_0, arg2_0, arg3_0, arg4_0, arg5_0, arg6_0 ]
    , fn6 =
        \arg1_0 arg2_0 arg3_0 arg4_0 arg5_0 arg6_0 arg7_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "fn6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
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
                [ arg1_0, arg2_0, arg3_0, arg4_0, arg5_0, arg6_0, arg7_0 ]
    , function =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , functionReduced =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "functionReduced"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , functionAdvanced =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "functionAdvanced"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.namedWith [ "Elm" ] "Expression" []
                                ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , customType =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , variant =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , variantWith =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , alias =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , equal =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "equal"
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
                [ arg1_0, arg2_0 ]
    , notEqual =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "notEqual"
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
                [ arg1_0, arg2_0 ]
    , append =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "append"
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
                [ arg1_0, arg2_0 ]
    , cons =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "cons"
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
                [ arg1_0, arg2_0 ]
    , plus =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "plus"
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
                [ arg1_0, arg2_0 ]
    , minus =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "minus"
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
                [ arg1_0, arg2_0 ]
    , multiply =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "multiply"
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
                [ arg1_0, arg2_0 ]
    , divide =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "divide"
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
                [ arg1_0, arg2_0 ]
    , intDivide =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "intDivide"
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
                [ arg1_0, arg2_0 ]
    , power =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "power"
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
                [ arg1_0, arg2_0 ]
    , lt =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "lt"
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
                [ arg1_0, arg2_0 ]
    , gt =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "gt"
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
                [ arg1_0, arg2_0 ]
    , lte =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "lte"
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
                [ arg1_0, arg2_0 ]
    , gte =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "gte"
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
                [ arg1_0, arg2_0 ]
    , and =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "and"
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
                [ arg1_0, arg2_0 ]
    , or =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "or"
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
                [ arg1_0, arg2_0 ]
    , keep =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "keep"
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
                [ arg1_0, arg2_0 ]
    , skip =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "skip"
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
                [ arg1_0, arg2_0 ]
    , slash =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "slash"
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
                [ arg1_0, arg2_0 ]
    , query =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "query"
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
                [ arg1_0, arg2_0 ]
    , portIncoming =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , portOutgoing =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , parse =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , unsafe =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , toString =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0 ]
    , signature =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "signature"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                Type.string
                            )
                    }
                )
                [ arg1_0 ]
    , expressionImports =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "expressionImports"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                Type.string
                            )
                    }
                )
                [ arg1_0 ]
    , declarationToString =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "declarationToString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                Type.string
                            )
                    }
                )
                [ arg1_0 ]
    , declarationImports =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "declarationImports"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                Type.string
                            )
                    }
                )
                [ arg1_0 ]
    , apply =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
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
                [ arg1_0, arg2_0 ]
    , value =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "value"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0 ]
    , valueFrom =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "valueFrom"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string, Type.string ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , valueWith =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Elm" ]
                    , name = "valueWith"
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
                [ arg1_0 ]
    }


