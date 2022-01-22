module Gen.Platform.Cmd exposing (batch, call_, map, moduleName_, none, types_, values_)

{-| 
@docs moduleName_, none, batch, map, types_, values_, call_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Platform", "Cmd" ]


{-| Tell the runtime that there are no commands.

-}
none : Elm.Expression
none =
    Elm.valueWith
        { importFrom = [ "Platform", "Cmd" ]
        , name = "none"
        , annotation =
            Just (Type.namedWith [ "Platform", "Cmd" ] "Cmd" [ Type.var "msg" ])
        }


{-| When you need the runtime system to perform a couple commands, you
can batch them together. Each is handed to the runtime at the same time,
and since each can perform arbitrary operations in the world, there are
no ordering guarantees about the results.

**Note:** `Cmd.none` and `Cmd.batch [ Cmd.none, Cmd.none ]` and `Cmd.batch []`
all do the same thing.
-}
batch : List Elm.Expression -> Elm.Expression
batch arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Platform", "Cmd" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Platform", "Cmd" ]
                                "Cmd"
                                [ Type.var "msg" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Transform the messages produced by a command.
Very similar to [`Html.map`](/packages/elm/html/latest/Html#map).

This is very rarely useful in well-structured Elm code, so definitely read the
section on [structure][] in the guide before reaching for this!

[structure]: https://guide.elm-lang.org/webapps/structure.html
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Platform", "Cmd" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
            )
        , arg2
        ]


types_ : { cmd : { annotation : Type.Annotation -> Type.Annotation } }
types_ =
    { cmd =
        { annotation =
            \arg0_0_0 -> Type.namedWith moduleName_ "Cmd" [ arg0_0_0 ]
        }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { none : Elm.Expression, batch : Elm.Expression, map : Elm.Expression }
values_ =
    { none =
        Elm.valueWith
            { importFrom = [ "Platform", "Cmd" ]
            , name = "none"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Platform", "Cmd" ]
                        "Cmd"
                        [ Type.var "msg" ]
                    )
            }
    , batch =
        Elm.valueWith
            { importFrom = [ "Platform", "Cmd" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Platform", "Cmd" ]
                                "Cmd"
                                [ Type.var "msg" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
    , map =
        Elm.valueWith
            { importFrom = [ "Platform", "Cmd" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
call_ :
    { batch : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { batch =
        \arg1_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Platform", "Cmd" ]
                    , name = "batch"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Platform", "Cmd" ]
                                        "Cmd"
                                        [ Type.var "msg" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Platform", "Cmd" ]
                                    "Cmd"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , map =
        \arg1_0 arg2_0 ->
            Elm.apply
                (Elm.valueWith
                    { importFrom = [ "Platform", "Cmd" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Platform", "Cmd" ]
                                    "Cmd"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Platform", "Cmd" ]
                                    "Cmd"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1_0, arg2_0 ]
    }


