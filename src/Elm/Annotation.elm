module Elm.Annotation exposing
    ( Annotation, var, bool, int, float, string, char, unit
    , named, namedWith
    , list, tuple, triple, set, dict, maybe, record, extensible
    , function
    )

{-|

@docs Annotation, var, bool, int, float, string, char, unit

@docs named, namedWith

@docs list, tuple, triple, set, dict, maybe, record, extensible

@docs function

-}

import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler


{-| -}
type alias Annotation =
    Compiler.Annotation


type alias Declaration =
    Compiler.Declaration


{-| -}
type alias Module =
    Compiler.Module


{-| A type variable
-}
var : String -> Annotation
var a =
    Compiler.Annotation
        { annotation = Annotation.GenericType (Compiler.formatValue a)
        , imports = []
        }


{-| -}
bool : Annotation
bool =
    typed [ "Basics" ] "Bool" []


{-| -}
int : Annotation
int =
    typed [ "Basics" ] "Int" []


{-| -}
float : Annotation
float =
    typed [ "Basics" ] "Float" []


{-| -}
string : Annotation
string =
    typed [ "String" ] "String" []


{-| -}
char : Annotation
char =
    typed [ "Char" ] "Char" []


{-| -}
unit : Annotation
unit =
    Compiler.Annotation
        { annotation = Annotation.Unit
        , imports = []
        }


{-| -}
list : Annotation -> Annotation
list inner =
    typed [ "List" ] "List" [ inner ]


{-| -}
tuple : Annotation -> Annotation -> Annotation
tuple one two =
    Compiler.Annotation
        { annotation =
            Annotation.Tupled
                (Compiler.nodifyAll
                    [ Compiler.getInnerAnnotation one
                    , Compiler.getInnerAnnotation two
                    ]
                )
        , imports =
            Compiler.getAnnotationImports one
                ++ Compiler.getAnnotationImports two
        }


{-| -}
triple : Annotation -> Annotation -> Annotation -> Annotation
triple one two three =
    Compiler.Annotation
        { annotation =
            Annotation.Tupled
                (Compiler.nodifyAll
                    [ Compiler.getInnerAnnotation one
                    , Compiler.getInnerAnnotation two
                    , Compiler.getInnerAnnotation three
                    ]
                )
        , imports =
            Compiler.getAnnotationImports one
                ++ Compiler.getAnnotationImports two
                ++ Compiler.getAnnotationImports three
        }


{-| -}
set : Annotation -> Annotation
set setArg =
    typed [ "Set" ] "Set" [ setArg ]


{-| -}
dict : Annotation -> Annotation -> Annotation
dict keyArg valArg =
    typed [ "Dict" ] "Dict" [ keyArg, valArg ]


{-| -}
maybe : Annotation -> Annotation
maybe maybeArg =
    typed [ "Maybe" ] "Maybe" [ maybeArg ]


{-| -}
record : List ( String, Annotation ) -> Annotation
record fields =
    Compiler.Annotation
        { annotation =
            fields
                |> List.map
                    (\( name, ann ) ->
                        ( Compiler.nodify name
                        , Compiler.nodify (Compiler.getInnerAnnotation ann)
                        )
                    )
                |> Compiler.nodifyAll
                |> Annotation.Record
        , imports =
            fields
                |> List.concatMap (Tuple.second >> Compiler.getAnnotationImports)
        }


{-| -}
extensible : String -> List ( String, Annotation ) -> Annotation
extensible base fields =
    Compiler.Annotation
        { annotation =
            fields
                |> List.map
                    (\( name, ann ) ->
                        ( Compiler.nodify name
                        , Compiler.nodify (Compiler.getInnerAnnotation ann)
                        )
                    )
                |> Compiler.nodifyAll
                |> Compiler.nodify
                |> Annotation.GenericRecord (Compiler.nodify base)
        , imports =
            fields
                |> List.concatMap (Tuple.second >> Compiler.getAnnotationImports)
        }


{-| -}
named : Module -> String -> Annotation
named ((Compiler.Module mod maybeAlias) as fullMod) name =
    Compiler.Annotation
        { annotation =
            case maybeAlias of
                Nothing ->
                    Annotation.Typed (Compiler.nodify ( mod, name )) []

                Just aliasStr ->
                    Annotation.Typed (Compiler.nodify ( [ aliasStr ], name )) []
        , imports = [ fullMod ]
        }


{-| -}
namedWith : Module -> String -> List Annotation -> Annotation
namedWith ((Compiler.Module mod maybeAlias) as fullMod) name args =
    case maybeAlias of
        Nothing ->
            Compiler.Annotation
                { annotation =
                    Annotation.Typed (Compiler.nodify ( mod, name ))
                        (Compiler.nodifyAll
                            (List.map Compiler.getInnerAnnotation
                                args
                            )
                        )
                , imports =
                    fullMod
                        :: List.concatMap Compiler.getAnnotationImports
                            args
                }

        Just aliasStr ->
            Compiler.Annotation
                { annotation =
                    Annotation.Typed (Compiler.nodify ( [ aliasStr ], name ))
                        (Compiler.nodifyAll
                            (List.map Compiler.getInnerAnnotation
                                args
                            )
                        )
                , imports =
                    fullMod
                        :: List.concatMap Compiler.getAnnotationImports
                            args
                }


{-| -}
typed : List String -> String -> List Annotation -> Annotation
typed mod name args =
    Compiler.Annotation
        { annotation =
            Annotation.Typed
                (Compiler.nodify ( mod, name ))
                (Compiler.nodifyAll
                    (List.map Compiler.getInnerAnnotation args)
                )
        , imports = List.concatMap Compiler.getAnnotationImports args
        }


{-| -}
function : List Annotation -> Annotation -> Annotation
function anns return =
    Compiler.Annotation
        { annotation =
            List.foldr
                (\ann fn ->
                    Annotation.FunctionTypeAnnotation
                        (Compiler.nodify ann)
                        (Compiler.nodify fn)
                )
                (Compiler.getInnerAnnotation return)
                (List.map Compiler.getInnerAnnotation anns)
        , imports =
            Compiler.getAnnotationImports return
                ++ List.concatMap Compiler.getAnnotationImports anns
        }
