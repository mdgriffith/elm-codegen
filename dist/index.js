"use strict";
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
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
Object.defineProperty(exports, "__esModule", { value: true });
var commander = __importStar(require("commander")); // include commander in git clone of commander repo
var program = new commander.Command();
program
    .version('0.1.0')
    .arguments('<file>')
    .option('--watch', 'Watch the given file for changes and rerun the generator when a change is made.')
    .option('--output', 'The directory where your generated files should go.')
    .option('--from-docs', 'The docs.json file to generate package bindings from.')
    .action(function (file, options, com) {
    console.log("FILE:", file);
    console.log(options);
    if (file.endsWith(".elm")) {
        console.log("ELM");
    }
    else if (file.endsWith(".json")) {
        console.log("JS");
    }
    else if (file.split("/").length == 2) {
        console.log("Elm package!");
    }
});
program.parse();
