module Elm.Annotation exposing
    ( Annotation, var, bool, int, float, string, char, unit
    , named, namedWith
    , list, tuple, triple, set, dict, maybe, record, extensible
    , function
    , toString
    )

{-|

@docs Annotation, var, bool, int, float, string, char, unit

@docs named, namedWith

@docs list, tuple, triple, set, dict, maybe, record, extensible

@docs function

@docs toString

-}

import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer
import Internal.Compiler as Compiler


{-| -}
type alias Annotation =
    Compiler.Annotation


type alias Declaration =
    Compiler.Declaration


{-| -}
type alias Module =
    Compiler.Module


{-| -}
toString : Annotation -> String
toString (Compiler.Annotation ann) =
    Elm.Writer.writeTypeAnnotation (Compiler.nodify ann.annotation)
        |> Elm.Writer.write


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
    typed [] "Bool" []


{-| -}
int : Annotation
int =
    typed [] "Int" []


{-| -}
float : Annotation
float =
    typed [] "Float" []


{-| -}
string : Annotation
string =
    typed [] "String" []


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
    typed [] "List" [ inner ]


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
    typed [] "Maybe" [ maybeArg ]


{-| -}
record : List ( String, Annotation ) -> Annotation
record fields =
    Compiler.Annotation
        { annotation =
            fields
                |> List.map
                    (\( name, ann ) ->
                        ( Compiler.nodify (Compiler.formatValue name)
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
                |> Annotation.GenericRecord (Compiler.nodify (Compiler.formatValue base))
        , imports =
            fields
                |> List.concatMap (Tuple.second >> Compiler.getAnnotationImports)
        }


{-| -}
named : Module -> String -> Annotation
named mod name =
    Compiler.Annotation
        { annotation =
            Annotation.Typed
                (Compiler.nodify
                    ( Compiler.resolveModuleName mod, Compiler.formatType name )
                )
                []
        , imports = [ mod ]
        }


{-| -}
namedWith : Module -> String -> List Annotation -> Annotation
namedWith mod name args =
    Compiler.Annotation
        { annotation =
            Annotation.Typed (Compiler.nodify ( Compiler.resolveModuleName mod, Compiler.formatType name ))
                (Compiler.nodifyAll
                    (List.map Compiler.getInnerAnnotation
                        args
                    )
                )
        , imports =
            mod
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
