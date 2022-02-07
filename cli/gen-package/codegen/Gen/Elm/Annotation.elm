module Gen.Elm.Annotation exposing (annotation_, bool, call_, char, dict, extensible, float, function, int, list, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, unit, values_, var)

{-| 
@docs moduleName_, var, bool, int, float, string, char, unit, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, function, toString, annotation_, call_, values_
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
        (Elm.value
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
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "bool"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
int : Elm.Expression
int =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "int"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
float : Elm.Expression
float =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "float"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
string : Elm.Expression
string =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "string"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
char : Elm.Expression
char =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "char"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
unit : Elm.Expression
unit =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "unit"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| -}
named : List Elm.Expression -> Elm.Expression -> Elm.Expression
named arg1 arg2 =
    Elm.apply
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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
        (Elm.value
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


annotation_ : { annotation : Type.Annotation }
annotation_ =
    { annotation = Type.namedWith moduleName_ "Annotation" [] }


call_ :
    { var : Elm.Expression -> Elm.Expression
    , named : Elm.Expression -> Elm.Expression -> Elm.Expression
    , namedWith :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , maybe : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , set : Elm.Expression -> Elm.Expression
    , dict : Elm.Expression -> Elm.Expression -> Elm.Expression
    , result : Elm.Expression -> Elm.Expression -> Elm.Expression
    , record : Elm.Expression -> Elm.Expression
    , extensible : Elm.Expression -> Elm.Expression -> Elm.Expression
    , function : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { var =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "var"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , named =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "named"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string, Type.string ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , namedWith =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
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
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , maybe =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "maybe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , list =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "list"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , tuple =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "tuple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , triple =
        \arg1_0 arg2_0 arg3_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "triple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0, arg3_0 ]
    , set =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "set"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , dict =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "dict"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , result =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "result"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , record =
        \arg1_0 ->
            Elm.apply
                (Elm.value
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
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , extensible =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
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
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , function =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.value
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
                                , Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    , toString =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "toString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                ]
                                Type.string
                            )
                    }
                )
                [ arg1_0 ]
    }


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
        Elm.value
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
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "bool"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , int =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "int"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , float =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "float"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , string =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "string"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , char =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "char"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , unit =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "unit"
            , annotation =
                Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            }
    , named =
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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
        Elm.value
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


