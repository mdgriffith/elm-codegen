module Gen.Error.Format exposing (block, cyan, green, grey, moduleName_, red, types_, values_, yellow)

{-| @docs moduleName_, types_, values_, block, cyan, yellow, green, red, grey
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Error", "Format" ]


types_ : {}
types_ =
    {}


{-| Every value/function in this module in case you need to refer to it directly. -}
values_ :
    { block : Elm.Expression
    , cyan : Elm.Expression
    , yellow : Elm.Expression
    , green : Elm.Expression
    , red : Elm.Expression
    , grey : Elm.Expression
    }
values_ =
    { block =
        Elm.withType
            (Type.function [ Type.list Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "block")
    , cyan =
        Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "cyan")
    , yellow =
        Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "yellow")
    , green =
        Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "green")
    , red =
        Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "red")
    , grey =
        Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "grey")
    }


{-| An indented block with a newline above and below
-}
block : List Elm.Expression -> Elm.Expression
block arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.list Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "block")
        )
        [ Elm.list arg1 ]


{-| -}
cyan : Elm.Expression -> Elm.Expression
cyan arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "cyan")
        )
        [ arg1 ]


{-| -}
yellow : Elm.Expression -> Elm.Expression
yellow arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "yellow")
        )
        [ arg1 ]


{-| -}
green : Elm.Expression -> Elm.Expression
green arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "green")
        )
        [ arg1 ]


{-| -}
red : Elm.Expression -> Elm.Expression
red arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "red")
        )
        [ arg1 ]


{-| -}
grey : Elm.Expression -> Elm.Expression
grey arg1 =
    Elm.apply
        (Elm.withType
            (Type.function [ Type.string ] Type.string)
            (Elm.valueFrom moduleName_ "grey")
        )
        [ arg1 ]


