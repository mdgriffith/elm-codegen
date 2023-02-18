# Using Helpers

Writing generators for absolutely everything is way too much work.

The easiest approach by far is to only write generators for stuff _you absolutely need to generate_, and write normal Elm code for everything else.

This means we need an easy way to:

1. use existing Elm packages!
2. use code we have written locally.

## Using Packages

Let's say you wanted to generate some code that uses [`elm/html`](https://package.elm-lang.org/packages/elm/html/latest/)!

`elm-codegen` can help you out with that.

If you haven't already, make a new codegen project by running `elm-codegen init`, like you did in [Getting Started](https://github.com/mdgriffith/elm-codegen/tree/main/guide/GettingStarted.md).

Now, run `cd codegen ; elm-codegen install elm/html`.

This will create the following files —

- `codegen/Gen/Html.elm`
- `codegen/Gen/Html/Attributes.elm`
- `codegen/Gen/Html/Events.elm`
- `codegen/Gen/Html/Lazy.elm`
- `codegen/Gen/Html/Keyed.elm`

We can use `Gen.Html` to help generate calls to `Html`.

In our `codegen/Generate.elm` file, we can write:

```elm
import Gen.Html
import Gen.Attributes

div : Elm.Expression
div =
    Gen.Html.div
        [ Gen.Html.Attributes.class
            "hello"
        ]
        [ Gen.Html.text
            "Hello world!"
        ]

```

Which will generate:

```elm
Html.div
    [ Html.Attributes.class "hello" ]
    [ Html.text "Hello world!" ]
```

Crazy, right?

## Using `.call`

What if you wanted to render text that is only known at _run time_?

The generated package bindings also includes a thing called `.call_`, which can help you out.

While normally, `Gen.Html.text` is defined as

```elm
text : String -> Elm.Expression
```

`Gen.Html.call_.text` is defined as

```elm
text : Elm.Expression -> Elm.Expression
```

Which means you can generate any expression you want to provide the string.

For example, here's how we'd create a function that takes one argument called `myString` and returns some `Html`.

```elm
import Gen.Html
import Gen.Attributes
import Elm


div : Elm.Expression
div =
    Elm.fn ("myString", Just Elm.Annotation.string)
        (\myString ->
            Gen.Html.div
                [ Gen.Html.Attributes.class
                    "hello"
                ]
                [ Gen.Html.call_.text
                    myString
                ]
        )
```

## Local bindings

We may also need bindings for local files instead of just published packages!

You can specify directories that you want to generate bindings for under the `local` field of your `elm.codegen.json`, and generate them by running `elm-codegen install`.

But what the heck does that mean?

Let's say you if you have a file `./src/MyFile.elm` which has a function in it called `addFive : Int -> Int`, and you'd like to generate some code that _calls that function_.

You could add `src/` to your `elm.codegen.json`

```json
{
  "elm-codegen-version": "0.1.3",
  "codegen-helpers": {
    "packages": {
      "elm/core": "1.0.5",
      "elm/json": "1.1.3"
    },
    "local": ["src/"]
  }
}
```

Run `elm-codegen install`, and now in `codegen/Generate.elm`, you could write

```elm
import Gen.MyFile


myExpression : Elm.Expression
myExpression =
    Gen.MyFile.add5 20

```

which would generate

```elm
MyFile.add5 20
```

Cool!

## What's in the box?

Let's take a peak into the `Gen/Html.elm` file. The hope is that it's not too hard to read once you get used to it.

The majority of what you'll find are _direct bindings_. These are things such as `Gen.Html.div`, which allow you to call a function much like you would in normal Elm, but have it generate that value for you instead of actually calling it.

Additionally though, there are a few other helpers —

1. `moduleName_` — The name of the module, as you'd probably expect.
2. `annotation_` — Helpers to construct a type annotation which can be used with `Elm.withType` or `Elm.value`
   - **Note!** `elm-codegen` has builtin type inference, so hopefully the number of times you need this is pretty low.
3. `make_` — Create a value of a type. `Gen.Maybe.make_.just (Elm.string "Hello")` would generate `Just "Hello"`.
4. `call_` — The top level "bindings" that are generated for you will take in actual primitives. However there are cases where you want to pass in an `Expression` to a function instead of an actual string!

5. `values_` — In some cases you may need to do something fancier. The `values_` record will help you refer directly to a single value.
   So, `Gen.Html.values_.div` is an `Expression` which generates just `Html.div`.
