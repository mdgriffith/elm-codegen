module Gen.Elm.Annotation exposing
    ( alias
    , annotation_
    , bool
    , call_
    , char
    , cmd
    , dict
    , extensible
    , float
    , function
    , int
    , list
    , maybe
    , moduleName_
    , named
    , namedWith
    , record
    , result
    , set
    , string
    , sub
    , toString
    , triple
    , tuple
    , unit
    , values_
    , var
    )

{-|
# Generated bindings for Elm.Annotation

@docs moduleName_, var, bool, int, float, string, char, unit, cmd, sub, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, alias, function, toString, annotation_, call_, values_
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
var varArg_ =
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
        [ Elm.string varArg_ ]


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


{-| cmd: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
cmd : Elm.Expression -> Elm.Expression
cmd cmdArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Annotation" ]
             , name = "cmd"
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
        [ cmdArg_ ]


{-| sub: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
sub : Elm.Expression -> Elm.Expression
sub subArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Annotation" ]
             , name = "sub"
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
        [ subArg_ ]


{-| named: List String -> String -> Elm.Annotation.Annotation -}
named : List String -> String -> Elm.Expression
named namedArg_ namedArg_0 =
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
        [ Elm.list (List.map Elm.string namedArg_), Elm.string namedArg_0 ]


{-| namedWith: 
    List String
    -> String
    -> List Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
namedWith : List String -> String -> List Elm.Expression -> Elm.Expression
namedWith namedWithArg_ namedWithArg_0 namedWithArg_1 =
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
        [ Elm.list (List.map Elm.string namedWithArg_)
        , Elm.string namedWithArg_0
        , Elm.list namedWithArg_1
        ]


{-| maybe: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
maybe : Elm.Expression -> Elm.Expression
maybe maybeArg_ =
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
        [ maybeArg_ ]


{-| list: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
list : Elm.Expression -> Elm.Expression
list listArg_ =
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
        [ listArg_ ]


{-| tuple: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg_ tupleArg_0 =
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
        [ tupleArg_, tupleArg_0 ]


{-| triple: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg_ tripleArg_0 tripleArg_1 =
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
        [ tripleArg_, tripleArg_0, tripleArg_1 ]


{-| set: Elm.Annotation.Annotation -> Elm.Annotation.Annotation -}
set : Elm.Expression -> Elm.Expression
set setArg_ =
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
        [ setArg_ ]


{-| dict: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
dict : Elm.Expression -> Elm.Expression -> Elm.Expression
dict dictArg_ dictArg_0 =
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
        [ dictArg_, dictArg_0 ]


{-| result: 
    Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
result : Elm.Expression -> Elm.Expression -> Elm.Expression
result resultArg_ resultArg_0 =
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
        [ resultArg_, resultArg_0 ]


{-| record: List ( String, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation -}
record : List Elm.Expression -> Elm.Expression
record recordArg_ =
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
        [ Elm.list recordArg_ ]


{-| extensible: 
    String
    -> List ( String, Elm.Annotation.Annotation )
    -> Elm.Annotation.Annotation
-}
extensible : String -> List Elm.Expression -> Elm.Expression
extensible extensibleArg_ extensibleArg_0 =
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
        [ Elm.string extensibleArg_, Elm.list extensibleArg_0 ]


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
alias aliasArg_ aliasArg_0 aliasArg_1 aliasArg_2 =
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
        [ Elm.list (List.map Elm.string aliasArg_)
        , Elm.string aliasArg_0
        , Elm.list aliasArg_1
        , aliasArg_2
        ]


{-| function: 
    List Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
-}
function : List Elm.Expression -> Elm.Expression -> Elm.Expression
function functionArg_ functionArg_0 =
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
        [ Elm.list functionArg_, functionArg_0 ]


{-| toString: Elm.Annotation.Annotation -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
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
        [ toStringArg_ ]


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
    , cmd : Elm.Expression -> Elm.Expression
    , sub : Elm.Expression -> Elm.Expression
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
        \varArg_ ->
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
                [ varArg_ ]
    , cmd =
        \cmdArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Annotation" ]
                     , name = "cmd"
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
                [ cmdArg_ ]
    , sub =
        \subArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Annotation" ]
                     , name = "sub"
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
                [ subArg_ ]
    , named =
        \namedArg_ namedArg_0 ->
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
                [ namedArg_, namedArg_0 ]
    , namedWith =
        \namedWithArg_ namedWithArg_0 namedWithArg_1 ->
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
                [ namedWithArg_, namedWithArg_0, namedWithArg_1 ]
    , maybe =
        \maybeArg_ ->
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
                [ maybeArg_ ]
    , list =
        \listArg_ ->
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
                [ listArg_ ]
    , tuple =
        \tupleArg_ tupleArg_0 ->
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
                [ tupleArg_, tupleArg_0 ]
    , triple =
        \tripleArg_ tripleArg_0 tripleArg_1 ->
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
                [ tripleArg_, tripleArg_0, tripleArg_1 ]
    , set =
        \setArg_ ->
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
                [ setArg_ ]
    , dict =
        \dictArg_ dictArg_0 ->
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
                [ dictArg_, dictArg_0 ]
    , result =
        \resultArg_ resultArg_0 ->
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
                [ resultArg_, resultArg_0 ]
    , record =
        \recordArg_ ->
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
                [ recordArg_ ]
    , extensible =
        \extensibleArg_ extensibleArg_0 ->
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
                [ extensibleArg_, extensibleArg_0 ]
    , alias =
        \aliasArg_ aliasArg_0 aliasArg_1 aliasArg_2 ->
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
                [ aliasArg_, aliasArg_0, aliasArg_1, aliasArg_2 ]
    , function =
        \functionArg_ functionArg_0 ->
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
                [ functionArg_, functionArg_0 ]
    , toString =
        \toStringArg_ ->
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
                [ toStringArg_ ]
    }


values_ :
    { var : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , string : Elm.Expression
    , char : Elm.Expression
    , unit : Elm.Expression
    , cmd : Elm.Expression
    , sub : Elm.Expression
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
    , cmd =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "cmd"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , sub =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "sub"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , named =
        Elm.value
            { importFrom = [ "Elm", "Annotation" ]
            , name = "named"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string, Type.string ]
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , maybe =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , list =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , tuple =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , triple =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , set =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , dict =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , result =
        Elm.value
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
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
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                    )
            }
    , toString =
        Elm.value
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
    }