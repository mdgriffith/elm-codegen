module Elm.Gen.Elm.Debug exposing (annotation, id_, moduleName_)

{-| 
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Debug" ]


{-| Print out what elm-prefab thinks the type signature is at any given point.
-}
annotation :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
annotation arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "annotation"
            (Type.function
                [ Type.function
                    [ Type.string
                    , Type.namedWith
                        [ "Result" ]
                        "Result"
                        [ Type.list
                            (Type.namedWith
                                [ "Internal", "Compiler" ]
                                "InferenceError"
                                []
                            )
                        , Type.namedWith
                            [ "Elm", "Syntax", "TypeAnnotation" ]
                            "TypeAnnotation"
                            []
                        ]
                    ]
                    (Type.namedWith
                        [ "Result" ]
                        "Result"
                        [ Type.list
                            (Type.namedWith
                                [ "Internal", "Compiler" ]
                                "InferenceError"
                                []
                            )
                        , Type.namedWith
                            [ "Elm", "Syntax", "TypeAnnotation" ]
                            "TypeAnnotation"
                            []
                        ]
                    )
                , Type.string
                , Type.namedWith [ "Elm", "Debug" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Debug" ] "Expression" [])
            )
        )
        [ arg1 Elm.pass Elm.pass, arg2, arg3 ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ : { annotation : Elm.Expression }
id_ =
    { annotation =
        Elm.valueWith
            moduleName_
            "annotation"
            (Type.function
                [ Type.function
                    [ Type.string
                    , Type.namedWith
                        [ "Result" ]
                        "Result"
                        [ Type.list
                            (Type.namedWith
                                [ "Internal", "Compiler" ]
                                "InferenceError"
                                []
                            )
                        , Type.namedWith
                            [ "Elm", "Syntax", "TypeAnnotation" ]
                            "TypeAnnotation"
                            []
                        ]
                    ]
                    (Type.namedWith
                        [ "Result" ]
                        "Result"
                        [ Type.list
                            (Type.namedWith
                                [ "Internal", "Compiler" ]
                                "InferenceError"
                                []
                            )
                        , Type.namedWith
                            [ "Elm", "Syntax", "TypeAnnotation" ]
                            "TypeAnnotation"
                            []
                        ]
                    )
                , Type.string
                , Type.namedWith [ "Elm", "Debug" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Debug" ] "Expression" [])
            )
    }


