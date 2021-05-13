module Elm.Pattern exposing
    ( Pattern, var, skip, unit, char, string, int, hex, float
    , tuple, triple, fields, cons, list, named, namedFrom, withAlias
    )

{-|

@docs Pattern, var, skip, unit, char, string, int, hex, float

@docs tuple, triple, fields, cons, list, named, namedFrom, withAlias

-}

import Elm
import Elm.Syntax.Pattern as Pattern
import Internal.Util as Util



{-


   Reference

       AllPattern: _
       UnitPattern: ()
       CharPattern: 'c'
       StringPattern: "hello"
       IntPattern: 42
       HexPattern: 0x11
       FloatPattern: 42.0
       TuplePattern: (a, b)
       RecordPattern: {name, age}
       UnConsPattern: x :: xs
       ListPattern: [ x, y ]
       VarPattern: x
       NamedPattern: Just _
       AsPattern: _ as x
       ParenthesizedPattern: ( _ )

-}


{-| -}
type alias Pattern =
    Pattern.Pattern


{-| The catchall `_` pattern.
-}
skip : Pattern
skip =
    Pattern.AllPattern


{-|

    `()`

-}
unit : Pattern
unit =
    Pattern.UnitPattern


{-|

    `'c'`

-}
char : Char -> Pattern
char charVal =
    Pattern.CharPattern charVal


{-| -}
string : String -> Pattern
string literal =
    Pattern.StringPattern literal


{-| -}
int : Int -> Pattern
int intVal =
    Pattern.IntPattern intVal


{-|

    `0x11`

-}
hex : Int -> Pattern
hex hexVal =
    Pattern.HexPattern hexVal


{-| -}
float : Float -> Pattern
float floatVal =
    Pattern.FloatPattern floatVal


{-|

    Elm.Pattern.tuple
        (Elm.Pattern.var "one")
        (Elm.Pattern.var "two")

results in

    `(one, two)`

-}
tuple : Pattern -> Pattern -> Pattern
tuple one two =
    Pattern.TuplePattern (Util.nodifyAll [ one, two ])


{-| -}
triple : Pattern -> Pattern -> Pattern
triple one two =
    Pattern.TuplePattern (Util.nodifyAll [ one, two ])


{-|

    Elm.Pattern.fields
        [ "field1"
        , "field2"
        ]

results in

    { field1, field2}

-}
fields : List String -> Pattern
fields flds =
    Pattern.RecordPattern (Util.nodifyAll flds)


{-| -}
cons : Pattern -> Pattern -> Pattern
cons hd tl =
    Pattern.UnConsPattern (Util.nodify hd) (Util.nodify tl)
        |> parens


{-| -}
list : List Pattern -> Pattern
list seq =
    Pattern.ListPattern (Util.nodifyAll seq)


{-| A simple variable name!

This is what you want 90% of the time.

-}
var : String -> Pattern
var name =
    Pattern.VarPattern name


{-|

    Elm.Pattern.named "Just" [ Elm.Pattern.var "value" ]

would result in the following unpacking

    Just value

-}
named : String -> List Pattern -> Pattern
named name patterns =
    Pattern.NamedPattern { moduleName = [], name = name } (Util.nodifyAll patterns)
        |> parensIf (not (List.isEmpty patterns))


{-| Same as `named`, but from a specific module.

    result = Elm.moduleName ["Result" ]

    Elm.Pattern.namedFrom result "Ok" [ Elm.Pattern.var "value" ]

would result in

    Result.Ok value

-}
namedFrom : Elm.Module -> String -> List Pattern -> Pattern
namedFrom moduleName name patterns =
    Pattern.NamedPattern { moduleName = Util.unpack moduleName, name = name } (Util.nodifyAll patterns)
        |> parensIf (not (List.isEmpty patterns))


{-| This is equivalent to `as` in Elm.

Sometimes you want to unpack some stuff, but also keep a reference to the top level thing.

    Pattern.withAlias "fullTuple"
        (Pattern.tuple
            (Pattern.var "one")
            (Pattern.var "two")
        )

results in

    ((one, two) as fullTuple)

-}
withAlias : String -> Pattern -> Pattern
withAlias name pattern =
    Pattern.AsPattern (Util.nodify pattern) (Util.nodify name)
        |> parens


parensIf : Bool -> Pattern -> Pattern
parensIf on pattern =
    if on then
        parens pattern

    else
        pattern


parens : Pattern -> Pattern
parens pattern =
    Pattern.ParenthesizedPattern (Util.nodify pattern)
