module Elm.Gen.Elm.Pattern exposing (aliasPattern, char, cons, fields, float, hex, id_, int, list, moduleName_, named, namedFrom, string, triple, tuple, unit, var, wildcard, withAlias)

{-| 
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Pattern" ]


{-| -}
aliasPattern : { annotation : Type.Annotation }
aliasPattern =
    { annotation = Type.named moduleName_ "Pattern" }


{-| A simple variable name!

This is what you want 90% of the time.

-}
var : Elm.Expression -> Elm.Expression
var arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "var"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-|

    `()`

-}
unit : Elm.Expression
unit =
    Elm.valueWith
        moduleName_
        "unit"
        (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])


{-|

    'c'

-}
char : Elm.Expression -> Elm.Expression
char arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "char"
            (Type.function
                [ Type.namedWith [ "Char" ] "Char" [] ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-| -}
string : Elm.Expression -> Elm.Expression
string arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "string"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-| -}
int : Elm.Expression -> Elm.Expression
int arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "int"
            (Type.function
                [ Type.int ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-|

    0x11

-}
hex : Elm.Expression -> Elm.Expression
hex arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "hex"
            (Type.function
                [ Type.int ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-| -}
float : Elm.Expression -> Elm.Expression
float arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "float"
            (Type.function
                [ Type.float ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-|

    Elm.Pattern.tuple
        (Elm.Pattern.var "one")
        (Elm.Pattern.var "two")

results in

    ( one, two )

-}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "tuple"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "triple"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2, arg3 ]


{-|

    Elm.Pattern.fields
        [ "field1"
        , "field2"
        ]

results in

    { field1, field2}

-}
fields : Elm.Expression -> Elm.Expression
fields arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "fields"
            (Type.function
                [ Type.list Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-| -}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "cons"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
list : Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "list"
            (Type.function
                [ Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" []) ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1 ]


{-|

    Elm.Pattern.named "Just" [ Elm.Pattern.var "value" ]

would result in the following unpacking

    Just value

-}
named : Elm.Expression -> Elm.Expression -> Elm.Expression
named arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "named"
            (Type.function
                [ Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2 ]


{-| Same as `named`, but from a specific module.

    result = Elm.moduleName ["Result" ]

    Elm.Pattern.namedFrom result "Ok" [ Elm.Pattern.var "value" ]

would result in

    Result.Ok value

-}
namedFrom : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
namedFrom arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "namedFrom"
            (Type.function
                [ Type.list Type.string
                , Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2, arg3 ]


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
withAlias : Elm.Expression -> Elm.Expression -> Elm.Expression
withAlias arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "withAlias"
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
        )
        [ arg1, arg2 ]


{-| The catchall `_` pattern.
-}
wildcard : Elm.Expression
wildcard =
    Elm.valueWith
        moduleName_
        "wildcard"
        (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ :
    { var : Elm.Expression
    , unit : Elm.Expression
    , char : Elm.Expression
    , string : Elm.Expression
    , int : Elm.Expression
    , hex : Elm.Expression
    , float : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , fields : Elm.Expression
    , cons : Elm.Expression
    , list : Elm.Expression
    , named : Elm.Expression
    , namedFrom : Elm.Expression
    , withAlias : Elm.Expression
    , wildcard : Elm.Expression
    }
id_ =
    { var =
        Elm.valueWith
            moduleName_
            "var"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , unit =
        Elm.valueWith
            moduleName_
            "unit"
            (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
    , char =
        Elm.valueWith
            moduleName_
            "char"
            (Type.function
                [ Type.namedWith [ "Char" ] "Char" [] ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , string =
        Elm.valueWith
            moduleName_
            "string"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , int =
        Elm.valueWith
            moduleName_
            "int"
            (Type.function
                [ Type.int ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , hex =
        Elm.valueWith
            moduleName_
            "hex"
            (Type.function
                [ Type.int ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , float =
        Elm.valueWith
            moduleName_
            "float"
            (Type.function
                [ Type.float ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , tuple =
        Elm.valueWith
            moduleName_
            "tuple"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , triple =
        Elm.valueWith
            moduleName_
            "triple"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , fields =
        Elm.valueWith
            moduleName_
            "fields"
            (Type.function
                [ Type.list Type.string ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , cons =
        Elm.valueWith
            moduleName_
            "cons"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , list =
        Elm.valueWith
            moduleName_
            "list"
            (Type.function
                [ Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" []) ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , named =
        Elm.valueWith
            moduleName_
            "named"
            (Type.function
                [ Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , namedFrom =
        Elm.valueWith
            moduleName_
            "namedFrom"
            (Type.function
                [ Type.list Type.string
                , Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , withAlias =
        Elm.valueWith
            moduleName_
            "withAlias"
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                ]
                (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
            )
    , wildcard =
        Elm.valueWith
            moduleName_
            "wildcard"
            (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
    }


