module Gen.Maybe exposing
    ( andThen
    , annotation_
    , call_
    , caseOf_
    , make_
    , map
    , map2
    , map3
    , map4
    , map5
    , moduleName_
    , values_
    , withDefault
    )

{-|
# Generated bindings for Maybe

@docs moduleName_, withDefault, map, map2, map3, map4, map5, andThen, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Maybe" ]


{-| Provide a default value, turning an optional value into a normal
value.  This comes in handy when paired with functions like
[`Dict.get`](Dict#get) which gives back a `Maybe`.

    withDefault 100 (Just 42)   -- 42
    withDefault 100 Nothing     -- 100

    withDefault "unknown" (Dict.get "Tom" Dict.empty)   -- "unknown"

**Note:** This can be overused! Many cases are better handled by a `case`
expression. And if you end up using `withDefault` a lot, it can be a good sign
that a [custom type][ct] will clean your code up quite a bit!

[ct]: https://guide.elm-lang.org/types/custom_types.html

withDefault: a -> Maybe a -> a
-}
withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
withDefault withDefaultArg_ withDefaultArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "withDefault"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a", Type.maybe (Type.var "a") ]
                          (Type.var "a")
                     )
             }
        )
        [ withDefaultArg_, withDefaultArg_0 ]


{-| Transform a `Maybe` value with a given function:

    map sqrt (Just 9) == Just 3
    map sqrt Nothing  == Nothing

    map sqrt (String.toFloat "9") == Just 3
    map sqrt (String.toFloat "x") == Nothing

map: (a -> b) -> Maybe a -> Maybe b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.maybe (Type.var "a")
                          ]
                          (Type.maybe (Type.var "b"))
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Apply a function if all the arguments are `Just` a value.

    map2 (+) (Just 3) (Just 4) == Just 7
    map2 (+) (Just 3) Nothing == Nothing
    map2 (+) Nothing (Just 4) == Nothing

    map2 (+) (String.toInt "1") (String.toInt "123") == Just 124
    map2 (+) (String.toInt "x") (String.toInt "123") == Nothing
    map2 (+) (String.toInt "1") (String.toInt "1.3") == Nothing

map2: (a -> b -> value) -> Maybe a -> Maybe b -> Maybe value
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg_ map2Arg_0 map2Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "map2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "value")
                          , Type.maybe (Type.var "a")
                          , Type.maybe (Type.var "b")
                          ]
                          (Type.maybe (Type.var "value"))
                     )
             }
        )
        [ Elm.functionReduced
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg_ functionReducedUnpack)
            )
        , map2Arg_0
        , map2Arg_1
        ]


{-| map3: (a -> b -> c -> value) -> Maybe a -> Maybe b -> Maybe c -> Maybe value -}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "map3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b", Type.var "c" ]
                              (Type.var "value")
                          , Type.maybe (Type.var "a")
                          , Type.maybe (Type.var "b")
                          , Type.maybe (Type.var "c")
                          ]
                          (Type.maybe (Type.var "value"))
                     )
             }
        )
        [ Elm.functionReduced
            "map3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((map3Arg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , map3Arg_0
        , map3Arg_1
        , map3Arg_2
        ]


{-| map4: 
    (a -> b -> c -> d -> value)
    -> Maybe a
    -> Maybe b
    -> Maybe c
    -> Maybe d
    -> Maybe value
-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "map4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              ]
                              (Type.var "value")
                          , Type.maybe (Type.var "a")
                          , Type.maybe (Type.var "b")
                          , Type.maybe (Type.var "c")
                          , Type.maybe (Type.var "d")
                          ]
                          (Type.maybe (Type.var "value"))
                     )
             }
        )
        [ Elm.functionReduced
            "map4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((map4Arg_ functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                     )
                            )
                   )
            )
        , map4Arg_0
        , map4Arg_1
        , map4Arg_2
        , map4Arg_3
        ]


{-| map5: 
    (a -> b -> c -> d -> e -> value)
    -> Maybe a
    -> Maybe b
    -> Maybe c
    -> Maybe d
    -> Maybe e
    -> Maybe value
-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "map5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              ]
                              (Type.var "value")
                          , Type.maybe (Type.var "a")
                          , Type.maybe (Type.var "b")
                          , Type.maybe (Type.var "c")
                          , Type.maybe (Type.var "d")
                          , Type.maybe (Type.var "e")
                          ]
                          (Type.maybe (Type.var "value"))
                     )
             }
        )
        [ Elm.functionReduced
            "map5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((map5Arg_ functionReducedUnpack
                                                 )
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , map5Arg_0
        , map5Arg_1
        , map5Arg_2
        , map5Arg_3
        , map5Arg_4
        ]


{-| Chain together many computations that may fail. It is helpful to see its
definition:

    andThen : (a -> Maybe b) -> Maybe a -> Maybe b
    andThen callback maybe =
        case maybe of
            Just value ->
                callback value

            Nothing ->
                Nothing

This means we only continue with the callback if things are going well. For
example, say you need to parse some user input as a month:

    parseMonth : String -> Maybe Int
    parseMonth userInput =
        String.toInt userInput
          |> andThen toValidMonth

    toValidMonth : Int -> Maybe Int
    toValidMonth month =
        if 1 <= month && month <= 12 then
            Just month
        else
            Nothing

In the `parseMonth` function, if `String.toInt` produces `Nothing` (because
the `userInput` was not an integer) this entire chain of operations will
short-circuit and result in `Nothing`. If `toValidMonth` results in `Nothing`,
again the chain of computations will result in `Nothing`.

andThen: (a -> Maybe b) -> Maybe a -> Maybe b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Maybe" ]
             , name = "andThen"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.maybe (Type.var "b"))
                          , Type.maybe (Type.var "a")
                          ]
                          (Type.maybe (Type.var "b"))
                     )
             }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


annotation_ : { maybe : Type.Annotation -> Type.Annotation }
annotation_ =
    { maybe = \maybeArg0 -> Type.namedWith [] "Maybe" [ maybeArg0 ] }


make_ : { just : Elm.Expression -> Elm.Expression, nothing : Elm.Expression }
make_ =
    { just =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = []
                     , name = "Just"
                     , annotation =
                         Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
                     }
                )
                [ ar0 ]
    , nothing =
        Elm.value
            { importFrom = []
            , name = "Nothing"
            , annotation = Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
            }
    }


caseOf_ :
    { maybe :
        Elm.Expression
        -> { just : Elm.Expression -> Elm.Expression, nothing : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { maybe =
        \maybeExpression maybeTags ->
            Elm.Case.custom
                maybeExpression
                (Type.namedWith [ "Maybe" ] "Maybe" [ Type.var "a" ])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Just" maybeTags.just |> Elm.Arg.item
                                                                       (Elm.Arg.varWith
                                                                              "a"
                                                                              (Type.var
                                                                                     "a"
                                                                              )
                                                                       )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Nothing" maybeTags.nothing)
                    Basics.identity
                ]
    }


call_ :
    { withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { withDefault =
        \withDefaultArg_ withDefaultArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "withDefault"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a", Type.maybe (Type.var "a") ]
                                  (Type.var "a")
                             )
                     }
                )
                [ withDefaultArg_, withDefaultArg_0 ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.maybe (Type.var "a")
                                  ]
                                  (Type.maybe (Type.var "b"))
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "map2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "value")
                                  , Type.maybe (Type.var "a")
                                  , Type.maybe (Type.var "b")
                                  ]
                                  (Type.maybe (Type.var "value"))
                             )
                     }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "map3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      ]
                                      (Type.var "value")
                                  , Type.maybe (Type.var "a")
                                  , Type.maybe (Type.var "b")
                                  , Type.maybe (Type.var "c")
                                  ]
                                  (Type.maybe (Type.var "value"))
                             )
                     }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "map4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      ]
                                      (Type.var "value")
                                  , Type.maybe (Type.var "a")
                                  , Type.maybe (Type.var "b")
                                  , Type.maybe (Type.var "c")
                                  , Type.maybe (Type.var "d")
                                  ]
                                  (Type.maybe (Type.var "value"))
                             )
                     }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "map5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      ]
                                      (Type.var "value")
                                  , Type.maybe (Type.var "a")
                                  , Type.maybe (Type.var "b")
                                  , Type.maybe (Type.var "c")
                                  , Type.maybe (Type.var "d")
                                  , Type.maybe (Type.var "e")
                                  ]
                                  (Type.maybe (Type.var "value"))
                             )
                     }
                )
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , andThen =
        \andThenArg_ andThenArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Maybe" ]
                     , name = "andThen"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.maybe (Type.var "b"))
                                  , Type.maybe (Type.var "a")
                                  ]
                                  (Type.maybe (Type.var "b"))
                             )
                     }
                )
                [ andThenArg_, andThenArg_0 ]
    }


values_ :
    { withDefault : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , andThen : Elm.Expression
    }
values_ =
    { withDefault =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a", Type.maybe (Type.var "a") ]
                         (Type.var "a")
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.maybe (Type.var "a")
                         ]
                         (Type.maybe (Type.var "b"))
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "value")
                         , Type.maybe (Type.var "a")
                         , Type.maybe (Type.var "b")
                         ]
                         (Type.maybe (Type.var "value"))
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b", Type.var "c" ]
                             (Type.var "value")
                         , Type.maybe (Type.var "a")
                         , Type.maybe (Type.var "b")
                         , Type.maybe (Type.var "c")
                         ]
                         (Type.maybe (Type.var "value"))
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             ]
                             (Type.var "value")
                         , Type.maybe (Type.var "a")
                         , Type.maybe (Type.var "b")
                         , Type.maybe (Type.var "c")
                         , Type.maybe (Type.var "d")
                         ]
                         (Type.maybe (Type.var "value"))
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             ]
                             (Type.var "value")
                         , Type.maybe (Type.var "a")
                         , Type.maybe (Type.var "b")
                         , Type.maybe (Type.var "c")
                         , Type.maybe (Type.var "d")
                         , Type.maybe (Type.var "e")
                         ]
                         (Type.maybe (Type.var "value"))
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Maybe" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.maybe (Type.var "b"))
                         , Type.maybe (Type.var "a")
                         ]
                         (Type.maybe (Type.var "b"))
                    )
            }
    }