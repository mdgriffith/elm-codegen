module Gen.Elm.Annotation exposing (alias, annotation_, bool, call_, char, dict, extensible, float, function, int, list, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, unit, values_, var)

{-| 
@docs moduleName_, var, bool, int, float, string, char, unit, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, alias, function, toString, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Annotation" ]


{-| A type variable

var: String -> Elm.Annotation.Annotation
-}
var : String -> Elm.Expression
var varArg =
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
        [ Elm.string varArg ]


{-| bool: Elm.Annotation.Annotation -}
bool : Elm.Expression
bool =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "bool"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| int: Elm.Annotation.Annotation -}
int : Elm.Expression
int =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "int"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| float: Elm.Annotation.Annotation -}
float : Elm.Expression
float =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "float"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| string: Elm.Annotation.Annotation -}
string : Elm.Expression
string =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "string"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| char: Elm.Annotation.Annotation -}
char : Elm.Expression
char =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "char"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| unit: Elm.Annotation.Annotation -}
unit : Elm.Expression
unit =
    Elm.value
        { importFrom = [ "Elm", "Annotation" ]
        , name = "unit"
        , annotation =
            Just (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        }


{-| named: List String -> String -> Elm.Annotation.Annotation -}
named : List String -> String -> Elm.Expression
named namedArg namedArg0 =
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
        [ Elm.list (List.map Elm.string namedArg), Elm.string namedArg0 ]


{-| namedWith: 
    List String
    -> String
    -> List Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
namedWith : List String -> String -> List Elm.Expression -> Elm.Expression
namedWith namedWithArg namedWithArg0 namedWithArg1 =
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
        [ Elm.list (List.map Elm.string namedWithArg)
        , Elm.string namedWithArg0
        , Elm.list namedWithArg1
        ]


{-| maybe: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
maybe : Elm.Expression -> Elm.Expression
maybe maybeArg =
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
        [ maybeArg ]


{-| list: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
list : Elm.Expression -> Elm.Expression
list listArg =
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
        [ listArg ]


{-| tuple: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg tupleArg0 =
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
        [ tupleArg, tupleArg0 ]


{-| triple: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 =
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
        [ tripleArg, tripleArg0, tripleArg1 ]


{-| set: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
set : Elm.Expression -> Elm.Expression
set setArg =
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
        [ setArg ]


{-| dict: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
dict : Elm.Expression -> Elm.Expression -> Elm.Expression
dict dictArg dictArg0 =
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
        [ dictArg, dictArg0 ]


{-| result: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
result : Elm.Expression -> Elm.Expression -> Elm.Expression
result resultArg resultArg0 =
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
        [ resultArg, resultArg0 ]


{-| record: List ( String, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation -}
record : List Elm.Expression -> Elm.Expression
record recordArg =
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
        [ Elm.list recordArg ]


{-| extensible: 
    String
    -> List ( String, Elm.Annotation.Annotation )
    -> Elm.Annotation.Annotation
-}
extensible : String -> List Elm.Expression -> Elm.Expression
extensible extensibleArg extensibleArg0 =
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
        [ Elm.string extensibleArg, Elm.list extensibleArg0 ]


{-| The classic example of a Model

    Elm.Annotation.alias []
        "Model"
        []
        (Elm.Annotation.record
            [ ( "hello", Elm.Annotation.string ) ]
        )

would correspond to

    type alias Model =
        { hello : String
        }

alias: 
    List String
    -> String
    -> List Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
alias :
    List String
    -> String
    -> List Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
alias aliasArg aliasArg0 aliasArg1 aliasArg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "alias"
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
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
            }
        )
        [ Elm.list (List.map Elm.string aliasArg)
        , Elm.string aliasArg0
        , Elm.list aliasArg1
        , aliasArg2
        ]


{-| function: 
    List Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
function : List Elm.Expression -> Elm.Expression -> Elm.Expression
function functionArg functionArg0 =
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
        [ Elm.list functionArg, functionArg0 ]


{-| toString: Elm.Annotation.Annotation -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
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
        [ toStringArg ]


annotation_ : { annotation : Type.Annotation }
annotation_ =
    { annotation =
        Type.alias
            moduleName_
            "Annotation"
            []
            (Type.namedWith [ "Internal", "Compiler" ] "Annotation" [])
    }


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
    , alias :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , function : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { var =
        \varArg ->
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
                [ varArg ]
    , named =
        \namedArg namedArg0 ->
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
                [ namedArg, namedArg0 ]
    , namedWith =
        \namedWithArg namedWithArg0 namedWithArg1 ->
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
                [ namedWithArg, namedWithArg0, namedWithArg1 ]
    , maybe =
        \maybeArg ->
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
                [ maybeArg ]
    , list =
        \listArg ->
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
                [ listArg ]
    , tuple =
        \tupleArg tupleArg0 ->
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
                [ tupleArg, tupleArg0 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 ->
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
                [ tripleArg, tripleArg0, tripleArg1 ]
    , set =
        \setArg ->
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
                [ setArg ]
    , dict =
        \dictArg dictArg0 ->
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
                [ dictArg, dictArg0 ]
    , result =
        \resultArg resultArg0 ->
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
                [ resultArg, resultArg0 ]
    , record =
        \recordArg ->
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
                [ recordArg ]
    , extensible =
        \extensibleArg extensibleArg0 ->
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
                [ extensibleArg, extensibleArg0 ]
    , alias =
        \aliasArg aliasArg0 aliasArg1 aliasArg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Annotation" ]
                    , name = "alias"
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
                [ aliasArg, aliasArg0, aliasArg1, aliasArg2 ]
    , function =
        \functionArg functionArg0 ->
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
                [ functionArg, functionArg0 ]
    , toString =
        \toStringArg ->
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
                [ toStringArg ]
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
    , alias : Elm.Expression
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
    , alias =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "alias"
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
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
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


