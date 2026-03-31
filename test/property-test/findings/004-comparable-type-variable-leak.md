# Bug: Comparable type variable leaks through inference cache

## Summary

Same class of bug as finding #1 (number type variable collision), but for the `comparable` type variable used by comparison operators (`<`, `>`, `<=`, `>=`, `==`, `/=`).

When a comparison operator appears inside a case branch, its internal `comparable` type variable (unified with the operand type, e.g. `Char`) leaks into the inference cache. When the case expression merges inferences across branches, this leaked binding can overwrite another branch's type, producing a type mismatch in the generated code.

## Reproduction

```sh
cd test/property-test
SEED=2 COUNT=20 sh run.sh   # Test13 fails
SEED=7 COUNT=20 sh run.sh   # Test18 fails
```

## Generated code (seed 2, Test13)

```elm
value1300 : Bool
value1300 =
    case Just True of
        Nothing ->
            'e'       -- Char! Should be Bool.

        Just mV0x123 ->
            'j' < 'y' -- Bool (correct)
```

The type annotation says `Bool` (from the comparison branch). The `Nothing` branch returns `'e'` (Char) even though the generator requested `TBool` for both branches. The `comparable -> Char` binding from the comparison's operands leaked and infected the other branch's type resolution.

## Root cause

`Elm.Op.lt` (and all comparison operators) uses the type signature `comparable -> comparable -> Bool` via `applyInfix`. When applied to `Elm.char 'j'` and `Elm.char 'y'`, the inference cache gets `{ "comparable" -> Char }`. The result type `Bool` is concrete, so fix #1's `resolveInferenceType` correctly resolves the result but does NOT remove `comparable -> Char` from the cache — it's in the parameter position, and removing parameter bindings breaks legitimate type resolution chains (like `(a -> b) -> List a -> List b`).

When this comparison expression is placed in a case branch, `Elm.Case` merges inferences from all branches. The `comparable -> Char` binding from the comparison branch collides with inference in other branches.

## Relationship to fix #1

Fix #1 (`resolveInferenceType` in `Compiler.applyType`) resolves the *result* type eagerly, which fixed the `number` variable in arithmetic operators. But it doesn't clean up *parameter* variables like `comparable` because:

- Removing all resolved variables from the cache breaks higher-order function type inference (e.g. `map : (a -> b) -> List a -> List b` needs `a` to stay in the cache)
- We can't easily distinguish "internal operator variables" from "external function variables" at the `applyType` level

A proper fix would need to scope type variables to the expression that introduced them, preventing cross-expression leakage through the inference cache merge. This is an architectural issue with how `mergeInferences` works.

## Affected API

All comparison operators when used inside case branches, let bindings, or other compound expressions that merge inferences:
- `Elm.Op.lt`, `Elm.Op.gt`, `Elm.Op.lte`, `Elm.Op.gte`
- `Elm.Op.equal`, `Elm.Op.notEqual`

Also potentially affects any operator whose type signature uses type variables in parameter positions (e.g. `comparable`, `appendable`).
