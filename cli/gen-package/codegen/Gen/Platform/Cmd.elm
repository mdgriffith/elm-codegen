module Gen.Platform.Cmd exposing (annotation_, batch, call_, map, moduleName_, none, values_)

{-| 
@docs moduleName_, none, batch, map, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Cmd" ]


{-| Tell the runtime that there are no commands.

none: Platform.Cmd.Cmd msg
-}
none : Elm.Expression
none =
    Elm.value
        { importFrom = [ "Cmd" ]
        , name = "none"
        , annotation = Just (Type.namedWith [] "Cmd" [ Type.var "msg" ])
        }


{-| When you need the runtime system to perform a couple commands, you
can batch them together. Each is handed to the runtime at the same time,
and since each can perform arbitrary operations in the world, there are
no ordering guarantees about the results.

**Note:** `Cmd.none` and `Cmd.batch [ Cmd.none, Cmd.none ]` and `Cmd.batch []`
all do the same thing.

batch: List (Platform.Cmd.Cmd msg) -> Platform.Cmd.Cmd msg
-}
batch : List Elm.Expression -> Elm.Expression
batch batchArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Cmd" ]
             , name = "batch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                          ]
                          (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.list batchArg ]


{-| Transform the messages produced by a command.
Very similar to [`Html.map`](/packages/elm/html/latest/Html#map).

This is very rarely useful in well-structured Elm code, so definitely read the
section on [structure][] in the guide before reaching for this!

[structure]: https://guide.elm-lang.org/webapps/structure.html

map: (a -> msg) -> Platform.Cmd.Cmd a -> Platform.Cmd.Cmd msg
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Cmd" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "msg")
                          , Type.namedWith [] "Cmd" [ Type.var "a" ]
                          ]
                          (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


annotation_ : { cmd : Type.Annotation -> Type.Annotation }
annotation_ =
    { cmd = \cmdArg0 -> Type.namedWith [ "Cmd" ] "Cmd" [ cmdArg0 ] }


call_ :
    { batch : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { batch =
        \batchArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Cmd" ]
                     , name = "batch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         []
                                         "Cmd"
                                         [ Type.var "msg" ]
                                      )
                                  ]
                                  (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                             )
                     }
                )
                [ batchArg ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Cmd" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "msg")
                                  , Type.namedWith [] "Cmd" [ Type.var "a" ]
                                  ]
                                  (Type.namedWith [] "Cmd" [ Type.var "msg" ])
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
            { importFrom = [ "Cmd" ]
            , name = "none"
            , annotation = Just (Type.namedWith [] "Cmd" [ Type.var "msg" ])
            }
    , batch =
        Elm.value
            { importFrom = [ "Cmd" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                         ]
                         (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Cmd" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "msg")
                         , Type.namedWith [] "Cmd" [ Type.var "a" ]
                         ]
                         (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                    )
            }
    }