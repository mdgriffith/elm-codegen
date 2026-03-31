# Bug: Elm.Arg.aliasAs generates wrong type for alias variable

## Summary

When using `Elm.Arg.aliasAs` to create an `as` pattern on a record destructure, the type annotation for the alias variable uses a fresh type variable instead of the actual record type.

## Reproduction

```elm
Elm.Declare.fn "aliasPattern"
    (Elm.Arg.record (\a b -> ( a, b ))
        |> Elm.Arg.field "name"
        |> Elm.Arg.field "age"
        |> Elm.Arg.aliasAs "person"
    )
    (\( ( name, _ ), person ) ->
        Elm.tuple name person
    )
    |> .declaration
```

## Generated code

```elm
aliasPattern : { name : name, age : age } -> ( name, person )
aliasPattern ({ name, age } as person) =
    ( name, person )
```

## Expected

```elm
aliasPattern : { name : name, age : age } -> ( name, { name : name, age : age } )
aliasPattern ({ name, age } as person) =
    ( name, person )
```

The expression body is correct — `({ name, age } as person)` correctly destructures and aliases. But the return type says `( name, person )` where `person` is a fresh type variable instead of `{ name : name, age : age }`.

## Root cause

`Elm.Arg.aliasAs` (in Internal/Arg.elm) creates the alias pattern but doesn't link the alias variable's type to the underlying pattern's type in the inference. The alias `person` gets a fresh type variable instead of inheriting the record type from the `{ name, age }` pattern.

## Elm compiler error

```
-- TYPE MISMATCH

Something is off with the body of the `aliasPattern` definition:

    ( name, person )

The body is a tuple of type:

    ( name, { age : age, name : name } )

But the type annotation says it should be:

    ( name, person )
```

## Found by

Whitebox analysis targeting 0%-covered `Elm.Arg.aliasAs` function in Internal/Arg.elm.
