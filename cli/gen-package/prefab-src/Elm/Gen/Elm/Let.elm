module Elm.Gen.Elm.Let exposing (aliasDeclaration, destructure, function, id_, moduleName_, value)

{-| 
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Let" ]


{-| -}
aliasDeclaration : { annotation : Type.Annotation }
aliasDeclaration =
    { annotation = Type.named moduleName_ "Declaration" }


{-| -}
value : Elm.Expression -> Elm.Expression -> Elm.Expression
value arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "value"
            (Type.function
                [ Type.string, Type.namedWith [ "Elm", "Let" ] "Expression" [] ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
destructure : Elm.Expression -> Elm.Expression -> Elm.Expression
destructure arg1 arg2 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "destructure"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Let" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
        )
        [ arg1, arg2 ]


{-| -}
function : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
function arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueWith
            moduleName_
            "function"
            (Type.function
                [ Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                , Type.namedWith [ "Elm", "Let" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
        )
        [ arg1, arg2, arg3 ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ :
    { value : Elm.Expression
    , destructure : Elm.Expression
    , function : Elm.Expression
    }
id_ =
    { value =
        Elm.valueWith
            moduleName_
            "value"
            (Type.function
                [ Type.string, Type.namedWith [ "Elm", "Let" ] "Expression" [] ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
    , destructure =
        Elm.valueWith
            moduleName_
            "destructure"
            (Type.function
                [ Type.namedWith [ "Elm", "Pattern" ] "Pattern" []
                , Type.namedWith [ "Elm", "Let" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
    , function =
        Elm.valueWith
            moduleName_
            "function"
            (Type.function
                [ Type.string
                , Type.list (Type.namedWith [ "Elm", "Pattern" ] "Pattern" [])
                , Type.namedWith [ "Elm", "Let" ] "Expression" []
                ]
                (Type.namedWith [ "Elm", "Let" ] "Declaration" [])
            )
    }


