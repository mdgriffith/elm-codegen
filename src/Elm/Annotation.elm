module Elm.Annotation exposing
    ( Annotation, var, bool, int, float, string, char, unit
    , named, namedWith
    , list, tuple, triple, set, dict, maybe, record, extensible
    )

{-|

@docs Annotation, var, bool, int, float, string, char, unit

@docs named, namedWith

@docs list, tuple, triple, set, dict, maybe, record, extensible

-}

import Elm.Syntax.Declaration as Declaration
import Elm.Syntax.Type as Type
import Elm.Syntax.TypeAlias as TypeAlias
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Util as Util


{-| -}
type alias Annotation =
    Annotation.TypeAnnotation


type alias Declaration =
    Util.Declaration


{-| -}
type alias Module =
    Util.Module


{-| A type variable
-}
var : String -> Annotation
var a =
    Annotation.GenericType (Util.formatValue a)


{-| -}
bool : Annotation
bool =
    typed "Bool" []


{-| -}
int : Annotation
int =
    typed "Int" []


{-| -}
float : Annotation
float =
    typed "Float" []


{-| -}
string : Annotation
string =
    typed "String" []


{-| -}
char : Annotation
char =
    typed "Char" []


{-| -}
unit : Annotation
unit =
    Annotation.Unit


{-| -}
list : Annotation -> Annotation
list inner =
    typed "List" [ inner ]


{-| -}
tuple : Annotation -> Annotation -> Annotation
tuple one two =
    Annotation.Tupled (Util.nodifyAll [ one, two ])


{-| -}
triple : Annotation -> Annotation -> Annotation -> Annotation
triple one two three =
    Annotation.Tupled (Util.nodifyAll [ one, two, three ])


{-| -}
set : Annotation -> Annotation
set setArg =
    typed "Set" [ setArg ]


{-| -}
dict : Annotation -> Annotation -> Annotation
dict keyArg valArg =
    typed "Dict" [ keyArg, valArg ]


{-| -}
maybe : Annotation -> Annotation
maybe maybeArg =
    typed "Maybe" [ maybeArg ]


{-| -}
record : List ( String, Annotation ) -> Annotation
record fields =
    List.map (Tuple.mapBoth Util.nodify Util.nodify) fields
        |> Util.nodifyAll
        |> Annotation.Record


{-| -}
extensible : String -> List ( String, Annotation ) -> Annotation
extensible base fields =
    List.map (Tuple.mapBoth Util.nodify Util.nodify) fields
        |> Util.nodifyAll
        |> Annotation.Record


{-| -}
named : Module -> String -> Annotation
named (Util.Module mod maybeAlias) name =
    case maybeAlias of
        Nothing ->
            Annotation.Typed (Util.nodify ( mod, name )) []

        Just aliasStr ->
            Annotation.Typed (Util.nodify ( [ aliasStr ], name )) []


{-| -}
namedWith : Module -> String -> List Annotation -> Annotation
namedWith (Util.Module mod maybeAlias) name args =
    case maybeAlias of
        Nothing ->
            Annotation.Typed (Util.nodify ( mod, name ))
                (Util.nodifyAll args)

        Just aliasStr ->
            Annotation.Typed (Util.nodify ( [ aliasStr ], name )) (Util.nodifyAll args)


{-| -}
typed : String -> List Annotation -> Annotation
typed name args =
    Annotation.Typed (Util.nodify ( [], name )) (Util.nodifyAll args)
