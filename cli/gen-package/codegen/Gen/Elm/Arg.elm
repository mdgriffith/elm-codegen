module Gen.Elm.Arg exposing
    ( aliasAs
    , call_
    , char
    , customType
    , field
    , ignore
    , item
    , items
    , list
    , listRemaining
    , moduleName_
    , record
    , string
    , triple
    , tuple
    , unit
    , values_
    , var
    , varWith
    )

{-|
# Generated bindings for Elm.Arg

@docs moduleName_, unit, var, varWith, tuple, triple, record, field, aliasAs, ignore, string, char, list, item, items, listRemaining, customType, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Arg" ]


{-| An empty tuple `()` is generally called "unit".

unit: Elm.Arg Elm.Expression
-}
unit : Elm.Expression
unit =
    Elm.value
        { importFrom = [ "Elm", "Arg" ]
        , name = "unit"
        , annotation =
            Just
                (Type.namedWith
                     [ "Elm" ]
                     "Arg"
                     [ Type.namedWith [ "Elm" ] "Expression" [] ]
                )
        }


{-| var: String -> Elm.Arg Elm.Expression -}
var : String -> Elm.Expression
var varArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "var"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Elm" ]
                               "Arg"
                               [ Type.namedWith [ "Elm" ] "Expression" [] ]
                          )
                     )
             }
        )
        [ Elm.string varArg_ ]


{-| varWith: String -> Elm.Annotation.Annotation -> Elm.Arg Elm.Expression -}
varWith : String -> Elm.Expression -> Elm.Expression
varWith varWithArg_ varWithArg_0 =
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
                               [ "Elm" ]
                               "Arg"
                               [ Type.namedWith [ "Elm" ] "Expression" [] ]
                          )
                     )
             }
        )
        [ Elm.string varWithArg_, varWithArg_0 ]


{-| tuple: Elm.Arg one -> Elm.Arg two -> Elm.Arg ( one, two ) -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg_ tupleArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "tuple"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          ]
                          (Type.namedWith
                               [ "Elm" ]
                               "Arg"
                               [ Type.tuple (Type.var "one") (Type.var "two") ]
                          )
                     )
             }
        )
        [ tupleArg_, tupleArg_0 ]


{-| triple: Elm.Arg one -> Elm.Arg two -> Elm.Arg three -> Elm.Arg ( one, two, three ) -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg_ tripleArg_0 tripleArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "triple"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                          ]
                          (Type.namedWith
                               [ "Elm" ]
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
        [ tripleArg_, tripleArg_0, tripleArg_1 ]


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

record: fields -> Elm.Arg fields
-}
record : Elm.Expression -> Elm.Expression
record recordArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "record"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "fields" ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "fields" ])
                     )
             }
        )
        [ recordArg_ ]


{-| field: String -> Elm.Arg (Elm.Expression -> a) -> Elm.Arg a -}
field : String -> Elm.Expression -> Elm.Expression
field fieldArg_ fieldArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "field"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm" ]
                              "Arg"
                              [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.var "a")
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.string fieldArg_, fieldArg_0 ]


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

aliasAs: String -> Elm.Arg arg -> Elm.Arg ( arg, Elm.Expression )
-}
aliasAs : String -> Elm.Expression -> Elm.Expression
aliasAs aliasAsArg_ aliasAsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "aliasAs"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                          ]
                          (Type.namedWith
                               [ "Elm" ]
                               "Arg"
                               [ Type.tuple
                                   (Type.var "arg")
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string aliasAsArg_, aliasAsArg_0 ]


{-| Will generate `_` to ignore an argument or pattern.

ignore: Elm.Arg Elm.Expression
-}
ignore : Elm.Expression
ignore =
    Elm.value
        { importFrom = [ "Elm", "Arg" ]
        , name = "ignore"
        , annotation =
            Just
                (Type.namedWith
                     [ "Elm" ]
                     "Arg"
                     [ Type.namedWith [ "Elm" ] "Expression" [] ]
                )
        }


{-| string: String -> Elm.Arg Elm.Expression -}
string : String -> Elm.Expression
string stringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "string"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Elm" ]
                               "Arg"
                               [ Type.namedWith [ "Elm" ] "Expression" [] ]
                          )
                     )
             }
        )
        [ Elm.string stringArg_ ]


{-| char: Char.Char -> Elm.Arg Elm.Expression -}
char : Char.Char -> Elm.Expression
char charArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "char"
             , annotation =
                 Just
                     (Type.function
                          [ Type.char ]
                          (Type.namedWith
                               [ "Elm" ]
                               "Arg"
                               [ Type.namedWith [ "Elm" ] "Expression" [] ]
                          )
                     )
             }
        )
        [ Elm.char charArg_ ]


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

list: a -> Elm.Arg a
-}
list : Elm.Expression -> Elm.Expression
list listArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "list"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ listArg_ ]


{-| item: Elm.Arg arg -> Elm.Arg (arg -> a) -> Elm.Arg a -}
item : Elm.Expression -> Elm.Expression -> Elm.Expression
item itemArg_ itemArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "item"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                          , Type.namedWith
                              [ "Elm" ]
                              "Arg"
                              [ Type.function [ Type.var "arg" ] (Type.var "a")
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ itemArg_, itemArg_0 ]


{-| This is for the situation where you only know the number of arguments when you run the generator.

This isn't super common.

items: List (Elm.Arg arg) -> Elm.Arg (List arg -> a) -> Elm.Arg a
-}
items : List Elm.Expression -> Elm.Expression -> Elm.Expression
items itemsArg_ itemsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "items"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                              )
                          , Type.namedWith
                              [ "Elm" ]
                              "Arg"
                              [ Type.function
                                    [ Type.list (Type.var "arg") ]
                                    (Type.var "a")
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.list itemsArg_, itemsArg_0 ]


{-| listRemaining: String -> Elm.Arg (Elm.Expression -> a) -> Elm.Arg a -}
listRemaining : String -> Elm.Expression -> Elm.Expression
listRemaining listRemainingArg_ listRemainingArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "listRemaining"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm" ]
                              "Arg"
                              [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.var "a")
                              ]
                          ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.string listRemainingArg_, listRemainingArg_0 ]


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

customType: String -> a -> Elm.Arg a
-}
customType : String -> Elm.Expression -> Elm.Expression
customType customTypeArg_ customTypeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Arg" ]
             , name = "customType"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.var "a" ]
                          (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                     )
             }
        )
        [ Elm.string customTypeArg_, customTypeArg_0 ]


call_ :
    { var : Elm.Expression -> Elm.Expression
    , varWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , record : Elm.Expression -> Elm.Expression
    , field : Elm.Expression -> Elm.Expression -> Elm.Expression
    , aliasAs : Elm.Expression -> Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , char : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , item : Elm.Expression -> Elm.Expression -> Elm.Expression
    , items : Elm.Expression -> Elm.Expression -> Elm.Expression
    , listRemaining : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { var =
        \varArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "var"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ varArg_ ]
    , varWith =
        \varWithArg_ varWithArg_0 ->
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
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ varWithArg_, varWithArg_0 ]
    , tuple =
        \tupleArg_ tupleArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "tuple"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.tuple
                                           (Type.var "one")
                                           (Type.var "two")
                                       ]
                                  )
                             )
                     }
                )
                [ tupleArg_, tupleArg_0 ]
    , triple =
        \tripleArg_ tripleArg_0 tripleArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "triple"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
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
                [ tripleArg_, tripleArg_0, tripleArg_1 ]
    , record =
        \recordArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "record"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "fields" ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "fields" ]
                                  )
                             )
                     }
                )
                [ recordArg_ ]
    , field =
        \fieldArg_ fieldArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "field"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ fieldArg_, fieldArg_0 ]
    , aliasAs =
        \aliasAsArg_ aliasAsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "aliasAs"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.tuple
                                           (Type.var "arg")
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ aliasAsArg_, aliasAsArg_0 ]
    , string =
        \stringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "string"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ stringArg_ ]
    , char =
        \charArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "char"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.char ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ charArg_ ]
    , list =
        \listArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "list"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ listArg_ ]
    , item =
        \itemArg_ itemArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "item"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.var "arg" ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ itemArg_, itemArg_0 ]
    , items =
        \itemsArg_ itemsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "items"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Elm" ]
                                         "Arg"
                                         [ Type.var "arg" ]
                                      )
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.list (Type.var "arg") ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ itemsArg_, itemsArg_0 ]
    , listRemaining =
        \listRemainingArg_ listRemainingArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "listRemaining"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.var "a")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ listRemainingArg_, listRemainingArg_0 ]
    , customType =
        \customTypeArg_ customTypeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Arg" ]
                     , name = "customType"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.var "a" ]
                                  (Type.namedWith
                                       [ "Elm" ]
                                       "Arg"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ customTypeArg_, customTypeArg_0 ]
    }


values_ :
    { unit : Elm.Expression
    , var : Elm.Expression
    , varWith : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , record : Elm.Expression
    , field : Elm.Expression
    , aliasAs : Elm.Expression
    , ignore : Elm.Expression
    , string : Elm.Expression
    , char : Elm.Expression
    , list : Elm.Expression
    , item : Elm.Expression
    , items : Elm.Expression
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
                         [ "Elm" ]
                         "Arg"
                         [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                              [ "Elm" ]
                              "Arg"
                              [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                              [ "Elm" ]
                              "Arg"
                              [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         ]
                         (Type.namedWith
                              [ "Elm" ]
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                         ]
                         (Type.namedWith
                              [ "Elm" ]
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
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "fields" ])
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
                             [ "Elm" ]
                             "Arg"
                             [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                    )
            }
    , aliasAs =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "aliasAs"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                         ]
                         (Type.namedWith
                              [ "Elm" ]
                              "Arg"
                              [ Type.tuple
                                  (Type.var "arg")
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
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
                         [ "Elm" ]
                         "Arg"
                         [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                              [ "Elm" ]
                              "Arg"
                              [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                              [ "Elm" ]
                              "Arg"
                              [ Type.namedWith [ "Elm" ] "Expression" [] ]
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
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                    )
            }
    , item =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "item"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
                         , Type.namedWith
                             [ "Elm" ]
                             "Arg"
                             [ Type.function [ Type.var "arg" ] (Type.var "a") ]
                         ]
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                    )
            }
    , items =
        Elm.value
            { importFrom = [ "Elm", "Arg" ]
            , name = "items"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ])
                         , Type.namedWith
                             [ "Elm" ]
                             "Arg"
                             [ Type.function
                                   [ Type.list (Type.var "arg") ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
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
                             [ "Elm" ]
                             "Arg"
                             [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.var "a")
                             ]
                         ]
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
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
                         (Type.namedWith [ "Elm" ] "Arg" [ Type.var "a" ])
                    )
            }
    }