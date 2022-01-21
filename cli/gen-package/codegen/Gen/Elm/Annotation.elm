module Gen.Elm.Annotation exposing (bool, char, dict, extensible, float, function, int, list, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, types_, unit, values_, var)

{-| 
@docs moduleName_, var, bool, int, float, string, char, unit, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, function, toString, types_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Annotation" ]


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
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1 ]


{-| -}
bool : Elm.Expression
bool =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "bool"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
int : Elm.Expression
int =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "int"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
float : Elm.Expression
float =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "float"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
string : Elm.Expression
string =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "string"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
char : Elm.Expression
char =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "char"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
unit : Elm.Expression
unit =
    Elm.valueWith
        { importFrom = [ "Elm", "Annotation" ]
        , name = "unit"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1 ]


{-| -}
dict : Elm.Expression -> Elm.Expression -> Elm.Expression
dict arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
result : Elm.Expression -> Elm.Expression -> Elm.Expression
result arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "result"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| -}
function : List Elm.Expression -> Elm.Expression -> Elm.Expression
function arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        Type.string
                    )
            }
        )
        [ arg1 ]


types_ : { annotation : { annotation : Type.Annotation } }
types_ =
    { annotation = { annotation = Type.namedWith moduleName_ "Annotation" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
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
values_ =
    { var =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , bool =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "bool"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , int =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "int"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , float =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "float"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , string =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "string"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , char =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "char"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , unit =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "unit"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , named =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "named"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                        , Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , maybe =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , list =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , tuple =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , triple =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , set =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "set"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , dict =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , result =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "result"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , function =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                            )
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
    , toString =
        Elm.valueWith
            { importFrom = [ "Elm", "Annotation" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        Type.string
                    )
            }
    }


