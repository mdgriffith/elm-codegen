module Gen.Elm.Declare exposing
    ( alias
    , annotation_
    , call_
    , customType
    , customTypeAdvanced
    , customVariant
    , finishCustomType
    , fn
    , fn2
    , fn3
    , fn4
    , fn5
    , fn6
    , fnArg
    , fnBody
    , fnBuilder
    , fnDone
    , function
    , include
    , make_
    , moduleName_
    , module_
    , placeholder
    , toFile
    , value
    , values_
    , variant0
    , variant1
    , variant2
    , variant3
    , variant4
    , with
    , withDocumentation
    , withSubmodule
    , withUnexposed
    )

{-|
# Generated bindings for Elm.Declare

@docs moduleName_, fn, fn2, fn3, fn4, fn5, fn6, withDocumentation, fnBuilder, fnArg, fnDone, fnBody, placeholder, value, function, module_, with, withUnexposed, alias, customType, toFile, include, withSubmodule, customTypeAdvanced, variant0, variant1, variant2, variant3, variant4, customVariant, finishCustomType, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Declare" ]


{-| fn: 
    String
    -> Elm.Arg value
    -> (value -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression)
-}
fn :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn fnArg_ fnArg_0 fnArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "value" ]
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
        [ Elm.string fnArg_, fnArg_0, Elm.functionReduced "fnUnpack" fnArg_1 ]


{-| fn2: 
    String
    -> Elm.Arg one
    -> Elm.Arg two
    -> (one -> two -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
-}
fn2 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 fn2Arg_ fn2Arg_0 fn2Arg_1 fn2Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
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
        [ Elm.string fn2Arg_
        , fn2Arg_0
        , fn2Arg_1
        , Elm.functionReduced
            "fn2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (fn2Arg_2 functionReducedUnpack)
            )
        ]


{-| fn3: 
    String
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
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
fn3 fn3Arg_ fn3Arg_0 fn3Arg_1 fn3Arg_2 fn3Arg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
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
        [ Elm.string fn3Arg_
        , fn3Arg_0
        , fn3Arg_1
        , fn3Arg_2
        , Elm.functionReduced
            "fn3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((fn3Arg_3 functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        ]


{-| fn4: 
    String
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
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
fn4 fn4Arg_ fn4Arg_0 fn4Arg_1 fn4Arg_2 fn4Arg_3 fn4Arg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
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
        [ Elm.string fn4Arg_
        , fn4Arg_0
        , fn4Arg_1
        , fn4Arg_2
        , fn4Arg_3
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
                                     (((fn4Arg_4 functionReducedUnpack)
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
    -> Elm.Arg five
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
fn5 fn5Arg_ fn5Arg_0 fn5Arg_1 fn5Arg_2 fn5Arg_3 fn5Arg_4 fn5Arg_5 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "five" ]
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
        [ Elm.string fn5Arg_
        , fn5Arg_0
        , fn5Arg_1
        , fn5Arg_2
        , fn5Arg_3
        , fn5Arg_4
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
                                              ((((fn5Arg_5 functionReducedUnpack
                                                 )
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
    -> Elm.Arg one
    -> Elm.Arg two
    -> Elm.Arg three
    -> Elm.Arg four
    -> Elm.Arg five
    -> Elm.Arg six
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
fn6 fn6Arg_ fn6Arg_0 fn6Arg_1 fn6Arg_2 fn6Arg_3 fn6Arg_4 fn6Arg_5 fn6Arg_6 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fn6"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "five" ]
                          , Type.namedWith [ "Elm" ] "Arg" [ Type.var "six" ]
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
        [ Elm.string fn6Arg_
        , fn6Arg_0
        , fn6Arg_1
        , fn6Arg_2
        , fn6Arg_3
        , fn6Arg_4
        , fn6Arg_5
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
                                                       (((((fn6Arg_6
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


{-| Add documentation to a function or value declared using this module.

withDocumentation: 
    String
    -> { a | declaration : Elm.Declaration }
    -> { a | declaration : Elm.Declaration }
-}
withDocumentation :
    String -> { a | declaration : Elm.Expression } -> Elm.Expression
withDocumentation withDocumentationArg_ withDocumentationArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "withDocumentation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.extensible
                              "a"
                              [ ( "declaration"
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                )
                              ]
                          ]
                          (Type.extensible
                               "a"
                               [ ( "declaration"
                                 , Type.namedWith [ "Elm" ] "Declaration" []
                                 )
                               ]
                          )
                     )
             }
        )
        [ Elm.string withDocumentationArg_
        , Elm.record
            [ Tuple.pair "declaration" withDocumentationArg_0.declaration ]
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
fnBuilder fnBuilderArg_ fnBuilderArg_0 =
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
        [ Elm.string fnBuilderArg_, fnBuilderArg_0 ]


{-| fnArg: 
    Elm.Arg arg
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
fnArg fnArgArg_ fnArgArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fnArg"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
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
        [ fnArgArg_
        , Elm.record
            [ Tuple.pair "name" (Elm.string fnArgArg_0.name)
            , Tuple.pair "builder" fnArgArg_0.builder
            , Tuple.pair
                  "call"
                  (Elm.functionReduced
                       "fnArgUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (fnArgArg_0.call functionReducedUnpack)
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
fnDone fnDoneArg_ =
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
            [ Tuple.pair "name" (Elm.string fnDoneArg_.name)
            , Tuple.pair "builder" fnDoneArg_.builder
            , Tuple.pair
                  "call"
                  (Elm.functionReduced
                       "fnDoneUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (fnDoneArg_.call functionReducedUnpack)
                       )
                  )
            ]
        ]


{-| fnBody: 
    (args -> Elm.Expression)
    -> { name : String
    , builder : Elm.Fn args
    , call : Elm.Expression -> List Elm.Expression -> res
    }
    -> Elm.Declare.Function res
-}
fnBody :
    (Elm.Expression -> Elm.Expression)
    -> { name : String
    , builder : Elm.Expression
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
fnBody fnBodyArg_ fnBodyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "fnBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "args" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.record
                              [ ( "name", Type.string )
                              , ( "builder"
                                , Type.namedWith
                                    [ "Elm" ]
                                    "Fn"
                                    [ Type.var "args" ]
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
        [ Elm.functionReduced "fnBodyUnpack" fnBodyArg_
        , Elm.record
            [ Tuple.pair "name" (Elm.string fnBodyArg_0.name)
            , Tuple.pair "builder" fnBodyArg_0.builder
            , Tuple.pair
                  "call"
                  (Elm.functionReduced
                       "fnBodyUnpack"
                       (\functionReducedUnpack ->
                            Elm.functionReduced
                                "unpack"
                                (fnBodyArg_0.call functionReducedUnpack)
                       )
                  )
            ]
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


{-| value: String -> Elm.Expression -> Elm.Declare.Value -}
value : String -> Elm.Expression -> Elm.Expression
value valueArg_ valueArg_0 =
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
        [ Elm.string valueArg_, valueArg_0 ]


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
function functionArg_ functionArg_0 functionArg_1 =
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
        [ Elm.string functionArg_
        , Elm.list functionArg_0
        , Elm.functionReduced "functionUnpack" functionArg_1
        ]


{-| module_: List String -> val -> Elm.Declare.Module val -}
module_ : List String -> Elm.Expression -> Elm.Expression
module_ module_Arg_ module_Arg_0 =
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
        [ Elm.list (List.map Elm.string module_Arg_), module_Arg_0 ]


{-| with: 
    { a | declaration : Elm.Declaration, internal : Elm.Declare.Internal required }
    -> Elm.Declare.Module (required -> val)
    -> Elm.Declare.Module val
-}
with :
    { a | declaration : Elm.Expression, internal : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
with withArg_ withArg_0 =
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
            [ Tuple.pair "declaration" withArg_.declaration
            , Tuple.pair "internal" withArg_.internal
            ]
        , withArg_0
        ]


{-| withUnexposed: 
    { a | declaration : Elm.Declaration }
    -> Elm.Declare.Module val
    -> Elm.Declare.Module val
-}
withUnexposed :
    { a | declaration : Elm.Expression } -> Elm.Expression -> Elm.Expression
withUnexposed withUnexposedArg_ withUnexposedArg_0 =
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
        [ Elm.record [ Tuple.pair "declaration" withUnexposedArg_.declaration ]
        , withUnexposedArg_0
        ]


{-| alias: String -> Elm.Annotation.Annotation -> Elm.Declare.Annotation -}
alias : String -> Elm.Expression -> Elm.Expression
alias aliasArg_ aliasArg_0 =
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
        [ Elm.string aliasArg_, aliasArg_0 ]


{-| customType: String -> List Elm.Variant -> Elm.Declare.Annotation -}
customType : String -> List Elm.Expression -> Elm.Expression
customType customTypeArg_ customTypeArg_0 =
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
        [ Elm.string customTypeArg_, Elm.list customTypeArg_0 ]


{-| toFile: Elm.Declare.Module val -> Elm.File -}
toFile : Elm.Expression -> Elm.Expression
toFile toFileArg_ =
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
        [ toFileArg_ ]


{-| Include a module as a declaration in another module.

**Note** - Be aware that the modulename of the included module must match the module name of the module you're including it in!

include: Elm.Declare.Module val -> Elm.Declaration
-}
include : Elm.Expression -> Elm.Expression
include includeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "include"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "val" ]
                          ]
                          (Type.namedWith [ "Elm" ] "Declaration" [])
                     )
             }
        )
        [ includeArg_ ]


{-| Add a module as a "submodule".

This can be useful for organizing particularly complex modules.

The only thing to be aware of here is that the module name for both of these modules must be the same or you're going to have a bad time.

withSubmodule: 
    Elm.Declare.Module submod
    -> Elm.Declare.Module (submod -> mod)
    -> Elm.Declare.Module mod
-}
withSubmodule : Elm.Expression -> Elm.Expression -> Elm.Expression
withSubmodule withSubmoduleArg_ withSubmoduleArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "withSubmodule"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "submod" ]
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.function
                                    [ Type.var "submod" ]
                                    (Type.var "mod")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "Module"
                               [ Type.var "mod" ]
                          )
                     )
             }
        )
        [ withSubmoduleArg_, withSubmoduleArg_0 ]


{-| customTypeAdvanced: 
    String
    -> { exposeConstructor : Bool }
    -> make_
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
customTypeAdvanced :
    String -> { exposeConstructor : Bool } -> Elm.Expression -> Elm.Expression
customTypeAdvanced customTypeAdvancedArg_ customTypeAdvancedArg_0 customTypeAdvancedArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "customTypeAdvanced"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.record [ ( "exposeConstructor", Type.bool ) ]
                          , Type.var "make_"
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string customTypeAdvancedArg_
        , Elm.record
            [ Tuple.pair
                  "exposeConstructor"
                  (Elm.bool customTypeAdvancedArg_0.exposeConstructor)
            ]
        , customTypeAdvancedArg_1
        ]


{-| variant0: 
    String
    -> (case_ -> Elm.Expression)
    -> Elm.Declare.CustomTypeBuilder case_ (Elm.Expression -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
variant0 :
    String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
variant0 variant0Arg_ variant0Arg_0 variant0Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "variant0"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "case_" ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.var "make_")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string variant0Arg_
        , Elm.functionReduced "variant0Unpack" variant0Arg_0
        , variant0Arg_1
        ]


{-| variant1: 
    String
    -> (case_ -> Elm.Expression -> Elm.Expression)
    -> Elm.Annotation.Annotation
    -> Elm.Declare.CustomTypeBuilder case_ ((Elm.Expression -> Elm.Expression)
    -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
variant1 :
    String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
variant1 variant1Arg_ variant1Arg_0 variant1Arg_1 variant1Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "variant1"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "case_"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_"
                              , Type.function
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
                                    (Type.var "make_")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string variant1Arg_
        , Elm.functionReduced
            "variant1Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (variant1Arg_0 functionReducedUnpack)
            )
        , variant1Arg_1
        , variant1Arg_2
        ]


{-| variant2: 
    String
    -> (case_ -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Declare.CustomTypeBuilder case_ ((Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
variant2 :
    String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
variant2 variant2Arg_ variant2Arg_0 variant2Arg_1 variant2Arg_2 variant2Arg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "variant2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "case_"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_"
                              , Type.function
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
                                    (Type.var "make_")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string variant2Arg_
        , Elm.functionReduced
            "variant2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((variant2Arg_0 functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , variant2Arg_1
        , variant2Arg_2
        , variant2Arg_3
        ]


{-| variant3: 
    String
    -> (case_
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Declare.CustomTypeBuilder case_ ((Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
variant3 :
    String
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
variant3 variant3Arg_ variant3Arg_0 variant3Arg_1 variant3Arg_2 variant3Arg_3 variant3Arg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "variant3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "case_"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_"
                              , Type.function
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
                                    (Type.var "make_")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string variant3Arg_
        , Elm.functionReduced
            "variant3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_1_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((variant3Arg_0 functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_1_2_0_0
                                     )
                            )
                   )
            )
        , variant3Arg_1
        , variant3Arg_2
        , variant3Arg_3
        , variant3Arg_4
        ]


{-| variant4: 
    String
    -> (case_
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Annotation.Annotation
    -> Elm.Declare.CustomTypeBuilder case_ ((Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
variant4 :
    String
    -> (Elm.Expression
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
variant4 variant4Arg_ variant4Arg_0 variant4Arg_1 variant4Arg_2 variant4Arg_3 variant4Arg_4 variant4Arg_5 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "variant4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "case_"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              , Type.namedWith [ "Elm" ] "Expression" []
                              ]
                              (Type.namedWith [ "Elm" ] "Expression" [])
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Annotation" ]
                              "Annotation"
                              []
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_"
                              , Type.function
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
                                    (Type.var "make_")
                              ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string variant4Arg_
        , Elm.functionReduced
            "variant4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_1_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_1_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((variant4Arg_0
                                                      functionReducedUnpack
                                                 )
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_1_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_1_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , variant4Arg_1
        , variant4Arg_2
        , variant4Arg_3
        , variant4Arg_4
        , variant4Arg_5
        ]


{-| customVariant: 
    String
    -> List Elm.Annotation.Annotation
    -> (case_ -> branch)
    -> (Elm.Arg branch -> Elm.Arg Elm.Expression)
    -> ((List Elm.Expression -> Elm.Expression) -> previousMake_ -> make_)
    -> Elm.Declare.CustomTypeBuilder case_ previousMake_
    -> Elm.Declare.CustomTypeBuilder case_ make_
-}
customVariant :
    String
    -> List Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
customVariant customVariantArg_ customVariantArg_0 customVariantArg_1 customVariantArg_2 customVariantArg_3 customVariantArg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "customVariant"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Elm", "Annotation" ]
                                 "Annotation"
                                 []
                              )
                          , Type.function
                              [ Type.var "case_" ]
                              (Type.var "branch")
                          , Type.function
                              [ Type.namedWith
                                    [ "Elm" ]
                                    "Arg"
                                    [ Type.var "branch" ]
                              ]
                              (Type.namedWith
                                 [ "Elm" ]
                                 "Arg"
                                 [ Type.namedWith [ "Elm" ] "Expression" [] ]
                              )
                          , Type.function
                              [ Type.function
                                    [ Type.list
                                        (Type.namedWith
                                           [ "Elm" ]
                                           "Expression"
                                           []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              , Type.var "previousMake_"
                              ]
                              (Type.var "make_")
                          , Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "previousMake_" ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomTypeBuilder"
                               [ Type.var "case_", Type.var "make_" ]
                          )
                     )
             }
        )
        [ Elm.string customVariantArg_
        , Elm.list customVariantArg_0
        , Elm.functionReduced "customVariantUnpack" customVariantArg_1
        , Elm.functionReduced "customVariantUnpack" customVariantArg_2
        , Elm.functionReduced
            "customVariantUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (customVariantArg_3 functionReducedUnpack)
            )
        , customVariantArg_4
        ]


{-| finishCustomType: Elm.Declare.CustomTypeBuilder make_ make_ -> Elm.Declare.CustomType make_ -}
finishCustomType : Elm.Expression -> Elm.Expression
finishCustomType finishCustomTypeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Elm", "Declare" ]
             , name = "finishCustomType"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "make_", Type.var "make_" ]
                          ]
                          (Type.namedWith
                               [ "Elm", "Declare" ]
                               "CustomType"
                               [ Type.var "make_" ]
                          )
                     )
             }
        )
        [ finishCustomTypeArg_ ]


annotation_ :
    { function : Type.Annotation -> Type.Annotation
    , value : Type.Annotation
    , module_ : Type.Annotation -> Type.Annotation
    , annotation : Type.Annotation
    , customType : Type.Annotation -> Type.Annotation
    , customTypeBuilder : Type.Annotation -> Type.Annotation -> Type.Annotation
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
    , customType =
        \customTypeArg0 ->
            Type.alias
                moduleName_
                "CustomType"
                [ customTypeArg0 ]
                (Type.record
                     [ ( "declaration"
                       , Type.namedWith [ "Elm" ] "Declaration" []
                       )
                     , ( "annotation"
                       , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                       )
                     , ( "make_", Type.var "make_" )
                     , ( "case_"
                       , Type.function
                             [ Type.namedWith [ "Elm" ] "Expression" []
                             , Type.var "make_"
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                       )
                     , ( "internal"
                       , Type.namedWith
                             [ "Elm", "Declare" ]
                             "Internal"
                             [ Type.record
                                 [ ( "annotation"
                                   , Type.namedWith
                                       [ "Elm", "Annotation" ]
                                       "Annotation"
                                       []
                                   )
                                 , ( "make_", Type.var "make_" )
                                 , ( "case_"
                                   , Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       , Type.var "make_"
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   )
                                 ]
                             ]
                       )
                     ]
                )
    , customTypeBuilder =
        \customTypeBuilderArg0 customTypeBuilderArg1 ->
            Type.namedWith
                [ "Elm", "Declare" ]
                "CustomTypeBuilder"
                [ customTypeBuilderArg0, customTypeBuilderArg1 ]
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
    , customType :
        { declaration : Elm.Expression
        , annotation : Elm.Expression
        , make_ : Elm.Expression
        , case_ : Elm.Expression
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
    , customType =
        \customType_args ->
            Elm.withType
                (Type.alias
                     [ "Elm", "Declare" ]
                     "CustomType"
                     [ Type.var "make_" ]
                     (Type.record
                          [ ( "declaration"
                            , Type.namedWith [ "Elm" ] "Declaration" []
                            )
                          , ( "annotation"
                            , Type.namedWith
                                  [ "Elm", "Annotation" ]
                                  "Annotation"
                                  []
                            )
                          , ( "make_", Type.var "make_" )
                          , ( "case_"
                            , Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.var "make_"
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                            )
                          , ( "internal"
                            , Type.namedWith
                                  [ "Elm", "Declare" ]
                                  "Internal"
                                  [ Type.record
                                      [ ( "annotation"
                                        , Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                      , ( "make_", Type.var "make_" )
                                      , ( "case_"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            , Type.var "make_"
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "declaration" customType_args.declaration
                     , Tuple.pair "annotation" customType_args.annotation
                     , Tuple.pair "make_" customType_args.make_
                     , Tuple.pair "case_" customType_args.case_
                     , Tuple.pair "internal" customType_args.internal
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
    , withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnBuilder : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnArg : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fnDone : Elm.Expression -> Elm.Expression
    , fnBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : Elm.Expression -> Elm.Expression -> Elm.Expression
    , function :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , module_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , with : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withUnexposed : Elm.Expression -> Elm.Expression -> Elm.Expression
    , alias : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toFile : Elm.Expression -> Elm.Expression
    , include : Elm.Expression -> Elm.Expression
    , withSubmodule : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customTypeAdvanced :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant0 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant1 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant2 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , customVariant :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , finishCustomType : Elm.Expression -> Elm.Expression
    }
call_ =
    { fn =
        \fnArg_ fnArg_0 fnArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fnArg_, fnArg_0, fnArg_1 ]
    , fn2 =
        \fn2Arg_ fn2Arg_0 fn2Arg_1 fn2Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fn2Arg_, fn2Arg_0, fn2Arg_1, fn2Arg_2 ]
    , fn3 =
        \fn3Arg_ fn3Arg_0 fn3Arg_1 fn3Arg_2 fn3Arg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fn3Arg_, fn3Arg_0, fn3Arg_1, fn3Arg_2, fn3Arg_3 ]
    , fn4 =
        \fn4Arg_ fn4Arg_0 fn4Arg_1 fn4Arg_2 fn4Arg_3 fn4Arg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fn4Arg_, fn4Arg_0, fn4Arg_1, fn4Arg_2, fn4Arg_3, fn4Arg_4 ]
    , fn5 =
        \fn5Arg_ fn5Arg_0 fn5Arg_1 fn5Arg_2 fn5Arg_3 fn5Arg_4 fn5Arg_5 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "four" ]
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fn5Arg_
                , fn5Arg_0
                , fn5Arg_1
                , fn5Arg_2
                , fn5Arg_3
                , fn5Arg_4
                , fn5Arg_5
                ]
    , fn6 =
        \fn6Arg_ fn6Arg_0 fn6Arg_1 fn6Arg_2 fn6Arg_3 fn6Arg_4 fn6Arg_5 fn6Arg_6 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fn6"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "one" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "two" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "three" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "four" ]
                                  , Type.namedWith
                                      [ "Elm" ]
                                      "Arg"
                                      [ Type.var "five" ]
                                  , Type.namedWith
                                      [ "Elm" ]
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
                [ fn6Arg_
                , fn6Arg_0
                , fn6Arg_1
                , fn6Arg_2
                , fn6Arg_3
                , fn6Arg_4
                , fn6Arg_5
                , fn6Arg_6
                ]
    , withDocumentation =
        \withDocumentationArg_ withDocumentationArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "withDocumentation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.extensible
                                      "a"
                                      [ ( "declaration"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                        )
                                      ]
                                  ]
                                  (Type.extensible
                                       "a"
                                       [ ( "declaration"
                                         , Type.namedWith
                                               [ "Elm" ]
                                               "Declaration"
                                               []
                                         )
                                       ]
                                  )
                             )
                     }
                )
                [ withDocumentationArg_, withDocumentationArg_0 ]
    , fnBuilder =
        \fnBuilderArg_ fnBuilderArg_0 ->
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
                [ fnBuilderArg_, fnBuilderArg_0 ]
    , fnArg =
        \fnArgArg_ fnArgArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fnArg"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm" ]
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
                [ fnArgArg_, fnArgArg_0 ]
    , fnDone =
        \fnDoneArg_ ->
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
                [ fnDoneArg_ ]
    , fnBody =
        \fnBodyArg_ fnBodyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "fnBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "args" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.record
                                      [ ( "name", Type.string )
                                      , ( "builder"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Fn"
                                            [ Type.var "args" ]
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
                [ fnBodyArg_, fnBodyArg_0 ]
    , value =
        \valueArg_ valueArg_0 ->
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
                [ valueArg_, valueArg_0 ]
    , function =
        \functionArg_ functionArg_0 functionArg_1 ->
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
                [ functionArg_, functionArg_0, functionArg_1 ]
    , module_ =
        \module_Arg_ module_Arg_0 ->
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
                [ module_Arg_, module_Arg_0 ]
    , with =
        \withArg_ withArg_0 ->
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
                [ withArg_, withArg_0 ]
    , withUnexposed =
        \withUnexposedArg_ withUnexposedArg_0 ->
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
                [ withUnexposedArg_, withUnexposedArg_0 ]
    , alias =
        \aliasArg_ aliasArg_0 ->
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
                [ aliasArg_, aliasArg_0 ]
    , customType =
        \customTypeArg_ customTypeArg_0 ->
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
                [ customTypeArg_, customTypeArg_0 ]
    , toFile =
        \toFileArg_ ->
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
                [ toFileArg_ ]
    , include =
        \includeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "include"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.var "val" ]
                                  ]
                                  (Type.namedWith [ "Elm" ] "Declaration" [])
                             )
                     }
                )
                [ includeArg_ ]
    , withSubmodule =
        \withSubmoduleArg_ withSubmoduleArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "withSubmodule"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.var "submod" ]
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "Module"
                                      [ Type.function
                                            [ Type.var "submod" ]
                                            (Type.var "mod")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "Module"
                                       [ Type.var "mod" ]
                                  )
                             )
                     }
                )
                [ withSubmoduleArg_, withSubmoduleArg_0 ]
    , customTypeAdvanced =
        \customTypeAdvancedArg_ customTypeAdvancedArg_0 customTypeAdvancedArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "customTypeAdvanced"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.record
                                      [ ( "exposeConstructor", Type.bool ) ]
                                  , Type.var "make_"
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ customTypeAdvancedArg_
                , customTypeAdvancedArg_0
                , customTypeAdvancedArg_1
                ]
    , variant0 =
        \variant0Arg_ variant0Arg_0 variant0Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "variant0"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "case_" ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.function
                                            [ Type.namedWith
                                                [ "Elm" ]
                                                "Expression"
                                                []
                                            ]
                                            (Type.var "make_")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ variant0Arg_, variant0Arg_0, variant0Arg_1 ]
    , variant1 =
        \variant1Arg_ variant1Arg_0 variant1Arg_1 variant1Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "variant1"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "case_"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.function
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
                                            (Type.var "make_")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ variant1Arg_, variant1Arg_0, variant1Arg_1, variant1Arg_2 ]
    , variant2 =
        \variant2Arg_ variant2Arg_0 variant2Arg_1 variant2Arg_2 variant2Arg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "variant2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "case_"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.function
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
                                            (Type.var "make_")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ variant2Arg_
                , variant2Arg_0
                , variant2Arg_1
                , variant2Arg_2
                , variant2Arg_3
                ]
    , variant3 =
        \variant3Arg_ variant3Arg_0 variant3Arg_1 variant3Arg_2 variant3Arg_3 variant3Arg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "variant3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "case_"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.function
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
                                            (Type.var "make_")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ variant3Arg_
                , variant3Arg_0
                , variant3Arg_1
                , variant3Arg_2
                , variant3Arg_3
                , variant3Arg_4
                ]
    , variant4 =
        \variant4Arg_ variant4Arg_0 variant4Arg_1 variant4Arg_2 variant4Arg_3 variant4Arg_4 variant4Arg_5 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "variant4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "case_"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Annotation" ]
                                      "Annotation"
                                      []
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.function
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
                                            (Type.var "make_")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ variant4Arg_
                , variant4Arg_0
                , variant4Arg_1
                , variant4Arg_2
                , variant4Arg_3
                , variant4Arg_4
                , variant4Arg_5
                ]
    , customVariant =
        \customVariantArg_ customVariantArg_0 customVariantArg_1 customVariantArg_2 customVariantArg_3 customVariantArg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "customVariant"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Elm", "Annotation" ]
                                         "Annotation"
                                         []
                                      )
                                  , Type.function
                                      [ Type.var "case_" ]
                                      (Type.var "branch")
                                  , Type.function
                                      [ Type.namedWith
                                            [ "Elm" ]
                                            "Arg"
                                            [ Type.var "branch" ]
                                      ]
                                      (Type.namedWith
                                         [ "Elm" ]
                                         "Arg"
                                         [ Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                         ]
                                      )
                                  , Type.function
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
                                      , Type.var "previousMake_"
                                      ]
                                      (Type.var "make_")
                                  , Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "case_"
                                      , Type.var "previousMake_"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomTypeBuilder"
                                       [ Type.var "case_", Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ customVariantArg_
                , customVariantArg_0
                , customVariantArg_1
                , customVariantArg_2
                , customVariantArg_3
                , customVariantArg_4
                ]
    , finishCustomType =
        \finishCustomTypeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Elm", "Declare" ]
                     , name = "finishCustomType"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Elm", "Declare" ]
                                      "CustomTypeBuilder"
                                      [ Type.var "make_", Type.var "make_" ]
                                  ]
                                  (Type.namedWith
                                       [ "Elm", "Declare" ]
                                       "CustomType"
                                       [ Type.var "make_" ]
                                  )
                             )
                     }
                )
                [ finishCustomTypeArg_ ]
    }


values_ :
    { fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fn4 : Elm.Expression
    , fn5 : Elm.Expression
    , fn6 : Elm.Expression
    , withDocumentation : Elm.Expression
    , fnBuilder : Elm.Expression
    , fnArg : Elm.Expression
    , fnDone : Elm.Expression
    , fnBody : Elm.Expression
    , placeholder : Elm.Expression
    , value : Elm.Expression
    , function : Elm.Expression
    , module_ : Elm.Expression
    , with : Elm.Expression
    , withUnexposed : Elm.Expression
    , alias : Elm.Expression
    , customType : Elm.Expression
    , toFile : Elm.Expression
    , include : Elm.Expression
    , withSubmodule : Elm.Expression
    , customTypeAdvanced : Elm.Expression
    , variant0 : Elm.Expression
    , variant1 : Elm.Expression
    , variant2 : Elm.Expression
    , variant3 : Elm.Expression
    , variant4 : Elm.Expression
    , customVariant : Elm.Expression
    , finishCustomType : Elm.Expression
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "value" ]
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "five" ]
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
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "one" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "two" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "three" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "four" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "five" ]
                         , Type.namedWith [ "Elm" ] "Arg" [ Type.var "six" ]
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
    , withDocumentation =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "withDocumentation"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.extensible
                             "a"
                             [ ( "declaration"
                               , Type.namedWith [ "Elm" ] "Declaration" []
                               )
                             ]
                         ]
                         (Type.extensible
                              "a"
                              [ ( "declaration"
                                , Type.namedWith [ "Elm" ] "Declaration" []
                                )
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
                         [ Type.namedWith [ "Elm" ] "Arg" [ Type.var "arg" ]
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
    , fnBody =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "fnBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "args" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.record
                             [ ( "name", Type.string )
                             , ( "builder"
                               , Type.namedWith
                                   [ "Elm" ]
                                   "Fn"
                                   [ Type.var "args" ]
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
    , placeholder =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "placeholder"
            , annotation = Just (Type.namedWith [ "Elm" ] "Expression" [])
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
    , include =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "include"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.var "val" ]
                         ]
                         (Type.namedWith [ "Elm" ] "Declaration" [])
                    )
            }
    , withSubmodule =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "withSubmodule"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.var "submod" ]
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "Module"
                             [ Type.function
                                   [ Type.var "submod" ]
                                   (Type.var "mod")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "Module"
                              [ Type.var "mod" ]
                         )
                    )
            }
    , customTypeAdvanced =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "customTypeAdvanced"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.record [ ( "exposeConstructor", Type.bool ) ]
                         , Type.var "make_"
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , variant0 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "variant0"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "case_" ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_"
                             , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.var "make_")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , variant1 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "variant1"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "case_"
                             , Type.namedWith [ "Elm" ] "Expression" []
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_"
                             , Type.function
                                   [ Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "make_")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , variant2 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "variant2"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "case_"
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_"
                             , Type.function
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "make_")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , variant3 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "variant3"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "case_"
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_"
                             , Type.function
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "make_")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , variant4 =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "variant4"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "case_"
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             , Type.namedWith [ "Elm" ] "Expression" []
                             ]
                             (Type.namedWith [ "Elm" ] "Expression" [])
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Annotation" ]
                             "Annotation"
                             []
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_"
                             , Type.function
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
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.var "make_")
                             ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , customVariant =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "customVariant"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Elm", "Annotation" ]
                                "Annotation"
                                []
                             )
                         , Type.function
                             [ Type.var "case_" ]
                             (Type.var "branch")
                         , Type.function
                             [ Type.namedWith
                                   [ "Elm" ]
                                   "Arg"
                                   [ Type.var "branch" ]
                             ]
                             (Type.namedWith
                                [ "Elm" ]
                                "Arg"
                                [ Type.namedWith [ "Elm" ] "Expression" [] ]
                             )
                         , Type.function
                             [ Type.function
                                   [ Type.list
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                             , Type.var "previousMake_"
                             ]
                             (Type.var "make_")
                         , Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "case_", Type.var "previousMake_" ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomTypeBuilder"
                              [ Type.var "case_", Type.var "make_" ]
                         )
                    )
            }
    , finishCustomType =
        Elm.value
            { importFrom = [ "Elm", "Declare" ]
            , name = "finishCustomType"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Elm", "Declare" ]
                             "CustomTypeBuilder"
                             [ Type.var "make_", Type.var "make_" ]
                         ]
                         (Type.namedWith
                              [ "Elm", "Declare" ]
                              "CustomType"
                              [ Type.var "make_" ]
                         )
                    )
            }
    }