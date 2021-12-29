# Elm CodeGen

Elm CodeGen is an **Elm package** and **CLI tool** for generating Elm code easily and maintainably.

The goal is to be easier to write and more maintainable than that string template you have lying around. 😏

Here's what this tool does for you in order to make generating code simpler.

1. **Automatic imports** — Import declarations are calculated.
2. **Builtin type inference** — The types for your generated code are inferred.
3. **Use existing packages easily** — For generating code that uses a specific _library_ such as [`elm-ui`](https://package.elm-lang.org/packages/mdgriffith/elm-ui/1.1.8/), the `elm-codegen` CLI can create some Elm code to help you out.
   Check out the [Using packages](/guide/UsingPackages.md) guide to get a better idea of what this looks like!

To get started, here's a small example to give you an idea of what the code looks like!

```elm
Elm.declaration "anExample"
    (Elm.record
        [ Elm.field "name" (Elm.string "a fancy string!")
        , Elm.field "fancy" (Elm.bool True)
        ]
    )
    |> Elm.declarationToString
```

The above will generate the following string:

```elm
anExample : { name : String, fancy : Bool }
anExample =
    { name = "a fancy string!"
    , fancy = True
    }
```

## Best practices for Code Generation

Even in the best of times, code generation can be a challenging subject!

## Check out the guide!

- [Getting started](/guide/01_GettingStarted.md)
- [Writing a generator](/guide/WritingAGenerator.md)
- [Using packages](/guide/UsingPackages.md)

And finally, the [elm-codegen package documentation](https://elm-doc-preview.netlify.app/?repo=mdgriffith/elm-codegen).
