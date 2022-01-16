"use strict";
/**/
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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var Commander = __importStar(require("commander"));
var chalk_1 = __importDefault(require("chalk"));
var Run = __importStar(require("./run"));
var program = new Commander.Command();
var helpText = "\nWelcome to " + chalk_1.default.cyan("elm-codegen") + "!\n\nMake sure to check out the " + chalk_1.default.yellow("guides") + ":\n    https://github.com/mdgriffith/elm-codegen#check-out-the-guide\n";
program.version("0.1.0").name("elm-codegen").addHelpText("before", helpText);
program
    .command("init")
    .description("\n    Start an Elm CodeGen project.\n    This will create a " + chalk_1.default.yellow("codegen") + " directory and provide you with everything you need to get started.\n")
    .argument("[installDir]")
    .action(Run.init);
program
    .command("install")
    .description("\n    Install helpers for an " + chalk_1.default.yellow("Elm package") + " or a local Elm file.\n    " + chalk_1.default.cyan("elm-codegen install elm/json") + "\n    " + chalk_1.default.cyan("elm-codegen install codegen/helpers/LocalFile.elm") + "\n")
    .argument("[package]")
    .argument("[version]")
    .action(Run.run_install);
program
    .command("run")
    .description("\n    Run " + chalk_1.default.yellow("codegen/Generate.elm") + ".\n    " + chalk_1.default.cyan("elm-codegen run") + "\n\n  You may pass it a specific Elm file to run.\n")
    .argument("[elmFile]")
    .option("--debug", "Run your generator in debug mode, allowing you to use Debug.log in your elm.", false)
    .option("--watch", "Watch the given file for changes and rerun the generator when a change is made.", false)
    .option("--output <dir>", "The directory where your generated files should go.", "generated")
    .option("--flags-from <file>", "The file to feed to your elm app as flags.  If it has a json extension, it will be handed in as json.")
    .option("--flags <json>", "Json to pass to your elm app.  if --flags-from is given, that will take precedence.")
    .action(Run.run_generation_from_cli);
program.showHelpAfterError();
program.parseAsync();
