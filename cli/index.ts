

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
const program = new commander.Command();

program
  .version('0.1.0')
  .arguments('<file>')
  .option('--watch', 'Watch the given file for changes and rerun the generator when a change is made.')
  .option('--output', 'The directory where your generated files should go.')
  .option('--from-docs', 'The docs.json file to generate package bindings from.')
  .action((file, options, com) => {
    console.log("FILE:" , file)
    console.log(options)
    if (file.endsWith(".elm")) {
        console.log("ELM")
    } else if (file.endsWith(".json")) {
        console.log("JS")
    } else if (file.split("/").length == 2 {
        console.log("Elm package!")
    }
  });

program.parse();



