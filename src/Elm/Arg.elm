module Elm.Arg exposing
    ( unit, var, varWith
    , tuple, triple
    , record, field
    , aliasAs
    , ignore, string, char, int
    , list, item, items, listRemaining
    , customType
    )

{-| An `Arg` can be used to pattern match on the arguments of a function.

    let
        args =
            Elm.Arg.tuple (Arg.var "first") (Arg.var "second")
    in
    Elm.fn args
        (\( first, second ) ->
            Elm.record
                [ ( "first", first )
                , ( "second", second )
                ]
        )

Will generate

    \( first, second ) ->
        { first = first
        , second = second
        }

Or they can be used to unpack values in the branch of a case expression.

    Elm.Case.custom (Elm.val "myVar") (Elm.Annotation.named [] "MyCustomType)
        [ Elm.branch "MyCustomType" (Arg.tuple (Arg.var "first") (Arg.var "second"))
            (\( first, second ) ->
                Elm.record
                    [ ( "first", first )
                    , ( "second", second )
                    ]
            )
        ]

Will generate

      case myVar of
          MyCustomType first second ->
              { first = first
              , second = second
              }

@docs unit, var, varWith

@docs tuple, triple

@docs record, field

@docs aliasAs


## Useful for case expressions

@docs ignore, string, char, int

@docs list, item, items, listRemaining

@docs customType

-}

import Elm exposing (Arg, Expression)
import Elm.Annotation
import Internal.Arg


{-| -}
var : String -> Arg Expression
var =
    Internal.Arg.var


{-| -}
varWith : String -> Elm.Annotation.Annotation -> Arg Expression
varWith =
    Internal.Arg.varWith


{-| An empty tuple `()` is generally called "unit".
-}
unit : Arg Expression
unit =
    Internal.Arg.unit


{-| Unpack a pattern, but keep a reference to the original value.

    let
        args =
            Elm.Arg.customType "MyCustomType" Tuple.pair
                |> Elm.Arg.item (Arg.var "first")
                |> Elm.Arg.item (Arg.var "second")
                |> Elm.Arg.aliasAs "myAlias"
    in
    Elm.fn args
        (\( ( first, second ), myAlias ) ->
            Elm.record
                [ ( "first", first )
                , ( "second", second )
                , ( "myAlias", myAlias )
                ]
        )

Will generate

    \((MyCustomType first second) as myAlias) ->
        { first = first
        , second = second
        , myAlias = myAlias
        }

-}
aliasAs : String -> Arg arg -> Arg ( arg, Expression )
aliasAs =
    Internal.Arg.aliasAs


{-| -}
tuple : Arg one -> Arg two -> Arg ( one, two )
tuple =
    Internal.Arg.tuple


{-| -}
triple : Arg one -> Arg two -> Arg three -> Arg ( one, two, three )
triple =
    Internal.Arg.triple


{-| Unpack record fields.

    let
        args =
            Elm.Arg.record
                |> Elm.Arg.field "first" (Arg.var "first")
                |> Elm.Arg.field "second" (Arg.var "second")
    in
    Elm.fn args
        (\{ first, second } ->
            Elm.record
                [ ( "first", first )
                , ( "second", second )
                ]
        )

Would generate

    \{ first, second } ->
        { first = first
        , second = second
        }

-}
record : fields -> Arg fields
record =
    Internal.Arg.record


{-| -}
field : String -> Arg (Expression -> a) -> Arg a
field =
    Internal.Arg.field


{-| -}
string : String -> Arg Expression
string =
    Internal.Arg.string


{-| -}
char : Char -> Arg Expression
char =
    Internal.Arg.char


{-| -}
int : Int -> Arg Expression
int =
    Internal.Arg.int


{-| Will generate `_` to ignore an argument or pattern.
-}
ignore : Arg Expression
ignore =
    Internal.Arg.ignore


{-|

    Arg.list Tuple.pair
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")

Will genrate

    [ first, second ]

And

     Arg.list
        (\one two remaining ->
            { one = one
            , two = two
            , remaining = remaining
            }
        )
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")
        |> Arg.listRemaining "remaining"

Will generate

    first :: second :: remaining

-}
list : a -> Arg a
list =
    Internal.Arg.list


{-| -}
listRemaining : String -> Arg (Expression -> a) -> Arg a
listRemaining =
    Internal.Arg.listRemaining


{-| -}
item : Arg arg -> Arg (arg -> a) -> Arg a
item =
    Internal.Arg.item


{-| This is for the situation where you only know the number of arguments when you run the generator.

This isn't super common.

-}
items : List (Arg arg) -> Arg (List arg -> a) -> Arg a
items =
    Internal.Arg.items


{-| Let's say you have a custom type like

    type MyCustomType
        = MyCustomType String Int

And you want to extract the String and Int

    let
        args =
            Elm.Arg.customType "MyCustomType" Tuple.pair
                |> Elm.Arg.item (Arg.var "first")
                |> Elm.Arg.item (Arg.var "second")
    in
    Elm.fn args
        (\( first, second ) ->
            Elm.record
                [ ( "first", first )
                , ( "second", second )
                ]
        )

Which will generate

    \(MyCustomType first second) ->
        { first = first
        , second = second
        }

-}
customType : String -> a -> Arg a
customType =
    Internal.Arg.customType
