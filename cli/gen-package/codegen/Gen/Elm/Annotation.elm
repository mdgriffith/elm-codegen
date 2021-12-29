module Gen.Elm.Annotation exposing (bool, char, dict, extensible, float, function, int, list, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, types_, unit, values_, var)

{-| @docs moduleName_, types_, values_, var, bool, int, float, string, char, unit, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, function, toString
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Annotation" ]


types_ : { annotation : { annotation : Type.Annotation } }
types_ =
    { annotation = { annotation = Type.namedWith moduleName_ "Annotation" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ =
    { var =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.annotation.annotation)
            }
    , bool =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "bool"
            , annotation = Just types_.annotation.annotation
            }
    , int =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "int"
            , annotation = Just types_.annotation.annotation
            }
    , float =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "float"
            , annotation = Just types_.annotation.annotation
            }
    , string =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "string"
            , annotation = Just types_.annotation.annotation
            }
    , char =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "char"
            , annotation = Just types_.annotation.annotation
            }
    , unit =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "unit"
            , annotation = Just types_.annotation.annotation
            }
    , named =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "named"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        types_.annotation.annotation
                    )
            }
    , namedWith =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "namedWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.list types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , maybe =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
    , list =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
    , tuple =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , triple =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , set =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "set"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
    , dict =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , result =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "result"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , record =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple Type.string types_.annotation.annotation
                            )
                        ]
                        types_.annotation.annotation
                    )
            }
    , extensible =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "extensible"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple Type.string types_.annotation.annotation
                            )
                        ]
                        types_.annotation.annotation
                    )
            }
    , function =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
    , toString =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function [ types_.annotation.annotation ] Type.string)
            }
    }


{-| A type variable
-}
var : Elm.Expression -> Elm.Expression
var arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.annotation.annotation)
            }
        )
        [ arg1 ]


{-| -}
bool : Elm.Expression
bool =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "bool"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
int : Elm.Expression
int =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "int"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
float : Elm.Expression
float =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "float"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
string : Elm.Expression
string =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "string"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
char : Elm.Expression
char =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "char"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
unit : Elm.Expression
unit =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "unit"
        , annotation = Just types_.annotation.annotation
        }


{-| -}
named : List Elm.Expression -> Elm.Expression -> Elm.Expression
named arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "named"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        types_.annotation.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-| -}
namedWith :
    List Elm.Expression
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
namedWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "namedWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.string
                        , Type.list types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2, Elm.list arg3 ]


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
list : Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1, arg2, arg3 ]


{-| -}
set : Elm.Expression -> Elm.Expression
set arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "set"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
dict arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
result arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "result"
            , annotation =
                Just
                    (Type.function
                        [ types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
record : List Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple Type.string types_.annotation.annotation
                            )
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ Elm.list arg1 ]


{-| -}
extensible : Elm.Expression -> List Elm.Expression -> Elm.Expression
extensible arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "extensible"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple Type.string types_.annotation.annotation
                            )
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| -}
function arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.annotation.annotation
                        , types_.annotation.annotation
                        ]
                        types_.annotation.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function [ types_.annotation.annotation ] Type.string)
            }
        )
        [ arg1 ]


