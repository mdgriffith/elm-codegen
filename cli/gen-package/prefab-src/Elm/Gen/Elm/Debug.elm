module Elm.Gen.Elm.Debug exposing (annotation, id_, make_, moduleName_, types_)

{-| @docs moduleName_, types_, make_, annotation, id_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Debug" ]


types_ : {}
types_ =
    {}


make_ : {}
make_ =
    {}


{-| Print out what elm-prefab thinks the type signature is at any given point.
-}
annotation :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
annotation arg1 arg2 arg3 =
    Elm.apply
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "annotation")
        )
        [ Elm.lambdaWith
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg1 (Elm.value "ar1") (Elm.value "ar2"))
        , arg2
        , arg3
        ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ =
    { annotation =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "annotation")
    }


