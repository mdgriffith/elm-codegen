#!/usr/bin/env node

/**
 * Compiles the Elm generator, runs it, and writes the generated files to disk.
 * Usage: node generate.mjs --seed <N> --count <N>
 */

import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import vm from 'vm';
import { fileURLToPath } from 'url';
import { parseArgs } from 'util';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const scriptDir = path.join(__dirname, 'script');
const generatedDir = path.join(__dirname, 'generated');

// Parse CLI args
const { values } = parseArgs({
  options: {
    seed: { type: 'string' },
    count: { type: 'string', default: '10' },
  },
});

const seed = parseInt(values.seed, 10);
const count = parseInt(values.count || '10', 10);

if (isNaN(seed)) {
  console.error('Usage: node generate.mjs --seed <number> [--count <number>]');
  process.exit(1);
}

// 1. Compile the Elm generator
const elmOutput = path.join(scriptDir, 'elm-stuff', 'generate.js');
console.log('Compiling generator...');
execSync(
  `elm make src/GenerateProgram.elm --optimize --output=${elmOutput}`,
  { cwd: scriptDir, stdio: 'pipe' }
);

// 2. Run the compiled Elm program
const jsSource = fs.readFileSync(elmOutput, 'utf8');
const result = await new Promise((resolve, reject) => {
  const timeout = setTimeout(() => reject(new Error('Generator timed out')), 30000);

  const sandbox = {
    setTimeout: globalThis.setTimeout,
    clearTimeout: globalThis.clearTimeout,
    setInterval: globalThis.setInterval,
    clearInterval: globalThis.clearInterval,
    console: { log() {}, warn() {}, error() {} },
  };

  const context = vm.createContext(sandbox);
  const script = new vm.Script(jsSource, { filename: 'GenerateProgram.js' });
  script.runInContext(context);

  const app = sandbox.Elm.GenerateProgram.init({
    flags: { seed, count },
  });

  app.ports.output.subscribe((value) => {
    clearTimeout(timeout);
    resolve(value);
  });
});

// 3. Write generated files to disk
fs.mkdirSync(path.join(generatedDir, 'src'), { recursive: true });

// Ensure elm.json exists for the generated project
const elmJsonPath = path.join(generatedDir, 'elm.json');
if (!fs.existsSync(elmJsonPath)) {
  fs.writeFileSync(elmJsonPath, JSON.stringify({
    "type": "application",
    "source-directories": ["src"],
    "elm-version": "0.19.1",
    "dependencies": {
      "direct": { "elm/core": "1.0.5", "elm/json": "1.1.4" },
      "indirect": {}
    },
    "test-dependencies": { "direct": {}, "indirect": {} }
  }, null, 4));
}

for (const file of result.files) {
  const filePath = path.join(generatedDir, 'src', file.path);
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, file.contents);
}

// 4. Write manifest
fs.writeFileSync(
  path.join(generatedDir, 'manifest.json'),
  JSON.stringify(result.moduleNames, null, 2)
);

console.log(`Generated ${result.moduleNames.length} programs with seed ${seed}`);
