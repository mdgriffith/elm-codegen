module Gen.Task exposing
    ( andThen
    , annotation_
    , attempt
    , call_
    , fail
    , map
    , map2
    , map3
    , map4
    , map5
    , mapError
    , moduleName_
    , onError
    , perform
    , sequence
    , succeed
    , values_
    )

{-|
# Generated bindings for Task

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

perform: (a -> msg) -> Task.Task Basics.Never a -> Platform.Cmd.Cmd msg
-}
perform : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
perform performArg_ performArg_0 =
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
                          (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.functionReduced "performUnpack" performArg_, performArg_0 ]


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

attempt: (Result.Result x a -> msg) -> Task.Task x a -> Platform.Cmd.Cmd msg
-}
attempt : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
attempt attemptArg_ attemptArg_0 =
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
                          (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.functionReduced "attemptUnpack" attemptArg_, attemptArg_0 ]


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

andThen: (a -> Task.Task x b) -> Task.Task x a -> Task.Task x b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
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
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


{-| A task that succeeds immediately when run. It is usually used with
[`andThen`](#andThen). You can use it like `map` if you want:

    import Time -- elm install elm/time

    timeInMillis : Task x Int
    timeInMillis =
      Time.now
        |> andThen (\t -> succeed (Time.posixToMillis t))

succeed: a -> Task.Task x a
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
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
        [ succeedArg_ ]


{-| A task that fails immediately when run. Like with `succeed`, this can be
used with `andThen` to check on the outcome of another task.

    type Error = NotFound

    notFound : Task Error a
    notFound =
      fail NotFound

fail: x -> Task.Task x a
-}
fail : Elm.Expression -> Elm.Expression
fail failArg_ =
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
        [ failArg_ ]


{-| Start with a list of tasks, and turn them into a single task that returns a
list. The tasks will be run in order one-by-one and if any task fails the whole
sequence fails.

    sequence [ succeed 1, succeed 2 ] == succeed [ 1, 2 ]

sequence: List (Task.Task x a) -> Task.Task x (List a)
-}
sequence : List Elm.Expression -> Elm.Expression
sequence sequenceArg_ =
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
        [ Elm.list sequenceArg_ ]


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

map: (a -> b) -> Task.Task x a -> Task.Task x b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
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
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


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

map2: (a -> b -> result) -> Task.Task x a -> Task.Task x b -> Task.Task x result
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg_ map2Arg_0 map2Arg_1 =
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
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg_ functionReducedUnpack)
            )
        , map2Arg_0
        , map2Arg_1
        ]


{-| map3: 
    (a -> b -> c -> result)
    -> Task.Task x a
    -> Task.Task x b
    -> Task.Task x c
    -> Task.Task x result
-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 =
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
    (a -> b -> c -> d -> result)
    -> Task.Task x a
    -> Task.Task x b
    -> Task.Task x c
    -> Task.Task x d
    -> Task.Task x result
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
    (a -> b -> c -> d -> e -> result)
    -> Task.Task x a
    -> Task.Task x b
    -> Task.Task x c
    -> Task.Task x d
    -> Task.Task x e
    -> Task.Task x result
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


{-| Recover from a failure in a task. If the given task fails, we use the
callback to recover.

    fail "file not found"
      |> onError (\msg -> succeed 42)
      -- succeed 42

    succeed 9
      |> onError (\msg -> succeed 42)
      -- succeed 9

onError: (x -> Task.Task y a) -> Task.Task x a -> Task.Task y a
-}
onError : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
onError onErrorArg_ onErrorArg_0 =
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
        [ Elm.functionReduced "onErrorUnpack" onErrorArg_, onErrorArg_0 ]


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

mapError: (x -> y) -> Task.Task x a -> Task.Task y a
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError mapErrorArg_ mapErrorArg_0 =
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
        [ Elm.functionReduced "mapErrorUnpack" mapErrorArg_, mapErrorArg_0 ]


annotation_ : { task : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { task =
        \taskArg0 taskArg1 ->
            Type.alias
                moduleName_
                "Task"
                [ taskArg0, taskArg1 ]
                (Type.namedWith
                     [ "Platform" ]
                     "Task"
                     [ Type.var "x", Type.var "a" ]
                )
    }


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
        \performArg_ performArg_0 ->
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
                                  (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                             )
                     }
                )
                [ performArg_, performArg_0 ]
    , attempt =
        \attemptArg_ attemptArg_0 ->
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
                                  (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                             )
                     }
                )
                [ attemptArg_, attemptArg_0 ]
    , andThen =
        \andThenArg_ andThenArg_0 ->
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
                [ andThenArg_, andThenArg_0 ]
    , succeed =
        \succeedArg_ ->
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
                [ succeedArg_ ]
    , fail =
        \failArg_ ->
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
                [ failArg_ ]
    , sequence =
        \sequenceArg_ ->
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
                                       [ Type.var "x"
                                       , Type.list (Type.var "a")
                                       ]
                                  )
                             )
                     }
                )
                [ sequenceArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Task" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
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
                [ mapArg_, mapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
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
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Task" ]
                     , name = "map3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
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
                                  ]
                                  (Type.namedWith
                                       [ "Task" ]
                                       "Task"
                                       [ Type.var "x", Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
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
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
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
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , onError =
        \onErrorArg_ onErrorArg_0 ->
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
                [ onErrorArg_, onErrorArg_0 ]
    , mapError =
        \mapErrorArg_ mapErrorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Task" ]
                     , name = "mapError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "x" ]
                                      (Type.var "y")
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
                [ mapErrorArg_, mapErrorArg_0 ]
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
                         (Type.namedWith [] "Cmd" [ Type.var "msg" ])
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
                         (Type.namedWith [] "Cmd" [ Type.var "msg" ])
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