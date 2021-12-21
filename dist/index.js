"use strict";
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
var templates_1 = __importDefault(require("./templates"));
var gen_package = require("./gen-package");
// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest_1.XMLHttpRequest.XMLHttpRequest;
var currentVersion = require('../package.json').version;
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
                if (app.ports.onInfoSend) {
                    app.ports.onInfoSend.subscribe(function (info) { return console.log(info); });
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
                var s = files.length == 1 ? "" : "s";
                console.log(format_block([chalk_1.default.yellow(files.length) + " file" + s + " generated!"]));
            })
                .catch(function (reason) {
                console.error(format_title(reason.title), "\n\n" + reason.description + "\n");
            });
            return [2 /*return*/, promise];
        });
    });
}
var program = new commander.Command();
function generate(debug, elm_file, moduleName, target_dir, base, flags) {
    try {
        var data = elm_compiler.compileToStringSync([elm_file], { cwd: base, optimize: !debug, processOpts: { stdio: [null, null, 'inherit'] } });
        // @ts-ignore
        return new run_generator(target_dir, moduleName, data.toString(), flags);
    }
    catch (error) {
        // This is generally an elm make error from the elm_compiler
        console.log(error);
    }
}
var docs_generator = { cwd: "cli/gen-package", file: "src/Generate.elm", moduleName: "Generate" };
function format_title(title) {
    var tail = "-".repeat(80 - (title.length + 2));
    return chalk_1.default.cyan("--" + title.toUpperCase() + tail);
}
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
                if (app.ports.onInfoSend) {
                    app.ports.onInfoSend.subscribe(function (info) { return console.log(info); });
                }
                if (app.ports.onFailureSend) {
                    app.ports.onFailureSend.subscribe(reject);
                }
            })
                .then(function (files) {
                for (var _i = 0, files_2 = files; _i < files_2.length; _i++) {
                    var file = files_2[_i];
                    var fullpath = path.join(output, file.path);
                    fs.mkdirSync(path.dirname(fullpath), { recursive: true });
                    fs.writeFileSync(fullpath, file.contents);
                }
            })
                .catch(function (reason) {
                console.error(format_title(reason.title), "\n\n" + reason.description + "\n");
            });
            return [2 /*return*/, promise];
        });
    });
}
// INSTALL
//   Install bindings for a package
function install_package(pkg, output, version) {
    return __awaiter(this, void 0, void 0, function () {
        var searchResp, search, _i, search_1, found, docsResp, docs, codeGenJson;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    if (!(version == null)) return [3 /*break*/, 3];
                    return [4 /*yield*/, node_fetch_1.default("https://elm-package-cache-psi.vercel.app/search.json")];
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
                    codeGenJson = getCodeGenJson();
                    if (codeGenJson.version != currentVersion) {
                        console.log(chalk_1.default.cyan("elm.codegen.json") + " says you are on version " + chalk_1.default.yellow(codeGenJson.version) + ", but you're running version " + chalk_1.default.yellow(currentVersion));
                        process.exit();
                    }
                    if (codeGenJson.dependencies && codeGenJson.dependencies.packages && pkg in codeGenJson.dependencies.packages) {
                        console.log(chalk_1.default.yellow(pkg) + " is already installed!");
                        if (codeGenJson.dependencies.packages[pkg] != version) {
                            console.log("If you want to change versions, adjust " + chalk_1.default.cyan("elm.codegen.json") + " and run " + chalk_1.default.cyan("elm-codegen install"));
                        }
                        process.exit(1);
                    }
                    try {
                        codeGenJson.dependencies.packages[pkg] = version;
                        fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson));
                        run_package_generator(output, { docs: docs });
                    }
                    catch (error) {
                        console.log("There was an issue generating docs for " + pkg);
                        // @ts-ignore
                        console.log(format_block([error]));
                    }
                    return [2 /*return*/];
            }
        });
    });
}
function getCodeGenJson() {
    var codeGenJson = JSON.parse(fs.readFileSync(path.join(".", "elm.codegen.json")).toString());
    return { version: codeGenJson["elm-codegen-version"], output: codeGenJson.output, dependencies: { packages: codeGenJson.dependencies.packages, local: codeGenJson.dependencies.local } };
}
function codeGenJsonToString(codeGen) {
    var obj = {};
    obj["elm-codegen-version"] = codeGen.version;
    obj.dependencies = codeGen.dependencies;
    return JSON.stringify(obj);
}
// INIT
//    Start a new elm-codegen project
//    Generates some files and installs `core`
function init(install_dir) {
    return __awaiter(this, void 0, void 0, function () {
        var base, codeGenJson;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    base = path.join(".", install_dir);
                    // create folder
                    if (fs.existsSync(base)) {
                        console.log(format_block(["Looks like there's already a " + chalk_1.default.cyan(install_dir) + " folder."]));
                        process.exit(1);
                    }
                    if (fs.existsSync(path.join(base, "elm.codegen.json"))) {
                        console.log(format_block(["Looks like there's already a " + chalk_1.default.cyan(path.join(base, "elm.codegen.json")) + " file."]));
                        process.exit(1);
                    }
                    codeGenJson = JSON.parse(templates_1.default.init.elmCodegenJson());
                    codeGenJson["elm-codegen-version"] = currentVersion;
                    fs.mkdirSync(base);
                    fs.mkdirSync(path.join(base, "Elm"));
                    fs.writeFileSync(path.join(".", "elm.codegen.json"), JSON.stringify(codeGenJson));
                    fs.writeFileSync(path.join(base, "elm.json"), templates_1.default.init.elmJson());
                    fs.writeFileSync(path.join(base, "Generate.elm"), templates_1.default.init.starter());
                    fs.writeFileSync(path.join(base, "Elm", "Gen.elm"), templates_1.default.init.elmGen());
                    return [4 /*yield*/, install_package("elm/core", install_dir, null)];
                case 1:
                    _a.sent();
                    console.log(format_block([
                        "Welcome to " + chalk_1.default.yellow("elm-codegen") + "!",
                        "",
                        "I've created the " + chalk_1.default.cyan(install_dir) + " folder and added some files.",
                        chalk_1.default.cyan(path.join(base, "Generate.elm")) + " is a good place to start to see how everything works!",
                        "",
                        "Run your generator by running " + chalk_1.default.yellow("elm-codegen") + ".",
                    ]));
                    return [2 /*return*/];
            }
        });
    });
}
function install_from_codegen_json(options) {
    return __awaiter(this, void 0, void 0, function () {
        var cwd, codeGenJson, install_dir, _i, _a, _b, key, value, elmSources, item, docs;
        return __generator(this, function (_c) {
            console.log("Installing " + chalk_1.default.cyan('elm-codegen') + " dependencies");
            cwd = options.cwd || ".";
            codeGenJson = getCodeGenJson();
            install_dir = path.join(cwd, options.output || "codegen");
            for (_i = 0, _a = Object.entries(codeGenJson.dependencies.packages); _i < _a.length; _i++) {
                _b = _a[_i], key = _b[0], value = _b[1];
                // `value` is a string
                // @ts-ignore
                install_package(key, install_dir, value);
            }
            elmSources = [];
            for (item in codeGenJson.dependencies.local) {
                if (item.endsWith(".json")) {
                    docs = JSON.parse(fs.readFileSync(item).toString());
                    run_package_generator(install_dir, { docs: docs });
                }
                else if (item.endsWith(".elm")) {
                    elmSources.push(fs.readFileSync(item).toString());
                }
            }
            if (elmSources.length > 0) {
                run_package_generator(install_dir, { elmSource: elmSources });
            }
            console.log(chalk_1.default.green("Success!"));
            return [2 /*return*/];
        });
    });
}
// INIT
//    Start a new elm-codegen project
//    Generates some files and installs `core`
function make(elm_file, moduleName, target_dir, base, flags) {
    return __awaiter(this, void 0, void 0, function () {
        var data;
        return __generator(this, function (_a) {
            try {
                data = elm_compiler.compileToStringSync([elm_file], { cwd: base, optimize: true, processOpts: { stdio: [null, null, 'inherit'] } });
                // @ts-ignore
                return [2 /*return*/, new run_generator(target_dir, moduleName, data.toString(), flags)];
            }
            catch (error) {
                // This is generally an elm make error from the elm_compiler
                console.log(error);
            }
            return [2 /*return*/];
        });
    });
}
function clear(dir) {
    fs.readdir(dir, function (err, files) {
        if (err)
            throw err;
        for (var _i = 0, files_3 = files; _i < files_3.length; _i++) {
            var file = files_3[_i];
            fs.unlink(path.join(dir, file), function (err) {
                if (err)
                    throw err;
            });
        }
    });
}
function action(cmd, pkg, options, com) {
    return __awaiter(this, void 0, void 0, function () {
        var cwd, install_dir, codeGenJson, docs, output_1, codeGenJson, flags_1, moduleName_1;
        return __generator(this, function (_a) {
            cwd = options.cwd || ".";
            install_dir = path.join(cwd, "codegen");
            if (cmd == "init") {
                init(install_dir);
            }
            else if (cmd == "install") {
                // Installing packages
                if (!!pkg) {
                    codeGenJson = getCodeGenJson();
                    // Package specified
                    if (pkg.endsWith(".json")) {
                        if (pkg in codeGenJson.dependencies.local) {
                            console.log(pkg + " is already installed!");
                            process.exit(1);
                        }
                        console.log(format_block(["Adding " + chalk_1.default.cyan(pkg) + " to local dependencies and installing."]));
                        docs = JSON.parse(fs.readFileSync(pkg).toString());
                        run_package_generator(install_dir, { docs: docs });
                        codeGenJson.dependencies.local.push(pkg);
                        fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson));
                    }
                    else if (pkg.endsWith(".elm")) {
                        if (pkg in codeGenJson.dependencies.local) {
                            console.log(pkg + " is already installed!");
                            process.exit(1);
                        }
                        run_package_generator(install_dir, { elmSource: [fs.readFileSync(pkg).toString()] });
                        codeGenJson.dependencies.local.push(pkg);
                        fs.writeFileSync(path.join(".", "elm.codegen.json"), codeGenJsonToString(codeGenJson));
                    }
                    else {
                        console.log("Installing " + chalk_1.default.cyan(pkg) + " in " + chalk_1.default.yellow(install_dir));
                        install_package(pkg, install_dir, null);
                    }
                }
                else {
                    // elm-codegen install
                    // means reinstall all packages
                    install_from_codegen_json(options);
                }
            }
            else {
                output_1 = path.join(cwd, options.output || "output");
                try {
                    codeGenJson = getCodeGenJson();
                    output_1 = path.join(cwd, options.output || codeGenJson.output);
                }
                catch (err) { }
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
                        //         clear(output)
                        generate(options.debug, cmd, moduleName_1, output_1, cwd, flags_1);
                        chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output_1, "**") }).on("all", function (event, path) {
                            console.log("\nFile changed, regenerating");
                            generate(options.debug, cmd, moduleName_1, output_1, cwd, flags_1);
                        });
                    }
                    else {
                        //         skipping clearing files because in my test case it was failing with permission denied all the time.
                        //         clear(output)
                        generate(options.debug, cmd, moduleName_1, output_1, cwd, flags_1);
                    }
                }
            }
            return [2 /*return*/];
        });
    });
}
program
    .version("0.1.0")
    .arguments("[cmd] [package]")
    .option("--debug", "Run your generator in debug mode, allowing you to use Debug.log in your elm.", false)
    .option("--watch", "Watch the given file for changes and rerun the generator when a change is made.")
    .option("--cwd <dir>", "Change the base directory for compiling your Elm generator")
    .option("--output <dir>", "The directory where your generated files should go.")
    .option("--flags-from <file>", "The file to feed to your elm app as flags.  If it has a json extension, it will be handed in as json.")
    .option("--flags <json>", "Json to pass to your elm app.  if --flags-from is given, that will take precedence.")
    .action(action);
program.parseAsync();
