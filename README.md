# Elm Prefab

**Under construction and not published yet!**

Code generation for Elm!

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

You can run `elm-codegen Generator.elm` and it will generate

```elm
module My.Module exposing (..)

placeholder : String
placeholder =
    "a fancy string!"

```

Some cool stuff that's handled under the hood.

- All imports are automatically handled.
-

## Automatic Imports

There's no way to manually generate an `import` statement in `elm-codegen`.

Instead, all imports are automatically calculated by the values that you use in your generator.

## Type signatures for free! (sometimes)

Let's say you create a record like so

```
Elm.declaration "myRecord"
    (Elm.record
        [ ( "field1", Elm.string "My cool string" )
        , ( "field2", Elm.int 5 )
        , ( "field4", Elm.bool False )
        , ( "field5", Elm.int 5 )
        , ( "field6", Elm.string "My cool string?!?!?!" )
        , ( "field7"
            , Elm.record
                [ ( "field1", Elm.string "My cool string" )
                , ( "field2", Elm.int 5 )
                ]
            )
        ]
    )
```

`elm-codegen` will just figure out what type signature this has and inlcude it in the generated file!

```
myRecord :
    { field1 : String
    , field2 : Int
    , field4 : Bool
    , field5 : Int
    , field6 : String
    , field7 : { field1 : String, field2 : Int }
    }
myRecord =
    { field1 = "My cool string"
    , field2 = 5
    , field4 = False
    , field5 = 5
    , field6 = "My cool string?!?!?!"
    , field7 = { field1 = "My cool string", field2 = 5 }
    }

```

## Bindings to Elm Packages

Let's say you want to generate code that uses a specific library like `mdgriffith/elm-ui`.

Elm codegen can help you out!

```bash
elm-codegen install mdgriffith/elm-ui
```

Will generate a module `Elm.Gen.Element` which contains a bunch of helpers for you to generate code from the `Element` module in `elm-ui`!

So, writing something like this:

```elm

import Elm
import Elm.Gen.Element as El
import Elm.Gen.Element.Font as Font


file =
    Elm.file [ "My", "Special", "Module" ]
        [ Elm.declaration "myElement"
            (El.el
                [ Font.size (Elm.int 16)

                ]
                (El.text (Elm.string "Hello from elm-ui!"))
            )
        ]

```

Would generate the following:

```elm
module My.Special.Module exposing (..)


import Element
import Element.Font

myElement : Element.Element msg
myElement =
    Element.el
        [ Element.Font.size 16

        ]
        (Element.text "Hello from elm-ui!")

```

**Note** Notice the automatically calculated import statements and the type signature!
