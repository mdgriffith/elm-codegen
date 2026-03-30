import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const generatedDir = path.join(__dirname, 'generated');
const manifestPath = path.join(generatedDir, 'manifest.json');

async function main() {
  if (!fs.existsSync(manifestPath)) {
    console.error('No manifest.json found. Run the generator first.');
    process.exit(1);
  }

  const moduleNames = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
  console.log(`Testing ${moduleNames.length} generated programs...\n`);

  let passed = 0;
  let failed = 0;
  const failures = [];

  // Phase 1: Compile all modules together (faster than one-by-one)
  console.log('Phase 1: Compiling all generated modules...');
  const elmFiles = moduleNames.map(m => path.join('src', `${m}.elm`));

  try {
    execSync(
      `elm make ${elmFiles.join(' ')} --output=/dev/null`,
      { cwd: generatedDir, stdio: 'pipe', timeout: 120000 }
    );
    console.log(`  All ${moduleNames.length} modules compiled successfully.\n`);
    passed = moduleNames.length;
  } catch (e) {
    console.log('  Batch compilation failed. Testing individually...\n');

    // Fall back to individual compilation to find which ones fail
    for (const moduleName of moduleNames) {
      const elmFile = path.join('src', `${moduleName}.elm`);
      try {
        execSync(
          `elm make ${elmFile} --output=/dev/null`,
          { cwd: generatedDir, stdio: 'pipe', timeout: 30000 }
        );
        passed++;
        process.stdout.write(`  ${moduleName}: COMPILE OK\n`);
      } catch (compileErr) {
        failed++;
        const stderr = compileErr.stderr ? compileErr.stderr.toString() : compileErr.message;
        failures.push({ moduleName, phase: 'compile', error: stderr.slice(0, 500) });
        process.stdout.write(`  ${moduleName}: COMPILE FAIL\n`);

        // Show the generated source for debugging
        const srcPath = path.join(generatedDir, 'src', `${moduleName}.elm`);
        if (fs.existsSync(srcPath)) {
          const src = fs.readFileSync(srcPath, 'utf8');
          console.log(`    --- Generated source (${moduleName}.elm) ---`);
          console.log(src.split('\n').map(l => `    ${l}`).join('\n'));
          console.log(`    --- End source ---`);
        }
        console.log(`    Error: ${stderr.slice(0, 300)}`);
      }
    }
  }

  // Phase 2: Run elm-review on generated code
  console.log('Phase 2: Running elm-review on generated code...');
  const reviewConfigDir = path.join(__dirname, 'review');

  if (fs.existsSync(reviewConfigDir)) {
    try {
      execSync(
        `npx elm-review --config ${reviewConfigDir}`,
        { cwd: generatedDir, stdio: 'pipe', timeout: 120000 }
      );
      console.log('  elm-review: PASS\n');
    } catch (reviewErr) {
      const stdout = reviewErr.stdout ? reviewErr.stdout.toString() : '';
      const stderr = reviewErr.stderr ? reviewErr.stderr.toString() : '';
      const output = stdout || stderr;

      // Count review errors
      const errorLines = output.split('\n').filter(l => l.includes('(fix)') || l.includes('REVIEW'));
      console.log(`  elm-review: FAIL (${errorLines.length} issues found)\n`);
      console.log(output.slice(0, 2000));

      failures.push({ moduleName: 'elm-review', phase: 'review', error: output.slice(0, 1000) });
      failed++;
    }
  } else {
    console.log('  Skipping elm-review (no review/ config found)\n');
  }

  // Summary
  console.log(`\nResults: ${passed} compiled, ${failed} failed`);

  if (failures.length > 0) {
    console.log('\nFailures:');
    for (const f of failures) {
      console.log(`  - ${f.moduleName} [${f.phase}]: ${f.error.split('\n')[0]}`);
    }
    process.exit(1);
  }
}

main();
