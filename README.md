# Elm Prefab

Code generation for Elm.

*Under Construction!*

With the file `Generator.elm`
```elm
import Elm

main =
    Elm.Gen.files
        [ Elm.file [ "My", "Module" ]
            [ Elm.declaration "placeholder"
                (Elm.string "a fancy string!")
            ]
        ]

```

You can run `elm-prefab Generator.elm` and it will generate


```elm
module My.Module exposing (..)

placeholder : String
placeholder =
    "a fancy string!"

```

## Running an Elm Generator program


```bash
elm-prefab src/MyGenerator.elm
```




## Generating Code for a Package

Let's say you want to generate code that uses a specific library like `mdgriffith/elm-ui`.

Elm prefab can help you out!

Running
```bash
elm-prefab install mdgriffith/elm-ui
```

Will generate a module `Elm.Gen.Element` which contains a bunch of helpers for you to generate code from the `Element` module in `elm-ui`!

So, if you wanted to generate a call to `Element.el`, you could use `Element.Gen.Element.el`.

Confused?  Yeah, it's a bit confusing!  Let's check out an example.  Later, when I have time to write an example.




