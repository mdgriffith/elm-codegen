module Gen.Platform.Sub exposing (batch, map, moduleName_, none, types_, values_)

{-| 
@docs moduleName_, none, batch, map, types_, values_
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
    Elm.valueWith
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
        (Elm.valueWith
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
map arg1 arg2 =
    Elm.apply
        (Elm.valueWith
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


types_ : { sub : { annotation : Type.Annotation -> Type.Annotation } }
types_ =
    { sub =
        { annotation =
            \arg0_0_0 -> Type.namedWith moduleName_ "Sub" [ arg0_0_0 ]
        }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { none : Elm.Expression, batch : Elm.Expression, map : Elm.Expression }
values_ =
    { none =
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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


