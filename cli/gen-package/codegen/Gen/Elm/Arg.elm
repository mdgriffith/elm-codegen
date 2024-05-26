module Gen.Elm.Arg exposing (annotation_, call_, char, customType, field, ignore, item, list, listRemaining, moduleName_, record, string, triple, tuple, unit, values_, var, varWith)

{-| 
@docs moduleName_, unit, var, varWith, tuple, triple, record, field, ignore, string, char, list, item, listRemaining, customType, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Arg" ]


{-| unit: Elm.Arg.Arg Elm.Arg.Expression -}
unit : Elm.Expression
unit =
    Elm.value
        { importFrom = [ "Elm", "Arg" ]
        , name = "unit"
        , annotation =
            Just
                (Type.namedWith
                     [ "Elm", "Arg" ]
                     "Arg"
                     [ Type.namedWith [ "Elm", "Arg" ] "Expression" [] ]
                )
        }


{-| var: String -> Elm.Arg.Arg Elm.Arg.Expression -}
var : String -> Elm.Expression
var varArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "var"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                               ]
                          )
                     )
             }
        )
        [ Elm.string varArg ]


{-| varWith: String -> Elm.Annotation.Annotation -> Elm.Arg.Arg Elm.Arg.Expression -}
varWith : String -> Elm.Expression -> Elm.Expression
varWith varWithArg varWithArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "varWith"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                               ]
                          )
                     )
             }
        )
        [ Elm.string varWithArg, varWithArg0 ]


{-| tuple: Elm.Arg.Arg one -> Elm.Arg.Arg two -> Elm.Arg.Arg ( one, two ) -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg tupleArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "tuple"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.tuple (Type.var "one") (Type.var "two") ]
                          )
                     )
             }
        )
        [ tupleArg, tupleArg0 ]


{-| triple: 
    Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg ( one, two, three )
-}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "triple"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.triple
                                   (Type.var "one")
                                   (Type.var "two")
                                   (Type.var "three")
                               ]
                          )
                     )
             }
        )
        [ tripleArg, tripleArg0, tripleArg1 ]


{-| record: fields -> Elm.Arg.Arg fields -}
record : Elm.Expression -> Elm.Expression
record recordArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "record"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "fields" ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "fields" ]
                          )
                     )
             }
        )
        [ recordArg ]


{-| field: String -> Elm.Arg.Arg (Elm.Arg.Expression -> a) -> Elm.Arg.Arg a -}
field : String -> Elm.Expression -> Elm.Expression
field fieldArg fieldArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "field"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.function
                                    [ Type.namedWith
                                        [ "Elm", "Arg" ]
                                        "Expression"
                                        []
                                    ]
                                    (Type.var "a")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string fieldArg, fieldArg0 ]


{-| ignore: Elm.Arg.Arg Elm.Arg.Expression -}
ignore : Elm.Expression
ignore =
    Elm.value
        { importFrom = [ "Elm", "Arg" ]
        , name = "ignore"
        , annotation =
            Just
                (Type.namedWith
                     [ "Elm", "Arg" ]
                     "Arg"
                     [ Type.namedWith [ "Elm", "Arg" ] "Expression" [] ]
                )
        }


{-| string: String -> Elm.Arg.Arg Elm.Arg.Expression -}
string : String -> Elm.Expression
string stringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "string"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                               ]
                          )
                     )
             }
        )
        [ Elm.string stringArg ]


{-| char: Char.Char -> Elm.Arg.Arg Elm.Arg.Expression -}
char : Char.Char -> Elm.Expression
char charArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "char"
             , annotation =
                 Just
                     (Type.function
                          [ Type.char ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                               ]
                          )
                     )
             }
        )
        [ Elm.char charArg ]


{-| Arg.list Tuple.pair
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

list: a -> Elm.Arg.Arg a
-}
list : Elm.Expression -> Elm.Expression
list listArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "list"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ listArg ]


{-| item: Elm.Arg.Arg arg -> Elm.Arg.Arg (arg -> a) -> Elm.Arg.Arg a -}
item : Elm.Expression -> Elm.Expression -> Elm.Expression
item itemArg itemArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "item"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "arg" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.function [ Type.var "arg" ] (Type.var "a")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ itemArg, itemArg0 ]


{-| listRemaining: String -> Elm.Arg.Arg (Elm.Arg.Expression -> a) -> Elm.Arg.Arg a -}
listRemaining : String -> Elm.Expression -> Elm.Expression
listRemaining listRemainingArg listRemainingArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "listRemaining"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.function
                                    [ Type.namedWith
                                        [ "Elm", "Arg" ]
                                        "Expression"
                                        []
                                    ]
                                    (Type.var "a")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string listRemainingArg, listRemainingArg0 ]


{-| Arg.customType "MyCustomType" Tuple.pair
        |> Arg.item (Arg.var "first")
        |> Arg.item (Arg.var "second")

Will generate

    MyCustomType first second

customType: String -> a -> Elm.Arg.Arg a
-}
customType : String -> Elm.Expression -> Elm.Expression
customType customTypeArg customTypeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "customType"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.var "a" ]
                          (Type.namedWith
                               [ "Elm", "Arg" ]
                               "Arg"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string customTypeArg, customTypeArg0 ]


annotation_ : { arg : Type.Annotation -> Type.Annotation }
annotation_ =
    { arg =
        \argArg0 ->
            Type.alias
                moduleName_
                "Arg"
                [ argArg0 ]
                (Type.namedWith [ "Internal", "Arg" ] "Arg" [ Type.var "val" ])
    }


call_ :
    { var : Elm.Expression -> Elm.Expression
    , varWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , record : Elm.Expression -> Elm.Expression
    , field : Elm.Expression -> Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , char : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , item : Elm.Expression -> Elm.Expression -> Elm.Expression
    , listRemaining : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { var =
        \varArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "var"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm", "Arg" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ varArg ]
    , varWith =
        \varWithArg varWithArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "varWith"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm", "Arg" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ varWithArg, varWithArg0 ]
    , tuple =
        \tupleArg tupleArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "tuple"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.tuple
                                           (Type.var "one")
                                           (Type.var "two")
                                       ]
                                  )
                             )
                     }
                )
                [ tupleArg, tupleArg0 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "triple"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.triple
                                           (Type.var "one")
                                           (Type.var "two")
                                           (Type.var "three")
                                       ]
                                  )
                             )
                     }
                )
                [ tripleArg, tripleArg0, tripleArg1 ]
    , record =
        \recordArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "record"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "fields" ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "fields" ]
                                  )
                             )
                     }
                )
                [ recordArg ]
    , field =
        \fieldArg fieldArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "field"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.namedWith
                                                [ "Elm", "Arg" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ fieldArg, fieldArg0 ]
    , string =
        \stringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "string"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm", "Arg" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ stringArg ]
    , char =
        \charArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "char"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.char ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm", "Arg" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ charArg ]
    , list =
        \listArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "list"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ listArg ]
    , item =
        \itemArg itemArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "item"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.var "arg" ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ itemArg, itemArg0 ]
    , listRemaining =
        \listRemainingArg listRemainingArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "listRemaining"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.namedWith
                                                [ "Elm", "Arg" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ listRemainingArg, listRemainingArg0 ]
    , customType =
        \customTypeArg customTypeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "customType"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.var "a" ]
                                  (Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ customTypeArg, customTypeArg0 ]
    }


values_ :
    { unit : Elm.Expression
    , var : Elm.Expression
    , varWith : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , record : Elm.Expression
    , field : Elm.Expression
    , ignore : Elm.Expression
    , string : Elm.Expression
    , char : Elm.Expression
    , list : Elm.Expression
    , item : Elm.Expression
    , listRemaining : Elm.Expression
    , customType : Elm.Expression
    }
values_ =
    { unit =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "unit"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Elm", "Arg" ]
                         "Arg"
                         [ Type.namedWith [ "Elm", "Arg" ] "Expression" [] ]
                    )
            }
    , var =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                              ]
                         )
                    )
            }
    , varWith =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "varWith"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                              ]
                         )
                    )
            }
    , tuple =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.tuple (Type.var "one") (Type.var "two") ]
                         )
                    )
            }
    , triple =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.triple
                                  (Type.var "one")
                                  (Type.var "two")
                                  (Type.var "three")
                              ]
                         )
                    )
            }
    , record =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "fields" ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "fields" ]
                         )
                    )
            }
    , field =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.function
                                   [ Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Expression"
                                       []
                                   ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm", "Arg" ] "Arg" [ Type.var "a" ]
                         )
                    )
            }
    , ignore =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "ignore"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Elm", "Arg" ]
                         "Arg"
                         [ Type.namedWith [ "Elm", "Arg" ] "Expression" [] ]
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                              ]
                         )
                    )
            }
    , char =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "char"
            , annotation =
                Just
                    (Type.function
                         [ Type.char ]
                         (Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.namedWith [ "Elm", "Arg" ] "Expression" []
                              ]
                         )
                    )
            }
    , list =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith [ "Elm", "Arg" ] "Arg" [ Type.var "a" ]
                         )
                    )
            }
    , item =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "item"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "arg" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.function [ Type.var "arg" ] (Type.var "a") ]
                         ]
                         (Type.namedWith [ "Elm", "Arg" ] "Arg" [ Type.var "a" ]
                         )
                    )
            }
    , listRemaining =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "listRemaining"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.function
                                   [ Type.namedWith
                                       [ "Elm", "Arg" ]
                                       "Expression"
                                       []
                                   ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm", "Arg" ] "Arg" [ Type.var "a" ]
                         )
                    )
            }
    , customType =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.var "a" ]
                         (Type.namedWith [ "Elm", "Arg" ] "Arg" [ Type.var "a" ]
                         )
                    )
            }
    }