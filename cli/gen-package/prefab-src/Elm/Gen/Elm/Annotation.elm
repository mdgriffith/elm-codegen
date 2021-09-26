module Elm.Gen.Elm.Annotation exposing (aliasAnnotation, bool, char, dict, extensible, float, function, id_, int, list, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, unit, var)

{-| 
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Annotation" ]


{-| -}
aliasAnnotation : { annotation : Type.Annotation }
aliasAnnotation =
    { annotation = Type.named moduleName_ "Annotation" }


{-| A type variable
-}
var : Elm.Expression -> Elm.Expression
var arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "var"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1 ]


{-| -}
bool : Elm.Expression
bool =
    Elm.valueWith
        moduleName_
        "bool"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
int : Elm.Expression
int =
    Elm.valueWith
        moduleName_
        "int"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
float : Elm.Expression
float =
    Elm.valueWith
        moduleName_
        "float"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
string : Elm.Expression
string =
    Elm.valueWith
        moduleName_
        "string"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
char : Elm.Expression
char =
    Elm.valueWith
        moduleName_
        "char"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
unit : Elm.Expression
unit =
    Elm.valueWith
        moduleName_
        "unit"
        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])


{-| -}
named : Elm.Expression -> Elm.Expression -> Elm.Expression
named arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "named"
            (Type.function
                [ Type.list Type.string, Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
namedWith : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
namedWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "namedWith"
            (Type.function
                [ Type.list Type.string
                , Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2, arg3 ]


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "maybe"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1 ]


{-| -}
list : Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "list"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "tuple"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2, arg3 ]


{-| -}
set : Elm.Expression -> Elm.Expression
set arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "set"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1 ]


{-| -}
dict : Elm.Expression -> Elm.Expression -> Elm.Expression
dict arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "dict"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
result : Elm.Expression -> Elm.Expression -> Elm.Expression
result arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "result"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
record : Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "record"
            (Type.function
                [ Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1 ]


{-| -}
extensible : Elm.Expression -> Elm.Expression -> Elm.Expression
extensible arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "extensible"
            (Type.function
                [ Type.string
                , Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
function : Elm.Expression -> Elm.Expression -> Elm.Expression
function arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "function"
            (Type.function
                [ Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "toString"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                Type.string
            )
        )
        [ arg1 ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ :
    { var : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , string : Elm.Expression
    , char : Elm.Expression
    , unit : Elm.Expression
    , named : Elm.Expression
    , namedWith : Elm.Expression
    , maybe : Elm.Expression
    , list : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , set : Elm.Expression
    , dict : Elm.Expression
    , result : Elm.Expression
    , record : Elm.Expression
    , extensible : Elm.Expression
    , function : Elm.Expression
    , toString : Elm.Expression
    }
id_ =
    { var =
        Elm.valueWith
            moduleName_
            "var"
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , bool =
        Elm.valueWith
            moduleName_
            "bool"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , int =
        Elm.valueWith
            moduleName_
            "int"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , float =
        Elm.valueWith
            moduleName_
            "float"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , string =
        Elm.valueWith
            moduleName_
            "string"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , char =
        Elm.valueWith
            moduleName_
            "char"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , unit =
        Elm.valueWith
            moduleName_
            "unit"
            (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
    , named =
        Elm.valueWith
            moduleName_
            "named"
            (Type.function
                [ Type.list Type.string, Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , namedWith =
        Elm.valueWith
            moduleName_
            "namedWith"
            (Type.function
                [ Type.list Type.string
                , Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , maybe =
        Elm.valueWith
            moduleName_
            "maybe"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , list =
        Elm.valueWith
            moduleName_
            "list"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , tuple =
        Elm.valueWith
            moduleName_
            "tuple"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , triple =
        Elm.valueWith
            moduleName_
            "triple"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , set =
        Elm.valueWith
            moduleName_
            "set"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , dict =
        Elm.valueWith
            moduleName_
            "dict"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , result =
        Elm.valueWith
            moduleName_
            "result"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , record =
        Elm.valueWith
            moduleName_
            "record"
            (Type.function
                [ Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , extensible =
        Elm.valueWith
            moduleName_
            "extensible"
            (Type.function
                [ Type.string
                , Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , function =
        Elm.valueWith
            moduleName_
            "function"
            (Type.function
                [ Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
    , toString =
        Elm.valueWith
            moduleName_
            "toString"
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                Type.string
            )
    }


