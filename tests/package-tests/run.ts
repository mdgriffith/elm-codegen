//
// The docs folder contains a list of docs.json files from
//

import * as fs from "fs"
import * as path from "path"
import * as Process from "child_process"
import { chdir } from "process"

const dir = "./docs"
const runDir = "./run"
const cacheFile = "cache.txt"

function toCodeGenFile(docsFile: string): string {
  return `{
        "elm-codegen-version": "0.1.0",
        "codegen-helpers": {
          "packages": {},
          "local": ["${docsFile}"]
        }
      }`
}

function elmJson() {
  return `{
    "type": "application",
    "source-directories": [".", "../../../src"],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
        "Chadtech/elm-bool-extra": "2.4.2",
        "elm/browser": "1.0.2",
        "elm/core": "1.0.5",
        "elm/html": "1.0.0",
        "elm/json": "1.1.3",
        "elm/parser": "1.1.0",
        "elm/project-metadata-utils": "1.0.2",
        "elm-community/maybe-extra": "5.2.0",
        "rtfeldman/elm-hex": "1.0.0",
        "stil4m/elm-syntax": "7.2.4",
        "the-sett/elm-pretty-printer": "3.0.0"
        },
        "indirect": {
        "elm/time": "1.0.0",
        "elm/url": "1.0.0",
        "elm/virtual-dom": "1.0.2",
        "elm-community/basics-extra": "4.1.0",
        "elm-community/list-extra": "8.3.0",
        "miniBill/elm-unicode": "1.0.2",
        "stil4m/structured-writer": "1.0.3"
        }
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}
      `
}

function toElmFile(files: string[]) {
  let allImports = ""
  for (const i in files) {
    allImports += `import ${formatFileToElmModule(files[i])}\n`
  }
  return `module Test exposing (test)

${allImports}

test : String
test = "Hello"

`
}

function formatFileToElmModule(filepath: string): string {
  return filepath.replace(/\.elm/, "").replace(/\//g, ".")
}

function getFilesWithin(dir: string, endsWith: string) {
  let files: string[] = []
  fs.readdirSync(dir).forEach((file) => {
    const absolute = path.join(dir, file)

    if (fs.statSync(absolute).isDirectory()) {
      files = files.concat(getFilesWithin(absolute, endsWith))
    } else {
      if (absolute.endsWith(endsWith)) {
        files.push(absolute)
      }
    }
  })

  return files
}

function getCache(): string[] {
  if (fs.existsSync(cacheFile)) {
    return fs.readFileSync(cacheFile).toString().split("\n")
  }
  return []
}

function writeCache(cache: string[]) {
  return fs.writeFileSync(cacheFile, cache.join("\n"))
}

function run() {
  const cache = getCache()
  fs.readdirSync(dir).forEach((file) => {
    if (fs.existsSync(runDir)) {
      fs.rmdirSync(runDir, { recursive: true })
    }
    fs.mkdirSync(runDir)

    if (!cache.includes(file)) {
      fs.copyFileSync(path.join(dir, file), path.join(runDir, file))
      fs.writeFileSync(path.join(runDir, "elm.codegen.json"), toCodeGenFile(file))

      // Change into the run dir
      chdir(runDir)
      const stdout = Process.execSync("node ../../../bin/elm-codegen install")

      fs.writeFileSync("elm.json", elmJson())
      let elmFiles = getFilesWithin("./Gen", "elm")
      fs.writeFileSync("Test.elm", toElmFile(elmFiles))
      try {
        Process.execSync("elm make Test.elm")
      } catch (e) {
        chdir("..")
        writeCache(cache)
        throw `Ran into an issue generating bindings for ${file}`
      }
      console.log(`Success! ${file}`)
      chdir("..")
      // Now out of the run dir

      fs.rmdirSync(runDir, { recursive: true })
      cache.push(file)
      writeCache(cache)
    } else {
      console.log(`Already ran ${file}`)
    }
  })
}

run()
