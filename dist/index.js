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
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var commander = __importStar(require("commander")); // include commander in git clone of commander repo
var elm_compiler = __importStar(require("node-elm-compiler"));
var path = __importStar(require("path"));
var fs = __importStar(require("fs"));
var XMLHttpRequest_1 = require("./run/vendor/XMLHttpRequest");
var chokidar = __importStar(require("chokidar"));
var node_fetch_1 = __importDefault(require("node-fetch"));
var chalk_1 = __importDefault(require("chalk"));
var gen_package = require('./gen-package');
// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest_1.XMLHttpRequest.XMLHttpRequest;
function run_generator(base, moduleName, elm_source, flags) {
    return __awaiter(this, void 0, void 0, function () {
        var promise;
        var _this = this;
        return __generator(this, function (_a) {
            eval(elm_source);
            promise = new Promise(function (resolve, reject) {
                // @ts-ignore
                var app = _this.Elm[moduleName].init({ flags: flags });
                if (app.ports.onSuccessSend) {
                    app.ports.onSuccessSend.subscribe(resolve);
                }
                if (app.ports.onFailureSend) {
                    app.ports.onFailureSend.subscribe(reject);
                }
            })
                .then(function (files) {
                for (var _i = 0, files_1 = files; _i < files_1.length; _i++) {
                    var file = files_1[_i];
                    var fullpath = path.join(base, file.path);
                    fs.mkdirSync(path.dirname(fullpath), { recursive: true });
                    fs.writeFileSync(fullpath, file.contents);
                }
            })
                .then(function (_) { return console.info("Success!"); })
                .catch(function (reason) { return console.error("Failure", reason); });
            return [2 /*return*/, promise];
        });
    });
}
var program = new commander.Command();
function generate(elm_file, moduleName, target_dir, base, flags) {
    var data = elm_compiler.compileToStringSync([elm_file], { cwd: base });
    if (data === "") {
        throw "Compiler error";
    }
    // @ts-ignore
    new run_generator(target_dir, moduleName, data.toString(), flags);
}
var elm_gen_file = "\nport module Elm.Gen exposing (File, error, files)\n\nimport Json.Encode as Json\n\n\ntype alias File =\n    { path : String\n    , contents : String\n    }\n\n\nencodeFile : File -> Json.Value\nencodeFile file =\n    Json.object\n        [ ( \"path\", Json.string file.path )\n        , ( \"contents\", Json.string file.contents )\n        ]\n\n\nfiles : List File -> Cmd msg\nfiles list =\n    onSuccessSend (List.map encodeFile list)\n\n\nerror : String -> Cmd msg\nerror err =\n    onFailureSend err\n\n\nport onSuccessSend : List Json.Value -> Cmd msg\n\n\nport onFailureSend : String -> Cmd msg\n";
var elm_json_file = "\n{\n    \"type\": \"application\",\n    \"source-directories\": [\n        \".\", \"../src\"\n    ],\n    \"elm-version\": \"0.19.1\",\n    \"dependencies\": {\n        \"direct\": {\n            \"elm/browser\": \"1.0.2\",\n            \"elm/core\": \"1.0.5\",\n            \"elm/html\": \"1.0.0\"\n        },\n        \"indirect\": {\n            \"elm/json\": \"1.1.3\",\n            \"elm/time\": \"1.0.0\",\n            \"elm/url\": \"1.0.0\",\n            \"elm/virtual-dom\": \"1.0.2\"\n        }\n    },\n    \"test-dependencies\": {\n        \"direct\": {},\n        \"indirect\": {}\n    }\n}\n";
var elm_starter_file = "module Generator exposing (main)\n\n{-| -}\n\nimport Elm\nimport Elm.Pattern as Pattern\nimport Elm.Type as Type\nimport Elm.Gen\n\n\nmain : Program {} () ()\nmain =\n    Platform.worker\n        { init =\n            json ->\n                ( ()\n                , Elm.Gen.files\n                    [ Elm.render file\n                    ]\n                )\n        , update =\n            msg model ->\n                ( model, Cmd.none )\n        , subscriptions = _ -> Sub.none\n        }\n\n\nfile =\n    Elm.file (Elm.moduleName [ \"My\", \"Module\" ])\n        [ Elm.declaration \"placeholder\"\n            (Elm.valueFrom (Elm.moduleAs [ \"Json\", \"Decode\" ] \"Json\")\n                \"map2\"\n            )\n        , Elm.declaration \"myRecord\"\n            (Elm.record\n                [ ( \"one\", Elm.string \"My cool string\" )\n                , ( \"two\", Elm.int 5 )\n                , ( \"three\"\n                  , Elm.record\n                        [ ( \"four\", Elm.string \"My cool string\" )\n                        , ( \"five\", Elm.int 5 )\n                        ]\n                  )\n                ]\n            )\n            |> Elm.expose\n        ]\n";
var docs_generator = { cwd: "cli/gen-package",
    file: "src/Generate.elm",
    moduleName: "Generate"
};
function format_block(content) {
    return "\n    " + content.join("\n    ") + "\n";
}
function run_package_generator(output, flags) {
    return __awaiter(this, void 0, void 0, function () {
        var promise;
        return __generator(this, function (_a) {
            promise = new Promise(function (resolve, reject) {
                // @ts-ignore
                var app = gen_package.Elm.Generate.init({ flags: flags });
                if (app.ports.onSuccessSend) {
                    app.ports.onSuccessSend.subscribe(resolve);
                }
                if (app.ports.onFailureSend) {
                    app.ports.onFailureSend.subscribe(reject);
                }
            })
                .then(function (files) {
                for (var _i = 0, files_2 = files; _i < files_2.length; _i++) {
                    var file = files_2[_i];
                    var fullpath = path.join(output, file.path);
                    console.log("Generating: " + chalk_1.default.cyan(fullpath));
                    fs.mkdirSync(path.dirname(fullpath), { recursive: true });
                    fs.writeFileSync(fullpath, file.contents);
                }
            })
                .then(function (_) { return console.info("Success!"); })
                .catch(function (reason) { return console.error("Failure", reason); });
            return [2 /*return*/, promise];
        });
    });
}
function install(pkg, output, version) {
    return __awaiter(this, void 0, void 0, function () {
        var searchResp, search, _i, search_1, found, docsResp, docs;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    if (!(version == null)) return [3 /*break*/, 3];
                    return [4 /*yield*/, node_fetch_1.default('https://elm-package-cache-psi.vercel.app/search.json')];
                case 1:
                    searchResp = _a.sent();
                    return [4 /*yield*/, searchResp.json()];
                case 2:
                    search = _a.sent();
                    for (_i = 0, search_1 = search; _i < search_1.length; _i++) {
                        found = search_1[_i];
                        if (found.name == pkg) {
                            version = found.version;
                            break;
                        }
                    }
                    if (version == null) {
                        console.log(format_block(["No package found for " + pkg]));
                        process.exit();
                    }
                    _a.label = 3;
                case 3: return [4 /*yield*/, node_fetch_1.default("https://elm-package-cache-psi.vercel.app/packages/" + pkg + "/" + version + "/docs.json")];
                case 4:
                    docsResp = _a.sent();
                    return [4 /*yield*/, docsResp.json()];
                case 5:
                    docs = _a.sent();
                    try {
                        run_package_generator(output, docs);
                    }
                    catch (error) {
                        console.log("There was an issue generating docs for " + pkg);
                        console.log(format_block([error]));
                    }
                    return [2 /*return*/];
            }
        });
    });
}
function action(cmd, pkg, options, com) {
    return __awaiter(this, void 0, void 0, function () {
        var cwd, output, base, docs, flags_1, moduleName_1;
        return __generator(this, function (_a) {
            cwd = options.cwd || ".";
            output = path.join(cwd, options.output || "output");
            base = "generators";
            if (cmd == "init") {
                // create folder
                if (fs.existsSync("./" + base)) {
                    console.log(format_block(["Looks like there's already a " + chalk_1.default.cyan(base) + " folder."]));
                    process.exit(1);
                }
                fs.mkdirSync("./" + base);
                fs.mkdirSync("./" + base + "/Elm");
                fs.writeFileSync("./" + base + "/elm.json", elm_json_file);
                fs.writeFileSync("./" + base + "/Generate.elm", elm_starter_file);
                fs.writeFileSync("./" + base + "/Elm/Gen.elm", elm_gen_file);
                install("elm/core", base, null);
                console.log(format_block(["I've created the " + chalk_1.default.cyan(base) + " folder and added some files.", chalk_1.default.cyan(base + "/Generate.elm") + " is a good place to get start to see how everything works!", "",
                    "Run your generator by running " + chalk_1.default.yellow("elm-prefab")]));
            }
            else if (cmd == "install" && !!pkg) {
                if (pkg.endsWith(".json")) {
                    console.log(format_block(["Installing via json from " + chalk_1.default.cyan(pkg)]));
                    docs = JSON.parse(fs.readFileSync(pkg).toString());
                    run_package_generator(output, docs);
                }
                else {
                    install(pkg, base, null);
                }
            }
            else {
                flags_1 = null;
                if (options.flagsFrom) {
                    if (options.flagsFrom.endsWith(".json")) {
                        flags_1 = JSON.parse(fs.readFileSync(options.flagsFrom).toString());
                    }
                    else {
                        flags_1 = fs.readFileSync(options.flagsFrom).toString();
                    }
                }
                else if (options.flags) {
                    flags_1 = JSON.parse(options.flags);
                }
                if (cmd.endsWith(".elm")) {
                    moduleName_1 = path.parse(cmd).name;
                    if (options.watch) {
                        generate(cmd, moduleName_1, output, cwd, flags_1);
                        chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output, "**") }).on('all', function (event, path) {
                            console.log("\nFile changed, regenerating");
                            generate(cmd, moduleName_1, output, cwd, flags_1);
                        });
                    }
                    else {
                        generate(cmd, moduleName_1, output, cwd, flags_1);
                    }
                }
            }
            return [2 /*return*/];
        });
    });
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
