module Gen.Elm exposing (alias, aliasWith, annotation_, apply, bool, call_, char, comment, customType, customTypeWith, declaration, docs, expose, exposeWith, file, fileWith, float, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, get, hex, ifThen, int, just, list, make_, maybe, moduleName_, nothing, parse, portIncoming, portOutgoing, record, string, toString, triple, tuple, unit, unsafe, unwrap, unwrapper, updateRecord, val, value, values_, variant, variantWith, withDocumentation, withType)

{-| 
@docs moduleName_, file, toString, bool, int, float, char, string, hex, unit, maybe, just, nothing, list, tuple, triple, withType, record, get, updateRecord, ifThen, comment, declaration, withDocumentation, expose, exposeWith, fileWith, docs, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, customType, customTypeWith, variant, variantWith, alias, aliasWith, portIncoming, portOutgoing, parse, unsafe, apply, val, value, unwrap, unwrapper, annotation_, make_, call_, values_
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

file: List String -> List Elm.Declaration -> Elm.File
-}
file : List String -> List Elm.Expression -> Elm.Expression
file fileArg fileArg0 =
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
        [ Elm.list (List.map Elm.string fileArg), Elm.list fileArg0 ]


{-| See what code this expression would generate!

**Note** - Check out the `Elm.ToString` module if this doesn't quite meet your needs!

toString: Elm.Expression -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
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
        [ toStringArg ]


{-| bool: Bool -> Elm.Expression -}
bool : Bool -> Elm.Expression
bool boolArg =
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
        [ Elm.bool boolArg ]


{-| int: Int -> Elm.Expression -}
int : Int -> Elm.Expression
int intArg =
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
        [ Elm.int intArg ]


{-| float: Float -> Elm.Expression -}
float : Float -> Elm.Expression
float floatArg =
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
        [ Elm.float floatArg ]


{-| char: Char.Char -> Elm.Expression -}
char : Char.Char -> Elm.Expression
char charArg =
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
        [ Elm.char charArg ]


{-| string: String -> Elm.Expression -}
string : String -> Elm.Expression
string stringArg =
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
        [ Elm.string stringArg ]


{-| hex: Int -> Elm.Expression -}
hex : Int -> Elm.Expression
hex hexArg =
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
        [ Elm.int hexArg ]


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
maybe maybeArg =
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
        [ maybeArg ]


{-| just: Elm.Expression -> Elm.Expression -}
just : Elm.Expression -> Elm.Expression
just justArg =
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
        [ justArg ]


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
list listArg =
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
        [ Elm.list listArg ]


{-| tuple: Elm.Expression -> Elm.Expression -> Elm.Expression -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg tupleArg0 =
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
        [ tupleArg, tupleArg0 ]


{-| triple: Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 =
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
        [ tripleArg, tripleArg0, tripleArg1 ]


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType Type.string

Though be sure `elm-codegen` isn't already doing this automatically for you!

withType: Elm.Annotation.Annotation -> Elm.Expression -> Elm.Expression
-}
withType : Elm.Expression -> Elm.Expression -> Elm.Expression
withType withTypeArg withTypeArg0 =
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
        [ withTypeArg, withTypeArg0 ]


{-| Elm.record
        [ ( "name", Elm.string "Elm" )
        , ( "designation", Elm.string "Pretty fabulous" )
        ]

record: List ( String, Elm.Expression ) -> Elm.Expression
-}
record : List Elm.Expression -> Elm.Expression
record recordArg =
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
        [ Elm.list recordArg ]


{-| record
        |> Elm.get "field"

results in

    record.field

get: String -> Elm.Expression -> Elm.Expression
-}
get : String -> Elm.Expression -> Elm.Expression
get getArg getArg0 =
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
        [ Elm.string getArg, getArg0 ]


{-| myRecord
        |> updateRecord
            [ ( "designation", Elm.string "Pretty fabulous" )
            ]

Results in

    { myRecord | designation = "Pretty fabulous" }

updateRecord: List ( String, Elm.Expression ) -> Elm.Expression -> Elm.Expression
-}
updateRecord : List Elm.Expression -> Elm.Expression -> Elm.Expression
updateRecord updateRecordArg updateRecordArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
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
        [ Elm.list updateRecordArg, updateRecordArg0 ]


{-| ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

Will generate

    if True then
        "yes"

    else
        "no"

If you need more than one branch, then chain them together!

     Elm.ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.ifThen (Elm.bool True)
            (Elm.string "maybe")
            (Elm.string "no")
        )

Will generate

    if True then
        "yes"

    else if True then
        "maybe"

    else
        "no"

ifThen: Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
-}
ifThen : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
ifThen ifThenArg ifThenArg0 ifThenArg1 =
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
        [ ifThenArg, ifThenArg0, ifThenArg1 ]


{-| Renders a multiline comment.

    Elm.comment """Here is my comment!"""

Will generate



    {- Here is my comment! -}

comment: String -> Elm.Declaration
-}
comment : String -> Elm.Expression
comment commentArg =
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
        [ Elm.string commentArg ]


{-| declaration: String -> Elm.Expression -> Elm.Declaration -}
declaration : String -> Elm.Expression -> Elm.Expression
declaration declarationArg declarationArg0 =
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
        [ Elm.string declarationArg, declarationArg0 ]


{-| Add a documentation comment to a declaration!

withDocumentation: String -> Elm.Declaration -> Elm.Declaration
-}
withDocumentation : String -> Elm.Expression -> Elm.Expression
withDocumentation withDocumentationArg withDocumentationArg0 =
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
        [ Elm.string withDocumentationArg, withDocumentationArg0 ]


{-| By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

expose: Elm.Declaration -> Elm.Declaration
-}
expose : Elm.Expression -> Elm.Expression
expose exposeArg =
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
        [ exposeArg ]


{-| You can also add a group tag to an exposed value. This will automatically group the `docs` statements in the module docs.

For precise control over what is rendered for the module comment, use [fileWith](#fileWith).

exposeWith: 
    { exposeConstructor : Bool, group : Maybe String }
    -> Elm.Declaration
    -> Elm.Declaration
-}
exposeWith :
    { exposeConstructor : Bool, group : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
exposeWith exposeWithArg exposeWithArg0 =
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
            [ Tuple.pair
                "exposeConstructor"
                (Elm.bool exposeWithArg.exposeConstructor)
            , Tuple.pair "group" exposeWithArg.group
            ]
        , exposeWithArg0
        ]


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@docs` comment.

Each exposed item is grouped based on the string used in [exposeWith](#exposeWith).

**aliases** allow you to specify a module alias to be used.

    Elm.fileWith [ "MyModule" ]
        { docs = List.map Elm.docs
        , aliases =
            [ ( [ "Json", "Encode" ], "Encode" )
            ]
        }
        [-- whatever declarations you desire.
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
fileWith fileWithArg fileWithArg0 fileWithArg1 =
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
        [ Elm.list (List.map Elm.string fileWithArg)
        , Elm.record
            [ Tuple.pair
                "docs"
                (Elm.functionReduced "fileWithUnpack" fileWithArg0.docs)
            , Tuple.pair "aliases" (Elm.list fileWithArg0.aliases)
            ]
        , Elm.list fileWithArg1
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
docs docsArg =
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
            [ Tuple.pair "group" docsArg.group
            , Tuple.pair
                "members"
                (Elm.list (List.map Elm.string docsArg.members))
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
fn fnArg fnArg0 =
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
        [ fnArg, Elm.functionReduced "fnUnpack" fnArg0 ]


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
fn2 fn2Arg fn2Arg0 fn2Arg1 =
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
        [ fn2Arg
        , fn2Arg0
        , Elm.functionReduced
            "fn2Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (fn2Arg1 functionReducedUnpack)
            )
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
fn3 fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 =
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
        [ fn3Arg
        , fn3Arg0
        , fn3Arg1
        , Elm.functionReduced
            "fn3Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (fn3Arg2 functionReducedUnpack
                                functionReducedUnpack0
                            )
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
fn4 fn4Arg fn4Arg0 fn4Arg1 fn4Arg2 fn4Arg3 =
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
        [ fn4Arg
        , fn4Arg0
        , fn4Arg1
        , fn4Arg2
        , Elm.functionReduced
            "fn4Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_4_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (fn4Arg3 functionReducedUnpack
                                         functionReducedUnpack0
                                        functionReducedUnpack_2_1_2_0_2_4_2_0_0
                                    )
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
fn5 fn5Arg fn5Arg0 fn5Arg1 fn5Arg2 fn5Arg3 fn5Arg4 =
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
        [ fn5Arg
        , fn5Arg0
        , fn5Arg1
        , fn5Arg2
        , fn5Arg3
        , Elm.functionReduced
            "fn5Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_5_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_5_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (fn5Arg4 functionReducedUnpack
                                                 functionReducedUnpack0
                                                 functionReducedUnpack_2_1_2_0_2_5_2_0_0
                                                functionReducedUnpack_2_1_2_1_2_0_2_5_2_0_0
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
fn6 fn6Arg fn6Arg0 fn6Arg1 fn6Arg2 fn6Arg3 fn6Arg4 fn6Arg5 =
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
        [ fn6Arg
        , fn6Arg0
        , fn6Arg1
        , fn6Arg2
        , fn6Arg3
        , fn6Arg4
        , Elm.functionReduced
            "fn6Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_6_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_6_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (fn6Arg5
                                                         functionReducedUnpack
                                                         functionReducedUnpack0
                                                         functionReducedUnpack_2_1_2_0_2_6_2_0_0
                                                         functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0
                                                        functionReducedUnpack_2_1_2_1_2_1_2_0_2_6_2_0_0
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
function functionArg functionArg0 =
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
        [ Elm.list functionArg
        , Elm.functionReduced "functionUnpack" functionArg0
        ]


{-| This is a special case of function declaration which will _reduce_ itself if possible.

Meaning, if this would generate the following code

    \myArg -> someOtherFunction myArg

Then it will replace itself with just

    someOtherFunction

**Note** you likely won't need this! It's generally used by the package-helper generator, but that might be a relatively special case.

functionReduced: String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
-}
functionReduced : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
functionReduced functionReducedArg functionReducedArg0 =
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
        [ Elm.string functionReducedArg
        , Elm.functionReduced "functionReducedUnpack" functionReducedArg0
        ]


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
customType customTypeArg customTypeArg0 =
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
        [ Elm.string customTypeArg, Elm.list customTypeArg0 ]


{-| A custom type declaration, with the ability to specify in which order to put the type variables.

    Elm.customTypeWith "MyType"
        [ "addVar", "twoVar" ]
        [ Elm.variantWith "One"
            [ Elm.Annotation.var "oneVar" ]
        , Elm.variantWith "Two"
            [ Elm.Annotation.var "twoVar" ]
        ]

Will result in

    type MyType addVar twoVar oneVar
        = One oneVar
        | Two twoVar

Notice how nonexisting variables (as used in phantom types) are included, and missing variable are automatically added.

customTypeWith: String -> List String -> List Elm.Variant -> Elm.Declaration
-}
customTypeWith : String -> List String -> List Elm.Expression -> Elm.Expression
customTypeWith customTypeWithArg customTypeWithArg0 customTypeWithArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "customTypeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list Type.string
                        , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string customTypeWithArg
        , Elm.list (List.map Elm.string customTypeWithArg0)
        , Elm.list customTypeWithArg1
        ]


{-| variant: String -> Elm.Variant -}
variant : String -> Elm.Expression
variant variantArg =
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
        [ Elm.string variantArg ]


{-| variantWith: String -> List Elm.Annotation.Annotation -> Elm.Variant -}
variantWith : String -> List Elm.Expression -> Elm.Expression
variantWith variantWithArg variantWithArg0 =
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
        [ Elm.string variantWithArg, Elm.list variantWithArg0 ]


{-| A type alias declaration.

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
alias aliasArg aliasArg0 =
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
        [ Elm.string aliasArg, aliasArg0 ]


{-| A type alias declaration, with the ability to specify in which order to put the type variables.

    import Elm.Annotation as Type

    Elm.aliasWith "MyAlias" [ "twoVar", "nonexistingVar", "oneVar" ]
        (Type.record
            [ ( "one", Type.var "oneVar" )
            , ( "two", Type.var "twoVar" )
            , ( "three", Type.var "threeVar" )
            ]
        )

Should result in

    type alias MyAlias twoVar oneVar threeVar =
        { one : oneVar
        , two : twoVar
        , three : threeVar
        }

Notice how nonexisting variables are omitted, and missing variable are automatically added.

aliasWith: String -> List String -> Elm.Annotation.Annotation -> Elm.Declaration
-}
aliasWith : String -> List String -> Elm.Expression -> Elm.Expression
aliasWith aliasWithArg aliasWithArg0 aliasWithArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "aliasWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
        )
        [ Elm.string aliasWithArg
        , Elm.list (List.map Elm.string aliasWithArg0)
        , aliasWithArg1
        ]


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

**Another note** - You may need to expose your port explicitly using [`Elm.expose`](#expose).

portIncoming: String -> List Elm.Annotation.Annotation -> Elm.Declaration
-}
portIncoming : String -> List Elm.Expression -> Elm.Expression
portIncoming portIncomingArg portIncomingArg0 =
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
        [ Elm.string portIncomingArg, Elm.list portIncomingArg0 ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

portOutgoing: String -> Elm.Annotation.Annotation -> Elm.Declaration
-}
portOutgoing : String -> Elm.Expression -> Elm.Expression
portOutgoing portOutgoingArg portOutgoingArg0 =
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
        [ Elm.string portOutgoingArg, portOutgoingArg0 ]


{-| parse: String -> Result.Result String { declarations : List Elm.Declaration } -}
parse : String -> Elm.Expression
parse parseArg =
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
        [ Elm.string parseArg ]


{-| This will insert the given string into your generated file.

Check out the [using packages/helpers guide](https://github.com/mdgriffith/elm-codegen/tree/main/guide/UsingHelpers.md). If you're reaching for this, it's likely you'd be better off using a local helper file!

unsafe: String -> Elm.Declaration
-}
unsafe : String -> Elm.Expression
unsafe unsafeArg =
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
        [ Elm.string unsafeArg ]


{-| apply: Elm.Expression -> List Elm.Expression -> Elm.Expression -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply applyArg applyArg0 =
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
        [ applyArg, Elm.list applyArg0 ]


{-| val: String -> Elm.Expression -}
val : String -> Elm.Expression
val valArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm" ]
            , name = "val"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
        )
        [ Elm.string valArg ]


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
value valueArg =
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
                (Elm.list (List.map Elm.string valueArg.importFrom))
            , Tuple.pair "name" (Elm.string valueArg.name)
            , Tuple.pair "annotation" valueArg.annotation
            ]
        ]


{-| Unwraps a single-variant type

    Elm.declaration "myFunction" <|
        Elm.fn "val"
            (\val ->
                Elm.unwrap "MyType" val
            )

Results in the following lambda

    myFunction val =
        (\(MyType val) -> val) val

unwrap: List String -> String -> Elm.Expression -> Elm.Expression
-}
unwrap : List String -> String -> Elm.Expression -> Elm.Expression
unwrap unwrapArg unwrapArg0 unwrapArg1 =
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
        [ Elm.list (List.map Elm.string unwrapArg)
        , Elm.string unwrapArg0
        , unwrapArg1
        ]


{-| Generate a lambda which unwraps a single-variant type.

    Elm.unwrapper [ "MyModule" ] "MyType"

Results in the following lambda

    \(MyModule.MyType val) -> val

unwrapper: List String -> String -> Elm.Expression
-}
unwrapper : List String -> String -> Elm.Expression
unwrapper unwrapperArg unwrapperArg0 =
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
        [ Elm.list (List.map Elm.string unwrapperArg)
        , Elm.string unwrapperArg0
        ]


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
                [ ( "path", Type.string )
                , ( "contents", Type.string )
                , ( "warnings"
                  , Type.list
                        (Type.record
                            [ ( "declaration", Type.string )
                            , ( "warning", Type.string )
                            ]
                        )
                  )
                ]
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
    , variant = Type.namedWith [ "Elm" ] "Variant" []
    }


make_ :
    { file :
        { path : Elm.Expression
        , contents : Elm.Expression
        , warnings : Elm.Expression
        }
        -> Elm.Expression
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
                        [ ( "path", Type.string )
                        , ( "contents", Type.string )
                        , ( "warnings"
                          , Type.list
                                (Type.record
                                    [ ( "declaration", Type.string )
                                    , ( "warning", Type.string )
                                    ]
                                )
                          )
                        ]
                    )
                )
                (Elm.record
                    [ Tuple.pair "path" file_args.path
                    , Tuple.pair "contents" file_args.contents
                    , Tuple.pair "warnings" file_args.warnings
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
    , customTypeWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant : Elm.Expression -> Elm.Expression
    , variantWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , alias : Elm.Expression -> Elm.Expression -> Elm.Expression
    , aliasWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , portIncoming : Elm.Expression -> Elm.Expression -> Elm.Expression
    , portOutgoing : Elm.Expression -> Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression
    , unsafe : Elm.Expression -> Elm.Expression
    , apply : Elm.Expression -> Elm.Expression -> Elm.Expression
    , val : Elm.Expression -> Elm.Expression
    , value : Elm.Expression -> Elm.Expression
    , unwrap :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , unwrapper : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { file =
        \fileArg fileArg0 ->
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
                [ fileArg, fileArg0 ]
    , toString =
        \toStringArg ->
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
                [ toStringArg ]
    , bool =
        \boolArg ->
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
                [ boolArg ]
    , int =
        \intArg ->
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
                [ intArg ]
    , float =
        \floatArg ->
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
                [ floatArg ]
    , char =
        \charArg ->
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
                [ charArg ]
    , string =
        \stringArg ->
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
                [ stringArg ]
    , hex =
        \hexArg ->
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
                [ hexArg ]
    , maybe =
        \maybeArg ->
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
                [ maybeArg ]
    , just =
        \justArg ->
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
                [ justArg ]
    , list =
        \listArg ->
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
                [ listArg ]
    , tuple =
        \tupleArg tupleArg0 ->
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
                [ tupleArg, tupleArg0 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 ->
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
                [ tripleArg, tripleArg0, tripleArg1 ]
    , withType =
        \withTypeArg withTypeArg0 ->
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
                [ withTypeArg, withTypeArg0 ]
    , record =
        \recordArg ->
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
                [ recordArg ]
    , get =
        \getArg getArg0 ->
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
                [ getArg, getArg0 ]
    , updateRecord =
        \updateRecordArg updateRecordArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "updateRecord"
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
                [ updateRecordArg, updateRecordArg0 ]
    , ifThen =
        \ifThenArg ifThenArg0 ifThenArg1 ->
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
                [ ifThenArg, ifThenArg0, ifThenArg1 ]
    , comment =
        \commentArg ->
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
                [ commentArg ]
    , declaration =
        \declarationArg declarationArg0 ->
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
                [ declarationArg, declarationArg0 ]
    , withDocumentation =
        \withDocumentationArg withDocumentationArg0 ->
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
                [ withDocumentationArg, withDocumentationArg0 ]
    , expose =
        \exposeArg ->
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
                [ exposeArg ]
    , exposeWith =
        \exposeWithArg exposeWithArg0 ->
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
                [ exposeWithArg, exposeWithArg0 ]
    , fileWith =
        \fileWithArg fileWithArg0 fileWithArg1 ->
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
                [ fileWithArg, fileWithArg0, fileWithArg1 ]
    , docs =
        \docsArg ->
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
                [ docsArg ]
    , fn =
        \fnArg fnArg0 ->
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
                [ fnArg, fnArg0 ]
    , fn2 =
        \fn2Arg fn2Arg0 fn2Arg1 ->
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
                [ fn2Arg, fn2Arg0, fn2Arg1 ]
    , fn3 =
        \fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 ->
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
                [ fn3Arg, fn3Arg0, fn3Arg1, fn3Arg2 ]
    , fn4 =
        \fn4Arg fn4Arg0 fn4Arg1 fn4Arg2 fn4Arg3 ->
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
                [ fn4Arg, fn4Arg0, fn4Arg1, fn4Arg2, fn4Arg3 ]
    , fn5 =
        \fn5Arg fn5Arg0 fn5Arg1 fn5Arg2 fn5Arg3 fn5Arg4 ->
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
                [ fn5Arg, fn5Arg0, fn5Arg1, fn5Arg2, fn5Arg3, fn5Arg4 ]
    , fn6 =
        \fn6Arg fn6Arg0 fn6Arg1 fn6Arg2 fn6Arg3 fn6Arg4 fn6Arg5 ->
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
                [ fn6Arg, fn6Arg0, fn6Arg1, fn6Arg2, fn6Arg3, fn6Arg4, fn6Arg5 ]
    , function =
        \functionArg functionArg0 ->
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
                [ functionArg, functionArg0 ]
    , functionReduced =
        \functionReducedArg functionReducedArg0 ->
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
                [ functionReducedArg, functionReducedArg0 ]
    , customType =
        \customTypeArg customTypeArg0 ->
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
                [ customTypeArg, customTypeArg0 ]
    , customTypeWith =
        \customTypeWithArg customTypeWithArg0 customTypeWithArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "customTypeWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list Type.string
                                , Type.list
                                    (Type.namedWith [ "Elm" ] "Variant" [])
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ customTypeWithArg, customTypeWithArg0, customTypeWithArg1 ]
    , variant =
        \variantArg ->
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
                [ variantArg ]
    , variantWith =
        \variantWithArg variantWithArg0 ->
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
                [ variantWithArg, variantWithArg0 ]
    , alias =
        \aliasArg aliasArg0 ->
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
                [ aliasArg, aliasArg0 ]
    , aliasWith =
        \aliasWithArg aliasWithArg0 aliasWithArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "aliasWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.list Type.string
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                    }
                )
                [ aliasWithArg, aliasWithArg0, aliasWithArg1 ]
    , portIncoming =
        \portIncomingArg portIncomingArg0 ->
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
                [ portIncomingArg, portIncomingArg0 ]
    , portOutgoing =
        \portOutgoingArg portOutgoingArg0 ->
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
                [ portOutgoingArg, portOutgoingArg0 ]
    , parse =
        \parseArg ->
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
                [ parseArg ]
    , unsafe =
        \unsafeArg ->
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
                [ unsafeArg ]
    , apply =
        \applyArg applyArg0 ->
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
                [ applyArg, applyArg0 ]
    , val =
        \valArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm" ]
                    , name = "val"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                    }
                )
                [ valArg ]
    , value =
        \valueArg ->
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
                [ valueArg ]
    , unwrap =
        \unwrapArg unwrapArg0 unwrapArg1 ->
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
                [ unwrapArg, unwrapArg0, unwrapArg1 ]
    , unwrapper =
        \unwrapperArg unwrapperArg0 ->
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
                [ unwrapperArg, unwrapperArg0 ]
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
    , customTypeWith : Elm.Expression
    , variant : Elm.Expression
    , variantWith : Elm.Expression
    , alias : Elm.Expression
    , aliasWith : Elm.Expression
    , portIncoming : Elm.Expression
    , portOutgoing : Elm.Expression
    , parse : Elm.Expression
    , unsafe : Elm.Expression
    , apply : Elm.Expression
    , val : Elm.Expression
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
    , customTypeWith =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "customTypeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list Type.string
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
    , aliasWith =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "aliasWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list Type.string
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
    , val =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "val"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
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