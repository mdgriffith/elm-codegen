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
exports.run_generation_from_cli = exports.run = exports.run_install = exports.init = void 0;
var elm_compiler = __importStar(require("node-elm-compiler"));
var path = __importStar(require("path"));
var fs = __importStar(require("fs"));
var XMLHttpRequest_1 = require("./run/vendor/XMLHttpRequest");
var Chokidar = __importStar(require("chokidar"));
var node_fetch_1 = __importDefault(require("node-fetch"));
var chalk_1 = __importDefault(require("chalk"));
var templates_1 = __importDefault(require("./templates"));
var gen_package = require("./gen-package");
// We have to stub this in the allow Elm the ability to make http requests.
// @ts-ignore
globalThis["XMLHttpRequest"] = XMLHttpRequest_1.XMLHttpRequest.XMLHttpRequest;
var currentVersion = require("../package.json").version;
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
                if (files.length == 1) {
                    console.log(format_block(["" + chalk_1.default.cyan(base + path.sep) + chalk_1.default.yellow(files[0].path) + " was generated!"]));
                }
                else {
                    console.log(format_block([chalk_1.default.yellow(files.length) + " files generated in " + chalk_1.default.cyan(base) + "!"]));
                }
            })
                .catch(function (errors) {
                var formatted = "";
                if (!!errors[Symbol.iterator]) {
                    for (var _i = 0, errors_1 = errors; _i < errors_1.length; _i++) {
                        var err = errors_1[_i];
                        formatted = formatted + format_title(err.title) + "\n\n" + err.description + "\n";
                    }
                }
                else {
                    if (errors.message.contains("https://github.com/elm/core/blob/1.0.0/hints/2.md")) {
                        formatted = "Problem with the flags given to your Elm application on initialization.\n\n\nAdd the " + chalk_1.default.cyan("--debug") + " to see more details!"; // Assuming this is an Elm init error.
                    }
                    else {
                        formatted = chalk_1.default.cyan(errors.message);
                    }
                }
                console.error(formatted);
            });
            return [2 /*return*/, promise];
        });
    });
}
function generate(debug, elm_file, moduleName, target_dir, base, flags) {
    try {
        var data = elm_compiler.compileToStringSync([elm_file], {
            cwd: base,
            optimize: !debug,
            processOpts: { stdio: [null, null, "inherit"] },
        });
        // @ts-ignore
        return new run_generator(target_dir, moduleName, data.toString(), flags);
    }
    catch (error) {
        // This is generally an elm make error from the elm_compiler
        console.log(error);
    }
}
function getFilesWithin(dir, endsWith) {
    var files = [];
    fs.readdirSync(dir).forEach(function (file) {
        var absolute = path.join(dir, file);
        if (fs.statSync(absolute).isDirectory()) {
            files.concat(getFilesWithin(absolute, endsWith));
        }
        else {
            if (absolute.endsWith(endsWith)) {
                files.push(absolute);
            }
        }
    });
    return files;
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
function install_package(pkg, install_dir, version, codeGenJson) {
    return __awaiter(this, void 0, void 0, function () {
        var searchResp, search, _i, search_1, found, docsResp, docs;
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
                        console.log(format_block(["No package found for " + chalk_1.default.yellow(pkg)]));
                        process.exit();
                    }
                    _a.label = 3;
                case 3: return [4 /*yield*/, node_fetch_1.default("https://elm-package-cache-psi.vercel.app/packages/" + pkg + "/" + version + "/docs.json")];
                case 4:
                    docsResp = _a.sent();
                    return [4 /*yield*/, docsResp.json()
                        // let codeGenJson = getCodeGenJson(install_dir)
                    ];
                case 5:
                    docs = _a.sent();
                    // let codeGenJson = getCodeGenJson(install_dir)
                    if (codeGenJson.version != currentVersion) {
                        console.log(chalk_1.default.cyan("elm.codegen.json") +
                            " says you are on version " +
                            chalk_1.default.yellow(codeGenJson.version) +
                            ", but you're running version " +
                            chalk_1.default.yellow(currentVersion));
                        process.exit();
                    }
                    if (codeGenJson.dependencies && codeGenJson.dependencies.packages && pkg in codeGenJson.dependencies.packages) {
                        console.log(chalk_1.default.yellow(pkg) + " is already installed!");
                        if (codeGenJson.dependencies.packages[pkg] != version) {
                            console.log("If you want to change versions, adjust " +
                                chalk_1.default.cyan("elm.codegen.json") +
                                " and run " +
                                chalk_1.default.cyan("elm-codegen install"));
                        }
                        process.exit(1);
                    }
                    try {
                        run_package_generator(install_dir, { docs: docs });
                        codeGenJson.dependencies.packages[pkg] = version;
                        // fs.writeFileSync(path.join(install_dir, "elm.codegen.json"), codeGenJsonToString(codeGenJson))
                        return [2 /*return*/, codeGenJson];
                    }
                    catch (error) {
                        console.log("There was an issue generating docs for " + pkg);
                        // @ts-ignore
                        console.log(format_block([error]));
                        process.exit(1);
                    }
                    return [2 /*return*/];
            }
        });
    });
}
function getCodeGenJsonDir() {
    if (fs.existsSync("elm.codegen.json")) {
        return ".";
    }
    else if (fs.existsSync("codegen/elm.codegen.json")) {
        return "codegen";
    }
    console.log(format_block([
        "Looks like there's no " + chalk_1.default.yellow("elm.codegen.json") + ".",
        "Run " + chalk_1.default.cyan("elm-codegen init") + " to generate one!",
    ]));
    process.exit(1);
}
function getCodeGenJson(cwd) {
    var stringContents = "";
    try {
        stringContents = fs.readFileSync(path.join(cwd, "elm.codegen.json")).toString();
    }
    catch (error) {
        console.log(format_block([
            "Looks like there's no " + chalk_1.default.yellow("elm.codegen.json") + ".",
            "Run " + chalk_1.default.cyan("elm-codegen init") + " to generate one!",
        ]));
        process.exit(1);
    }
    return json2CodeGenConfig(stringContents);
}
function json2CodeGenConfig(stringJson) {
    try {
        var codeGenJson = JSON.parse(stringJson);
        return {
            version: codeGenJson["elm-codegen-version"],
            dependencies: { packages: codeGenJson["codegen-helpers"].packages, local: codeGenJson["codegen-helpers"].local },
        };
    }
    catch (exception_var) {
        // TODO: convert this exception to a more useful error message
        console.log(format_block(["Looks like there's an issue with " + chalk_1.default.yellow("elm.codegen.json") + "."]));
        process.exit(1);
    }
}
function codeGenJsonToString(codeGen) {
    var obj = {};
    obj["elm-codegen-version"] = codeGen.version;
    obj["codegen-helpers"] = codeGen.dependencies;
    return JSON.stringify(obj, null, 4);
}
function codeGenJsonDefault() {
    var codeGenJson = JSON.parse(templates_1.default.init.elmCodegenJson());
    codeGenJson["elm-codegen-version"] = currentVersion;
    return json2CodeGenConfig(JSON.stringify(codeGenJson));
}
// INIT
//    Start a new elm-codegen project
//    Generates some files and installs `core`
function init(desiredInstallDir) {
    return __awaiter(this, void 0, void 0, function () {
        var install_dir, base, codeGenJson, updatedCodeGenJson, helperPath, elmSources;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    install_dir = desiredInstallDir || "codegen";
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
                    codeGenJson = codeGenJsonDefault();
                    fs.mkdirSync(base);
                    fs.mkdirSync(path.join(base, "Gen"));
                    fs.mkdirSync(path.join(base, "Gen", "CodeGen"));
                    fs.mkdirSync(path.join(base, "helpers"));
                    fs.writeFileSync(path.join(base, "elm.json"), templates_1.default.init.elmJson());
                    fs.writeFileSync(path.join(base, "Generate.elm"), templates_1.default.init.starter());
                    fs.writeFileSync(path.join(base, "Gen", "CodeGen", "Generate.elm"), templates_1.default.init.codegenProgram());
                    fs.writeFileSync(path.join(base, "helpers", "Helper.elm"), templates_1.default.init.helper());
                    return [4 /*yield*/, install_package("elm/core", install_dir, null, codeGenJson)];
                case 1:
                    updatedCodeGenJson = _a.sent();
                    helperPath = path.join(base, "helpers") + path.sep;
                    elmSources = [];
                    getFilesWithin(helperPath, ".elm").forEach(function (elmPath) {
                        elmSources.push(fs.readFileSync(elmPath).toString());
                    });
                    run_package_generator(install_dir, { elmSource: elmSources });
                    updatedCodeGenJson.dependencies.local.push(helperPath);
                    fs.writeFileSync(path.join(base, "elm.codegen.json"), codeGenJsonToString(updatedCodeGenJson));
                    console.log(format_block([
                        "Welcome to " + chalk_1.default.yellow("elm-codegen") + "!",
                        "",
                        "I've created the " + chalk_1.default.cyan(install_dir) + " folder and added some files.",
                        chalk_1.default.cyan(path.join(base, "Generate.elm")) + " is a good place to start to see how everything works!",
                        "",
                        "Run your generator by running " + chalk_1.default.yellow("elm-codegen run"),
                    ]));
                    return [2 /*return*/];
            }
        });
    });
}
exports.init = init;
function reinstall_everything(install_dir, codeGenJson) {
    return __awaiter(this, void 0, void 0, function () {
        var emptyCodeGenJson, _i, _a, _b, key, version, elmSources, _c, _d, item, docs;
        return __generator(this, function (_e) {
            switch (_e.label) {
                case 0:
                    console.log("Installing dependencies from " + chalk_1.default.yellow("elm.codegen.json"));
                    emptyCodeGenJson = codeGenJsonDefault();
                    _i = 0, _a = Object.entries(codeGenJson.dependencies.packages);
                    _e.label = 1;
                case 1:
                    if (!(_i < _a.length)) return [3 /*break*/, 4];
                    _b = _a[_i], key = _b[0], version = _b[1];
                    // `version` is a string
                    // install_package returns a new CodeGenJson,
                    // but we already know it should be exactly like the one we have
                    // @ts-ignore
                    return [4 /*yield*/, install_package(key, install_dir, version, emptyCodeGenJson)];
                case 2:
                    // `version` is a string
                    // install_package returns a new CodeGenJson,
                    // but we already know it should be exactly like the one we have
                    // @ts-ignore
                    _e.sent();
                    _e.label = 3;
                case 3:
                    _i++;
                    return [3 /*break*/, 1];
                case 4:
                    fs.writeFileSync(path.join(install_dir, "Gen", "CodeGen", "Generate.elm"), templates_1.default.init.codegenProgram());
                    elmSources = [];
                    for (_c = 0, _d = codeGenJson.dependencies.local; _c < _d.length; _c++) {
                        item = _d[_c];
                        console.log("Installing " + item);
                        if (item.endsWith(".json")) {
                            console.log("From json " + item);
                            docs = JSON.parse(fs.readFileSync(item).toString());
                            run_package_generator(install_dir, { docs: docs });
                        }
                        else if (item.endsWith(".elm")) {
                            elmSources.push(fs.readFileSync(item).toString());
                        }
                        else if (item.endsWith(path.sep)) {
                            getFilesWithin(item, ".elm").forEach(function (elmPath) {
                                elmSources.push(fs.readFileSync(elmPath).toString());
                            });
                        }
                    }
                    if (elmSources.length > 0) {
                        run_package_generator(install_dir, { elmSource: elmSources });
                    }
                    console.log(chalk_1.default.green("Success!"));
                    return [2 /*return*/];
            }
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
function isLocal(pkg) {
    return pkg.endsWith(".json") || pkg.endsWith(path.sep) || pkg.endsWith(".elm");
}
function copyHelpers(codeGenJson, options) {
    // create output directory if it doesn't exist
    fs.mkdirSync(options.output, { recursive: true });
    var _loop_1 = function (item) {
        if (item.endsWith(".elm")) {
            fs.writeFileSync(path.join(options.output, item), fs.readFileSync(item).toString());
        }
        else if (item.endsWith(path.sep)) {
            getFilesWithin(item, ".elm").forEach(function (elmPath) {
                var relative = path.relative(item, elmPath);
                fs.writeFileSync(path.join(options.output, relative), fs.readFileSync(elmPath).toString());
            });
        }
    };
    // copy over all local dependencies
    for (var _i = 0, _a = codeGenJson.dependencies.local; _i < _a.length; _i++) {
        var item = _a[_i];
        _loop_1(item);
    }
}
function run_install(pkg, version) {
    return __awaiter(this, void 0, void 0, function () {
        var install_dir, codeGenJson, codeGenJsonPath, docs, elmSources_1, updatedCodeGenJson;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    install_dir = getCodeGenJsonDir();
                    codeGenJson = getCodeGenJson(install_dir);
                    codeGenJsonPath = path.join(install_dir, "elm.codegen.json");
                    if (!!!pkg) return [3 /*break*/, 6];
                    // Is it already installed?
                    // If it is and they want a reinstall, they should run `elm-codegen install`
                    if (isLocal(pkg) && pkg in codeGenJson.dependencies.local) {
                        console.log(format_block([
                            chalk_1.default.cyan(pkg) + " is already installed!",
                            "Run " + chalk_1.default.yellow("elm-codegen install") + " if you want to refresh the helper files.",
                        ]));
                        process.exit(1);
                    }
                    if (!pkg.endsWith(".json")) return [3 /*break*/, 1];
                    //
                    // Install local docs file
                    console.log(format_block(["Adding " + chalk_1.default.cyan(pkg) + " to local dependencies and installing."]));
                    docs = JSON.parse(fs.readFileSync(pkg).toString());
                    run_package_generator(install_dir, { docs: docs });
                    codeGenJson.dependencies.local.push(pkg);
                    fs.writeFileSync(codeGenJsonPath, codeGenJsonToString(codeGenJson));
                    return [3 /*break*/, 5];
                case 1:
                    if (!pkg.endsWith(path.sep)) return [3 /*break*/, 2];
                    //
                    // Install all files within the pkg directory
                    console.log(format_block(["Adding the " + chalk_1.default.cyan(pkg) + " directory to local dependencies and installing."]));
                    elmSources_1 = [];
                    getFilesWithin(pkg, ".elm").forEach(function (elmPath) {
                        elmSources_1.push(fs.readFileSync(elmPath).toString());
                    });
                    run_package_generator(install_dir, { elmSource: elmSources_1 });
                    codeGenJson.dependencies.local.push(pkg);
                    fs.writeFileSync(codeGenJsonPath, codeGenJsonToString(codeGenJson));
                    return [3 /*break*/, 5];
                case 2:
                    if (!pkg.endsWith(".elm")) return [3 /*break*/, 3];
                    //
                    // Install local elm file
                    run_package_generator(install_dir, { elmSource: [fs.readFileSync(pkg).toString()] });
                    codeGenJson.dependencies.local.push(pkg);
                    fs.writeFileSync(codeGenJsonPath, codeGenJsonToString(codeGenJson));
                    return [3 /*break*/, 5];
                case 3:
                    //
                    // Install from elm package
                    console.log("Installing " + chalk_1.default.cyan(pkg) + " in " + chalk_1.default.yellow(install_dir));
                    return [4 /*yield*/, install_package(pkg, install_dir, version, codeGenJson)];
                case 4:
                    updatedCodeGenJson = _a.sent();
                    fs.writeFileSync(codeGenJsonPath, codeGenJsonToString(updatedCodeGenJson));
                    console.log(chalk_1.default.green("Success!"));
                    _a.label = 5;
                case 5: return [3 /*break*/, 7];
                case 6:
                    // elm-codegen install
                    // means reinstall all packages
                    reinstall_everything(install_dir, codeGenJson);
                    _a.label = 7;
                case 7: return [2 /*return*/];
            }
        });
    });
}
exports.run_install = run_install;
function run(elmFile, options) {
    return __awaiter(this, void 0, void 0, function () {
        var moduleName, install_dir, codeGenJson;
        return __generator(this, function (_a) {
            moduleName = path.parse(elmFile).name;
            install_dir = getCodeGenJsonDir();
            codeGenJson = getCodeGenJson(install_dir);
            copyHelpers(codeGenJson, options);
            generate(options.debug, elmFile, moduleName, options.output, options.cwd || ".", options.flags);
            return [2 /*return*/];
        });
    });
}
exports.run = run;
function run_generation_from_cli(desiredElmFile, options) {
    return __awaiter(this, void 0, void 0, function () {
        var elmFile, cwd, fullSourcePath, output, flags, moduleName, install_dir, codeGenJson;
        return __generator(this, function (_a) {
            elmFile = "Generate.elm";
            cwd = "./codegen";
            if (desiredElmFile != null) {
                cwd = ".";
                elmFile = desiredElmFile;
            }
            fullSourcePath = path.join(cwd, elmFile);
            output = path.join(cwd, options.output);
            if (!fs.existsSync(fullSourcePath)) {
                console.log(format_block([
                    "I wasn't able to find " + chalk_1.default.yellow(fullSourcePath) + ".",
                    "Have you set up a project using " + chalk_1.default.cyan("elm-codegen init") + "?",
                ]));
                process.exit(0);
            }
            flags = null;
            if (options.flagsFrom) {
                if (options.flagsFrom.endsWith(".json")) {
                    flags = JSON.parse(fs.readFileSync(options.flagsFrom).toString());
                }
                else {
                    flags = fs.readFileSync(options.flagsFrom).toString();
                }
            }
            else if (options.flags) {
                flags = JSON.parse(options.flags);
            }
            moduleName = path.parse(elmFile).name;
            install_dir = getCodeGenJsonDir();
            codeGenJson = getCodeGenJson(install_dir);
            copyHelpers(codeGenJson, {
                debug: options.debug,
                output: options.output,
                flags: flags,
                cwd: null,
            });
            if (options.watch) {
                //         clear(output)
                generate(options.debug, elmFile, moduleName, output, cwd, flags);
                Chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output, "**") }).on("all", function (event, path) {
                    console.log("\nFile changed, regenerating");
                    generate(options.debug, elmFile, moduleName, output, cwd, flags);
                });
            }
            else {
                //         skipping clearing files because in my test case it was failing with permission denied all the time.
                //         clear(output)
                generate(options.debug, elmFile, moduleName, output, cwd, flags);
            }
            return [2 /*return*/];
        });
    });
}
exports.run_generation_from_cli = run_generation_from_cli;
