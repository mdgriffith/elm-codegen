module Gen.Elm.Declare exposing (call_, fn, fn2, fn3, fn4, fn5, fn6, function, moduleName_, value, values_)

{-| 
@docs moduleName_, fn, fn2, fn3, fn4, fn5, fn6, value, function, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Declare" ]


{-| fn: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        )
                    )
            }
        )
        [ Elm.string fnArg, fnArg0, Elm.functionReduced "fnUnpack" fnArg1 ]


{-| fn2: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom :
        List String
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                            (fn3Arg3 functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
        ]


{-| fn4: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , callFrom :
        List String
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                                    (fn4Arg4 functionReducedUnpack
                                         functionReducedUnpack0
                                        functionReducedUnpack_2_1_2_0_2_5_2_0_0
                                    )
                            )
                    )
            )
        ]


{-| fn5: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , callFrom :
        List String
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                                            (fn5Arg5 functionReducedUnpack
                                                 functionReducedUnpack0
                                                 functionReducedUnpack_2_1_2_0_2_6_2_0_0
                                                functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0
                                            )
                                    )
                            )
                    )
            )
        ]


{-| fn6: 
    String
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> ( String, Maybe Elm.Annotation.Annotation )
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , callFrom :
        List String
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                                                    (fn6Arg6
                                                         functionReducedUnpack
                                                         functionReducedUnpack0
                                                         functionReducedUnpack_2_1_2_0_2_7_2_0_0
                                                         functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0
                                                        functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| value: 
    String
    -> Elm.Expression
    -> { declaration : Elm.Declaration
    , value : Elm.Expression
    , valueFrom : List String -> Elm.Expression
    }
-}
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
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "value"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              )
                            , ( "valueFrom"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        )
                    )
            }
        )
        [ Elm.string valueArg, valueArg0 ]


{-| function: 
    String
    -> List ( String, Maybe Elm.Annotation.Annotation )
    -> (List Elm.Expression -> Elm.Expression)
    -> { declaration : Elm.Declaration
    , call : List Elm.Expression -> Elm.Expression
    , callFrom : List String -> List Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
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
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        )
                    )
            }
        )
        [ Elm.string functionArg
        , Elm.list functionArg0
        , Elm.functionReduced "functionUnpack" functionArg1
        ]


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
    , value : Elm.Expression -> Elm.Expression -> Elm.Expression
    , function :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.tuple
                                    Type.string
                                    (Type.maybe
                                        (Type.namedWith
                                            [ "Elm", "Annotation" ]
                                            "Annotation"
                                            []
                                        )
                                    )
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                ]
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                      )
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                [ fn6Arg
                , fn6Arg0
                , fn6Arg1
                , fn6Arg2
                , fn6Arg3
                , fn6Arg4
                , fn6Arg5
                , fn6Arg6
                ]
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
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "value"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      )
                                    , ( "valueFrom"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                                (Type.record
                                    [ ( "declaration"
                                      , Type.namedWith
                                            [ "Elm" ]
                                            "Declaration"
                                            []
                                      )
                                    , ( "call"
                                      , Type.function
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
                                      )
                                    , ( "callFrom"
                                      , Type.function
                                            [ Type.list Type.string
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
                                    , ( "value"
                                      , Type.function
                                            [ Type.list Type.string ]
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
                [ functionArg, functionArg0, functionArg1 ]
    }


values_ :
    { fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fn4 : Elm.Expression
    , fn5 : Elm.Expression
    , fn6 : Elm.Expression
    , value : Elm.Expression
    , function : Elm.Expression
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
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
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.tuple
                            Type.string
                            (Type.maybe
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.namedWith [ "Elm" ] "Expression" [])
                        ]
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
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
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "value"
                              , Type.namedWith [ "Elm" ] "Expression" []
                              )
                            , ( "valueFrom"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        )
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
                        (Type.record
                            [ ( "declaration"
                              , Type.namedWith [ "Elm" ] "Declaration" []
                              )
                            , ( "call"
                              , Type.function
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "callFrom"
                              , Type.function
                                    [ Type.list Type.string
                                    , Type.list
                                        (Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            , ( "value"
                              , Type.function
                                    [ Type.list Type.string ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                              )
                            ]
                        )
                    )
            }
    }