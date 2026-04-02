# Property Tests

Random program generator for elm-codegen. Generates random Elm files using elm-codegen's API, compiles them with `elm make`, and runs `elm-review` to catch bugs.

## Quick start

```sh
cd test/property-test
SEED=42 COUNT=10 bash run.sh
```

## Running the generator directly

```sh
cd test/property-test/script
elm-pages run src/GenerateProgram.elm -- --seed 42 --count 20
```

## Code coverage

The `--coverage-include ../../../src` flag limits instrumentation to elm-codegen's own source. Without it, the report includes the generator itself and generated codegen helpers (`Gen.*` modules), which are all 0% and dilute the coverage numbers.

```sh
cd test/property-test/script
elm-pages run --coverage --coverage-include ../../../src src/GenerateProgram.elm -- --seed 42 --count 10
```

Coverage output is written to `script/coverage/lcov.info`.
