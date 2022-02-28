module Gen.Task exposing (andThen, annotation_, attempt, call_, fail, map, map2, map3, map4, map5, mapError, moduleName_, onError, perform, sequence, succeed, values_)

{-| 
@docs moduleName_, perform, attempt, andThen, succeed, fail, sequence, map, map2, map3, map4, map5, onError, mapError, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Task" ]


{-| Like I was saying in the [`Task`](#Task) documentation, just having a
`Task` does not mean it is done. We must command Elm to `perform` the task:

    import Time  -- elm install elm/time
    import Task

    type Msg
      = Click
      | Search String
      | NewTime Time.Posix

    getNewTime : Cmd Msg
    getNewTime =
      Task.perform NewTime Time.now

If you have worked through [`guide.elm-lang.org`][guide] (highly recommended!)
you will recognize `Cmd` from the section on The Elm Architecture. So we have
changed a task like "make delicious lasagna" into a command like "Hey Elm, make
delicious lasagna and give it to my `update` function as a `Msg` value."

[guide]: https://guide.elm-lang.org/
-}
perform : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
perform arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "perform"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.namedWith [ "Basics" ] "Never" []
                            , Type.var "a"
                            ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


{-| This is very similar to [`perform`](#perform) except it can handle failures!
So we could _attempt_ to focus on a certain DOM node like this:

    import Browser.Dom  -- elm install elm/browser
    import Task

    type Msg
      = Click
      | Search String
      | Focus (Result Browser.DomError ())

    focus : Cmd Msg
    focus =
      Task.attempt Focus (Browser.Dom.focus "my-app-search-box")

So the task is "focus on this DOM node" and we are turning it into the command
"Hey Elm, attempt to focus on this DOM node and give me a `Msg` about whether
you succeeded or failed."

**Note:** Definitely work through [`guide.elm-lang.org`][guide] to get a
feeling for how commands fit into The Elm Architecture.

[guide]: https://guide.elm-lang.org/
-}
attempt : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
attempt arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "attempt"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


{-| Chain together a task and a callback. The first task will run, and if it is
successful, you give the result to the callback resulting in another task. This
task then gets run. We could use this to make a task that resolves an hour from
now:

    import Time -- elm install elm/time
    import Process

    timeInOneHour : Task x Time.Posix
    timeInOneHour =
      Process.sleep (60 * 60 * 1000)
        |> andThen (\_ -> Time.now)

First the process sleeps for an hour **and then** it tells us what time it is.
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "x", Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


{-| A task that succeeds immediately when run. It is usually used with
[`andThen`](#andThen). You can use it like `map` if you want:

    import Time -- elm install elm/time

    timeInMillis : Task x Int
    timeInMillis =
      Time.now
        |> andThen (\t -> succeed (Time.posixToMillis t))

-}
succeed : Elm.Expression -> Elm.Expression
succeed arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| A task that fails immediately when run. Like with `succeed`, this can be
used with `andThen` to check on the outcome of another task.

    type Error = NotFound

    notFound : Task Error a
    notFound =
      fail NotFound
-}
fail : Elm.Expression -> Elm.Expression
fail arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x" ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| Start with a list of tasks, and turn them into a single task that returns a
list. The tasks will be run in order one-by-one and if any task fails the whole
sequence fails.

    sequence [ succeed 1, succeed 2 ] == succeed [ 1, 2 ]

-}
sequence : List Elm.Expression -> Elm.Expression
sequence arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.list (Type.var "a") ]
                        )
                    )
            }
        )
        [ Elm.list arg1 ]


{-| Transform a task. Maybe you want to use [`elm/time`][time] to figure
out what time it will be in one hour:

    import Task exposing (Task)
    import Time -- elm install elm/time

    timeInOneHour : Task x Time.Posix
    timeInOneHour =
      Task.map addAnHour Time.now

    addAnHour : Time.Posix -> Time.Posix
    addAnHour time =
      Time.millisToPosix (Time.posixToMillis time + 60 * 60 * 1000)

[time]: /packages/elm/time/latest/
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


{-| Put the results of two tasks together. For example, if we wanted to know
the current month, we could use [`elm/time`][time] to ask:

    import Task exposing (Task)
    import Time -- elm install elm/time

    getMonth : Task x Int
    getMonth =
      Task.map2 Time.toMonth Time.here Time.now

**Note:** Say we were doing HTTP requests instead. `map2` does each task in
order, so it would try the first request and only continue after it succeeds.
If it fails, the whole thing fails!

[time]: /packages/elm/time/latest/
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack -> Elm.functionReduced "unpack" (arg1 unpack))
        , arg2
        , arg3
        ]


{-|-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced "unpack" (arg1 unpack unpack0)
                    )
            )
        , arg2
        , arg3
        , arg4
        ]


{-|-}
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
map4 arg1 arg2 arg3 arg4 arg5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
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
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_4_3_3_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (arg1 unpack unpack0 unpack_4_3_3_3_0)
                            )
                    )
            )
        , arg2
        , arg3
        , arg4
        , arg5
        ]


{-|-}
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
map5 arg1 arg2 arg3 arg4 arg5 arg6 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
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
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "d" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "unpack"
            (\unpack ->
                Elm.functionReduced
                    "unpack"
                    (\unpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\unpack_4_3_3_3_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\unpack_4_4_3_3_3_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (arg1 unpack unpack0
                                                 unpack_4_3_3_3_0
                                                unpack_4_4_3_3_3_0
                                            )
                                    )
                            )
                    )
            )
        , arg2
        , arg3
        , arg4
        , arg5
        , arg6
        ]


{-| Recover from a failure in a task. If the given task fails, we use the
callback to recover.

    fail "file not found"
      |> onError (\msg -> succeed 42)
      -- succeed 42

    succeed 9
      |> onError (\msg -> succeed 42)
      -- succeed 9
-}
onError : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
onError arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "onError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "x" ]
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "y", Type.var "a" ]
                            )
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


{-| Transform the error value. This can be useful if you need a bunch of error
types to match up.

    type Error
      = Http Http.Error
      | WebGL WebGL.Error

    getResources : Task Error Resource
    getResources =
      sequence
        [ mapError Http serverTask
        , mapError WebGL textureTask
        ]
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError arg1 arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Task" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "x" ] (Type.var "y")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "unpack" arg1, arg2 ]


annotation_ : { task : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { task = \arg0 arg1 -> Type.namedWith moduleName_ "Task" [ arg0, arg1 ] }


call_ :
    { perform : Elm.Expression -> Elm.Expression -> Elm.Expression
    , attempt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , fail : Elm.Expression -> Elm.Expression
    , sequence : Elm.Expression -> Elm.Expression
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
    , onError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , mapError : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { perform =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "perform"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.namedWith [ "Basics" ] "Never" []
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Platform", "Cmd" ]
                                    "Cmd"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    , attempt =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "attempt"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Platform", "Cmd" ]
                                    "Cmd"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    , andThen =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Task" ]
                                        "Task"
                                        [ Type.var "x", Type.var "b" ]
                                    )
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    , succeed =
        \arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "succeed"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1 ]
    , fail =
        \arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "fail"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x" ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1 ]
    , sequence =
        \arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "sequence"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Task" ]
                                        "Task"
                                        [ Type.var "x", Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.list (Type.var "a") ]
                                )
                            )
                    }
                )
                [ arg1 ]
    , map =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "b")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    , map2 =
        \arg1 arg2 arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "result" ]
                                )
                            )
                    }
                )
                [ arg1, arg2, arg3 ]
    , map3 =
        \arg1 arg2 arg3 arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b", Type.var "c" ]
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "c" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "result" ]
                                )
                            )
                    }
                )
                [ arg1, arg2, arg3, arg4 ]
    , map4 =
        \arg1 arg2 arg3 arg4 arg5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
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
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "c" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "d" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "result" ]
                                )
                            )
                    }
                )
                [ arg1, arg2, arg3, arg4, arg5 ]
    , map5 =
        \arg1 arg2 arg3 arg4 arg5 arg6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
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
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "b" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "c" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "d" ]
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "e" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "result" ]
                                )
                            )
                    }
                )
                [ arg1, arg2, arg3, arg4, arg5, arg6 ]
    , onError =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "onError"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "x" ]
                                    (Type.namedWith
                                        [ "Task" ]
                                        "Task"
                                        [ Type.var "y", Type.var "a" ]
                                    )
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "y", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    , mapError =
        \arg1 arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Task" ]
                    , name = "mapError"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "x" ] (Type.var "y")
                                , Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "y", Type.var "a" ]
                                )
                            )
                    }
                )
                [ arg1, arg2 ]
    }


values_ :
    { perform : Elm.Expression
    , attempt : Elm.Expression
    , andThen : Elm.Expression
    , succeed : Elm.Expression
    , fail : Elm.Expression
    , sequence : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , onError : Elm.Expression
    , mapError : Elm.Expression
    }
values_ =
    { perform =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "perform"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "msg")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.namedWith [ "Basics" ] "Never" []
                            , Type.var "a"
                            ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
    , attempt =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "attempt"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Platform", "Cmd" ]
                            "Cmd"
                            [ Type.var "msg" ]
                        )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "x", Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
    , fail =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x" ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
    , sequence =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.list (Type.var "a") ]
                        )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Task" ]
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
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Task" ]
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
                            (Type.var "result")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "d" ]
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "result" ]
                        )
                    )
            }
    , onError =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "onError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "x" ]
                            (Type.namedWith
                                [ "Task" ]
                                "Task"
                                [ Type.var "y", Type.var "a" ]
                            )
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "Task" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "x" ] (Type.var "y")
                        , Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Task" ]
                            "Task"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
    }


