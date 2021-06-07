module Elm.Gen.GraphQL.Engine exposing (arg, decodeId, encodeId, encodeOptionals, enum, field, fieldWith, id_, map, map2, maybeEnum, maybeScalarEncode, moduleName_, mutation, nullable, object, objectWith, optional, query, queryString, recover, select, typeArgument, typeId, typeMutation, typeOptional, typeQuery, typeSelection, union, with)

import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : Elm.Module
moduleName_ =
    Elm.moduleName [ "GraphQL", "Engine" ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ :
    { nullable : Elm.Expression
    , field : Elm.Expression
    , fieldWith : Elm.Expression
    , object : Elm.Expression
    , objectWith : Elm.Expression
    , enum : Elm.Expression
    , maybeEnum : Elm.Expression
    , union : Elm.Expression
    , select : Elm.Expression
    , with : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , recover : Elm.Expression
    , arg : Elm.Expression
    , optional : Elm.Expression
    , query : Elm.Expression
    , mutation : Elm.Expression
    , queryString : Elm.Expression
    , maybeScalarEncode : Elm.Expression
    , encodeId : Elm.Expression
    , decodeId : Elm.Expression
    , encodeOptionals : Elm.Expression
    }
id_ =
    { nullable =
        Elm.valueWith
            moduleName_
            "nullable"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source"
                    , Type.namedWith
                        (Elm.moduleName [ "Maybe" ])
                        "Maybe"
                        [ Type.var "data" ]
                    ]
                )
            )
    , field =
        Elm.valueWith
            moduleName_
            "field"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
    , fieldWith =
        Elm.valueWith
            moduleName_
            "fieldWith"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
    , object =
        Elm.valueWith
            moduleName_
            "object"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "otherSource", Type.var "data" ]
                )
            )
    , objectWith =
        Elm.valueWith
            moduleName_
            "objectWith"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "otherSource", Type.var "data" ]
                )
            )
    , enum =
        Elm.valueWith
            moduleName_
            "enum"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.var "item")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "item" ]
                )
            )
    , maybeEnum =
        Elm.valueWith
            moduleName_
            "maybeEnum"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.var "item")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.namedWith
                        (Elm.moduleName [ "Maybe" ])
                        "Maybe"
                        [ Type.var "item" ]
                    ]
                )
            )
    , union =
        Elm.valueWith
            moduleName_
            "union"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Selection"
                            [ Type.var "source", Type.var "data" ]
                        )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
    , select =
        Elm.valueWith
            moduleName_
            "select"
            (Type.function
                [ Type.var "data" ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
    , with =
        Elm.valueWith
            moduleName_
            "with"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source"
                    , Type.function [ Type.var "a" ] (Type.var "b")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                )
            )
    , map =
        Elm.valueWith
            moduleName_
            "map"
            (Type.function
                [ Type.function [ Type.var "a" ] (Type.var "b")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                )
            )
    , map2 =
        Elm.valueWith
            moduleName_
            "map2"
            (Type.function
                [ Type.function [ Type.var "a", Type.var "b" ] (Type.var "c")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "c" ]
                )
            )
    , recover =
        Elm.valueWith
            moduleName_
            "recover"
            (Type.function
                [ Type.var "recovered"
                , Type.function [ Type.var "data" ] (Type.var "recovered")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "recovered" ]
                )
            )
    , arg =
        Elm.valueWith
            moduleName_
            "arg"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "Json", "Encode" ])
                    "Value"
                    []
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Argument"
                    []
                )
            )
    , optional =
        Elm.valueWith
            moduleName_
            "optional"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Argument"
                    []
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Optional"
                    [ Type.var "arg" ]
                )
            )
    , query =
        Elm.valueWith
            moduleName_
            "query"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Query"
                        []
                    , Type.var "value"
                    ]
                , Type.record
                    [ ( "headers"
                      , Type.namedWith
                            (Elm.moduleName [ "List" ])
                            "List"
                            [ Type.namedWith
                                (Elm.moduleName [ "Http" ])
                                "Header"
                                []
                            ]
                      )
                    , ( "url"
                      , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                      )
                    , ( "timeout"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "Basics" ])
                                "Float"
                                []
                            ]
                      )
                    , ( "tracker"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "String" ])
                                "String"
                                []
                            ]
                      )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Platform", "Cmd" ])
                    "Cmd"
                    [ Type.namedWith
                        (Elm.moduleName [ "Result" ])
                        "Result"
                        [ Type.namedWith (Elm.moduleName [ "Http" ]) "Error" []
                        , Type.var "value"
                        ]
                    ]
                )
            )
    , mutation =
        Elm.valueWith
            moduleName_
            "mutation"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Mutation"
                        []
                    , Type.var "msg"
                    ]
                , Type.record
                    [ ( "headers"
                      , Type.namedWith
                            (Elm.moduleName [ "List" ])
                            "List"
                            [ Type.namedWith
                                (Elm.moduleName [ "Http" ])
                                "Header"
                                []
                            ]
                      )
                    , ( "url"
                      , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                      )
                    , ( "timeout"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "Basics" ])
                                "Float"
                                []
                            ]
                      )
                    , ( "tracker"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "String" ])
                                "String"
                                []
                            ]
                      )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Platform", "Cmd" ])
                    "Cmd"
                    [ Type.namedWith
                        (Elm.moduleName [ "Result" ])
                        "Result"
                        [ Type.namedWith (Elm.moduleName [ "Http" ]) "Error" []
                        , Type.var "msg"
                        ]
                    ]
                )
            )
    , queryString =
        Elm.valueWith
            moduleName_
            "queryString"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith (Elm.moduleName [ "String" ]) "String" [])
            )
    , maybeScalarEncode =
        Elm.valueWith
            moduleName_
            "maybeScalarEncode"
            (Type.function
                [ Type.function
                    [ Type.var "a" ]
                    (Type.namedWith
                        (Elm.moduleName [ "Json", "Encode" ])
                        "Value"
                        []
                    )
                , Type.namedWith
                    (Elm.moduleName [ "Maybe" ])
                    "Maybe"
                    [ Type.var "a" ]
                ]
                (Type.namedWith (Elm.moduleName [ "Json", "Encode" ]) "Value" []
                )
            )
    , encodeId =
        Elm.valueWith
            moduleName_
            "encodeId"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Id"
                    []
                ]
                (Type.namedWith (Elm.moduleName [ "Json", "Decode" ]) "Value" []
                )
            )
    , decodeId =
        Elm.valueWith
            moduleName_
            "decodeId"
            (Type.namedWith
                (Elm.moduleName [ "Json", "Decode" ])
                "Decoder"
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Id"
                    []
                ]
            )
    , encodeOptionals =
        Elm.valueWith
            moduleName_
            "encodeOptionals"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Optional"
                        [ Type.var "arg" ]
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                )
            )
    }


{-| Used in generated code to handle maybes
-}
nullable : Elm.Expression -> Elm.Expression
nullable arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "nullable"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source"
                    , Type.namedWith
                        (Elm.moduleName [ "Maybe" ])
                        "Maybe"
                        [ Type.var "data" ]
                    ]
                )
            )
        )
        [ arg1 ]


{-| -}
field : Elm.Expression -> Elm.Expression -> Elm.Expression
field arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "field"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
fieldWith : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
fieldWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "fieldWith"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
        )
        [ arg1, arg2, arg3 ]


{-| -}
object : Elm.Expression -> Elm.Expression -> Elm.Expression
object arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "object"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "otherSource", Type.var "data" ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
objectWith :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
objectWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "objectWith"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "otherSource", Type.var "data" ]
                )
            )
        )
        [ arg1, arg2, arg3 ]


{-| -}
enum : Elm.Expression -> Elm.Expression
enum arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "enum"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.var "item")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.var "item" ]
                )
            )
        )
        [ arg1 ]


{-| -}
maybeEnum : Elm.Expression -> Elm.Expression
maybeEnum arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "maybeEnum"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.var "item")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Json", "Decode" ])
                    "Decoder"
                    [ Type.namedWith
                        (Elm.moduleName [ "Maybe" ])
                        "Maybe"
                        [ Type.var "item" ]
                    ]
                )
            )
        )
        [ arg1 ]


{-| -}
union : Elm.Expression -> Elm.Expression
union arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "union"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Selection"
                            [ Type.var "source", Type.var "data" ]
                        )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
        )
        [ arg1 ]


{-| -}
typeSelection =
    { annotation =
        \arg0 arg1 -> Type.namedWith moduleName_ "Selection" [ arg0, arg1 ]
    }


{-| -}
select : Elm.Expression -> Elm.Expression
select arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "select"
            (Type.function
                [ Type.var "data" ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                )
            )
        )
        [ arg1 ]


{-| -}
with : Elm.Expression -> Elm.Expression -> Elm.Expression
with arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "with"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source"
                    , Type.function [ Type.var "a" ] (Type.var "b")
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "map"
            (Type.function
                [ Type.function [ Type.var "a" ] (Type.var "b")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                )
            )
        )
        [ arg1 Elm.pass, arg2 ]


{-| -}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "map2"
            (Type.function
                [ Type.function [ Type.var "a", Type.var "b" ] (Type.var "c")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "a" ]
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "b" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "c" ]
                )
            )
        )
        [ arg1 Elm.pass Elm.pass, arg2, arg3 ]


{-| -}
recover :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
recover arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "recover"
            (Type.function
                [ Type.var "recovered"
                , Type.function [ Type.var "data" ] (Type.var "recovered")
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "recovered" ]
                )
            )
        )
        [ arg1, arg2 Elm.pass, arg3 ]


{-| The encoded value and the name of the expected type for this argument
-}
arg : Elm.Expression -> Elm.Expression -> Elm.Expression
arg arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "arg"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "Json", "Encode" ])
                    "Value"
                    []
                , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Argument"
                    []
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
typeOptional =
    { annotation = \arg0 -> Type.namedWith moduleName_ "Optional" [ arg0 ] }


{-|

    Encode the nullability in the argument itself.

-}
optional : Elm.Expression -> Elm.Expression -> Elm.Expression
optional arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "optional"
            (Type.function
                [ Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                , Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Argument"
                    []
                ]
                (Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Optional"
                    [ Type.var "arg" ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
typeQuery : { annotation : Type.Annotation }
typeQuery =
    { annotation = Type.named moduleName_ "Query" }


{-| -}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "query"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Query"
                        []
                    , Type.var "value"
                    ]
                , Type.record
                    [ ( "headers"
                      , Type.namedWith
                            (Elm.moduleName [ "List" ])
                            "List"
                            [ Type.namedWith
                                (Elm.moduleName [ "Http" ])
                                "Header"
                                []
                            ]
                      )
                    , ( "url"
                      , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                      )
                    , ( "timeout"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "Basics" ])
                                "Float"
                                []
                            ]
                      )
                    , ( "tracker"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "String" ])
                                "String"
                                []
                            ]
                      )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Platform", "Cmd" ])
                    "Cmd"
                    [ Type.namedWith
                        (Elm.moduleName [ "Result" ])
                        "Result"
                        [ Type.namedWith (Elm.moduleName [ "Http" ]) "Error" []
                        , Type.var "value"
                        ]
                    ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
typeMutation : { annotation : Type.Annotation }
typeMutation =
    { annotation = Type.named moduleName_ "Mutation" }


{-| -}
mutation : Elm.Expression -> Elm.Expression -> Elm.Expression
mutation arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "mutation"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Mutation"
                        []
                    , Type.var "msg"
                    ]
                , Type.record
                    [ ( "headers"
                      , Type.namedWith
                            (Elm.moduleName [ "List" ])
                            "List"
                            [ Type.namedWith
                                (Elm.moduleName [ "Http" ])
                                "Header"
                                []
                            ]
                      )
                    , ( "url"
                      , Type.namedWith (Elm.moduleName [ "String" ]) "String" []
                      )
                    , ( "timeout"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "Basics" ])
                                "Float"
                                []
                            ]
                      )
                    , ( "tracker"
                      , Type.namedWith
                            (Elm.moduleName [ "Maybe" ])
                            "Maybe"
                            [ Type.namedWith
                                (Elm.moduleName [ "String" ])
                                "String"
                                []
                            ]
                      )
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "Platform", "Cmd" ])
                    "Cmd"
                    [ Type.namedWith
                        (Elm.moduleName [ "Result" ])
                        "Result"
                        [ Type.namedWith (Elm.moduleName [ "Http" ]) "Error" []
                        , Type.var "msg"
                        ]
                    ]
                )
            )
        )
        [ arg1, arg2 ]


{-| -}
queryString : Elm.Expression -> Elm.Expression
queryString arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "queryString"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Selection"
                    [ Type.var "source", Type.var "data" ]
                ]
                (Type.namedWith (Elm.moduleName [ "String" ]) "String" [])
            )
        )
        [ arg1 ]


{-| We can also accept:

  - Enum values (unquoted)
  - custom scalars

But we can define anything else in terms of these:

-}
typeArgument =
    { annotation = Type.named moduleName_ "Argument"
    , argValue =
        \ar0 ar1 ->
            Elm.apply
                (Elm.valueWith
                    moduleName_
                    "ArgValue"
                    (Type.namedWith (Elm.moduleName []) "Argument" [])
                )
                [ ar0, ar1 ]
    , var =
        \ar0 ->
            Elm.apply
                (Elm.valueWith
                    moduleName_
                    "Var"
                    (Type.namedWith (Elm.moduleName []) "Argument" [])
                )
                [ ar0 ]
    }


{-| -}
maybeScalarEncode :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
maybeScalarEncode arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "maybeScalarEncode"
            (Type.function
                [ Type.function
                    [ Type.var "a" ]
                    (Type.namedWith
                        (Elm.moduleName [ "Json", "Encode" ])
                        "Value"
                        []
                    )
                , Type.namedWith
                    (Elm.moduleName [ "Maybe" ])
                    "Maybe"
                    [ Type.var "a" ]
                ]
                (Type.namedWith (Elm.moduleName [ "Json", "Encode" ]) "Value" []
                )
            )
        )
        [ arg1 Elm.pass, arg2 ]


{-| -}
typeId : { annotation : Type.Annotation }
typeId =
    { annotation = Type.named moduleName_ "Id" }


{-| -}
encodeId : Elm.Expression -> Elm.Expression
encodeId arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "encodeId"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "GraphQL", "Engine" ])
                    "Id"
                    []
                ]
                (Type.namedWith (Elm.moduleName [ "Json", "Decode" ]) "Value" []
                )
            )
        )
        [ arg1 ]


{-| -}
decodeId : Elm.Expression
decodeId =
    Elm.valueWith
        moduleName_
        "decodeId"
        (Type.namedWith
            (Elm.moduleName [ "Json", "Decode" ])
            "Decoder"
            [ Type.namedWith (Elm.moduleName [ "GraphQL", "Engine" ]) "Id" [] ]
        )


{-| -}
encodeOptionals : Elm.Expression -> Elm.Expression
encodeOptionals arg1 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "encodeOptionals"
            (Type.function
                [ Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.namedWith
                        (Elm.moduleName [ "GraphQL", "Engine" ])
                        "Optional"
                        [ Type.var "arg" ]
                    ]
                ]
                (Type.namedWith
                    (Elm.moduleName [ "List" ])
                    "List"
                    [ Type.tuple
                        (Type.namedWith
                            (Elm.moduleName [ "String" ])
                            "String"
                            []
                        )
                        (Type.namedWith
                            (Elm.moduleName [ "GraphQL", "Engine" ])
                            "Argument"
                            []
                        )
                    ]
                )
            )
        )
        [ arg1 ]
