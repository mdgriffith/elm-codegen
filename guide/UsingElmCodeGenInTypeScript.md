# Using Elm CodeGen from TypeScript

You can also drive elm-codegen from typescript!

This can be useful if you want to generate code based on an http call or information from the file system.

Let's build a small script which gathers the filepaths of all the files within a folder and generates an Elm file that allows us to reference a file directly.

This can be super useful if you have an `assets` folder and want to make sure that you have the correct path for an image in you Elm project!

Let's get started.

First, install elm codegen to you package.json

```
npm install --save-dev elm-codegen
```

Then, let's run `elm-codegen init`, which will start an `elm-codegen` project.

Then, let's create a `scripts/generate.ts` file and put the following in it:

```ts
import * as CodeGen from "elm-codegen"
import * as fs from "fs"
import * as path from "path"

const directoryPath = __dirname

const found: { path: string; contents: string }[] = []

function readFilesRecursively(dir: string) {
  const files = fs.readdirSync(dir)
  for (const file of files) {
    const filePath = path.join(dir, file)
    const stat = fs.statSync(filePath)
    if (stat.isFile()) {
      const content = fs.readFileSync(filePath, "utf-8")
      found.push({ path: filePath, contents: content })
    } else if (stat.isDirectory()) {
      readFilesRecursively(filePath)
    }
  }
}

readFilesRecursively(directoryPath)

CodeGen.run("Generate.elm", {
  debug: true,
  output: "generated",
  flags: found,
  cwd: "./codegen",
})
```

Almost there!

Let's now modify `codegen/Generate.elm` to the following.

Conceptually we're doing two things.

1. Decoding the JSON we gave to elm-codegen as `flags`
2. Doing some generation!

```elm
module Generate exposing (main)

{-| -}

import Elm
import Gen.CodeGen.Generate as Generate
import Json.Decode


main : Program Json.Decode.Value () ()
main =
    Generate.fromJson
        (Json.Decode.list decodeFile)
        generate


type alias File =
    { path : String
    , contents : String
    }


decodeFile : Json.Decode.Decoder File
decodeFile =
    Json.Decode.map2 File
        (Json.Decode.field "path" Json.Decode.string)
        (Json.Decode.field "contents" Json.Decode.string)


generate : List File -> List Elm.File
generate files =
    [ Elm.file [ "Assets" ]
        (List.map fileToDeclaration files)
    ]


fileToDeclaration : File -> Elm.Declaration
fileToDeclaration file =
    Elm.declaration (getFileName file.path)
        (Elm.string file.path)



{- Some string formatting -}


getFileName : String -> String
getFileName path =
    let
        fileName =
            String.split "/" path
                |> List.reverse
                |> List.head
                |> Maybe.withDefault path
    in
    fileName
        |> String.replace "." ""
        |> String.replace "-" ""
        |> String.replace "_" ""
        |> String.replace " " ""
        |> String.replace "/" ""
        |> String.replace "’" ""
        |> String.replace "'" ""
        |> decapitalize


decapitalize : String -> String
decapitalize str =
    case String.uncons str of
        Nothing ->
            str

        Just ( first, tail ) ->
            String.fromChar (Char.toLower first) ++ tail

```

## Running your new script

You can now run your new script vis `ts-node`.

You may need to install `ts-node` via `npm install --save-dev ts-node`.

Once you do that, you can add a new script to your `package.json` file:

```
  "scripts":
    { "generate": "ts-node ./scripts/generate.ts"
    }
```

And you can run it via

```
npm run generate
```

Woohoo :tada:
