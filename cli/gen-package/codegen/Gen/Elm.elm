module Gen.Elm exposing (alias, and, append, apply, bool, char, comment, cons, customType, declaration, declarationImports, declarationToString, divide, docs, equal, expose, exposeWith, expressionImports, field, file, fileWith, float, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, get, gt, gte, hex, ifThen, int, intDivide, keep, letIn, list, lt, lte, maybe, minus, moduleName_, multiply, notEqual, or, parse, plus, portIncoming, portOutgoing, power, question, record, signatureString, skip, slash, string, toString, triple, tuple, types_, unit, unsafe, updateRecord, value, valueFrom, values_, variant, variantWith, withDocumentation, withType)

{-| @docs moduleName_, types_, values_, file, bool, int, float, char, string, hex, unit, maybe, list, tuple, triple, withType, record, field, get, updateRecord, letIn, ifThen, apply, comment, declaration, withDocumentation, fn, fn2, fn3, fn4, fn5, fn6, function, functionReduced, customType, variant, variantWith, alias, expose, exposeWith, fileWith, docs, equal, notEqual, append, cons, plus, minus, multiply, divide, intDivide, power, lt, gt, lte, gte, and, or, keep, skip, slash, question, portIncoming, portOutgoing, parse, unsafe, toString, signatureString, expressionImports, declarationToString, declarationImports, value, valueFrom
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
    , question : Elm.Expression
    , portIncoming : Elm.Expression
    , portOutgoing : Elm.Expression
    , parse : Elm.Expression
    , unsafe : Elm.Expression
    , toString : Elm.Expression
    , signatureString : Elm.Expression
    , expressionImports : Elm.Expression
    , declarationToString : Elm.Expression
    , declarationImports : Elm.Expression
    , value : Elm.Expression
    , valueFrom : Elm.Expression
    }
values_ =
    { file =
        Elm.withType
            (Type.function
                [ Type.list Type.string
                , Type.list types_.declaration.annotation
                ]
                types_.file.annotation
            )
            (Elm.valueFrom moduleName_ "file")
    , bool =
        Elm.withType
            (Type.function [ Type.bool ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "bool")
    , int =
        Elm.withType
            (Type.function [ Type.int ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "int")
    , float =
        Elm.withType
            (Type.function [ Type.float ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "float")
    , char =
        Elm.withType
            (Type.function [ Type.char ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "char")
    , string =
        Elm.withType
            (Type.function [ Type.string ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "string")
    , hex =
        Elm.withType
            (Type.function [ Type.int ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "hex")
    , unit =
        Elm.withType
            types_.expression.annotation
            (Elm.valueFrom moduleName_ "unit")
    , maybe =
        Elm.withType
            (Type.function
                [ Type.maybe types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "maybe")
    , list =
        Elm.withType
            (Type.function
                [ Type.list types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "list")
    , tuple =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "tuple")
    , triple =
        Elm.withType
            (Type.function
                [ types_.expression.annotation
                , types_.expression.annotation
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "triple")
    , withType =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "withType")
    , record =
        Elm.withType
            (Type.function
                [ Type.list types_.field.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "record")
    , field =
        Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.field.annotation
            )
            (Elm.valueFrom moduleName_ "field")
    , get =
        Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "get")
    , updateRecord =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.tuple Type.string types_.expression.annotation)
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "updateRecord")
    , letIn =
        Elm.withType
            (Type.function
                [ Type.list
                    (Type.tuple Type.string types_.expression.annotation)
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "letIn")
    , ifThen =
        Elm.withType
            (Type.function
                [ types_.expression.annotation
                , types_.expression.annotation
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "ifThen")
    , apply =
        Elm.withType
            (Type.function
                [ types_.expression.annotation
                , Type.list types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "apply")
    , comment =
        Elm.withType
            (Type.function [ Type.string ] types_.declaration.annotation)
            (Elm.valueFrom moduleName_ "comment")
    , declaration =
        Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "declaration")
    , withDocumentation =
        Elm.withType
            (Type.function
                [ Type.string, types_.declaration.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "withDocumentation")
    , fn =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ types_.expression.annotation ]
                    types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "fn")
    , fn2 =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "fn2")
    , fn3 =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "fn3")
    , fn4 =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "fn4")
    , fn5 =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "fn5")
    , fn6 =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "fn6")
    , function =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "function")
    , functionReduced =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.function
                    [ types_.expression.annotation ]
                    types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "functionReduced")
    , customType =
        Elm.withType
            (Type.function
                [ Type.string, Type.list types_.variant.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "customType")
    , variant =
        Elm.withType
            (Type.function [ Type.string ] types_.variant.annotation)
            (Elm.valueFrom moduleName_ "variant")
    , variantWith =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                types_.variant.annotation
            )
            (Elm.valueFrom moduleName_ "variantWith")
    , alias =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "alias")
    , expose =
        Elm.withType
            (Type.function
                [ types_.declaration.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "expose")
    , exposeWith =
        Elm.withType
            (Type.function
                [ Type.record
                    [ ( "exposeConstructor", Type.bool )
                    , ( "group", Type.maybe Type.string )
                    ]
                , types_.declaration.annotation
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "exposeWith")
    , fileWith =
        Elm.withType
            (Type.function
                [ Type.list Type.string
                , Type.record
                    [ ( "docs"
                      , Type.function
                            [ Type.list
                                (Type.record
                                    [ ( "group", Type.maybe Type.string )
                                    , ( "members", Type.list Type.string )
                                    ]
                                )
                            ]
                            (Type.list Type.string)
                      )
                    , ( "aliases"
                      , Type.list
                            (Type.tuple (Type.list Type.string) Type.string)
                      )
                    ]
                , Type.list types_.declaration.annotation
                ]
                types_.file.annotation
            )
            (Elm.valueFrom moduleName_ "fileWith")
    , docs =
        Elm.withType
            (Type.function
                [ Type.record
                    [ ( "group", Type.maybe Type.string )
                    , ( "members", Type.list Type.string )
                    ]
                ]
                Type.string
            )
            (Elm.valueFrom moduleName_ "docs")
    , equal =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "equal")
    , notEqual =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "notEqual")
    , append =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "append")
    , cons =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "cons")
    , plus =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "plus")
    , minus =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "minus")
    , multiply =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "multiply")
    , divide =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "divide")
    , intDivide =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "intDivide")
    , power =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "power")
    , lt =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "lt")
    , gt =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "gt")
    , lte =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "lte")
    , gte =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "gte")
    , and =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "and")
    , or =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "or")
    , keep =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "keep")
    , skip =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "skip")
    , slash =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "slash")
    , question =
        Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "question")
    , portIncoming =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "portIncoming")
    , portOutgoing =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "portOutgoing")
    , parse =
        Elm.withType
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
            (Elm.valueFrom moduleName_ "parse")
    , unsafe =
        Elm.withType
            (Type.function [ Type.string ] types_.declaration.annotation)
            (Elm.valueFrom moduleName_ "unsafe")
    , toString =
        Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "toString")
    , signatureString =
        Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "signatureString")
    , expressionImports =
        Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "expressionImports")
    , declarationToString =
        Elm.withType
            (Type.function [ types_.declaration.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "declarationToString")
    , declarationImports =
        Elm.withType
            (Type.function [ types_.declaration.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "declarationImports")
    , value =
        Elm.withType
            (Type.function [ Type.string ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "value")
    , valueFrom =
        Elm.withType
            (Type.function
                [ Type.list Type.string, Type.string ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "valueFrom")
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
        (Elm.withType
            (Type.function
                [ Type.list Type.string
                , Type.list types_.declaration.annotation
                ]
                types_.file.annotation
            )
            (Elm.valueFrom moduleName_ "file")
        )
        [ Elm.list arg1, Elm.list arg2 ]


{-| -}
bool : Elm.Expression -> Elm.Expression
bool arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.bool ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "bool")
        )
        [ arg1 ]


{-| -}
int : Elm.Expression -> Elm.Expression
int arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.int ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "int")
        )
        [ arg1 ]


{-| -}
float : Elm.Expression -> Elm.Expression
float arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.float ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "float")
        )
        [ arg1 ]


{-| -}
char : Elm.Expression -> Elm.Expression
char arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.char ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "char")
        )
        [ arg1 ]


{-| -}
string : Elm.Expression -> Elm.Expression
string arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "string")
        )
        [ arg1 ]


{-| -}
hex : Elm.Expression -> Elm.Expression
hex arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.int ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "hex")
        )
        [ arg1 ]


{-| -}
unit : Elm.Expression
unit =
    Elm.withType types_.expression.annotation (Elm.valueFrom moduleName_ "unit")


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.maybe types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "maybe")
        )
        [ arg1 ]


{-| -}
list : List Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.list types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "list")
        )
        [ Elm.list arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "tuple")
        )
        [ arg1, arg2 ]


{-| -}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple arg1 arg2 arg3 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation
                , types_.expression.annotation
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "triple")
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
        (Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "withType")
        )
        [ arg1, arg2 ]


{-| -}
record : List Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.list types_.field.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "record")
        )
        [ Elm.list arg1 ]


{-| -}
field : Elm.Expression -> Elm.Expression -> Elm.Expression
field arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.field.annotation
            )
            (Elm.valueFrom moduleName_ "field")
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
        (Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "get")
        )
        [ arg1, arg2 ]


{-| -}
updateRecord : Elm.Expression -> List Elm.Expression -> Elm.Expression
updateRecord arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.tuple Type.string types_.expression.annotation)
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "updateRecord")
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
        (Elm.withType
            (Type.function
                [ Type.list
                    (Type.tuple Type.string types_.expression.annotation)
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "letIn")
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
        (Elm.withType
            (Type.function
                [ types_.expression.annotation
                , types_.expression.annotation
                , types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "ifThen")
        )
        [ arg1, arg2, arg3 ]


{-| -}
apply : Elm.Expression -> List Elm.Expression -> Elm.Expression
apply arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation
                , Type.list types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "apply")
        )
        [ arg1, Elm.list arg2 ]


{-| -}
comment : Elm.Expression -> Elm.Expression
comment arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] types_.declaration.annotation)
            (Elm.valueFrom moduleName_ "comment")
        )
        [ arg1 ]


{-| -}
declaration : Elm.Expression -> Elm.Expression -> Elm.Expression
declaration arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string, types_.expression.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "declaration")
        )
        [ arg1, arg2 ]


{-| Add documentation to a declaration!
-}
withDocumentation : Elm.Expression -> Elm.Expression -> Elm.Expression
withDocumentation arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string, types_.declaration.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "withDocumentation")
        )
        [ arg1, arg2 ]


{-| -}
fn : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
fn arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.function
                    [ types_.expression.annotation ]
                    types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "fn")
        )
        [ arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "fn2")
        )
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" )
            , ( "ar2", Type.named [ "Elm" ] "Expression" )
            ]
            (arg3
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "fn3")
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
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "fn4")
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
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar4")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "fn5")
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
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar4")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar5")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "fn6")
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
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar2")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar3")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar4")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar5")
                )
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar6")
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
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "function")
        )
        [ Elm.list arg1
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg2
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
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
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.function
                    [ types_.expression.annotation ]
                    types_.expression.annotation
                ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "functionReduced")
        )
        [ arg1
        , arg2
        , Elm.functionAdvanced
            [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
            (arg3
                (Elm.withType
                    (Type.named [ "Elm" ] "Expression")
                    (Elm.value "ar1")
                )
            )
        ]


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
        (Elm.withType
            (Type.function
                [ Type.string, Type.list types_.variant.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "customType")
        )
        [ arg1, Elm.list arg2 ]


{-| -}
variant : Elm.Expression -> Elm.Expression
variant arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] types_.variant.annotation)
            (Elm.valueFrom moduleName_ "variant")
        )
        [ arg1 ]


{-| -}
variantWith : Elm.Expression -> List Elm.Expression -> Elm.Expression
variantWith arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                types_.variant.annotation
            )
            (Elm.valueFrom moduleName_ "variantWith")
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
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "alias")
        )
        [ arg1, arg2 ]


{-| -}
expose : Elm.Expression -> Elm.Expression
expose arg1 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.declaration.annotation ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "expose")
        )
        [ arg1 ]


{-| -}
exposeWith :
    { exposeConstructor : Elm.Expression, group : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
exposeWith arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.record
                    [ ( "exposeConstructor", Type.bool )
                    , ( "group", Type.maybe Type.string )
                    ]
                , types_.declaration.annotation
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "exposeWith")
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
        (Elm.withType
            (Type.function
                [ Type.list Type.string
                , Type.record
                    [ ( "docs"
                      , Type.function
                            [ Type.list
                                (Type.record
                                    [ ( "group", Type.maybe Type.string )
                                    , ( "members", Type.list Type.string )
                                    ]
                                )
                            ]
                            (Type.list Type.string)
                      )
                    , ( "aliases"
                      , Type.list
                            (Type.tuple (Type.list Type.string) Type.string)
                      )
                    ]
                , Type.list types_.declaration.annotation
                ]
                types_.file.annotation
            )
            (Elm.valueFrom moduleName_ "fileWith")
        )
        [ Elm.list arg1
        , Elm.record
            [ Elm.field
                "docs"
                (Elm.functionAdvanced
                    [ ( "ar1", Type.named [ "Elm" ] "Expression" ) ]
                    (arg2.docs
                        (Elm.withType
                            (Type.named [ "Elm" ] "Expression")
                            (Elm.value "ar1")
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
        (Elm.withType
            (Type.function
                [ Type.record
                    [ ( "group", Type.maybe Type.string )
                    , ( "members", Type.list Type.string )
                    ]
                ]
                Type.string
            )
            (Elm.valueFrom moduleName_ "docs")
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
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "equal")
        )
        [ arg1, arg2 ]


{-| `/=`
-}
notEqual : Elm.Expression -> Elm.Expression -> Elm.Expression
notEqual arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "notEqual")
        )
        [ arg1, arg2 ]


{-| `++`
-}
append : Elm.Expression -> Elm.Expression -> Elm.Expression
append arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "append")
        )
        [ arg1, arg2 ]


{-| `::`
-}
cons : Elm.Expression -> Elm.Expression -> Elm.Expression
cons arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "cons")
        )
        [ arg1, arg2 ]


{-| `+`
-}
plus : Elm.Expression -> Elm.Expression -> Elm.Expression
plus arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "plus")
        )
        [ arg1, arg2 ]


{-| `-`
-}
minus : Elm.Expression -> Elm.Expression -> Elm.Expression
minus arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "minus")
        )
        [ arg1, arg2 ]


{-| `*`
-}
multiply : Elm.Expression -> Elm.Expression -> Elm.Expression
multiply arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "multiply")
        )
        [ arg1, arg2 ]


{-| `/`
-}
divide : Elm.Expression -> Elm.Expression -> Elm.Expression
divide arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "divide")
        )
        [ arg1, arg2 ]


{-| `//`
-}
intDivide : Elm.Expression -> Elm.Expression -> Elm.Expression
intDivide arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "intDivide")
        )
        [ arg1, arg2 ]


{-| The to-the-power-of operator `^`
-}
power : Elm.Expression -> Elm.Expression -> Elm.Expression
power arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "power")
        )
        [ arg1, arg2 ]


{-| `<`
-}
lt : Elm.Expression -> Elm.Expression -> Elm.Expression
lt arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "lt")
        )
        [ arg1, arg2 ]


{-| `>`
-}
gt : Elm.Expression -> Elm.Expression -> Elm.Expression
gt arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "gt")
        )
        [ arg1, arg2 ]


{-| `<=`
-}
lte : Elm.Expression -> Elm.Expression -> Elm.Expression
lte arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "lte")
        )
        [ arg1, arg2 ]


{-| `>=`
-}
gte : Elm.Expression -> Elm.Expression -> Elm.Expression
gte arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "gte")
        )
        [ arg1, arg2 ]


{-| `&&`
-}
and : Elm.Expression -> Elm.Expression -> Elm.Expression
and arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "and")
        )
        [ arg1, arg2 ]


{-| `||`
-}
or : Elm.Expression -> Elm.Expression -> Elm.Expression
or arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "or")
        )
        [ arg1, arg2 ]


{-| used in the `elm/parser` library

`|=`

-}
keep : Elm.Expression -> Elm.Expression -> Elm.Expression
keep arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "keep")
        )
        [ arg1, arg2 ]


{-| `|.`
-}
skip : Elm.Expression -> Elm.Expression -> Elm.Expression
skip arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "skip")
        )
        [ arg1, arg2 ]


{-| `</>` used in url parsing
-}
slash : Elm.Expression -> Elm.Expression -> Elm.Expression
slash arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "slash")
        )
        [ arg1, arg2 ]


{-| `<?>` used in url parsing
-}
question : Elm.Expression -> Elm.Expression -> Elm.Expression
question arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ types_.expression.annotation, types_.expression.annotation ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "question")
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
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "portIncoming")
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
        (Elm.withType
            (Type.function
                [ Type.string
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                types_.declaration.annotation
            )
            (Elm.valueFrom moduleName_ "portOutgoing")
        )
        [ arg1, arg2 ]


{-| -}
parse : Elm.Expression -> Elm.Expression
parse arg1 =
    Elm.apply
        (Elm.withType
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
            (Elm.valueFrom moduleName_ "parse")
        )
        [ arg1 ]


{-| -}
unsafe : Elm.Expression -> Elm.Expression
unsafe arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] types_.declaration.annotation)
            (Elm.valueFrom moduleName_ "unsafe")
        )
        [ arg1 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "toString")
        )
        [ arg1 ]


{-| -}
signatureString : Elm.Expression -> Elm.Expression
signatureString arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "signatureString")
        )
        [ arg1 ]


{-| -}
expressionImports : Elm.Expression -> Elm.Expression
expressionImports arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ types_.expression.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "expressionImports")
        )
        [ arg1 ]


{-| -}
declarationToString : Elm.Expression -> Elm.Expression
declarationToString arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ types_.declaration.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "declarationToString")
        )
        [ arg1 ]


{-| -}
declarationImports : Elm.Expression -> Elm.Expression
declarationImports arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ types_.declaration.annotation ] Type.string)
            (Elm.valueFrom moduleName_ "declarationImports")
        )
        [ arg1 ]


{-| -}
value : Elm.Expression -> Elm.Expression
value arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] types_.expression.annotation)
            (Elm.valueFrom moduleName_ "value")
        )
        [ arg1 ]


{-| -}
valueFrom : List Elm.Expression -> Elm.Expression -> Elm.Expression
valueFrom arg1 arg2 =
    Elm.apply
        (Elm.withType
            (Type.function
                [ Type.list Type.string, Type.string ]
                types_.expression.annotation
            )
            (Elm.valueFrom moduleName_ "valueFrom")
        )
        [ Elm.list arg1, arg2 ]


