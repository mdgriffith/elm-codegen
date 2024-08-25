module Gen.Platform exposing
    ( annotation_
    , call_
    , moduleName_
    , sendToApp
    , sendToSelf
    , values_
    , worker
    )

{-|
# Generated bindings for Platform

@docs moduleName_, worker, sendToApp, sendToSelf, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Platform" ]


{-| Create a [headless][] program with no user interface.

This is great if you want to use Elm as the &ldquo;brain&rdquo; for something
else. For example, you could send messages out ports to modify the DOM, but do
all the complex logic in Elm.

[headless]: https://en.wikipedia.org/wiki/Headless_software

Initializing a headless program from JavaScript looks like this:

```javascript
var app = Elm.MyThing.init();
```

If you _do_ want to control the user interface in Elm, the [`Browser`][browser]
module has a few ways to create that kind of `Program` instead!

[headless]: https://en.wikipedia.org/wiki/Headless_software
[browser]: /packages/elm/browser/latest/Browser

worker: 
    { init : flags -> ( model, Platform.Cmd.Cmd msg )
    , update : msg -> model -> ( model, Platform.Cmd.Cmd msg )
    , subscriptions : model -> Platform.Sub.Sub msg
    }
    -> Platform.Program flags model msg
-}
worker :
    { init : Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    , subscriptions : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
worker workerArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Platform" ]
             , name = "worker"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "init"
                                , Type.function
                                    [ Type.var "flags" ]
                                    (Type.tuple
                                       (Type.var "model")
                                       (Type.namedWith
                                          []
                                          "Cmd"
                                          [ Type.var "msg" ]
                                       )
                                    )
                                )
                              , ( "update"
                                , Type.function
                                    [ Type.var "msg", Type.var "model" ]
                                    (Type.tuple
                                       (Type.var "model")
                                       (Type.namedWith
                                          []
                                          "Cmd"
                                          [ Type.var "msg" ]
                                       )
                                    )
                                )
                              , ( "subscriptions"
                                , Type.function
                                    [ Type.var "model" ]
                                    (Type.namedWith [] "Sub" [ Type.var "msg" ])
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "Platform" ]
                               "Program"
                               [ Type.var "flags"
                               , Type.var "model"
                               , Type.var "msg"
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "init"
                  (Elm.functionReduced "workerUnpack" workerArg_.init)
            , Tuple.pair
                  "update"
                  (Elm.functionReduced
                       "workerUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (workerArg_.update functionReducedUnpack)
                       )
                  )
            , Tuple.pair
                  "subscriptions"
                  (Elm.functionReduced "workerUnpack" workerArg_.subscriptions)
            ]
        ]


{-| Send the router a message for the main loop of your app. This message will
be handled by the overall `update` function, just like events from `Html`.

sendToApp: Platform.Router msg a -> msg -> Platform.Task x ()
-}
sendToApp : Elm.Expression -> Elm.Expression -> Elm.Expression
sendToApp sendToAppArg_ sendToAppArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Platform" ]
             , name = "sendToApp"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Platform" ]
                              "Router"
                              [ Type.var "msg", Type.var "a" ]
                          , Type.var "msg"
                          ]
                          (Type.namedWith
                               [ "Platform" ]
                               "Task"
                               [ Type.var "x", Type.unit ]
                          )
                     )
             }
        )
        [ sendToAppArg_, sendToAppArg_0 ]


{-| Send the router a message for your effect manager. This message will
be routed to the `onSelfMsg` function, where you can update the state of your
effect manager as necessary.

As an example, the effect manager for web sockets

sendToSelf: Platform.Router a msg -> msg -> Platform.Task x ()
-}
sendToSelf : Elm.Expression -> Elm.Expression -> Elm.Expression
sendToSelf sendToSelfArg_ sendToSelfArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Platform" ]
             , name = "sendToSelf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Platform" ]
                              "Router"
                              [ Type.var "a", Type.var "msg" ]
                          , Type.var "msg"
                          ]
                          (Type.namedWith
                               [ "Platform" ]
                               "Task"
                               [ Type.var "x", Type.unit ]
                          )
                     )
             }
        )
        [ sendToSelfArg_, sendToSelfArg_0 ]


annotation_ :
    { program :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , task : Type.Annotation -> Type.Annotation -> Type.Annotation
    , processId : Type.Annotation
    , router : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { program =
        \programArg0 programArg1 programArg2 ->
            Type.namedWith
                []
                "Program"
                [ programArg0, programArg1, programArg2 ]
    , task =
        \taskArg0 taskArg1 ->
            Type.namedWith [ "Platform" ] "Task" [ taskArg0, taskArg1 ]
    , processId = Type.namedWith [ "Platform" ] "ProcessId" []
    , router =
        \routerArg0 routerArg1 ->
            Type.namedWith [ "Platform" ] "Router" [ routerArg0, routerArg1 ]
    }


call_ :
    { worker : Elm.Expression -> Elm.Expression
    , sendToApp : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sendToSelf : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { worker =
        \workerArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Platform" ]
                     , name = "worker"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "init"
                                        , Type.function
                                            [ Type.var "flags" ]
                                            (Type.tuple
                                               (Type.var "model")
                                               (Type.namedWith
                                                  []
                                                  "Cmd"
                                                  [ Type.var "msg" ]
                                               )
                                            )
                                        )
                                      , ( "update"
                                        , Type.function
                                            [ Type.var "msg", Type.var "model" ]
                                            (Type.tuple
                                               (Type.var "model")
                                               (Type.namedWith
                                                  []
                                                  "Cmd"
                                                  [ Type.var "msg" ]
                                               )
                                            )
                                        )
                                      , ( "subscriptions"
                                        , Type.function
                                            [ Type.var "model" ]
                                            (Type.namedWith
                                               []
                                               "Sub"
                                               [ Type.var "msg" ]
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Platform" ]
                                       "Program"
                                       [ Type.var "flags"
                                       , Type.var "model"
                                       , Type.var "msg"
                                       ]
                                  )
                             )
                     }
                )
                [ workerArg_ ]
    , sendToApp =
        \sendToAppArg_ sendToAppArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Platform" ]
                     , name = "sendToApp"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Platform" ]
                                      "Router"
                                      [ Type.var "msg", Type.var "a" ]
                                  , Type.var "msg"
                                  ]
                                  (Type.namedWith
                                       [ "Platform" ]
                                       "Task"
                                       [ Type.var "x", Type.unit ]
                                  )
                             )
                     }
                )
                [ sendToAppArg_, sendToAppArg_0 ]
    , sendToSelf =
        \sendToSelfArg_ sendToSelfArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Platform" ]
                     , name = "sendToSelf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Platform" ]
                                      "Router"
                                      [ Type.var "a", Type.var "msg" ]
                                  , Type.var "msg"
                                  ]
                                  (Type.namedWith
                                       [ "Platform" ]
                                       "Task"
                                       [ Type.var "x", Type.unit ]
                                  )
                             )
                     }
                )
                [ sendToSelfArg_, sendToSelfArg_0 ]
    }


values_ :
    { worker : Elm.Expression
    , sendToApp : Elm.Expression
    , sendToSelf : Elm.Expression
    }
values_ =
    { worker =
        Elm.value
            { importFrom = [ "Platform" ]
            , name = "worker"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "init"
                               , Type.function
                                   [ Type.var "flags" ]
                                   (Type.tuple
                                      (Type.var "model")
                                      (Type.namedWith
                                         []
                                         "Cmd"
                                         [ Type.var "msg" ]
                                      )
                                   )
                               )
                             , ( "update"
                               , Type.function
                                   [ Type.var "msg", Type.var "model" ]
                                   (Type.tuple
                                      (Type.var "model")
                                      (Type.namedWith
                                         []
                                         "Cmd"
                                         [ Type.var "msg" ]
                                      )
                                   )
                               )
                             , ( "subscriptions"
                               , Type.function
                                   [ Type.var "model" ]
                                   (Type.namedWith [] "Sub" [ Type.var "msg" ])
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "Platform" ]
                              "Program"
                              [ Type.var "flags"
                              , Type.var "model"
                              , Type.var "msg"
                              ]
                         )
                    )
            }
    , sendToApp =
        Elm.value
            { importFrom = [ "Platform" ]
            , name = "sendToApp"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Platform" ]
                             "Router"
                             [ Type.var "msg", Type.var "a" ]
                         , Type.var "msg"
                         ]
                         (Type.namedWith
                              [ "Platform" ]
                              "Task"
                              [ Type.var "x", Type.unit ]
                         )
                    )
            }
    , sendToSelf =
        Elm.value
            { importFrom = [ "Platform" ]
            , name = "sendToSelf"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Platform" ]
                             "Router"
                             [ Type.var "a", Type.var "msg" ]
                         , Type.var "msg"
                         ]
                         (Type.namedWith
                              [ "Platform" ]
                              "Task"
                              [ Type.var "x", Type.unit ]
                         )
                    )
            }
    }