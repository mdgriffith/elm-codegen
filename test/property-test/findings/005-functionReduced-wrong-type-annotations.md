# Bug: functionReduced / betaReduce produces wrong type annotations

## Summary

`Elm.functionReduced` correctly beta-reduces lambda expressions (e.g. `\r -> r.name` becomes `.name`) but generates incorrect type annotations for the reduced form. The annotation uses the raw lambda parameter name instead of the inferred type.

## Reproduction

```elm
-- Record accessor reduction
Elm.functionReduced "r" (\r -> Elm.get "name" r)
```

### Generated code

```elm
betaAccessor : r -> name
betaAccessor =
    .name
```

### Expected

```elm
betaAccessor : { b | name : a } -> a
betaAccessor =
    .name
```

The type `r -> name` uses the lambda variable name `r` as a type variable and the field name `name` as a type variable. It should be `{ b | name : a } -> a` (extensible record accessor type).

## Second case: arithmetic partial application

```elm
Elm.functionReduced "x" (\x -> Elm.Op.plus x (Elm.int 1))
```

### Generated code

```elm
betaPartial : x -> Int
betaPartial x =
    x + 1
```

### Expected

```elm
betaPartial : Int -> Int
betaPartial x =
    x + 1
```

The type `x -> Int` uses the lambda variable name `x` as a type variable, but `x` is constrained to `Int` by the `+ 1`. The Elm compiler rejects this because `+` doesn't work with arbitrary type `x`.

## Root cause

`Elm.functionReduced` (Elm.elm ~line 1669) builds the type annotation from the lambda parameter's raw name, then calls `betaReduce` to optimize the expression. But `betaReduce` only transforms the expression AST — it doesn't update the type annotation to match the reduced form. The annotation still reflects the unreduced lambda's parameter types.

In `functionReduced` (line 1679), the argument type is set to `var arg1Name` where `arg1Name` is the user-provided name ("r", "x"). This becomes the type variable in the annotation. But after beta reduction, the actual type constraints (extensible record, number) from the body are lost because `betaReduce` doesn't propagate them back to the annotation.

## Also affects: Elm.unwrapper

```elm
Elm.unwrapper [] "Wrapper"
```

### Generated code
```elm
extract : val -> unwrapped
extract (Wrapper val) = val
```

### Expected
```elm
extract : Wrapper -> Int
extract (Wrapper val) = val
```

Same root cause — the lambda parameter names (`val`, `unwrapped`) become type variables instead of the actual types (`Wrapper`, `Int`).

## Affected patterns

- `Elm.functionReduced "r" (\r -> Elm.get "field" r)` — record accessor
- `Elm.functionReduced "x" (\x -> Elm.Op.plus x (Elm.int N))` — arithmetic
- `Elm.unwrapper` — single-variant type extraction
- Any lambda-producing function where the body constrains the argument type

## Note

`Elm.functionReduced "x" (\x -> x)` (identity) works correctly because the argument type `x` is genuinely polymorphic — no constraint from the body.

## Found by

Whitebox analysis of 0% covered `betaReduce` function, then targeted generator exercising all three reduction paths (record accessor, identity, partial application).
