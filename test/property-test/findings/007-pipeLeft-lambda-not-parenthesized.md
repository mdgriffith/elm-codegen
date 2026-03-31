# Bug: Elm.Op.pipeLeft with lambda absorbs operator into lambda body

## Summary

When `Elm.Op.pipeLeft` is used with a lambda expression as the left operand (the function), the lambda absorbs the `<|` operator into its body instead of being parenthesized.

## Reproduction

```elm
Elm.Op.pipeLeft
    (Elm.fn (Elm.Arg.var "x") (\x -> x))
    (Elm.string "hello")
```

## Generated code

```elm
pipeLeft0 : String
pipeLeft0 =
    \x -> x <| "hello"
```

## Expected

```elm
pipeLeft0 : String
pipeLeft0 =
    (\x -> x) <| "hello"
```

The generated `\x -> x <| "hello"` is parsed as `\x -> (x <| "hello")`, which applies `x` to `"hello"` — not what we wanted. We wanted `(\x -> x) <| "hello"` which applies the identity function to "hello".

## Root cause

Same class as finding #2 (pipe + lambda parens). The `pipeLeft` function uses `applyPipe` which doesn't parenthesize lambda expressions. Finding #2's fix (in `prettyOperatorApplication`) parenthesizes lambdas on the RIGHT side, but `pipeLeft` needs them on the LEFT side since `<|` is right-associative (the function is on the left).

## Note

The fix for finding #2 (PR #132) handles right-side lambdas for `|>`. This is the mirror case for `<|` where the lambda is on the left.

## Found by

Whitebox-targeted generator for 0%-covered `Elm.Op.pipeLeft`.
