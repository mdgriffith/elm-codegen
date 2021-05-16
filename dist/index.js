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
Object.defineProperty(exports, "__esModule", { value: true });
var commander = __importStar(require("commander")); // include commander in git clone of commander repo
var elm_compiler = __importStar(require("node-elm-compiler"));
var path = __importStar(require("path"));
var fs = __importStar(require("fs"));
var XMLHttpRequest_1 = require("./run/vendor/XMLHttpRequest");
var chokidar = __importStar(require("chokidar"));
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
var elm_process_opts = { stdio: [null, 'ignore', 'inherit'] };
var program = new commander.Command();
function generate(elm_file, moduleName, target_dir, base, flags) {
    var data = elm_compiler.compileToStringSync([elm_file], { cwd: base, processOpts: elm_process_opts });
    if (data === "") {
        throw "Compiler error";
    }
    // @ts-ignore
    new run_generator(target_dir, moduleName, data.toString(), flags);
}
program
    .version('0.1.0')
    .arguments('<file>')
    .option('--watch', 'Watch the given file for changes and rerun the generator when a change is made.')
    .option('--cwd <dir>', 'Change the base directory for compiling your Elm generator')
    .option('--output <dir>', 'The directory where your generated files should go.')
    .option('--from-docs <docs>', 'The docs.json file to generate package bindings from.')
    .action(function (file, options, com) {
    console.log("FILE:", file);
    console.log(options);
    var cwd = options.cwd || ".";
    var output = path.join(cwd, options.output || "generated");
    var flags = null;
    if (options.fromDocs) {
        flags = JSON.parse(fs.readFileSync(options.fromDocs).toString());
    }
    if (file.endsWith(".elm")) {
        var moduleName_1 = path.parse(file).name;
        if (options.watch) {
            generate(file, moduleName_1, output, cwd, flags);
            chokidar.watch(path.join(cwd, "**", "*.elm"), { ignored: path.join(output, "**") }).on('all', function (event, path) {
                console.log("\nFile changed, regenerating");
                generate(file, moduleName_1, output, cwd, flags);
            });
        }
        else {
            generate(file, moduleName_1, output, cwd, flags);
        }
    }
    else if (file.endsWith(".json")) {
        console.log("JS");
    }
    else if (file.split("/").length == 2) {
        console.log("Elm package!");
    }
});
program.parse();
