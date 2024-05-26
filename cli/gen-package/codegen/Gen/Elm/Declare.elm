module Gen.Elm.Declare exposing (alias, annotation_, call_, customType, fn, fn2, fn3, fn4, fn5, fn6, fnArg, fnBuilder, fnDone, function, make_, moduleName_, module_, placeholder, toFile, value, values_, with, withUnexposed)

{-| 
@docs moduleName_, fn, fn2, fn3, fn4, fn5, fn6, fnBuilder, fnArg, fnDone, value, function, module_, with, withUnexposed, placeholder, alias, customType, toFile, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Declare" ]


{-| fn: 
    String
    -> Elm.Arg.Arg value
    -> (value -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression)
-}
fn :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn fnArg fnArg0 fnArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "value" ]
                          , Type.function
                              [ Type.var "value" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fnArg, fnArg0, Elm.functionReduced "fnUnpack" fnArg1 ]


{-| fn2: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> (one -> two -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
-}
fn2 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 fn2Arg fn2Arg0 fn2Arg1 fn2Arg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.function
                              [ Type.var "one", Type.var "two" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fn2Arg
        , fn2Arg0
        , fn2Arg1
        , Elm.functionReduced
            "fn2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (fn2Arg2 functionReducedUnpack)
            )
        ]


{-| fn3: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> (one -> two -> three -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
-}
fn3 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn3 fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 fn3Arg3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fn3Arg
        , fn3Arg0
        , fn3Arg1
        , fn3Arg2
        , Elm.functionReduced
            "fn3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((fn3Arg3 functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        ]


{-| fn4: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> (one -> two -> three -> four -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
-}
fn4 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn4 fn4Arg fn4Arg0 fn4Arg1 fn4Arg2 fn4Arg3 fn4Arg4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "four" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
                              , Type.var "four"
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fn4Arg
        , fn4Arg0
        , fn4Arg1
        , fn4Arg2
        , fn4Arg3
        , Elm.functionReduced
            "fn4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_5_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((fn4Arg4 functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_5_2_0_0
                                     )
                            )
                   )
            )
        ]


{-| fn5: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> Elm.Arg.Arg five
    -> (one -> two -> three -> four -> five -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
-}
fn5 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn5 fn5Arg fn5Arg0 fn5Arg1 fn5Arg2 fn5Arg3 fn5Arg4 fn5Arg5 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "four" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "five" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
                              , Type.var "four"
                              , Type.var "five"
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fn5Arg
        , fn5Arg0
        , fn5Arg1
        , fn5Arg2
        , fn5Arg3
        , fn5Arg4
        , Elm.functionReduced
            "fn5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_6_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((fn5Arg5 functionReducedUnpack)
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_6_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0
                                              )
                                     )
                            )
                   )
            )
        ]


{-| fn6: 
    String
    -> Elm.Arg.Arg one
    -> Elm.Arg.Arg two
    -> Elm.Arg.Arg three
    -> Elm.Arg.Arg four
    -> Elm.Arg.Arg five
    -> Elm.Arg.Arg six
    -> (one -> two -> three -> four -> five -> six -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
-}
fn6 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn6 fn6Arg fn6Arg0 fn6Arg1 fn6Arg2 fn6Arg3 fn6Arg4 fn6Arg5 fn6Arg6 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn6"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "one" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "two" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "three" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "four" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "five" ]
                          , Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "six" ]
                          , Type.function
                              [ Type.var "one"
                              , Type.var "two"
                              , Type.var "three"
                              , Type.var "four"
                              , Type.var "five"
                              , Type.var "six"
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.namedWith [ "Elm" ] "Expression" []
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string fn6Arg
        , fn6Arg0
        , fn6Arg1
        , fn6Arg2
        , fn6Arg3
        , fn6Arg4
        , fn6Arg5
        , Elm.functionReduced
            "fn6Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_7_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (((((fn6Arg6
                                                                functionReducedUnpack
                                                           )
                                                               functionReducedUnpack0
                                                          )
                                                              functionReducedUnpack_2_1_2_0_2_7_2_0_0
                                                         )
                                                             functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0
                                                        )
                                                            functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0
                                                       )
                                              )
                                     )
                            )
                   )
            )
        ]


{-| fnBuilder: 
    String
    -> res
    -> { name : String
    , builder : Elm.Fn res
    , call : Elm.Expression -> List Elm.Expression -> Elm.Expression
    }
-}
fnBuilder : String -> Elm.Expression -> Elm.Expression
fnBuilder fnBuilderArg fnBuilderArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fnBuilder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.var "res" ]
                          (Type.record
                               [ ( "name", Type.string )
                               , ( "builder"
                                 , Type.namedWith
                                       [ "Elm" ]
                                       "Fn"
                                       [ Type.var "res" ]
                                 )
                               , ( "call"
                                 , Type.function
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       , Type.list
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                 )
                               ]
                          )
                     )
             }
        )
        [ Elm.string fnBuilderArg, fnBuilderArg0 ]


{-| fnArg: 
    Elm.Arg.Arg arg
    -> { name : String
    , builder : Elm.Fn (arg -> value)
    , call : Elm.Expression -> List Elm.Expression -> e
    }
    -> { name : String
    , builder : Elm.Fn value
    , call : Elm.Expression -> List Elm.Expression -> Elm.Expression -> e
    }
-}
fnArg :
    Elm.Expression
    -> { name : String
    , builder : Elm.Expression
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
fnArg fnArgArg fnArgArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fnArg"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Arg" ]
                              "Arg"
                              [ Type.var "arg" ]
                          , Type.record
                              [ ( "name", Type.string )
                              , ( "builder"
                                , Type.namedWith
                                    [ "Elm" ]
                                    "Fn"
                                    [ Type.function
                                          [ Type.var "arg" ]
                                          (Type.var "value")
                                    ]
                                )
                              , ( "call"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.list
                                          (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                          )
                                    ]
                                    (Type.var "e")
                                )
                              ]
                          ]
                          (Type.record
                               [ ( "name", Type.string )
                               , ( "builder"
                                 , Type.namedWith
                                       [ "Elm" ]
                                       "Fn"
                                       [ Type.var "value" ]
                                 )
                               , ( "call"
                                 , Type.function
                                       [ Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       , Type.list
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       , Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                       ]
                                       (Type.var "e")
                                 )
                               ]
                          )
                     )
             }
        )
        [ fnArgArg
        , Elm.record
            [ Tuple.pair "name" (Elm.string fnArgArg0.name)
            , Tuple.pair "builder" fnArgArg0.builder
            , Tuple.pair
                  "call"
                  (Elm.functionReduced
                       "fnArgUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (fnArgArg0.call functionReducedUnpack)
                       )
                  )
            ]
        ]


{-| fnDone: 
    { name : String
    , builder : Elm.Fn Elm.Expression
    , call : Elm.Expression -> List Elm.Expression -> res
    }
    -> Elm.Declare.Function res
-}
fnDone :
    { name : String
    , builder : Elm.Expression
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
fnDone fnDoneArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fnDone"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "name", Type.string )
                              , ( "builder"
                                , Type.namedWith
                                    [ "Elm" ]
                                    "Fn"
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                )
                              , ( "call"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.list
                                          (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                          )
                                    ]
                                    (Type.var "res")
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.var "res" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "name" (Elm.string fnDoneArg.name)
            , Tuple.pair "builder" fnDoneArg.builder
            , Tuple.pair
                  "call"
                  (Elm.functionReduced
                       "fnDoneUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (fnDoneArg.call functionReducedUnpack)
                       )
                  )
            ]
        ]


{-| value: String -> Elm.Expression -> Elm.Declare.Value -}
value : String -> Elm.Expression -> Elm.Expression
value valueArg valueArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "value"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Expression" []
                          ]
                          (Type.namedWith [ "Elm", "Declare" ] "Value" [])
                     )
             }
        )
        [ Elm.string valueArg, valueArg0 ]


{-| function: 
    String
    -> List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Elm.Expression -> Elm.Expression)
    -> Elm.Declare.Function (List Elm.Expression -> Elm.Expression)
-}
function :
    String
    -> List Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
function functionArg functionArg0 functionArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "function"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list
                              (Type.tuple
                                 Type.string
                                 (Type.maybe
                                    (Type.namedWith
                                       [ "Elm", "Annotation" ]
                                       "Annotation"
                                       []
                                    )
                                 )
                              )
                          , Type.function
                              [ Type.list
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Function"
                               [ Type.function
                                   [ Type.list
                                         (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                         )
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               ]
                          )
                     )
             }
        )
        [ Elm.string functionArg
        , Elm.list functionArg0
        , Elm.functionReduced "functionUnpack" functionArg1
        ]


{-| module_: List String -> val -> Elm.Declare.Module val -}
module_ : List String -> Elm.Expression -> Elm.Expression
module_ module_Arg module_Arg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "module_"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string, Type.var "val" ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Module"
                               [ Type.var "val" ]
                          )
                     )
             }
        )
        [ Elm.list (List.map Elm.string module_Arg), module_Arg0 ]


{-| with: 
    { a | declaration : Elm.Declaration, internal : Elm.Declare.Internal required }
    -> Elm.Declare.Module (required -> val)
    -> Elm.Declare.Module val
-}
with :
    { a | declaration : Elm.Expression, internal : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
with withArg withArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "with"
             , annotation =
                 Just
                     (Type.function
                          [ Type.extensible
                              "a"
                              [ ( "declaration"
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                )
                              , ( "internal"
                                , Type.namedWith
                                    [ "Elm", "Declare" ]
                                    "Internal"
                                    [ Type.var "required" ]
                                )
                              ]
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.function
                                    [ Type.var "required" ]
                                    (Type.var "val")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Module"
                               [ Type.var "val" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "declaration" withArg.declaration
            , Tuple.pair "internal" withArg.internal
            ]
        , withArg0
        ]


{-| withUnexposed: 
    { a | declaration : Elm.Declaration }
    -> Elm.Declare.Module val
    -> Elm.Declare.Module val
-}
withUnexposed :
    { a | declaration : Elm.Expression } -> Elm.Expression -> Elm.Expression
withUnexposed withUnexposedArg withUnexposedArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "withUnexposed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.extensible
                              "a"
                              [ ( "declaration"
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                )
                              ]
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Module"
                               [ Type.var "val" ]
                          )
                     )
             }
        )
        [ Elm.record [ Tuple.pair "declaration" withUnexposedArg.declaration ]
        , withUnexposedArg0
        ]


{-| You may want a placeholder function body if you're defining a function using `Declare` with the intention of _calling_ the function instead of defining it.

In that case you can use `placeholder`!

Of note, if you generate the actual body of `placeholder`, it'll generate `Debug.todo "Placeholder function body"`.

placeholder: Elm.Expression
-}
placeholder : Elm.Expression
placeholder =
    Elm.value
        { importFrom = [ "Elm", "Declare" ]
        , name = "placeholder"
        , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
        }


{-| alias: String -> Elm.Annotation.Annotation -> Elm.Declare.Annotation -}
alias : String -> Elm.Expression -> Elm.Expression
alias aliasArg aliasArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "alias"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          ]
                          (Type.namedWith [ "Elm", "Declare" ] "Annotation" [])
                     )
             }
        )
        [ Elm.string aliasArg, aliasArg0 ]


{-| customType: String -> List Elm.Variant -> Elm.Declare.Annotation -}
customType : String -> List Elm.Expression -> Elm.Expression
customType customTypeArg customTypeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "customType"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                          ]
                          (Type.namedWith [ "Elm", "Declare" ] "Annotation" [])
                     )
             }
        )
        [ Elm.string customTypeArg, Elm.list customTypeArg0 ]


{-| toFile: Elm.Declare.Module val -> Elm.File -}
toFile : Elm.Expression -> Elm.Expression
toFile toFileArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "toFile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                          ]
                          (Type.namedWith [ "Elm" ] "File" [])
                     )
             }
        )
        [ toFileArg ]


annotation_ :
    { function : Type.Annotation -> Type.Annotation
    , value : Type.Annotation
    , module_ : Type.Annotation -> Type.Annotation
    , annotation : Type.Annotation
    , internal : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { function =
        \functionArg0 ->
            Type.alias
                moduleName_
                "Function"
                [ functionArg0 ]
                (Type.record
                     [ ( "call", Type.var "tipe" )
                     , ( "value", Type.namedWith [ "Elm" ] "Expression" [] )
                     , ( "declaration"
                       , Type.namedWith [ "Elm" ] "Declaration" []
                       )
                     , ( "internal"
                       , Type.namedWith
                             [ "Elm", "Declare" ]
                             "Internal"
                             [ Type.var "tipe" ]
                       )
                     ]
                )
    , value =
        Type.alias
            moduleName_
            "Value"
            []
            (Type.record
                 [ ( "value", Type.namedWith [ "Elm" ] "Expression" [] )
                 , ( "declaration", Type.namedWith [ "Elm" ] "Declaration" [] )
                 , ( "internal"
                   , Type.namedWith
                         [ "Elm", "Declare" ]
                         "Internal"
                         [ Type.namedWith [ "Elm" ] "Expression" [] ]
                   )
                 ]
            )
    , module_ =
        \moduleArg0 ->
            Type.alias
                moduleName_
                "Module"
                [ moduleArg0 ]
                (Type.record
                     [ ( "name", Type.list Type.string )
                     , ( "declarations"
                       , Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                       )
                     , ( "call", Type.var "val" )
                     ]
                )
    , annotation =
        Type.alias
            moduleName_
            "Annotation"
            []
            (Type.record
                 [ ( "annotation"
                   , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                   )
                 , ( "declaration", Type.namedWith [ "Elm" ] "Declaration" [] )
                 , ( "internal"
                   , Type.namedWith
                         [ "Elm", "Declare" ]
                         "Internal"
                         [ Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                   )
                 ]
            )
    , internal =
        \internalArg0 ->
            Type.namedWith [ "Elm", "Declare" ] "Internal" [ internalArg0 ]
    }


make_ :
    { function :
        { call : Elm.Expression
        , value : Elm.Expression
        , declaration : Elm.Expression
        , internal : Elm.Expression
        }
        -> Elm.Expression
    , value :
        { value : Elm.Expression
        , declaration : Elm.Expression
        , internal : Elm.Expression
        }
        -> Elm.Expression
    , module_ :
        { name : Elm.Expression
        , declarations : Elm.Expression
        , call : Elm.Expression
        }
        -> Elm.Expression
    , annotation :
        { annotation : Elm.Expression
        , declaration : Elm.Expression
        , internal : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { function =
        \function_args ->
            Elm.withType
                (Type.alias
                     [ "Elm", "Declare" ]
                     "Function"
                     [ Type.var "tipe" ]
                     (Type.record
                          [ ( "call", Type.var "tipe" )
                          , ( "value"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          , ( "declaration"
                            , Type.namedWith [ "Elm" ] "Declaration" []
                            )
                          , ( "internal"
                            , Type.namedWith
                                  [ "Elm", "Declare" ]
                                  "Internal"
                                  [ Type.var "tipe" ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "call" function_args.call
                     , Tuple.pair "value" function_args.value
                     , Tuple.pair "declaration" function_args.declaration
                     , Tuple.pair "internal" function_args.internal
                     ]
                )
    , value =
        \value_args ->
            Elm.withType
                (Type.alias
                     [ "Elm", "Declare" ]
                     "Value"
                     []
                     (Type.record
                          [ ( "value"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          , ( "declaration"
                            , Type.namedWith [ "Elm" ] "Declaration" []
                            )
                          , ( "internal"
                            , Type.namedWith
                                  [ "Elm", "Declare" ]
                                  "Internal"
                                  [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "value" value_args.value
                     , Tuple.pair "declaration" value_args.declaration
                     , Tuple.pair "internal" value_args.internal
                     ]
                )
    , module_ =
        \module_args ->
            Elm.withType
                (Type.alias
                     [ "Elm", "Declare" ]
                     "Module"
                     [ Type.var "val" ]
                     (Type.record
                          [ ( "name", Type.list Type.string )
                          , ( "declarations"
                            , Type.list
                                  (Type.namedWith [ "Elm" ] "Declaration" [])
                            )
                          , ( "call", Type.var "val" )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "name" module_args.name
                     , Tuple.pair "declarations" module_args.declarations
                     , Tuple.pair "call" module_args.call
                     ]
                )
    , annotation =
        \annotation_args ->
            Elm.withType
                (Type.alias
                     [ "Elm", "Declare" ]
                     "Annotation"
                     []
                     (Type.record
                          [ ( "annotation"
                            , Type.namedWith
                                  [ "Elm", "Annotation" ]
                                  "Annotation"
                                  []
                            )
                          , ( "declaration"
                            , Type.namedWith [ "Elm" ] "Declaration" []
                            )
                          , ( "internal"
                            , Type.namedWith
                                  [ "Elm", "Declare" ]
                                  "Internal"
                                  [ Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "annotation" annotation_args.annotation
                     , Tuple.pair "declaration" annotation_args.declaration
                     , Tuple.pair "internal" annotation_args.internal
                     ]
                )
    }


call_ :
    { fn : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fn2 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fn6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fnBuilder : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnArg : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnDone : Elm.Expression -> Elm.Expression
    , value : Elm.Expression -> Elm.Expression -> Elm.Expression
    , function :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , module_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , with : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withUnexposed : Elm.Expression -> Elm.Expression -> Elm.Expression
    , alias : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toFile : Elm.Expression -> Elm.Expression
    }
call_ =
    { fn =
        \fnArg fnArg0 fnArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "value" ]
                                  , Type.function
                                      [ Type.var "value" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fnArg, fnArg0, fnArg1 ]
    , fn2 =
        \fn2Arg fn2Arg0 fn2Arg1 fn2Arg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.function
                                      [ Type.var "one", Type.var "two" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fn2Arg, fn2Arg0, fn2Arg1, fn2Arg2 ]
    , fn3 =
        \fn3Arg fn3Arg0 fn3Arg1 fn3Arg2 fn3Arg3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fn3Arg, fn3Arg0, fn3Arg1, fn3Arg2, fn3Arg3 ]
    , fn4 =
        \fn4Arg fn4Arg0 fn4Arg1 fn4Arg2 fn4Arg3 fn4Arg4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "four" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
                                      , Type.var "four"
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fn4Arg, fn4Arg0, fn4Arg1, fn4Arg2, fn4Arg3, fn4Arg4 ]
    , fn5 =
        \fn5Arg fn5Arg0 fn5Arg1 fn5Arg2 fn5Arg3 fn5Arg4 fn5Arg5 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "four" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "five" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
                                      , Type.var "four"
                                      , Type.var "five"
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fn5Arg, fn5Arg0, fn5Arg1, fn5Arg2, fn5Arg3, fn5Arg4, fn5Arg5 ]
    , fn6 =
        \fn6Arg fn6Arg0 fn6Arg1 fn6Arg2 fn6Arg3 fn6Arg4 fn6Arg5 fn6Arg6 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn6"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "four" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "five" ]
                                  , Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "six" ]
                                  , Type.function
                                      [ Type.var "one"
                                      , Type.var "two"
                                      , Type.var "three"
                                      , Type.var "four"
                                      , Type.var "five"
                                      , Type.var "six"
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ fn6Arg
                , fn6Arg0
                , fn6Arg1
                , fn6Arg2
                , fn6Arg3
                , fn6Arg4
                , fn6Arg5
                , fn6Arg6
                ]
    , fnBuilder =
        \fnBuilderArg fnBuilderArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fnBuilder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.var "res" ]
                                  (Type.record
                                       [ ( "name", Type.string )
                                       , ( "builder"
                                         , Type.namedWith
                                               [ "Elm" ]
                                               "Fn"
                                               [ Type.var "res" ]
                                         )
                                       , ( "call"
                                         , Type.function
                                               [ Type.namedWith
                                                   [ "Elm" ]
                                                   "Expression"
                                                   []
                                               , Type.list
                                                   (Type.namedWith
                                                      [ "Elm" ]
                                                      "Expression"
                                                      []
                                                   )
                                               ]
                                               (Type.namedWith
                                                    [ "Elm" ]
                                                    "Expression"
                                                    []
                                               )
                                         )
                                       ]
                                  )
                             )
                     }
                )
                [ fnBuilderArg, fnBuilderArg0 ]
    , fnArg =
        \fnArgArg fnArgArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fnArg"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Arg" ]
                                      "Arg"
                                      [ Type.var "arg" ]
                                  , Type.record
                                      [ ( "name", Type.string )
                                      , ( "builder"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Fn"
                                            [ Type.function
                                                  [ Type.var "arg" ]
                                                  (Type.var "value")
                                            ]
                                        )
                                      , ( "call"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            , Type.list
                                                  (Type.namedWith
                                                       [ "Elm" ]
                                                       "Expression"
                                                       []
                                                  )
                                            ]
                                            (Type.var "e")
                                        )
                                      ]
                                  ]
                                  (Type.record
                                       [ ( "name", Type.string )
                                       , ( "builder"
                                         , Type.namedWith
                                               [ "Elm" ]
                                               "Fn"
                                               [ Type.var "value" ]
                                         )
                                       , ( "call"
                                         , Type.function
                                               [ Type.namedWith
                                                   [ "Elm" ]
                                                   "Expression"
                                                   []
                                               , Type.list
                                                   (Type.namedWith
                                                      [ "Elm" ]
                                                      "Expression"
                                                      []
                                                   )
                                               , Type.namedWith
                                                   [ "Elm" ]
                                                   "Expression"
                                                   []
                                               ]
                                               (Type.var "e")
                                         )
                                       ]
                                  )
                             )
                     }
                )
                [ fnArgArg, fnArgArg0 ]
    , fnDone =
        \fnDoneArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fnDone"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "name", Type.string )
                                      , ( "builder"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Fn"
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            ]
                                        )
                                      , ( "call"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            , Type.list
                                                  (Type.namedWith
                                                       [ "Elm" ]
                                                       "Expression"
                                                       []
                                                  )
                                            ]
                                            (Type.var "res")
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.var "res" ]
                                  )
                             )
                     }
                )
                [ fnDoneArg ]
    , value =
        \valueArg valueArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "value"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ valueArg, valueArg0 ]
    , function =
        \functionArg functionArg0 functionArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "function"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list
                                      (Type.tuple
                                         Type.string
                                         (Type.maybe
                                            (Type.namedWith
                                               [ "Elm", "Annotation" ]
                                               "Annotation"
                                               []
                                            )
                                         )
                                      )
                                  , Type.function
                                      [ Type.list
                                            (Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                            )
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Function"
                                       [ Type.function
                                           [ Type.list
                                                 (Type.namedWith
                                                      [ "Elm" ]
                                                      "Expression"
                                                      []
                                                 )
                                           ]
                                           (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                           )
                                       ]
                                  )
                             )
                     }
                )
                [ functionArg, functionArg0, functionArg1 ]
    , module_ =
        \module_Arg module_Arg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "module_"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string, Type.var "val" ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Module"
                                       [ Type.var "val" ]
                                  )
                             )
                     }
                )
                [ module_Arg, module_Arg0 ]
    , with =
        \withArg withArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "with"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.extensible
                                      "a"
                                      [ ( "declaration"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                        )
                                      , ( "internal"
                                        , Type.namedWith
                                            [ "Elm", "Declare" ]
                                            "Internal"
                                            [ Type.var "required" ]
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.function
                                            [ Type.var "required" ]
                                            (Type.var "val")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Module"
                                       [ Type.var "val" ]
                                  )
                             )
                     }
                )
                [ withArg, withArg0 ]
    , withUnexposed =
        \withUnexposedArg withUnexposedArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "withUnexposed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.extensible
                                      "a"
                                      [ ( "declaration"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.var "val" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Module"
                                       [ Type.var "val" ]
                                  )
                             )
                     }
                )
                [ withUnexposedArg, withUnexposedArg0 ]
    , alias =
        \aliasArg aliasArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "alias"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Annotation"
                                       []
                                  )
                             )
                     }
                )
                [ aliasArg, aliasArg0 ]
    , customType =
        \customTypeArg customTypeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "customType"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list
                                      (Type.namedWith [ "Elm" ] "Variant" [])
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Annotation"
                                       []
                                  )
                             )
                     }
                )
                [ customTypeArg, customTypeArg0 ]
    , toFile =
        \toFileArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "toFile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.var "val" ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "File" [])
                             )
                     }
                )
                [ toFileArg ]
    }


values_ :
    { fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fn4 : Elm.Expression
    , fn5 : Elm.Expression
    , fn6 : Elm.Expression
    , fnBuilder : Elm.Expression
    , fnArg : Elm.Expression
    , fnDone : Elm.Expression
    , value : Elm.Expression
    , function : Elm.Expression
    , module_ : Elm.Expression
    , with : Elm.Expression
    , withUnexposed : Elm.Expression
    , placeholder : Elm.Expression
    , alias : Elm.Expression
    , customType : Elm.Expression
    , toFile : Elm.Expression
    }
values_ =
    { fn =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "value" ]
                         , Type.function
                             [ Type.var "value" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fn2 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.function
                             [ Type.var "one", Type.var "two" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fn3 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fn4 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "four" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
                             , Type.var "four"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fn5 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "four" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "five" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
                             , Type.var "four"
                             , Type.var "five"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fn6 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "one" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "two" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "three" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "four" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "five" ]
                         , Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "six" ]
                         , Type.function
                             [ Type.var "one"
                             , Type.var "two"
                             , Type.var "three"
                             , Type.var "four"
                             , Type.var "five"
                             , Type.var "six"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.namedWith [ "Elm" ] "Expression" []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , fnBuilder =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fnBuilder"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.var "res" ]
                         (Type.record
                              [ ( "name", Type.string )
                              , ( "builder"
                                , Type.namedWith
                                      [ "Elm" ]
                                      "Fn"
                                      [ Type.var "res" ]
                                )
                              , ( "call"
                                , Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.list
                                          (Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                          )
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              ]
                         )
                    )
            }
    , fnArg =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fnArg"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Arg" ]
                             "Arg"
                             [ Type.var "arg" ]
                         , Type.record
                             [ ( "name", Type.string )
                             , ( "builder"
                               , Type.namedWith
                                   [ "Elm" ]
                                   "Fn"
                                   [ Type.function
                                         [ Type.var "arg" ]
                                         (Type.var "value")
                                   ]
                               )
                             , ( "call"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.list
                                         (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                         )
                                   ]
                                   (Type.var "e")
                               )
                             ]
                         ]
                         (Type.record
                              [ ( "name", Type.string )
                              , ( "builder"
                                , Type.namedWith
                                      [ "Elm" ]
                                      "Fn"
                                      [ Type.var "value" ]
                                )
                              , ( "call"
                                , Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.list
                                          (Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                          )
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.var "e")
                                )
                              ]
                         )
                    )
            }
    , fnDone =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fnDone"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "name", Type.string )
                             , ( "builder"
                               , Type.namedWith
                                   [ "Elm" ]
                                   "Fn"
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                               )
                             , ( "call"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" []
                                   , Type.list
                                         (Type.namedWith
                                              [ "Elm" ]
                                              "Expression"
                                              []
                                         )
                                   ]
                                   (Type.var "res")
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.var "res" ]
                         )
                    )
            }
    , value =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Elm" ] "Expression" []
                         ]
                         (Type.namedWith [ "Elm", "Declare" ] "Value" [])
                    )
            }
    , function =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list
                             (Type.tuple
                                Type.string
                                (Type.maybe
                                   (Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                   )
                                )
                             )
                         , Type.function
                             [ Type.list
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Function"
                              [ Type.function
                                  [ Type.list
                                        (Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                        )
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                              ]
                         )
                    )
            }
    , module_ =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "module_"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string, Type.var "val" ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                         )
                    )
            }
    , with =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "with"
            , annotation =
                Just
                    (Type.function
                         [ Type.extensible
                             "a"
                             [ ( "declaration"
                               , Type.namedWith [ "Elm" ] "Declaration" []
                               )
                             , ( "internal"
                               , Type.namedWith
                                   [ "Elm", "Declare" ]
                                   "Internal"
                                   [ Type.var "required" ]
                               )
                             ]
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.function
                                   [ Type.var "required" ]
                                   (Type.var "val")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                         )
                    )
            }
    , withUnexposed =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "withUnexposed"
            , annotation =
                Just
                    (Type.function
                         [ Type.extensible
                             "a"
                             [ ( "declaration"
                               , Type.namedWith [ "Elm" ] "Declaration" []
                               )
                             ]
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.var "val" ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                         )
                    )
            }
    , placeholder =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "placeholder"
            , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
            }
    , alias =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "alias"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         ]
                         (Type.namedWith [ "Elm", "Declare" ] "Annotation" [])
                    )
            }
    , customType =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                         ]
                         (Type.namedWith [ "Elm", "Declare" ] "Annotation" [])
                    )
            }
    , toFile =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "toFile"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.var "val" ]
                         ]
                         (Type.namedWith [ "Elm" ] "File" [])
                    )
            }
    }