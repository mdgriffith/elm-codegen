module Gen.Elm exposing (alias, and, append, apply, bool, char, comment, cons, customType, declaration, declarationImports, declarationToString, divide, docs, equal, expose, exposeWith, expressionImports, field, file, fileWith, float, fn, fn2, fn3, fn4, fn5, fn6, function, functionAdvanced, functionReduced, get, gt, gte, hex, ifThen, int, intDivide, keep, letIn, list, lt, lte, maybe, minus, moduleName_, multiply, notEqual, or, parse, plus, portIncoming, portOutgoing, power, query, record, signature, skip, slash, string, toString, triple, tuple, types_, unit, unsafe, updateRecord, value, valueFrom, valueWith, values_, variant, variantWith, withDocumentation, withType)

{-| @docs moduleName_, types_, values_, file, bool, int, float, char, string, hex, unit, maybe, list, tuple, triple, withType, record, field, get, updateRecord, letIn, ifThen, apply, comment, declaration, withDocumentation, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, functionAdvanced, customType, variant, variantWith, alias, expose, exposeWith, fileWith, docs, equal, notEqual, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, and, or, keep, skip, slash, query, portIncoming, portOutgoing, parse, unsafe, toString, signature, expressionImports, declarationToString, declarationImports, value, valueFrom, valueWith
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm" ]


types_ :
    { file :
        { annotation : Type.Annotation
        , create :
            { path : Elm.Expression, contents : Elm.Expression }
            -> Elm.Expression
        }
    , expression : { annotation : Type.Annotation }
    , field : { annotation : Type.Annotation }
    , declaration : { annotation : Type.Annotation }
    , variant : { annotation : Type.Annotation }
    }
types_ =
    { file =
        { annotation = Type.namedWith moduleName_ "File" []
        , create =
            \arg ->
                Elm.record
                    [ Elm.field "path" arg.path
                    , Elm.field "contents" arg.contents
                    ]
        }
    , expression = { annotation = Type.namedWith moduleName_ "Expression" [] }
    , field = { annotation = Type.namedWith moduleName_ "Field" [] }
    , declaration = { annotation = Type.namedWith moduleName_ "Declaration" [] }
    , variant = { annotation = Type.namedWith moduleName_ "Variant" [] }
    }


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { file : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , char : Elm.Expression
    , string : Elm.Expression
    , hex : Elm.Expression
    , unit : Elm.Expression
    , maybe : Elm.Expression
    , list : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , withType : Elm.Expression
    , record : Elm.Expression
    , field : Elm.Expression
    , get : Elm.Expression
    , updateRecord : Elm.Expression
    , letIn : Elm.Expression
    , ifThen : Elm.Expression
    , apply : Elm.Expression
    , comment : Elm.Expression
    , declaration : Elm.Expression
    , withDocumentation : Elm.Expression
    , fn : Elm.Expression
    , fn2 : Elm.Expression
    , fn3 : Elm.Expression
    , fn4 : Elm.Expression
    , fn5 : Elm.Expression
    , fn6 : Elm.Expression
    , function : Elm.Expression
    , functionReduced : Elm.Expression
    , functionAdvanced : Elm.Expression
    , customType : Elm.Expression
    , variant : Elm.Expression
    , variantWith : Elm.Expression
    , alias : Elm.Expression
    , expose : Elm.Expression
    , exposeWith : Elm.Expression
    , fileWith : Elm.Expression
    , docs : Elm.Expression
    , equal : Elm.Expression
    , notEqual : Elm.Expression
    , append : Elm.Expression
    , cons : Elm.Expression
    , plus : Elm.Expression
    , minus : Elm.Expression
    , multiply : Elm.Expression
    , divide : Elm.Expression
    , intDivide : Elm.Expression
    , power : Elm.Expression
    , lt : Elm.Expression
    , gt : Elm.Expression
    , lte : Elm.Expression
    , gte : Elm.Expression
    , and : Elm.Expression
    , or : Elm.Expression
    , keep : Elm.Expression
    , skip : Elm.Expression
    , slash : Elm.Expression
    , query : Elm.Expression
    , portIncoming : Elm.Expression
    , portOutgoing : Elm.Expression
    , parse : Elm.Expression
    , unsafe : Elm.Expression
    , toString : Elm.Expression
    , signature : Elm.Expression
    , expressionImports : Elm.Expression
    , declarationToString : Elm.Expression
    , declarationImports : Elm.Expression
    , value : Elm.Expression
    , valueFrom : Elm.Expression
    , valueWith : Elm.Expression
    }
values_ =
    { file =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "file"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.list types_.declaration.annotation
                        ]
                        types_.file.annotation
                    )
            }
    , bool =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "bool"
            , annotation =
                Just (Type.function [ Type.bool ] types_.expression.annotation)
            }
    , int =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "int"
            , annotation =
                Just (Type.function [ Type.int ] types_.expression.annotation)
            }
    , float =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "float"
            , annotation =
                Just (Type.function [ Type.float ] types_.expression.annotation)
            }
    , char =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "char"
            , annotation =
                Just (Type.function [ Type.char ] types_.expression.annotation)
            }
    , string =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.expression.annotation)
            }
    , hex =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "hex"
            , annotation =
                Just (Type.function [ Type.int ] types_.expression.annotation)
            }
    , unit =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "unit"
            , annotation = Just types_.expression.annotation
            }
    , maybe =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.maybe types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
    , list =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
    , tuple =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , triple =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , withType =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "withType"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , record =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.field.annotation ]
                        types_.expression.annotation
                    )
            }
    , field =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.field.annotation
                    )
            }
    , get =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
    , updateRecord =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple Type.string types_.expression.annotation
                            )
                        ]
                        types_.expression.annotation
                    )
            }
    , letIn =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple Type.string types_.expression.annotation
                            )
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , ifThen =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "ifThen"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , apply =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "apply"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , Type.list types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , comment =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "comment"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.declaration.annotation
                    )
            }
    , declaration =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.declaration.annotation
                    )
            }
    , withDocumentation =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "withDocumentation"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.declaration.annotation ]
                        types_.declaration.annotation
                    )
            }
    , fn =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , fn2 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , fn3 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , fn4 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , fn5 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , fn6 =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , function =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
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
                            [ Type.list types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , functionReduced =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.function
                            [ types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , functionAdvanced =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionAdvanced"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , customType =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.list types_.variant.annotation ]
                        types_.declaration.annotation
                    )
            }
    , variant =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "variant"
            , annotation =
                Just (Type.function [ Type.string ] types_.variant.annotation)
            }
    , variantWith =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "variantWith"
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
                        ]
                        types_.variant.annotation
                    )
            }
    , alias =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "alias"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        types_.declaration.annotation
                    )
            }
    , expose =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expose"
            , annotation =
                Just
                    (Type.function
                        [ types_.declaration.annotation ]
                        types_.declaration.annotation
                    )
            }
    , exposeWith =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "exposeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "exposeConstructor", Type.bool )
                            , ( "group", Type.maybe Type.string )
                            ]
                        , types_.declaration.annotation
                        ]
                        types_.declaration.annotation
                    )
            }
    , fileWith =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fileWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.record
                            [ ( "docs"
                              , Type.function
                                    [ Type.list
                                        (Type.record
                                            [ ( "group"
                                              , Type.maybe Type.string
                                              )
                                            , ( "members"
                                              , Type.list Type.string
                                              )
                                            ]
                                        )
                                    ]
                                    (Type.list Type.string)
                              )
                            , ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.list types_.declaration.annotation
                        ]
                        types_.file.annotation
                    )
            }
    , docs =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "docs"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "group", Type.maybe Type.string )
                            , ( "members", Type.list Type.string )
                            ]
                        ]
                        Type.string
                    )
            }
    , equal =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "equal"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , notEqual =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "notEqual"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , append =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , cons =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "cons"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , plus =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , minus =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , multiply =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "multiply"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , divide =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "divide"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , intDivide =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "intDivide"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , power =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "power"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , lt =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lt"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , gt =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gt"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , lte =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lte"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , gte =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gte"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , and =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "and"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , or =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "or"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , keep =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "keep"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , skip =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "skip"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , slash =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , query =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
    , portIncoming =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "portIncoming"
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
                        ]
                        types_.declaration.annotation
                    )
            }
    , portOutgoing =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "portOutgoing"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        types_.declaration.annotation
                    )
            }
    , parse =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.string
                            , Type.record
                                [ ( "declarations"
                                  , Type.list types_.declaration.annotation
                                  )
                                ]
                            ]
                        )
                    )
            }
    , unsafe =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.declaration.annotation
                    )
            }
    , toString =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
    , signature =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "signature"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
    , expressionImports =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expressionImports"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
    , declarationToString =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationToString"
            , annotation =
                Just
                    (Type.function [ types_.declaration.annotation ] Type.string
                    )
            }
    , declarationImports =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationImports"
            , annotation =
                Just
                    (Type.function [ types_.declaration.annotation ] Type.string
                    )
            }
    , value =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.expression.annotation)
            }
    , valueFrom =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueFrom"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        types_.expression.annotation
                    )
            }
    , valueWith =
        Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "importFrom", Type.list Type.string )
                            , ( "name", Type.string )
                            , ( "annotation"
                              , Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                              )
                            ]
                        ]
                        types_.expression.annotation
                    )
            }
    }


{-| Build a file!

    Elm.file [ "My", "Module" ]
        [ Elm.declaration "placeholder"
            (Elm.string "a fancy string!")
        ]

-}
file : List Elm.Expression -> List Elm.Expression -> Elm.Expression
file arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "file"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.list types_.declaration.annotation
                        ]
                        types_.file.annotation
                    )
            }
        )
        [ Elm.list arg1, Elm.list arg2 ]


{-| -}
bool : Elm.Expression -> Elm.Expression
bool arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "bool"
            , annotation =
                Just (Type.function [ Type.bool ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
int : Elm.Expression -> Elm.Expression
int arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "int"
            , annotation =
                Just (Type.function [ Type.int ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
float : Elm.Expression -> Elm.Expression
float arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "float"
            , annotation =
                Just (Type.function [ Type.float ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
char : Elm.Expression -> Elm.Expression
char arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "char"
            , annotation =
                Just (Type.function [ Type.char ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
string : Elm.Expression -> Elm.Expression
string arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
hex : Elm.Expression -> Elm.Expression
hex arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "hex"
            , annotation =
                Just (Type.function [ Type.int ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
unit : Elm.Expression
unit =
    Elm.valueWith
        { importFrom = [ "Elm" ]
        , name = "unit"
        , annotation = Just types_.expression.annotation
        }


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.maybe types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
list : List Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2, arg3 ]


{-| Sometimes you may need to add a manual type annotation.

    import Elm.Annotation as Type

    Elm.value "myString"
        |> Elm.withType (Type.string)

Though be sure elm-prefab isn't already doing this automatically for you!

-}
withType : Elm.Expression -> Elm.Expression -> Elm.Expression
withType arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "withType"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
record : List Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "record"
            , annotation =
                Just
                    (Type.function
                        [ Type.list types_.field.annotation ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1 ]


{-| -}
field : Elm.Expression -> Elm.Expression -> Elm.Expression
field arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.field.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-|

    record
        |> Elm.get "field"

results in

    record.field

-}
get : Elm.Expression -> Elm.Expression -> Elm.Expression
get arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
updateRecord : Elm.Expression -> List Elm.Expression -> Elm.Expression
updateRecord arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "updateRecord"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.list
                            (Type.tuple Type.string types_.expression.annotation
                            )
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| A let block.

Check out `Elm.Let` to add things to it.

    import Elm.Let as Let

    Elm.letIn
        [ ("one", (Elm.int 5))
        , ("two", (Elm.int 10))
        ]
        (Elm.add (Elm.value "one") (Elm.value "two"))

-}
letIn : List Elm.Expression -> Elm.Expression -> Elm.Expression
letIn arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "letIn"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple Type.string types_.expression.annotation
                            )
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-|

    ifThen (Elm.bool True)
        (Elm.string "yes")
        (Elm.string "no")

    if True then
        "yes"

    else
        "no"

-}
ifThen : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
ifThen arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "ifThen"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2, arg3 ]


{-| -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "apply"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , Type.list types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| -}
comment : Elm.Expression -> Elm.Expression
comment arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "comment"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.declaration.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
declaration : Elm.Expression -> Elm.Expression -> Elm.Expression
declaration arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declaration"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.expression.annotation ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| Add documentation to a declaration!
-}
withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
withDocumentation arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "withDocumentation"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, types_.declaration.annotation ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
fn : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
fn arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
fn2 :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
fn3 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
fn3 arg1 arg2 arg3 arg4 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , arg3
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            ]
            (arg4
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
fn4 :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
fn4 arg1 arg2 arg3 arg4 arg5 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , arg3
        , arg4
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            , ( "ar4", Type.named [ "Elm" ] "Expression" )
            ]
            (arg5
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
fn5 :
    Elm.Expression
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
fn5 arg1 arg2 arg3 arg4 arg5 arg6 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , arg3
        , arg4
        , arg5
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            , ( "ar4", Type.named [ "Elm" ] "Expression" )
            , ( "ar5", Type.named [ "Elm" ] "Expression" )
            ]
            (arg6
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar5"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
fn6 :
    Elm.Expression
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
fn6 arg1 arg2 arg3 arg4 arg5 arg6 arg7 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fn6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.function
                            [ types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            , types_.expression.annotation
                            ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , arg3
        , arg4
        , arg5
        , arg6
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            , ( "ar3", Type.named [ "Elm" ] "Expression" )
            , ( "ar4", Type.named [ "Elm" ] "Expression" )
            , ( "ar5", Type.named [ "Elm" ] "Expression" )
            , ( "ar6", Type.named [ "Elm" ] "Expression" )
            ]
            (arg7
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar2"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar3"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar4"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar5"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar6"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-|

        Elm.function
            [ ("firstArg", Nothing)
            , ("secondArg", Just Type.string)
            ]
            (\variables ->
                -- variables is a list of expressions
                case variables of
                    [firstArg, secondArg] ->
                        -- do something with the first and second arg
                    _ ->
                        Elm.unit


            )

-}
function :
    List Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
function arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "function"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
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
                            [ Type.list types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| -}
functionReduced :
    Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
functionReduced arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionReduced"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        , Type.function
                            [ types_.expression.annotation ]
                            types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg3
                (Elm.valueWith
                    { importFrom = []
                    , name = "ar1"
                    , annotation = Just (Type.named [ "Elm" ] "Expression")
                    }
                )
            )
        ]


{-| For when you want the most control over a function being generated.

This is for when:

    1. You want your variable names to be exactly as provided(i.e. you don't want the variable name collision protection)
    2. You know exactly what type each variable should be.

-}
functionAdvanced : List Elm.Expression -> Elm.Expression -> Elm.Expression
functionAdvanced arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "functionAdvanced"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith
                                    [ "Elm", "Annotation" ]
                                    "Annotation"
                                    []
                                )
                            )
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-| A custom type declaration.

    Elm.customType "MyType"
        [ Elm.variant "One"
        , Elm.variantWith "Two" [ Elm.Annotation.list Elm.Annotation.string ]
        ]

Will result in

    type MyType
        = One
        | Two (List String)

-}
customType : Elm.Expression -> List Elm.Expression -> Elm.Expression
customType arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.list types_.variant.annotation ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| -}
variant : Elm.Expression -> Elm.Expression
variant arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "variant"
            , annotation =
                Just (Type.function [ Type.string ] types_.variant.annotation)
            }
        )
        [ arg1 ]


{-| -}
variantWith : Elm.Expression -> List Elm.Expression -> Elm.Expression
variantWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "variantWith"
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
                        ]
                        types_.variant.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| A custom type declaration.

    import Elm.Annotation as Type

    Elm.alias "MyAlias"
        (Type.record
            [ ( "one", Type.string )
            , ( "two", Type.int )
            , ( "three", Type.var "content" )
            ]
        )

Should result in

    type alias MyAlias content =
        { one : String
        , two : Int
        , three : content
        }

-}
alias : Elm.Expression -> Elm.Expression -> Elm.Expression
alias arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "alias"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
expose : Elm.Expression -> Elm.Expression
expose arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expose"
            , annotation =
                Just
                    (Type.function
                        [ types_.declaration.annotation ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
exposeWith :
    { exposeConstructor : Elm.Expression, group : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
exposeWith arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "exposeWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "exposeConstructor", Type.bool )
                            , ( "group", Type.maybe Type.string )
                            ]
                        , types_.declaration.annotation
                        ]
                        types_.declaration.annotation
                    )
            }
        )
        [ Elm.record
            [ Elm.field "exposeConstructor" arg1.exposeConstructor
            , Elm.field "group" arg1.group
            ]
        , arg2
        ]


{-| Same as [file](#file), but you have more control over how the module comment is generated!

Pass in a function that determines how to render a `@doc` comment.

Each exposed item is grouped based on the string used in [exposeWith](#exposeWith)

-}
fileWith :
    List Elm.Expression
    -> { docs : Elm.Expression -> Elm.Expression
    , aliases : List Elm.Expression
    }
    -> List Elm.Expression
    -> Elm.Expression
fileWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "fileWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.record
                            [ ( "docs"
                              , Type.function
                                    [ Type.list
                                        (Type.record
                                            [ ( "group"
                                              , Type.maybe Type.string
                                              )
                                            , ( "members"
                                              , Type.list Type.string
                                              )
                                            ]
                                        )
                                    ]
                                    (Type.list Type.string)
                              )
                            , ( "aliases"
                              , Type.list
                                    (Type.tuple
                                        (Type.list Type.string)
                                        Type.string
                                    )
                              )
                            ]
                        , Type.list types_.declaration.annotation
                        ]
                        types_.file.annotation
                    )
            }
        )
        [ Elm.list arg1
        , Elm.record
            [ Elm.field
                "docs"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.docs
                        (Elm.valueWith
                            { importFrom = []
                            , name = "ar1"
                            , annotation =
                                Just (Type.named [ "Elm" ] "Expression")
                            }
                        )
                    )
                )
            , Elm.field "aliases" (Elm.list arg2.aliases)
            ]
        , Elm.list arg3
        ]


{-| Render a standard docstring.

    @docs one, two, three

-}
docs :
    { group : Elm.Expression, members : List Elm.Expression } -> Elm.Expression
docs arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "docs"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "group", Type.maybe Type.string )
                            , ( "members", Type.list Type.string )
                            ]
                        ]
                        Type.string
                    )
            }
        )
        [ Elm.record
            [ Elm.field "group" arg1.group
            , Elm.field "members" (Elm.list arg1.members)
            ]
        ]


{-| `==`
-}
equal : Elm.Expression -> Elm.Expression -> Elm.Expression
equal arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "equal"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `/=`
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "notEqual"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `++`
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `::`
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "cons"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `+`
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "plus"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `-`
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "minus"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `*`
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "multiply"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `/`
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "divide"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `//`
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "intDivide"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| The to-the-power-of operator `^`
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "power"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `<`
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lt"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `>`
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gt"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `<=`
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "lte"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `>=`
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "gte"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `&&`
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "and"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `||`
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "or"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| used in the `elm/parser` library

`|=`

-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "keep"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `|.`
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "skip"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `</>` used in url parsing
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "slash"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| `<?>` used in url parsing
-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                        [ types_.expression.annotation
                        , types_.expression.annotation
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-|

    import Elm.Annotation as Type

    Elm.portIncoming "receiveMessageFromTheWorld"
        [ Type.string
        , Type.int
        ]

Results in

    port receiveMessageFromTheWorld :
        (String -> Int -> msg)
        -> Sub msg

**Note** You generally only need one incoming and one outgoing port!

If you want to vary the messages going in and out of your app, don't use a huge number of ports, instead write Json encoders and decoders.

This will give you more flexibility in the future and save you having to wire up a bunch of stuff.

**Another note** - You may need to expose your port explicitly using `Elm.expose`

-}
portIncoming : Elm.Expression -> List Elm.Expression -> Elm.Expression
portIncoming arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "portIncoming"
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
                        ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, Elm.list arg2 ]


{-| Create a port that can send messages to the outside world!

    import Elm.Annotation as Type

    Elm.portOutgoing "tellTheWorld" Type.string

will generate

    port tellTheWorld : String -> Cmd msg

-}
portOutgoing : Elm.Expression -> Elm.Expression -> Elm.Expression
portOutgoing arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "portOutgoing"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                        ]
                        types_.declaration.annotation
                    )
            }
        )
        [ arg1, arg2 ]


{-| -}
parse : Elm.Expression -> Elm.Expression
parse arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.string
                            , Type.record
                                [ ( "declarations"
                                  , Type.list types_.declaration.annotation
                                  )
                                ]
                            ]
                        )
                    )
            }
        )
        [ arg1 ]


{-| -}
unsafe : Elm.Expression -> Elm.Expression
unsafe arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "unsafe"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.declaration.annotation
                    )
            }
        )
        [ arg1 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
signature : Elm.Expression -> Elm.Expression
signature arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "signature"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
expressionImports : Elm.Expression -> Elm.Expression
expressionImports arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "expressionImports"
            , annotation =
                Just
                    (Type.function [ types_.expression.annotation ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
declarationToString : Elm.Expression -> Elm.Expression
declarationToString arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationToString"
            , annotation =
                Just
                    (Type.function [ types_.declaration.annotation ] Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
declarationImports : Elm.Expression -> Elm.Expression
declarationImports arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "declarationImports"
            , annotation =
                Just
                    (Type.function [ types_.declaration.annotation ] Type.string
                    )
            }
        )
        [ arg1 ]


{-| -}
value : Elm.Expression -> Elm.Expression
value arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "value"
            , annotation =
                Just
                    (Type.function [ Type.string ] types_.expression.annotation)
            }
        )
        [ arg1 ]


{-| -}
valueFrom : List Elm.Expression -> Elm.Expression -> Elm.Expression
valueFrom arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueFrom"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string, Type.string ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.list arg1, arg2 ]


{-| -}
valueWith :
    { importFrom : List Elm.Expression
    , name : Elm.Expression
    , annotation : Elm.Expression
    }
    -> Elm.Expression
valueWith arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Elm" ]
            , name = "valueWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "importFrom", Type.list Type.string )
                            , ( "name", Type.string )
                            , ( "annotation"
                              , Type.maybe
                                    (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                    )
                              )
                            ]
                        ]
                        types_.expression.annotation
                    )
            }
        )
        [ Elm.record
            [ Elm.field "importFrom" (Elm.list arg1.importFrom)
            , Elm.field "name" arg1.name
            , Elm.field "annotation" arg1.annotation
            ]
        ]


