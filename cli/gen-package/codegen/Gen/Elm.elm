module Gen.Elm exposing
    ( alias
    , aliasWith
    , annotation_
    , apply
    , body
    , bool
    , call_
    , char
    , comment
    , customType
    , customTypeWith
    , declaration
    , docs
    , expose
    , exposeConstructor
    , file
    , fileWith
    , float
    , fn
    , fn2
    , fn3
    , fnArg
    , fnBuilder
    , fnDone
    , function
    , functionReduced
    , get
    , group
    , hex
    , ifThen
    , int
    , just
    , list
    , make_
    , maybe
    , moduleName_
    , nothing
    , parse
    , portIncoming
    , portOutgoing
    , record
    , string
    , toString
    , triple
    , tuple
    , unit
    , unsafe
    , unwrap
    , unwrapper
    , updateRecord
    , val
    , value
    , values_
    , variant
    , variantWith
    , withDocumentation
    , withType
    )

{-|
# Generated bindings for Elm

@docs moduleName_, file, toString, bool, int, float, char, string, hex, unit, maybe, just, nothing, list, tuple, triple, withType, record, get, updateRecord, ifThen, comment, docs, declaration, withDocumentation, group, expose, exposeConstructor, fileWith, fn, fn2, fn3, fnBuilder, fnArg, fnDone, body, function, functionReduced, customType, customTypeWith, variant, variantWith, alias, aliasWith, portIncoming, portOutgoing, parse, unsafe, apply, val, value, unwrap, unwrapper, annotation_, make_, call_, values_
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
file fileArg_ fileArg_0 =
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
        [ Elm.list (List.map Elm.string fileArg_), Elm.list fileArg_0 ]


{-| See what code this expression would generate!

**Note** - Check out the `Elm.ToString` module if this doesn't quite meet your needs!

toString: Elm.Expression -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
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
        [ toStringArg_ ]


{-| bool: Bool -> Elm.Expression -}
bool : Bool -> Elm.Expression
bool boolArg_ =
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
        [ Elm.bool boolArg_ ]


{-| int: Int -> Elm.Expression -}
int : Int -> Elm.Expression
int intArg_ =
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
        [ Elm.int intArg_ ]


{-| float: Float -> Elm.Expression -}
float : Float -> Elm.Expression
float floatArg_ =
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
        [ Elm.float floatArg_ ]


{-| char: Char.Char -> Elm.Expression -}
char : Char.Char -> Elm.Expression
char charArg_ =
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
        [ Elm.char charArg_ ]


{-| string: String -> Elm.Expression -}
string : String -> Elm.Expression
string stringArg_ =
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
        [ Elm.string stringArg_ ]


{-| hex: Int -> Elm.Expression -}
hex : Int -> Elm.Expression
hex hexArg_ =
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
        [ Elm.int hexArg_ ]


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
maybe maybeArg_ =
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
        [ maybeArg_ ]


{-| just: Elm.Expression -> Elm.Expression -}
just : Elm.Expression -> Elm.Expression
just justArg_ =
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
        [ justArg_ ]


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
list listArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "list"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ Elm.list listArg_ ]


{-| tuple: Elm.Expression -> Elm.Expression -> Elm.Expression -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg_ tupleArg_0 =
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
        [ tupleArg_, tupleArg_0 ]


{-| triple: Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg_ tripleArg_0 tripleArg_1 =
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
        [ tripleArg_, tripleArg_0, tripleArg_1 ]


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value
        { importFrom = []
        , name = "myString"
        , annotation = Nothing
        }
        |> Elm.withType Type.string

Though be sure `elm-codegen` isn't already doing this automatically for you!

withType: Elm.Annotation.Annotation -> Elm.Expression -> Elm.Expression
-}
withType : Elm.Expression -> Elm.Expression -> Elm.Expression
withType withTypeArg_ withTypeArg_0 =
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
        [ withTypeArg_, withTypeArg_0 ]


{-| Elm.record
        [ ( "name", Elm.string "Elm" )
        , ( "designation", Elm.string "Pretty fabulous" )
        ]

record: List ( String, Elm.Expression ) -> Elm.Expression
-}
record : List Elm.Expression -> Elm.Expression
record recordArg_ =
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
        [ Elm.list recordArg_ ]


{-| record
        |> Elm.get "field"

results in

    record.field

get: String -> Elm.Expression -> Elm.Expression
-}
get : String -> Elm.Expression -> Elm.Expression
get getArg_ getArg_0 =
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
        [ Elm.string getArg_, getArg_0 ]


{-| myRecord
        |> updateRecord
            [ ( "designation", Elm.string "Pretty fabulous" )
            ]

Results in

    { myRecord | designation = "Pretty fabulous" }

updateRecord: List ( String, Elm.Expression ) -> Elm.Expression -> Elm.Expression
-}
updateRecord : List Elm.Expression -> Elm.Expression -> Elm.Expression
updateRecord updateRecordArg_ updateRecordArg_0 =
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
        [ Elm.list updateRecordArg_, updateRecordArg_0 ]


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
ifThen ifThenArg_ ifThenArg_0 ifThenArg_1 =
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
        [ ifThenArg_, ifThenArg_0, ifThenArg_1 ]


{-| Renders a multiline comment.

    Elm.comment """Here is my comment!"""

Will generate



    {- Here is my comment! -}

comment: String -> Elm.Declaration
-}
comment : String -> Elm.Expression
comment commentArg_ =
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
        [ Elm.string commentArg_ ]


{-| This will include some markdown in the module doc comment.

docs: String -> Elm.Declaration
-}
docs : String -> Elm.Expression
docs docsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "docs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Elm" ] "Declaration" [])
                     )
             }
        )
        [ Elm.string docsArg_ ]


{-| declaration: String -> Elm.Expression -> Elm.Declaration -}
declaration : String -> Elm.Expression -> Elm.Expression
declaration declarationArg_ declarationArg_0 =
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
        [ Elm.string declarationArg_, declarationArg_0 ]


{-| Add a documentation comment to a declaration!

withDocumentation: String -> Elm.Declaration -> Elm.Declaration
-}
withDocumentation : String -> Elm.Expression -> Elm.Expression
withDocumentation withDocumentationArg_ withDocumentationArg_0 =
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
        [ Elm.string withDocumentationArg_, withDocumentationArg_0 ]


{-| Group declarations in a module.

This will add a `@docs` tag to the module doc comment for any exposed functions in the group.

    Elm.group
        [ myFunction
        , myOtherFunction
        ]

Will create the following module doc comment:

    @docs myFunction, myOtherFunction

group: List Elm.Declaration -> Elm.Declaration
-}
group : List Elm.Expression -> Elm.Expression
group groupArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "group"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Elm" ] "Declaration" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Declaration" [])
                     )
             }
        )
        [ Elm.list groupArg_ ]


{-| By default, everything is exposed for your module.

However, you can tag specific declarations you want exposed, and then only those things will be exposed.

expose: Elm.Declaration -> Elm.Declaration
-}
expose : Elm.Expression -> Elm.Expression
expose exposeArg_ =
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
        [ exposeArg_ ]


{-| exposeConstructor: Elm.Declaration -> Elm.Declaration -}
exposeConstructor : Elm.Expression -> Elm.Expression
exposeConstructor exposeConstructorArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "exposeConstructor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                          (Type.namedWith [ "Elm" ] "Declaration" [])
                     )
             }
        )
        [ exposeConstructorArg_ ]


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@docs` comment.

Each exposed item is grouped using [group](#group).

**aliases** allow you to specify a module alias to be used.

    Elm.fileWith [ "MyModule" ]
        { docs = "# Here's my cool module!"
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
    -> { docs : String, aliases : List ( List String, String ) }
    -> List Elm.Declaration
    -> Elm.File
-}
fileWith :
    List String
    -> { docs : String, aliases : List Elm.Expression }
    -> List Elm.Expression
    -> Elm.Expression
fileWith fileWithArg_ fileWithArg_0 fileWithArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fileWith"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string
                          , Type.record
                              [ ( "docs", Type.string )
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
        [ Elm.list (List.map Elm.string fileWithArg_)
        , Elm.record
            [ Tuple.pair "docs" (Elm.string fileWithArg_0.docs)
            , Tuple.pair "aliases" (Elm.list fileWithArg_0.aliases)
            ]
        , Elm.list fileWithArg_1
        ]


{-| Create a function with a single argument.

This may seem a little weird the first time you encounter it, so let's break it down.

Here's what's happening for the `fn*` functions —

  - The `String` arguments are the **names of the arguments** for the generated function.
  - The attached `Maybe Annotation` is the type annotation. If you provide `Nothing`, then `elm-codegen` will infer the type for you!
  - The `(Expression -> Expression)` function is where we're providing you an `Expression` that represents an argument coming in to the generated function.

So, this

    Elm.fn (Elm.Arg.var "firstInt")
        (\firstArgument ->
            Elm.Op.plus
                (Elm.int 42)
                firstArgument
        )

Generates

    \firstInt -> 42 + firstInt

If you want to generate a **top level** function instead of an anonymous function, use `Elm.declaration`.

    Elm.declaration "add42" <|
        Elm.fn (Elm.Arg.var "firstInt")
            (\firstArgument ->
                Elm.Op.plus
                    (Elm.int 42)
                    firstArgument
            )

Results in

    add42 : Int -> Int
    add42 firstInt =
        42 + firstInt

**Note** — Elm CodeGen will protect variable names if they're used in a nested `fn*` by adding a string of numbers to the end of the name. So, you may see a variable name be something like `myVariable_0_1`.

fn: Elm.Arg arg -> (arg -> Elm.Expression) -> Elm.Expression
-}
fn : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
fn fnArg_ fnArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fn"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                          , Type.function
                              [ Type.var "arg" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ fnArg_, Elm.functionReduced "fnUnpack" fnArg_0 ]


{-| fn2: Elm.Arg one -> Elm.Arg two -> (one -> two -> Elm.Expression) -> Elm.Expression -}
fn2 :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 fn2Arg_ fn2Arg_0 fn2Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fn2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.function
                              [ Type.var "one", Type.var "two" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ fn2Arg_
        , fn2Arg_0
        , Elm.functionReduced
            "fn2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (fn2Arg_1 functionReducedUnpack)
            )
        ]


{-| fn3: 
    Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> (one -> two -> three -> Elm.Expression)
    -> Elm.Expression
-}
fn3 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn3 fn3Arg_ fn3Arg_0 fn3Arg_1 fn3Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fn3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ fn3Arg_
        , fn3Arg_0
        , fn3Arg_1
        , Elm.functionReduced
            "fn3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((fn3Arg_2 functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        ]


{-| Build a function with any number of arguments.

Here's how you'd implement a function which adds two numbers together:

    Elm.fnBuilder
        (\arg1 arg2 ->
            Elm.Op.plus arg1 arg2
        )
        |> Elm.fnArg (Elm.Arg.var "arg1")
        |> Elm.fnArg (Elm.Arg.var "arg2")
        |> Elm.fnDone

fnBuilder: value -> Elm.Fn value
-}
fnBuilder : Elm.Expression -> Elm.Expression
fnBuilder fnBuilderArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fnBuilder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "value" ]
                          (Type.namedWith [ "Elm" ] "Fn" [ Type.var "value" ])
                     )
             }
        )
        [ fnBuilderArg_ ]


{-| fnArg: Elm.Arg arg -> Elm.Fn (arg -> value) -> Elm.Fn value -}
fnArg : Elm.Expression -> Elm.Expression -> Elm.Expression
fnArg fnArgArg_ fnArgArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fnArg"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                          , Type.namedWith
                              [ "Elm" ]
                              "Fn"
                              [ Type.function
                                    [ Type.var "arg" ]
                                    (Type.var "value")
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Fn" [ Type.var "value" ])
                     )
             }
        )
        [ fnArgArg_, fnArgArg_0 ]


{-| fnDone: Elm.Fn Elm.Expression -> Elm.Expression -}
fnDone : Elm.Expression -> Elm.Expression
fnDone fnDoneArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "fnDone"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm" ]
                              "Fn"
                              [ Type.namedWith [ "Elm" ] "Expression" [] ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ fnDoneArg_ ]


{-| `body` allows you to define the funciton body _after_ defining the args.

So, normally, we'd have this.

    Elm.fnBuilder
        (\arg1 arg2 ->
            Elm.Op.plus arg1 arg2
        )
        |> Elm.fnArg (Elm.Arg.var "arg1")
        |> Elm.fnArg (Elm.Arg.var "arg2")
        |> Elm.fnDone

But, that's sorta weird because you're defining the body before the args.

You can also do this:

    Elm.fnBuilder Tuple.pair
        |> Elm.fnArg (Elm.Arg.var "arg1")
        |> Elm.fnArg (Elm.Arg.var "arg2")
        |> Elm.body
            (\( arg1, arg2 ) ->
                Elm.Op.plus arg1 arg2
            )

Which more closely mirrors the way you'd write a function in Elm.

The downside is that you need to capture the arguments in a data strucutre(in this example, we used `Tuple.pair`).

body: (args -> Elm.Expression) -> Elm.Fn args -> Elm.Expression
-}
body : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
body bodyArg_ bodyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm" ]
             , name = "body"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "args" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith [ "Elm" ] "Fn" [ Type.var "args" ]
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ Elm.functionReduced "bodyUnpack" bodyArg_, bodyArg_0 ]


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
function functionArg_ functionArg_0 =
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
        [ Elm.list functionArg_
        , Elm.functionReduced "functionUnpack" functionArg_0
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
functionReduced functionReducedArg_ functionReducedArg_0 =
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
        [ Elm.string functionReducedArg_
        , Elm.functionReduced "functionReducedUnpack" functionReducedArg_0
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
customType customTypeArg_ customTypeArg_0 =
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
        [ Elm.string customTypeArg_, Elm.list customTypeArg_0 ]


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
customTypeWith customTypeWithArg_ customTypeWithArg_0 customTypeWithArg_1 =
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
        [ Elm.string customTypeWithArg_
        , Elm.list (List.map Elm.string customTypeWithArg_0)
        , Elm.list customTypeWithArg_1
        ]


{-| variant: String -> Elm.Variant -}
variant : String -> Elm.Expression
variant variantArg_ =
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
        [ Elm.string variantArg_ ]


{-| variantWith: String -> List Elm.Annotation.Annotation -> Elm.Variant -}
variantWith : String -> List Elm.Expression -> Elm.Expression
variantWith variantWithArg_ variantWithArg_0 =
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
        [ Elm.string variantWithArg_, Elm.list variantWithArg_0 ]


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
alias aliasArg_ aliasArg_0 =
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
        [ Elm.string aliasArg_, aliasArg_0 ]


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
aliasWith aliasWithArg_ aliasWithArg_0 aliasWithArg_1 =
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
        [ Elm.string aliasWithArg_
        , Elm.list (List.map Elm.string aliasWithArg_0)
        , aliasWithArg_1
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
portIncoming portIncomingArg_ portIncomingArg_0 =
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
        [ Elm.string portIncomingArg_, Elm.list portIncomingArg_0 ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

portOutgoing: String -> Elm.Annotation.Annotation -> Elm.Declaration
-}
portOutgoing : String -> Elm.Expression -> Elm.Expression
portOutgoing portOutgoingArg_ portOutgoingArg_0 =
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
        [ Elm.string portOutgoingArg_, portOutgoingArg_0 ]


{-| parse: String -> Result.Result String { declarations : List Elm.Declaration } -}
parse : String -> Elm.Expression
parse parseArg_ =
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
        [ Elm.string parseArg_ ]


{-| This will insert the given string into your generated file.

Check out the [using packages/helpers guide](https://github.com/mdgriffith/elm-codegen/tree/main/guide/UsingHelpers.md). If you're reaching for this, it's likely you'd be better off using a local helper file!

unsafe: String -> Elm.Declaration
-}
unsafe : String -> Elm.Expression
unsafe unsafeArg_ =
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
        [ Elm.string unsafeArg_ ]


{-| apply: Elm.Expression -> List Elm.Expression -> Elm.Expression -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply applyArg_ applyArg_0 =
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
        [ applyArg_, Elm.list applyArg_0 ]


{-| val: String -> Elm.Expression -}
val : String -> Elm.Expression
val valArg_ =
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
        [ Elm.string valArg_ ]


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
value valueArg_ =
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
                  (Elm.list (List.map Elm.string valueArg_.importFrom))
            , Tuple.pair "name" (Elm.string valueArg_.name)
            , Tuple.pair "annotation" valueArg_.annotation
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
unwrap unwrapArg_ unwrapArg_0 unwrapArg_1 =
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
        [ Elm.list (List.map Elm.string unwrapArg_)
        , Elm.string unwrapArg_0
        , unwrapArg_1
        ]


{-| Generate a lambda which unwraps a single-variant type.

    Elm.unwrapper [ "MyModule" ] "MyType"

Results in the following lambda

    \(MyModule.MyType val) -> val

unwrapper: List String -> String -> Elm.Expression
-}
unwrapper : List String -> String -> Elm.Expression
unwrapper unwrapperArg_ unwrapperArg_0 =
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
        [ Elm.list (List.map Elm.string unwrapperArg_)
        , Elm.string unwrapperArg_0
        ]


annotation_ :
    { file : Type.Annotation
    , expression : Type.Annotation
    , declaration : Type.Annotation
    , arg : Type.Annotation -> Type.Annotation
    , fn : Type.Annotation -> Type.Annotation
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
    , arg =
        \argArg0 ->
            Type.alias
                moduleName_
                "Arg"
                [ argArg0 ]
                (Type.namedWith [ "Internal", "Arg" ] "Arg" [ Type.var "val" ])
    , fn = \fnArg0 -> Type.namedWith [ "Elm" ] "Fn" [ fnArg0 ]
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
    , docs : Elm.Expression -> Elm.Expression
    , declaration : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , group : Elm.Expression -> Elm.Expression
    , expose : Elm.Expression -> Elm.Expression
    , exposeConstructor : Elm.Expression -> Elm.Expression
    , fileWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn2 : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fnBuilder : Elm.Expression -> Elm.Expression
    , fnArg : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnDone : Elm.Expression -> Elm.Expression
    , body : Elm.Expression -> Elm.Expression -> Elm.Expression
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
        \fileArg_ fileArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "file"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string
                                  , Type.list
                                      (Type.namedWith [ "Elm" ] "Declaration" []
                                      )
                                  ]
                                  (Type.namedWith [ "Elm" ] "File" [])
                             )
                     }
                )
                [ fileArg_, fileArg_0 ]
    , toString =
        \toStringArg_ ->
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
                [ toStringArg_ ]
    , bool =
        \boolArg_ ->
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
                [ boolArg_ ]
    , int =
        \intArg_ ->
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
                [ intArg_ ]
    , float =
        \floatArg_ ->
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
                [ floatArg_ ]
    , char =
        \charArg_ ->
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
                [ charArg_ ]
    , string =
        \stringArg_ ->
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
                [ stringArg_ ]
    , hex =
        \hexArg_ ->
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
                [ hexArg_ ]
    , maybe =
        \maybeArg_ ->
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
                [ maybeArg_ ]
    , just =
        \justArg_ ->
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
                [ justArg_ ]
    , list =
        \listArg_ ->
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
                [ listArg_ ]
    , tuple =
        \tupleArg_ tupleArg_0 ->
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
                [ tupleArg_, tupleArg_0 ]
    , triple =
        \tripleArg_ tripleArg_0 tripleArg_1 ->
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
                [ tripleArg_, tripleArg_0, tripleArg_1 ]
    , withType =
        \withTypeArg_ withTypeArg_0 ->
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
                [ withTypeArg_, withTypeArg_0 ]
    , record =
        \recordArg_ ->
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
                [ recordArg_ ]
    , get =
        \getArg_ getArg_0 ->
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
                [ getArg_, getArg_0 ]
    , updateRecord =
        \updateRecordArg_ updateRecordArg_0 ->
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
                [ updateRecordArg_, updateRecordArg_0 ]
    , ifThen =
        \ifThenArg_ ifThenArg_0 ifThenArg_1 ->
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
                [ ifThenArg_, ifThenArg_0, ifThenArg_1 ]
    , comment =
        \commentArg_ ->
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
                [ commentArg_ ]
    , docs =
        \docsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "docs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Elm" ] "Declaration" [])
                             )
                     }
                )
                [ docsArg_ ]
    , declaration =
        \declarationArg_ declarationArg_0 ->
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
                [ declarationArg_, declarationArg_0 ]
    , withDocumentation =
        \withDocumentationArg_ withDocumentationArg_0 ->
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
                [ withDocumentationArg_, withDocumentationArg_0 ]
    , group =
        \groupArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "group"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith [ "Elm" ] "Declaration" []
                                      )
                                  ]
                                  (Type.namedWith [ "Elm" ] "Declaration" [])
                             )
                     }
                )
                [ groupArg_ ]
    , expose =
        \exposeArg_ ->
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
                [ exposeArg_ ]
    , exposeConstructor =
        \exposeConstructorArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "exposeConstructor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Declaration" [] ]
                                  (Type.namedWith [ "Elm" ] "Declaration" [])
                             )
                     }
                )
                [ exposeConstructorArg_ ]
    , fileWith =
        \fileWithArg_ fileWithArg_0 fileWithArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fileWith"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string
                                  , Type.record
                                      [ ( "docs", Type.string )
                                      , ( "aliases"
                                        , Type.list
                                            (Type.tuple
                                               (Type.list Type.string)
                                               Type.string
                                            )
                                        )
                                      ]
                                  , Type.list
                                      (Type.namedWith [ "Elm" ] "Declaration" []
                                      )
                                  ]
                                  (Type.namedWith [ "Elm" ] "File" [])
                             )
                     }
                )
                [ fileWithArg_, fileWithArg_0, fileWithArg_1 ]
    , fn =
        \fnArg_ fnArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fn"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.function
                                      [ Type.var "arg" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ fnArg_, fnArg_0 ]
    , fn2 =
        \fn2Arg_ fn2Arg_0 fn2Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fn2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.function
                                      [ Type.var "one", Type.var "two" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ fn2Arg_, fn2Arg_0, fn2Arg_1 ]
    , fn3 =
        \fn3Arg_ fn3Arg_0 fn3Arg_1 fn3Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fn3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ fn3Arg_, fn3Arg_0, fn3Arg_1, fn3Arg_2 ]
    , fnBuilder =
        \fnBuilderArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fnBuilder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "value" ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Fn"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ fnBuilderArg_ ]
    , fnArg =
        \fnArgArg_ fnArgArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fnArg"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Fn"
                                      [ Type.function
                                            [ Type.var "arg" ]
                                            (Type.var "value")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Fn"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ fnArgArg_, fnArgArg_0 ]
    , fnDone =
        \fnDoneArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "fnDone"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Fn"
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ fnDoneArg_ ]
    , body =
        \bodyArg_ bodyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "body"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "args" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Fn"
                                      [ Type.var "args" ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ bodyArg_, bodyArg_0 ]
    , function =
        \functionArg_ functionArg_0 ->
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
                [ functionArg_, functionArg_0 ]
    , functionReduced =
        \functionReducedArg_ functionReducedArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm" ]
                     , name = "functionReduced"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ functionReducedArg_, functionReducedArg_0 ]
    , customType =
        \customTypeArg_ customTypeArg_0 ->
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
                [ customTypeArg_, customTypeArg_0 ]
    , customTypeWith =
        \customTypeWithArg_ customTypeWithArg_0 customTypeWithArg_1 ->
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
                [ customTypeWithArg_, customTypeWithArg_0, customTypeWithArg_1 ]
    , variant =
        \variantArg_ ->
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
                [ variantArg_ ]
    , variantWith =
        \variantWithArg_ variantWithArg_0 ->
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
                [ variantWithArg_, variantWithArg_0 ]
    , alias =
        \aliasArg_ aliasArg_0 ->
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
                [ aliasArg_, aliasArg_0 ]
    , aliasWith =
        \aliasWithArg_ aliasWithArg_0 aliasWithArg_1 ->
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
                [ aliasWithArg_, aliasWithArg_0, aliasWithArg_1 ]
    , portIncoming =
        \portIncomingArg_ portIncomingArg_0 ->
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
                [ portIncomingArg_, portIncomingArg_0 ]
    , portOutgoing =
        \portOutgoingArg_ portOutgoingArg_0 ->
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
                [ portOutgoingArg_, portOutgoingArg_0 ]
    , parse =
        \parseArg_ ->
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
                [ parseArg_ ]
    , unsafe =
        \unsafeArg_ ->
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
                [ unsafeArg_ ]
    , apply =
        \applyArg_ applyArg_0 ->
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
                [ applyArg_, applyArg_0 ]
    , val =
        \valArg_ ->
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
                [ valArg_ ]
    , value =
        \valueArg_ ->
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
                [ valueArg_ ]
    , unwrap =
        \unwrapArg_ unwrapArg_0 unwrapArg_1 ->
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
                [ unwrapArg_, unwrapArg_0, unwrapArg_1 ]
    , unwrapper =
        \unwrapperArg_ unwrapperArg_0 ->
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
                [ unwrapperArg_, unwrapperArg_0 ]
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
    , docs : Elm.Expression
    , declaration : Elm.Expression
    , withDocumentation : Elm.Expression
    , group : Elm.Expression
    , expose : Elm.Expression
    , exposeConstructor : Elm.Expression
    , fileWith : Elm.Expression
    , fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fnBuilder : Elm.Expression
    , fnArg : Elm.Expression
    , fnDone : Elm.Expression
    , body : Elm.Expression
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
                         [ Type.list (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
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
                         [ Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
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
    , docs =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "docs"
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
    , group =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "group"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
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
    , exposeConstructor =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "exposeConstructor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Declaration" [] ]
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
                             [ ( "docs", Type.string )
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
    , fn =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                         , Type.function
                             [ Type.var "arg" ]
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.function
                             [ Type.var "one", Type.var "two" ]
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fnBuilder =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fnBuilder"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "value" ]
                         (Type.namedWith [ "Elm" ] "Fn" [ Type.var "value" ])
                    )
            }
    , fnArg =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fnArg"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                         , Type.namedWith
                             [ "Elm" ]
                             "Fn"
                             [ Type.function
                                   [ Type.var "arg" ]
                                   (Type.var "value")
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Fn" [ Type.var "value" ])
                    )
            }
    , fnDone =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "fnDone"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm" ]
                             "Fn"
                             [ Type.namedWith [ "Elm" ] "Expression" [] ]
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , body =
        Elm.value
            { importFrom = [ "Elm" ]
            , name = "body"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "args" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith [ "Elm" ] "Fn" [ Type.var "args" ]
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
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
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
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
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
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
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