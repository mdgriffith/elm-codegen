"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var Elm_Gen_elm_1 = __importDefault(require("./Elm.Gen.elm"));
var Starter_elm_1 = __importDefault(require("./Starter.elm"));
var Elm_json_1 = __importDefault(require("./Elm.json"));
exports.default = {
    init: {
        elmJson: Elm_json_1.default,
        starter: Starter_elm_1.default,
        elmGen: Elm_Gen_elm_1.default
    },
};
