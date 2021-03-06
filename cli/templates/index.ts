import codegenProgram from "./CodeGen.Generate.elm"
import starter from "./Starter.elm"
import elmJson from "./Elm.json"
import elmCodegenJson from "./ElmCodeGen.json"
import helper from "./Helper.elm"

export default {
  init: {
    elmJson,
    starter,
    codegenProgram,
    elmCodegenJson,
    helper,
  },
}
