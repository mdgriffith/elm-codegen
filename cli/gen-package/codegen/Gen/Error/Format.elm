module Gen.Error.Format exposing (block, cyan, green, grey, moduleName_, red, types_, values_, yellow)

{-| 
@docs moduleName_, block, cyan, yellow, green, red, grey, types_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Error", "Format" ]


{-| An indented block with a newline above and below
-}
block : List Elm.Expression -> Elm.Expression
block arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "block"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
        )
        [ Elm.list arg1 ]


{-| -}
cyan : Elm.Expression -> Elm.Expression
cyan arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "cyan"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
yellow : Elm.Expression -> Elm.Expression
yellow arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "yellow"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
green : Elm.Expression -> Elm.Expression
green arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "green"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
red : Elm.Expression -> Elm.Expression
red arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "red"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


{-| -}
grey : Elm.Expression -> Elm.Expression
grey arg1 =
    Elm.apply
        (Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "grey"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
        )
        [ arg1 ]


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
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "block"
            , annotation =
                Just (Type.function [ Type.list Type.string ] Type.string)
            }
    , cyan =
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "cyan"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , yellow =
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "yellow"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , green =
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "green"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , red =
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "red"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , grey =
        Elm.valueWith
            { importFrom = [ "Error", "Format" ]
            , name = "grey"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    }


