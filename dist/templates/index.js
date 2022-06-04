"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var CodeGen_Generate_elm_1 = __importDefault(require("./CodeGen.Generate.elm"));
var Starter_elm_1 = __importDefault(require("./Starter.elm"));
var Elm_json_1 = __importDefault(require("./Elm.json"));
var ElmCodeGen_json_1 = __importDefault(require("./ElmCodeGen.json"));
var Helper_elm_1 = __importDefault(require("./Helper.elm"));
exports.default = {
    init: {
        elmJson: Elm_json_1.default,
        starter: Starter_elm_1.default,
        codegenProgram: CodeGen_Generate_elm_1.default,
        elmCodegenJson: ElmCodeGen_json_1.default,
        helper: Helper_elm_1.default,
    },
};
