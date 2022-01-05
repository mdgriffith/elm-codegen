/*

    elm-codegen Gen.elm --output=./dir
        -> compile the elm file and run it via the index.js runner

    elm-codegen Gen.elm --watch
        -> recompile and run when the file changes

    elm-codegen install elm/json --output=./dir
        -> generate bindings for the elm/json package based on it's docs.json
        -> puts generated code in ./dir

    elm-codegen install docs.json
        -> same as above, but from a local set of docs

    elm-codegen install Module.elm
        -> same as above, but from a local elm file itself

*/

import * as commander from "commander" // include commander in git clone of commander repo
import * as elm_compiler from "node-elm-compiler"
import * as path from "path"
import * as fs from "fs"
import { XMLHttpRequest } from "./run/vendor/XMLHttpRequest"
import * as chokidar from "chokidar"
import fetch from "node-fetch"
import chalk from "chalk"
import templates from "./templates"
const gen_package = require("./gen-package")

// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest.XMLHttpRequest

const currentVersion = require("../package.json").version

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
    .catch((errors) => {
      let formatted = ""
      for (const err of errors) {
        formatted = formatted + format_title(err.title) + "\n\n" + err.description + "\n"
      }
      console.error(formatted)
    })
  return promise
}

const program = new commander.Command()

function generate(debug: boolean, elm_file: string, moduleName: string, target_dir: string, base: string, flags: any) {
  try {
    const data = elm_compiler.compileToStringSync([elm_file], {
      cwd: base,
      optimize: !debug,
      processOpts: { stdio: [null, null, "inherit"] },
    })

    // @ts-ignore
    return new run_generator(target_dir, moduleName, data.toString(), flags)
  } catch (error: unknown) {
    // This is generally an elm make error from the elm_compiler
    console.log(error)
  }
}

type Options = {
  debug: boolean
  // cwd: string | null
  output: string
  flagsFrom: string | null
  flags: string | null
  watch: boolean
}

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
        fs.mkdirSync(path.dirname(fullpath), { recursive: true })
        fs.writeFileSync(fullpath, file.contents)
      }
    })
    .catch((reason) => {
      console.error(format_title(reason.title), "\n\n" + reason.description + "\n")
    })
  return promise
}

// INSTALL
//   Install bindings for a package
async function install_package(pkg: string, output: string, version: string | null) {
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

  let codeGenJson = getCodeGenJson()

  if (codeGenJson.version != currentVersion) {
    console.log(
      chalk.cyan("elm.codegen.json") +
        " says you are on version " +
        chalk.yellow(codeGenJson.version) +
        `, but you're running version ` +
        chalk.yellow(currentVersion)
    )
    process.exit()
  }
  if (codeGenJson.dependencies && codeGenJson.dependencies.packages && pkg in codeGenJson.dependencies.packages) {
    console.log(chalk.yellow(pkg) + ` is already installed!`)
    if (codeGenJson.dependencies.packages[pkg] != version) {
      console.log(
        `If you want to change versions, adjust ` +
          chalk.cyan("elm.codegen.json") +
          " and run " +
          chalk.cyan("elm-codegen install")
      )
    }
    process.exit(1)
  }

  try {
    codeGenJson.dependencies.packages[pkg] = version
    fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson))
    run_package_generator(output, { docs: docs })
  } catch (error: unknown) {
    console.log(`There was an issue generating docs for ${pkg}`)
    // @ts-ignore
    console.log(format_block([error]))
  }
}

type CodeGenJson = {
  version: string
  dependencies: { packages: { [key: string]: string }; local: string[] }
}

function getCodeGenJson(): CodeGenJson {
  let stringContents = ""
  try {
    stringContents = fs.readFileSync(path.join(".", "elm.codegen.json")).toString()
  } catch (error) {
    console.log(
      format_block([
        "Looks like there's no " + chalk.yellow("elm.codegen.json") + ".",
        "Run " + chalk.cyan("elm-codegen init") + " to generate one!",
      ])
    )
    process.exit(1)
  }

  try {
    let codeGenJson = JSON.parse(stringContents)
    return {
      version: codeGenJson["elm-codegen-version"],
      dependencies: { packages: codeGenJson["codegen-helpers"].packages, local: codeGenJson["codegen-helpers"].local },
    }
  } catch (exception_var) {
    // TODO: convert this exception to a more useful error message
    console.log(format_block(["Looks like there's an issue with " + chalk.yellow("elm.codegen.json") + "."]))
    process.exit(1)
  }
}

function codeGenJsonToString(codeGen: CodeGenJson): string {
  let obj: any = {}
  obj["elm-codegen-version"] = codeGen.version
  obj["codegen-helpers"] = codeGen.dependencies
  return JSON.stringify(obj, null, 4)
}

// INIT
//    Start a new elm-codegen project
//    Generates some files and installs `core`
async function init() {
  const install_dir = "codegen"

  const base = path.join(".", install_dir)
  // create folder
  if (fs.existsSync(base)) {
    console.log(format_block(["Looks like there's already a " + chalk.cyan(install_dir) + " folder."]))
    process.exit(1)
  }
  if (fs.existsSync(path.join(base, "elm.codegen.json"))) {
    console.log(
      format_block(["Looks like there's already a " + chalk.cyan(path.join(base, "elm.codegen.json")) + " file."])
    )
    process.exit(1)
  }

  let codeGenJson = JSON.parse(templates.init.elmCodegenJson())
  codeGenJson["elm-codegen-version"] = currentVersion

  fs.mkdirSync(base)
  fs.mkdirSync(path.join(base, "Elm"))
  fs.writeFileSync(path.join(base, "elm.codegen.json"), JSON.stringify(codeGenJson, null, 2))
  fs.writeFileSync(path.join(base, "elm.json"), templates.init.elmJson())
  fs.writeFileSync(path.join(base, "Generate.elm"), templates.init.starter())
  fs.writeFileSync(path.join(base, "Elm", "Gen.elm"), templates.init.elmGen())
  await install_package("elm/core", install_dir, null)

  console.log(
    format_block([
      "Welcome to " + chalk.yellow("elm-codegen") + "!",
      "",
      "I've created the " + chalk.cyan(install_dir) + " folder and added some files.",
      chalk.cyan(path.join(base, "Generate.elm")) + " is a good place to start to see how everything works!",
      "",
      "Run your generator by running " + chalk.yellow("elm-codegen run"),
    ])
  )
}

async function install_from_codegen_json(cwd: string) {
  console.log("Installing dependencies from " + chalk.yellow("elm.codegen.json"))

  let codeGenJson = getCodeGenJson()
  console.log(codeGenJson)
  const install_dir = path.join(cwd, "codegen")

  for (let [key, value] of Object.entries(codeGenJson.dependencies.packages)) {
    // `value` is a string
    // @ts-ignore
    install_package(key, install_dir, value)
  }
  const elmSources = []

  for (const item of codeGenJson.dependencies.local) {
    console.log("Installing " + item)
    if (item.endsWith(".json")) {
      console.log("From json " + item)
      let docs = JSON.parse(fs.readFileSync(item).toString())
      run_package_generator(install_dir, { docs: docs })
    } else if (item.endsWith(".elm")) {
      elmSources.push(fs.readFileSync(item).toString())
    }
  }
  if (elmSources.length > 0) {
    run_package_generator(install_dir, { elmSource: elmSources })
  }
  console.log(chalk.green("Success!"))
}

// INIT
//    Start a new elm-codegen project
//    Generates some files and installs `core`
async function make(elm_file: string, moduleName: string, target_dir: string, base: string, flags: any) {
  try {
    const data = elm_compiler.compileToStringSync([elm_file], {
      cwd: base,
      optimize: true,
      processOpts: { stdio: [null, null, "inherit"] },
    })

    // @ts-ignore
    return new run_generator(target_dir, moduleName, data.toString(), flags)
  } catch (error: unknown) {
    // This is generally an elm make error from the elm_compiler
    console.log(error)
  }
}

function clear(dir: string) {
  fs.readdir(dir, (err, files) => {
    if (err) throw err
    for (const file of files) {
      fs.unlink(path.join(dir, file), (err) => {
        if (err) throw err
      })
    }
  })
}

async function run_install(pkg: string) {
  const install_dir = "."
  if (!!pkg) {
    let codeGenJson = getCodeGenJson()

    // Package specified
    if (pkg.endsWith(".json")) {
      if (codeGenJson.dependencies.local.includes(pkg)) {
        console.log(format_block([chalk.cyan(pkg) + " is already installed!"]))
        process.exit(1)
      }
      console.log(format_block(["Adding " + chalk.cyan(pkg) + " to local dependencies and installing."]))
      let docs = JSON.parse(fs.readFileSync(pkg).toString())
      run_package_generator(install_dir, { docs: docs })
      codeGenJson.dependencies.local.push(pkg)
      fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson))
    } else if (pkg.endsWith(".elm")) {
      if (pkg in codeGenJson.dependencies.local) {
        console.log(format_block([chalk.cyan(pkg) + " is already installed!"]))
        process.exit(1)
      }
      run_package_generator(install_dir, { elmSource: [fs.readFileSync(pkg).toString()] })
      codeGenJson.dependencies.local.push(pkg)
      fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson))
    } else {
      console.log("Installing " + chalk.cyan(pkg) + " in " + chalk.yellow(install_dir))
      install_package(pkg, install_dir, null)
    }
  } else {
    // elm-codegen install
    // means reinstall all packages
    install_from_codegen_json(".")
  }
}
async function run_generation(options: Options) {
  const elmFile = "Generate.elm"
  const cwd = "./codegen"
  let output = path.join(cwd, options.output)

  if (!fs.existsSync(elmFile)) {
    console.log(
      format_block([
        "I wasn't able to find " + chalk.yellow(elmFile) + ".",
        "Have you set up a project using " + chalk.cyan("elm-codegen init") + "?",
      ])
    )
    process.exit(0)
  }

  // prepare flags
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

  const moduleName = path.parse(elmFile).name

  if (options.watch) {
    //         clear(output)
    generate(options.debug, elmFile, moduleName, output, cwd, flags)
    chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output, "**") }).on("all", (event, path) => {
      console.log("\nFile changed, regenerating")
      generate(options.debug, elmFile, moduleName, output, cwd, flags)
    })
  } else {
    //         skipping clearing files because in my test case it was failing with permission denied all the time.
    //         clear(output)
    generate(options.debug, elmFile, moduleName, output, cwd, flags)
  }
}

const helpText = `
Welcome to ${chalk.cyan("elm-codegen")}!

Make sure to check out the ${chalk.yellow("guides")}:
    https://github.com/mdgriffith/elm-codegen#check-out-the-guide
`

program.version("0.1.0").name("elm-codegen").addHelpText("before", helpText)

const initDocs = `
    Start an Elm CodeGen project.
    This will create a ${chalk.yellow("codegen")} directory and provide you with everything you need to get started.
`

program.command("init").description(initDocs).action(init)

const installDocs = `
    Install helpers for an ${chalk.yellow("Elm package")} or a local Elm file.
    ${chalk.cyan("elm-codegen install elm/json")}
    ${chalk.cyan("elm-codegen install codegen/helpers/LocalFile.elm")}
`

program.command("install").description(installDocs).argument("<package>").action(run_install)

const runDocs = `
    Run ${chalk.yellow("codegen/Generate.elm")}.
    ${chalk.cyan("elm-codegen run")}
`

program
  .command("run")
  .description(runDocs)
  .option("--debug", "Run your generator in debug mode, allowing you to use Debug.log in your elm.", false)
  .option("--watch", "Watch the given file for changes and rerun the generator when a change is made.", false)
  .option("--output <dir>", "The directory where your generated files should go.", "generated")
  .option(
    "--flags-from <file>",
    "The file to feed to your elm app as flags.  If it has a json extension, it will be handed in as json."
  )
  .option("--flags <json>", "Json to pass to your elm app.  if --flags-from is given, that will take precedence.")
  .action(run_generation)

program.showHelpAfterError()

program.parseAsync()
