module Elm.Gen.Elm.Annotation exposing (bool, char, dict, extensible, float, function, id_, int, list, make_, maybe, moduleName_, named, namedWith, record, result, set, string, toString, triple, tuple, types_, unit, var)

{-| @docs moduleName_, types_, make_, var, bool, int, float, string, char, unit, named, namedWith, maybe, list, tuple, triple, set, dict, result, record, extensible, function, toString, id_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Annotation" ]


types_ : { annotation : Type.Annotation }
types_ =
    { annotation = Type.namedWith moduleName_ "Annotation" [] }


make_ : {}
make_ =
    {}


{-| A type variable
-}
var : Elm.Expression -> Elm.Expression
var arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.string ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "var")
        )
        [ arg1 ]


{-| -}
bool : Elm.Expression
bool =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "bool")


{-| -}
int : Elm.Expression
int =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "int")


{-| -}
float : Elm.Expression
float =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "float")


{-| -}
string : Elm.Expression
string =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "string")


{-| -}
char : Elm.Expression
char =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "char")


{-| -}
unit : Elm.Expression
unit =
    Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
        (Elm.valueFrom moduleName_ "unit")


{-| -}
named : List Elm.Expression -> Elm.Expression -> Elm.Expression
named arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.list Type.string, Type.string ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "named")
        )
        [ Elm.list arg1, arg2 ]


{-| -}
namedWith :
    List Elm.Expression
    -> Elm.Expression
    -> List Elm.Expression
    -> Elm.Expression
namedWith arg1 arg2 arg3 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.list Type.string
                 , Type.string
                 , Type.list
                     (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "namedWith")
        )
        [ Elm.list arg1, arg2, Elm.list arg3 ]


{-| -}
maybe : Elm.Expression -> Elm.Expression
maybe arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "maybe")
        )
        [ arg1 ]


{-| -}
list : Elm.Expression -> Elm.Expression
list arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "list")
        )
        [ arg1 ]


{-| -}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
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
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "triple")
        )
        [ arg1, arg2, arg3 ]


{-| -}
set : Elm.Expression -> Elm.Expression
set arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "set")
        )
        [ arg1 ]


{-| -}
dict : Elm.Expression -> Elm.Expression -> Elm.Expression
dict arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "dict")
        )
        [ arg1, arg2 ]


{-| -}
result : Elm.Expression -> Elm.Expression -> Elm.Expression
result arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "result")
        )
        [ arg1, arg2 ]


{-| -}
record : List Elm.Expression -> Elm.Expression
record arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.list
                     (Type.tuple
                         Type.string
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                     )
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "record")
        )
        [ Elm.list arg1 ]


{-| -}
extensible : Elm.Expression -> List Elm.Expression -> Elm.Expression
extensible arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.string
                 , Type.list
                     (Type.tuple
                         Type.string
                         (Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                         )
                     )
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "extensible")
        )
        [ arg1, Elm.list arg2 ]


{-| -}
function : List Elm.Expression -> Elm.Expression -> Elm.Expression
function arg1 arg2 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.list
                     (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                 , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                 ]
                 (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
             )
            (Elm.valueFrom moduleName_ "function")
        )
        [ Elm.list arg1, arg2 ]


{-| -}
toString : Elm.Expression -> Elm.Expression
toString arg1 =
    Elm.apply
        (Elm.withType
             (Type.function
                 [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                 Type.string
             )
            (Elm.valueFrom moduleName_ "toString")
        )
        [ arg1 ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ =
    { var =
        Elm.withType
            (Type.function
                [ Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "var")
    , bool =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "bool")
    , int =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "int")
    , float =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "float")
    , string =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "string")
    , char =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "char")
    , unit =
        Elm.withType (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            (Elm.valueFrom moduleName_ "unit")
    , named =
        Elm.withType
            (Type.function
                [ Type.list Type.string, Type.string ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "named")
    , namedWith =
        Elm.withType
            (Type.function
                [ Type.list Type.string
                , Type.string
                , Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "namedWith")
    , maybe =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "maybe")
    , list =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "list")
    , tuple =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "tuple")
    , triple =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "triple")
    , set =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "set")
    , dict =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "dict")
    , result =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "result")
    , record =
        Elm.withType
            (Type.function
                [ Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "record")
    , extensible =
        Elm.withType
            (Type.function
                [ Type.string
                , Type.list
                    (Type.tuple
                        Type.string
                        (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                    )
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "extensible")
    , function =
        Elm.withType
            (Type.function
                [ Type.list
                    (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
                , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                ]
                (Type.namedWith [ "Elm", "Annotation" ] "Annotation" [])
            )
            (Elm.valueFrom moduleName_ "function")
    , toString =
        Elm.withType
            (Type.function
                [ Type.namedWith [ "Elm", "Annotation" ] "Annotation" [] ]
                Type.string
            )
            (Elm.valueFrom moduleName_ "toString")
    }


