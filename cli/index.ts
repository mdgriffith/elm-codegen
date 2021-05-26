

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

import * as commander from 'commander' // include commander in git clone of commander repo
import * as elm_compiler from 'node-elm-compiler'
import * as path from 'path';
import * as fs from 'fs';
import {XMLHttpRequest}  from './run/vendor/XMLHttpRequest';
import * as chokidar from 'chokidar';
import * as https from 'https';
import fetch from 'node-fetch';
import chalk from 'chalk';
const gen_package = require('./gen-package')

// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest.XMLHttpRequest

async function run_generator(base:string, moduleName:string, elm_source:string, flags:any ) {

    eval(elm_source);

    const promise = new Promise((resolve, reject) => {
        // @ts-ignore
        const app = this.Elm[moduleName].init({flags: flags});
        if (app.ports.onSuccessSend) {
            app.ports.onSuccessSend.subscribe(resolve)
        }
        if (app.ports.onFailureSend) {
            app.ports.onFailureSend.subscribe(reject)
        }

    })
        .then((files:any) => {
            for (const file of files) {
                const fullpath = path.join(base, file.path)
                fs.mkdirSync(path.dirname(fullpath), { recursive: true })
                fs.writeFileSync(fullpath, file.contents)
            }
        })
        .then((_) => console.info("Success!"))
        .catch((reason) => console.error("Failure", reason))
    return promise
}


const program = new commander.Command();


function generate(elm_file: string, moduleName:string, target_dir: string, base: string, flags: any){
    const data = elm_compiler.compileToStringSync([elm_file], {cwd: base });
    if (data === "") {
        throw "Compiler error";
    }
    // @ts-ignore
    new run_generator(target_dir, moduleName, data.toString(), flags);
}


type Options = {
    cwd: string | null
    output: string | null
    flagsFrom: string | null
    flags: string | null
    watch: boolean
}

const elm_gen_file = `
port module Elm.Gen exposing (File, error, files)

import Json.Encode as Json


type alias File =
    { path : String
    , contents : String
    }


encodeFile : File -> Json.Value
encodeFile file =
    Json.object
        [ ( "path", Json.string file.path )
        , ( "contents", Json.string file.contents )
        ]


files : List File -> Cmd msg
files list =
    onSuccessSend (List.map encodeFile list)


error : String -> Cmd msg
error err =
    onFailureSend err


port onSuccessSend : List Json.Value -> Cmd msg


port onFailureSend : String -> Cmd msg
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


const docs_generator =
    { cwd: "cli/gen-package"
    , file: "src/Generate.elm"
    , moduleName: "Generate"
    }

function format_block(content: string[]) {
    return "\n    " + content.join("\n    ") + "\n"
}

async function run_package_generator(output: string, flags:any) {

    const promise = new Promise((resolve, reject) => {
        // @ts-ignore
        const app = gen_package.Elm.Generate.init({flags: flags});
        if (app.ports.onSuccessSend) {
            app.ports.onSuccessSend.subscribe(resolve)
        }
        if (app.ports.onFailureSend) {
            app.ports.onFailureSend.subscribe(reject)
        }

    })
        .then((files:any) => {
            for (const file of files) {
                const fullpath = path.join(output, file.path)
                fs.mkdirSync(path.dirname(fullpath), { recursive: true })
                fs.writeFileSync(fullpath, file.contents)
            }
        })
        .then((_) => console.info("Success!"))
        .catch((reason) => console.error("Failure", reason))
    return promise
}


async function install(pkg:string, output: string, version: string|null){
    if (version == null) {
        const searchResp = await fetch('https://elm-package-cache-psi.vercel.app/search.json')
        const search = await searchResp.json()
        for (let found of search) {
            if (found.name == pkg){
                version = found.version
                break
            }
        }
        if (version == null) {
            console.log(format_block([ `No package found for ${pkg}` ]))
            process.exit()
        }
    }
    const docsResp = await fetch(`https://elm-package-cache-psi.vercel.app/packages/${pkg}/${version}/docs.json`)
    const docs = await docsResp.json()

    try {
        run_package_generator(output, docs)
    } catch (error) {
        console.log(`There was an issue generating docs for ${pkg}`)
        console.log(format_block([error]))
    }
}

async function action(cmd: string, pkg: string | null, options: Options, com:any) {
//     console.log("FILE:" , cmd)
//     console.log("PACKAGE:", pkg)
//     console.log(options)
    const cwd = options.cwd || "."
    const output = path.join(cwd, options.output || "output")
    const base = "generators"
    if (cmd == "init") {
        // create folder
        if (fs.existsSync("./" + base)){
            console.log(format_block(["Looks like there's already a "+ chalk.cyan(base) + " folder."]))
            process.exit(1);
        }

        fs.mkdirSync(`./${base}`)
        fs.mkdirSync(`./${base}/Elm`)
        fs.writeFileSync(`./${base}/elm.json`, elm_json_file)
        fs.writeFileSync(`./${base}/Generate.elm`, elm_starter_file)
        fs.writeFileSync(`./${base}/Elm/Gen.elm`, elm_gen_file)
        install("elm/core", base, null)
        console.log(format_block(
            [ "I've created the " + chalk.cyan(base) +  " folder and added some files.",
             chalk.cyan(`${base}/Generate.elm`) + " is a good place to get start to see how everything works!"
            , ""
            , "Run your generator by running " + chalk.yellow("elm-prefab")
            ]))

    } else if (cmd == "install" && !!pkg) {
        install(pkg, base, null)
    } else {

        let flags:any | null = null
        if (options.flagsFrom) {
            if (options.flagsFrom.endsWith(".json")) {
                flags = JSON.parse(fs.readFileSync(options.flagsFrom).toString());
            } else {
                flags = fs.readFileSync(options.flagsFrom).toString();
            }
        } else if (options.flags) {
            flags = JSON.parse(options.flags)
        }

        if (cmd.endsWith(".elm")) {
            const moduleName = path.parse(cmd).name

            if (options.watch) {
                generate(cmd, moduleName, output, cwd, flags)
                chokidar.watch(path.join(cwd, "**", "*.elm"), {ignored: path.join(output, "**")} ).on('all', (event, path) => {
                    console.log("\nFile changed, regenerating")
                    generate(cmd, moduleName, output, cwd, flags)
                });
            } else {
               generate(cmd, moduleName, output, cwd, flags)
            }
        }
    }
}


program
  .version('0.1.0')
  .arguments('[cmd] [package]')
  .option('--watch', 'Watch the given file for changes and rerun the generator when a change is made.')
  .option('--cwd <dir>', 'Change the base directory for compiling your Elm generator')
  .option('--output <dir>', 'The directory where your generated files should go.')
  .option('--flags-from <file>', 'The file to feed to your elm app as flags.  If it has a json extension, it will be handed in as json.')
  .option('--flags <json>', 'Json to pass to your elm app.  if --flags-from is given, that will take precedence.')
  .action(action);



program.parseAsync();
