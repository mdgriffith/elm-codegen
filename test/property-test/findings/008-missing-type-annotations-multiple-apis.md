# Bug: Multiple APIs produce declarations without type annotations

## Summary

Several elm-codegen APIs produce declarations where the type inference fails silently, resulting in missing type annotations. The generated code still compiles (Elm infers the types), but the annotations are absent, which is unexpected for a code generation tool.

## Affected APIs

### 1. `Elm.Let.unpack` with tuple destructuring
```elm
Elm.Let.letIn (\( first, second ) -> first)
    |> Elm.Let.unpack (Elm.Arg.tuple (Elm.Arg.var "first") (Elm.Arg.var "second"))
        (Elm.tuple (Elm.int 1) (Elm.string "hi"))
    |> Elm.Let.toExpression
```
Generates `letUnpack = let (first, second) = (1, "hi") in first` with no type annotation.

### 2. `Elm.Let.fn` (let-bound functions)
```elm
Elm.Let.letIn (\myFn -> myFn (Elm.int 1))
    |> Elm.Let.fn "myFn" (Elm.Arg.var "arg") (\_ -> body.expr)
    |> Elm.Let.toExpression
```
Generates `letFn = let myFn arg = ... in myFn 1` with no type annotation.

### 3. `Elm.unwrap` (type constructor extraction)
```elm
Elm.unwrap [] "Wrapper" (Elm.apply constructor [ Elm.int 42 ])
```
Generates `unwrapped = (\(Wrapper val) -> val) (Wrapper 42)` with no type annotation.

### 4. `Elm.Declare.value`'s `.value` reference
```elm
let val = Elm.Declare.value "myVal" (Elm.int 42)
in Elm.declaration "useVal" val.value
```
Generates `useVal = myVal` with no type annotation.

### 5. `Elm.get` through a `Type.namedWith` alias
```elm
Elm.get "value" (Elm.record [("value", Elm.string "test")]
    |> Elm.withType (Type.namedWith [] "Container" [ Type.string ]))
```
Generates `containerVal = { value = "test" }.value` with no type annotation.

### 6. `Elm.get` on a record annotated with `Elm.withType (Type.named [])`
```elm
Elm.get "name" (recordVal |> Elm.withType (Type.named [] "MyAlias"))
```
Generates `aliasField = record.name` with no type annotation.

## Impact

All generated code compiles correctly — the Elm compiler infers the types. But missing type annotations are unexpected from a code generation tool and would fail `NoMissingTypeAnnotation` elm-review rules.

## Reproduction

Run the property test generator and check with elm-review:
```sh
cd test/property-test/script
elm-pages run src/GenerateProgram.elm -- --seed 42 --count 3
cd ..
npx elm-review --config review generated/
```

19 `NoMissingTypeAnnotation` violations across 3 generated files.

## Found by

Coverage-guided whitebox testing of `Elm.Let.unpack`, `Elm.Let.fn`, `Elm.unwrap`, `Elm.Declare.value`, and `Elm.get` through type aliases.
