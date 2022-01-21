module Gen.Process exposing (kill, moduleName_, sleep, spawn, types_, values_)

{-| 
@docs moduleName_, spawn, sleep, kill, types_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Process" ]


{-| Run a task in its own light-weight process. In the following example,
`task1` and `task2` will be interleaved. If `task1` makes a long HTTP request
or is just taking a long time, we can hop over to `task2` and do some work
there.

    spawn task1
      |> Task.andThen (\_ -> spawn task2)

**Note:** This creates a relatively restricted kind of `Process` because it
cannot receive any messages. More flexibility for user-defined processes will
come in a later release!
-}
spawn : Elm.Expression -> Elm.Expression
spawn arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "spawn"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y"
                            , Type.namedWith [ "Process" ] "Id" []
                            ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| Block progress on the current process for the given number of milliseconds.
The JavaScript equivalent of this is [`setTimeout`][setTimeout] which lets you
delay work until later.

[setTimeout]: https://developer.mozilla.org/en-US/docs/Web/API/WindowTimers/setTimeout
-}
sleep : Elm.Expression -> Elm.Expression
sleep arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "sleep"
            , annotation =
                Just
                    (Type.function
                        [ Type.float ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.unit ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| Sometimes you `spawn` a process, but later decide it would be a waste to
have it keep running and doing stuff. The `kill` function will force a process
to bail on whatever task it is running. So if there is an HTTP request in
flight, it will also abort the request.
-}
kill : Elm.Expression -> Elm.Expression
kill arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "kill"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Process" ] "Id" [] ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.unit ]
                        )
                    )
            }
        )
        [ arg1 ]


types_ : { id : { annotation : Type.Annotation } }
types_ =
    { id = { annotation = Type.namedWith moduleName_ "Id" [] } }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { spawn : Elm.Expression, sleep : Elm.Expression, kill : Elm.Expression }
values_ =
    { spawn =
        Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "spawn"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y"
                            , Type.namedWith [ "Process" ] "Id" []
                            ]
                        )
                    )
            }
    , sleep =
        Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "sleep"
            , annotation =
                Just
                    (Type.function
                        [ Type.float ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.unit ]
                        )
                    )
            }
    , kill =
        Elm.valueWith
            { importFrom = [ "Process" ]
            , name = "kill"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Process" ] "Id" [] ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.unit ]
                        )
                    )
            }
    }


