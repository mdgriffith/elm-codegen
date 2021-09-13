/*

    elm-prefab Gen.elm --output=./dir
        -> compile the elm file and run it via the index.js runner

    elm-prefab Gen.elm --watch
        -> recompile and run when the file changes

    elm-prefab elm/json --output=./dir
        -> generate bindings for the elm/json package based on it's docs.json
        -> puts generated code in ./dir

    elm-prefab docs.json
        -> same as above, but from a local set of docs

*/

import * as commander from "commander" // include commander in git clone of commander repo
import * as elm_compiler from "node-elm-compiler"
import * as path from "path"
import * as fs from "fs"
import { XMLHttpRequest } from "./run/vendor/XMLHttpRequest"
import * as chokidar from "chokidar"
import * as https from "https"
import fetch from "node-fetch"
import chalk from "chalk"
const gen_package = require("./gen-package")

// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest.XMLHttpRequest

async function run_generator(base: string, moduleName: string, elm_source: string, flags: any) {
  eval(elm_source)

  const promise = new Promise((resolve, reject) => {
    // @ts-ignore
    const app = this.Elm[moduleName].init({ flags: flags })
    if (app.ports.onSuccessSend) {
      app.ports.onSuccessSend.subscribe(resolve)
    }
    if (app.ports.onInfoSend) {
      app.ports.onInfoSend.subscribe((info: string) => console.log(info))
    }
    if (app.ports.onFailureSend) {
      app.ports.onFailureSend.subscribe(reject)
    }
  })
    .then((files: any) => {
      for (const file of files) {
        const fullpath = path.join(base, file.path)
        fs.mkdirSync(path.dirname(fullpath), { recursive: true })
        fs.writeFileSync(fullpath, file.contents)
      }

      const s = files.length == 1 ? "" : "s"
      console.log(format_block([`${chalk.yellow(files.length)} file${s} generated!`]))
    })
    .catch((reason) => {
      console.error(format_title(reason.title), "\n\n" + reason.description + "\n")
    })
  return promise
}

const program = new commander.Command()

function generate(debug: boolean, elm_file: string, moduleName: string, target_dir: string, base: string, flags: any) {
  try {
    const data = elm_compiler.compileToStringSync([elm_file], { cwd: base, optimize: !debug, processOpts: {stdio: [null, null, 'inherit']} })

    // @ts-ignore
    return new run_generator(target_dir, moduleName, data.toString(), flags)

  } catch (error : unknown) {
    // This is generally an elm make error from the elm_compiler
    console.log(error)
  }
}

type Options = {
  debug: boolean
  cwd: string | null
  output: string | null
  flagsFrom: string | null
  flags: string | null
  watch: boolean
}

const elm_gen_file = `
port module Elm.Gen exposing (File, files, error, info)


import Json.Encode as Json


type alias File =
       { path : String
       , contents : String
       }

encodeFile : File -> Json.Value
encodeFile file =
   Json.object
        [ ("path", (Json.string file.path))
        , ("contents", (Json.string file.contents))
        ]

{-|
     Provide the list of files to be generated.
     These files will be generated and the script will end.
-}
files : List File -> Cmd msg
files list =
     onSuccessSend (List.map encodeFile list)


{-|
     Report an error.  The script will end

-}
error : { title : String, description : String } -> Cmd msg
error err =
     onFailureSend err

{-| Report some info.  The script will continue to run.

-}
info : String -> Cmd msg
info err =
     onInfoSend err



port onSuccessSend : List Json.Value -> Cmd msg

port onFailureSend : { title : String, description : String } -> Cmd msg

port onInfoSend : String -> Cmd msg

`

const elm_json_file = `
{
    "type": "application",
    "source-directories": [
        ".", "../src"
    ],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/browser": "1.0.2",
            "elm/core": "1.0.5",
            "elm/html": "1.0.0"
        },
        "indirect": {
            "elm/json": "1.1.3",
            "elm/time": "1.0.0",
            "elm/url": "1.0.0",
            "elm/virtual-dom": "1.0.2"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}
`

const elm_starter_file = `module Generator exposing (main)

{-| -}

import Elm
import Elm.Pattern as Pattern
import Elm.Type as Type
import Elm.Gen


main : Program {} () ()
main =
    Platform.worker
        { init =
            \json ->
                ( ()
                , Elm.Gen.files
                    [ Elm.render file
                    ]
                )
        , update =
            \msg model ->
                ( model, Cmd.none )
        , subscriptions = \_ -> Sub.none
        }


file =
    Elm.file (Elm.moduleName [ "My", "Module" ])
        [ Elm.declaration "placeholder"
            (Elm.valueFrom (Elm.moduleAs [ "Json", "Decode" ] "Json")
                "map2"
            )
        , Elm.declaration "myRecord"
            (Elm.record
                [ ( "one", Elm.string "My cool string" )
                , ( "two", Elm.int 5 )
                , ( "three"
                  , Elm.record
                        [ ( "four", Elm.string "My cool string" )
                        , ( "five", Elm.int 5 )
                        ]
                  )
                ]
            )
            |> Elm.expose
        ]
`

const docs_generator = { cwd: "cli/gen-package", file: "src/Generate.elm", moduleName: "Generate" }

function format_title(title: string): string {
  const tail = "-".repeat(80 - (title.length + 2))
  return chalk.cyan("--" + title.toUpperCase() + tail)
}

function format_block(content: string[]) {
  return "\n    " + content.join("\n    ") + "\n"
}

async function run_package_generator(output: string, flags: any) {
  const promise = new Promise((resolve, reject) => {
    // @ts-ignore
    const app = gen_package.Elm.Generate.init({ flags: flags })
    if (app.ports.onSuccessSend) {
      app.ports.onSuccessSend.subscribe(resolve)
    }
    if (app.ports.onInfoSend) {
      app.ports.onInfoSend.subscribe((info: string) => console.log(info))
    }
    if (app.ports.onFailureSend) {
      app.ports.onFailureSend.subscribe(reject)
    }
  })
    .then((files: any) => {
      for (const file of files) {
        const fullpath = path.join(output, file.path)
        console.log("Generating: " + chalk.cyan(fullpath))
        fs.mkdirSync(path.dirname(fullpath), { recursive: true })
        fs.writeFileSync(fullpath, file.contents)
      }
      console.info("Success!")
    })
    .catch((reason) => {
      console.error(format_title(reason.title),  "\n\n" + reason.description  + "\n")
    })
  return promise
}

// INSTALL
//   Install bindings for a package
async function install(pkg: string, output: string, version: string | null) {
  if (version == null) {
    const searchResp = await fetch("https://elm-package-cache-psi.vercel.app/search.json")
    const search = await searchResp.json()
    for (let found of search) {
      if (found.name == pkg) {
        version = found.version
        break
      }
    }
    if (version == null) {
      console.log(format_block([`No package found for ${pkg}`]))
      process.exit()
    }
  }
  const docsResp = await fetch(`https://elm-package-cache-psi.vercel.app/packages/${pkg}/${version}/docs.json`)
  const docs = await docsResp.json()

  try {
    run_package_generator(output, docs)
  } catch (error:unknown) {
    console.log(`There was an issue generating docs for ${pkg}`)
    // @ts-ignore
    console.log(format_block([error]))
  }
}



// INIT
//    Start a new elm-prefab project
//    Generates some files and installs `core`
async function init(install_dir : string) {

   // create folder
   if (fs.existsSync("./" + install_dir)) {
    console.log(format_block(["Looks like there's already a " + chalk.cyan(install_dir) + " folder."]))
    process.exit(1)
  }

  fs.mkdirSync(`./${install_dir}`)
  fs.mkdirSync(`./${install_dir}/Elm`)
  fs.writeFileSync(`./${install_dir}/elm.json`, elm_json_file)
  fs.writeFileSync(`./${install_dir}/Generate.elm`, elm_starter_file)
  fs.writeFileSync(`./${install_dir}/Elm/Gen.elm`, elm_gen_file)
  install("elm/core", install_dir, null)

  console.log(
    format_block([
      "I've created the " + chalk.cyan(install_dir) + " folder and added some files.",
      chalk.cyan(`${install_dir}/Generate.elm`) + " is a good place to get start to see how everything works!",
      "",
      "Run your generator by running " + chalk.yellow("elm-prefab"),
    ])
  )
}



async function action(cmd: string, pkg: string | null, options: Options, com: any) {

  const cwd = options.cwd || "."
  const output = path.join(cwd, options.output || "output")
  const install_dir = path.join(cwd, options.output || "generators")
  if (cmd == "init") {
    init(install_dir)
  } else if (cmd == "install" && !!pkg) {
    if (pkg.endsWith(".json")) {
      console.log(format_block(["Installing via json from " + chalk.cyan(pkg)]))
      let docs = JSON.parse(fs.readFileSync(pkg).toString())
      run_package_generator(install_dir, docs)
    } else {
      install(pkg, install_dir, null)
    }
  } else {
    let flags: any | null = null
    if (options.flagsFrom) {
      if (options.flagsFrom.endsWith(".json")) {
        flags = JSON.parse(fs.readFileSync(options.flagsFrom).toString())
      } else {
        flags = fs.readFileSync(options.flagsFrom).toString()
      }
    } else if (options.flags) {
      flags = JSON.parse(options.flags)
    }

    if (cmd.endsWith(".elm")) {
      const moduleName = path.parse(cmd).name

      if (options.watch) {
        generate(options.debug, cmd, moduleName, output, cwd, flags)
        chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output, "**") }).on("all", (event, path) => {
          console.log("\nFile changed, regenerating")
          generate(options.debug, cmd, moduleName, output, cwd, flags)
        })
      } else {
        generate(options.debug, cmd, moduleName, output, cwd, flags)
      }
    }
  }
}

program
  .version("0.1.0")
  .arguments("[cmd] [package]")
  .option("--debug", "Run your generator in debug mode, allowing you to use Debug.log in your elm.", false)
  .option("--watch", "Watch the given file for changes and rerun the generator when a change is made.")
  .option("--cwd <dir>", "Change the base directory for compiling your Elm generator")
  .option("--output <dir>", "The directory where your generated files should go.")
  .option(
    "--flags-from <file>",
    "The file to feed to your elm app as flags.  If it has a json extension, it will be handed in as json."
  )
  .option("--flags <json>", "Json to pass to your elm app.  if --flags-from is given, that will take precedence.")
  //   .option('--import <file>', 'Parse an existing elm file and provide it to your generator')
  //   .option('--import-dir <dir>', 'Parse an directory of existing elm files and provide them to your generator. If this is called with --flags, then a tuple will be passed to your generator.')
  .action(action)

program.parseAsync()
