module Gen.Task exposing (andThen, attempt, fail, map, map2, map3, map4, map5, mapError, moduleName_, onError, perform, sequence, succeed, types_, values_)

{-| 
@docs moduleName_, perform, attempt, andThen, succeed, fail, sequence, map, map2, map3, map4, map5, onError, mapError, types_, values_
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0"
              , Type.namedWith
                    [ "Result" ]
                    "Result"
                    [ Type.var "x", Type.var "a" ]
              )
            ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation =
                        Just
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                    }
                )
            )
        , arg2
        ]


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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" ), ( "ar1", Type.var "b" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
            )
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" )
            , ( "ar1", Type.var "b" )
            , ( "ar2", Type.var "c" )
            ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.var "c")
                    }
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" )
            , ( "ar1", Type.var "b" )
            , ( "ar2", Type.var "c" )
            , ( "ar3", Type.var "d" )
            ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.var "c")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.var "d")
                    }
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "a" )
            , ( "ar1", Type.var "b" )
            , ( "ar2", Type.var "c" )
            , ( "ar3", Type.var "d" )
            , ( "ar4", Type.var "e" )
            ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "a")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.var "b")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.var "c")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.var "d")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation = Just (Type.var "e")
                    }
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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "x" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "x")
                    }
                )
            )
        , arg2
        ]


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
        (Elm.valueWith
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
        [ Elm.functionAdvanced
            [ ( "ar0", Type.var "x" ) ]
            (arg1
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar0"
                    , annotation = Just (Type.var "x")
                    }
                )
            )
        , arg2
        ]


types_ :
    { task :
        { annotation : Type.Annotation -> Type.Annotation -> Type.Annotation }
    }
types_ =
    { task =
        { annotation =
            \arg0_0_0 arg1_0_0 ->
                Type.namedWith moduleName_ "Task" [ arg0_0_0, arg1_0_0 ]
        }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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
        Elm.valueWith
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


