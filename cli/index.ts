import * as Run from "./run"

export async function run(targetFile: string, options: Run.Options) {
  return Run.run(targetFile, options)
}
