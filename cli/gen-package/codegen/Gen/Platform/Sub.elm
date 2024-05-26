module Gen.Platform.Sub exposing (annotation_, batch, call_, map, moduleName_, none, values_)

{-| 
@docs moduleName_, none, batch, map, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Sub" ]


{-| Tell the runtime that there are no subscriptions.

none: Platform.Sub.Sub msg
-}
none : Elm.Expression
none =
    Elm.value
        { importFrom = [ "Sub" ]
        , name = "none"
        , annotation = Just (Type.namedWith [] "Sub" [ Type.var "msg" ])
        }


{-| When you need to subscribe to multiple things, you can create a `batch` of
subscriptions.

**Note:** `Sub.none` and `Sub.batch [ Sub.none, Sub.none ]` and
`Sub.batch []` all do the same thing.

batch: List (Platform.Sub.Sub msg) -> Platform.Sub.Sub msg
-}
batch : List Elm.Expression -> Elm.Expression
batch batchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Sub" ]
             , name = "batch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [] "Sub" [ Type.var "msg" ])
                          ]
                          (Type.namedWith [] "Sub" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.list batchArg ]


{-| Transform the messages produced by a subscription.
Very similar to [`Html.map`](/packages/elm/html/latest/Html#map).

This is very rarely useful in well-structured Elm code, so definitely read the
section on [structure][] in the guide before reaching for this!

[structure]: https://guide.elm-lang.org/webapps/structure.html

map: (a -> msg) -> Platform.Sub.Sub a -> Platform.Sub.Sub msg
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Sub" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "msg")
                          , Type.namedWith [] "Sub" [ Type.var "a" ]
                          ]
                          (Type.namedWith [] "Sub" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


annotation_ : { sub : Type.Annotation -> Type.Annotation }
annotation_ =
    { sub = \subArg0 -> Type.namedWith [ "Sub" ] "Sub" [ subArg0 ] }


call_ :
    { batch : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { batch =
        \batchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Sub" ]
                     , name = "batch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         []
                                         "Sub"
                                         [ Type.var "msg" ]
                                      )
                                  ]
                                  (Type.namedWith [] "Sub" [ Type.var "msg" ])
                             )
                     }
                )
                [ batchArg ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Sub" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "msg")
                                  , Type.namedWith [] "Sub" [ Type.var "a" ]
                                  ]
                                  (Type.namedWith [] "Sub" [ Type.var "msg" ])
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    }


values_ :
    { none : Elm.Expression, batch : Elm.Expression, map : Elm.Expression }
values_ =
    { none =
        Elm.value
            { importFrom = [ "Sub" ]
            , name = "none"
            , annotation = Just (Type.namedWith [] "Sub" [ Type.var "msg" ])
            }
    , batch =
        Elm.value
            { importFrom = [ "Sub" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [] "Sub" [ Type.var "msg" ])
                         ]
                         (Type.namedWith [] "Sub" [ Type.var "msg" ])
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Sub" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "msg")
                         , Type.namedWith [] "Sub" [ Type.var "a" ]
                         ]
                         (Type.namedWith [] "Sub" [ Type.var "msg" ])
                    )
            }
    }