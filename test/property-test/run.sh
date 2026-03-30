#!/bin/bash
set -e

cd "$(dirname "$0")"

SEED=${SEED:-$RANDOM}
COUNT=${COUNT:-10}

echo "=== elm-codegen Property Tests ==="
echo "Seed: $SEED  Count: $COUNT"
echo ""

# Install npm deps if needed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Generate codegen helpers if needed
if [ ! -d "codegen/Gen" ]; then
    echo "Generating codegen helpers..."
    npx elm-codegen install
fi

# Clean previous generated files, preserve elm.json
rm -rf generated/src generated/manifest.json generated/elm-stuff
mkdir -p generated/src

# Ensure generated/elm.json exists
if [ ! -f "generated/elm.json" ]; then
    cat > generated/elm.json << 'ELMJSON'
{
    "type": "application",
    "source-directories": [
        "src"
    ],
    "elm-version": "0.19.1",
    "dependencies": {
        "direct": {
            "elm/core": "1.0.5",
            "elm/json": "1.1.4"
        },
        "indirect": {}
    },
    "test-dependencies": {
        "direct": {},
        "indirect": {}
    }
}
ELMJSON
fi

# Generate programs
echo "Generating $COUNT test programs with seed $SEED..."
node generate.mjs --seed "$SEED" --count "$COUNT"
echo ""

# Run the harness (compile + elm-review)
echo "Running property tests..."
echo ""
node harness.mjs

echo ""
echo "=== Done (seed: $SEED) ==="
