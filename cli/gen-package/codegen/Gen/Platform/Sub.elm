module Gen.Platform.Sub exposing (annotation_, batch, call_, map, moduleName_, none, values_)

{-| 
@docs moduleName_, none, batch, map, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Platform", "Sub" ]


{-| Tell the runtime that there are no subscriptions.
-}
none : Elm.Expression
none =
    Elm.value
        { importFrom = [ "Platform", "Sub" ]
        , name = "none"
        , annotation =
            Just (Type.namedWith [ "Platform", "Sub" ] "Sub" [ Type.var "msg" ])
        }


{-| When you need to subscribe to multiple things, you can create a `batch` of
subscriptions.

**Note:** `Sub.none` and `Sub.batch [ Sub.none, Sub.none ]` and
`Sub.batch []` all do the same thing.
-}
batch : List Elm.Expression -> Elm.Expression
batch arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Platform", "Sub" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Platform", "Sub" ]
                                "Sub"
                                [ Type.var "msg" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Transform the messages produced by a subscription.
Very similar to [`Html.map`](/packages/elm/html/latest/Html#map).

This is very rarely useful in well-structured Elm code, so definitely read the
section on [structure][] in the guide before reaching for this!

[structure]: https://guide.elm-lang.org/webapps/structure.html
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Platform", "Sub" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.fn "unpack0" (\fn0_3_3_0 -> arg1 fn0_3_3_0), arg2_1 ]


annotation_ : { sub : Type.Annotation -> Type.Annotation }
annotation_ =
    { sub = \arg0_0 -> Type.namedWith moduleName_ "Sub" [ arg0_0 ] }


call_ :
    { batch : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { batch =
        \arg1_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Platform", "Sub" ]
                    , name = "batch"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Platform", "Sub" ]
                                        "Sub"
                                        [ Type.var "msg" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Platform", "Sub" ]
                                    "Sub"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1_0 ]
    , map =
        \arg1_1_0 arg2_2_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Platform", "Sub" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Platform", "Sub" ]
                                    "Sub"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Platform", "Sub" ]
                                    "Sub"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1_1_0, arg2_2_0 ]
    }


values_ :
    { none : Elm.Expression, batch : Elm.Expression, map : Elm.Expression }
values_ =
    { none =
        Elm.value
            { importFrom = [ "Platform", "Sub" ]
            , name = "none"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Platform", "Sub" ]
                        "Sub"
                        [ Type.var "msg" ]
                    )
            }
    , batch =
        Elm.value
            { importFrom = [ "Platform", "Sub" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Platform", "Sub" ]
                                "Sub"
                                [ Type.var "msg" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "msg" ]
                        )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Platform", "Sub" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Sub" ]
                            "Sub"
                            [ Type.var "msg" ]
                        )
                    )
            }
    }


