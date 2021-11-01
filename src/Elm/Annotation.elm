module Elm.Annotation exposing
    ( Annotation, var, bool, int, float, string, char, unit
    , named, namedWith
    , maybe, list, tuple, triple, set, dict, result
    , record, extensible
    , function
    , toString
    )

{-|

@docs Annotation, var, bool, int, float, string, char, unit

@docs named, namedWith

@docs maybe, list, tuple, triple, set, dict, result

@docs record, extensible

@docs function

@docs toString

-}

import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer
import Internal.Compiler as Compiler
import Set exposing (Set)


{-| -}
type alias Annotation tipe =
    Compiler.Annotation tipe


{-| -}
toString : Annotation a -> String
toString (Compiler.Annotation ann) =
    Elm.Writer.writeTypeAnnotation (Compiler.nodify ann.annotation)
        |> Elm.Writer.write


{-| A type variable
-}
var : String -> Annotation a
var a =
    Compiler.Annotation
        { annotation = Annotation.GenericType (Compiler.formatValue a)
        , imports = []
        }


{-| -}
bool : Annotation Bool
bool =
    typed [] "Bool" []


{-| -}
int : Annotation Int
int =
    typed [] "Int" []


{-| -}
float : Annotation Float
float =
    typed [] "Float" []


{-| -}
string : Annotation String
string =
    typed [] "String" []


{-| -}
char : Annotation Char
char =
    typed [ "Char" ] "Char" []


{-| -}
unit : Annotation ()
unit =
    Compiler.Annotation
        { annotation = Annotation.Unit
        , imports = []
        }


{-| -}
list : Annotation a -> Annotation (List a)
list inner =
    typed [] "List" [ inner ]


{-| -}
result : Annotation err -> Annotation ok -> Annotation (Result err ok)
result err ok =
    typed [] "Result" [ err, ok ]


{-| -}
tuple : Annotation a -> Annotation b -> Annotation ( a, b )
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
triple : Annotation a -> Annotation b -> Annotation c -> Annotation ( a, b, c )
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
set : Annotation a -> Annotation (Set a)
set setArg =
    typed [ "Set" ] "Set" [ setArg ]


{-| -}
dict : Annotation comparable -> Annotation value -> Annotation (Dict comparable value)
dict keyArg valArg =
    typed [ "Dict" ] "Dict" [ keyArg, valArg ]


{-| -}
maybe : Annotation a -> Annotation (Maybe a)
maybe maybeArg =
    typed [] "Maybe" [ maybeArg ]


type Field
    = Field String (Annotation Whatever)


type Whatever
    = Whatever


type Record
    = Record


{-| -}
record : List Field -> Annotation Record
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
extensible : String -> List Field -> Annotation Record
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



-- {-| -}
-- named : List String -> String -> Annotation
-- named mod name =
--     Compiler.Annotation
--         { annotation =
--             Annotation.Typed
--                 (Compiler.nodify
--                     ( mod, Compiler.formatType name )
--                 )
--                 []
--         , imports = [ mod ]
--         }
-- {-| -}
-- namedWith : List String -> String -> List Annotation -> Annotation
-- namedWith mod name args =
--     Compiler.Annotation
--         { annotation =
--             Annotation.Typed
--                 (Compiler.nodify
--                     ( mod
--                     , Compiler.formatType name
--                     )
--                 )
--                 (Compiler.nodifyAll
--                     (List.map Compiler.getInnerAnnotation
--                         args
--                     )
--                 )
--         , imports =
--             mod
--                 :: List.concatMap Compiler.getAnnotationImports
--                     args
--         }


{-| -}
typed : List String -> String -> List Annotation -> Annotation
typed mod name args =
    Compiler.Annotation
        { annotation =
            Annotation.Typed
                (Compiler.nodify ( mod, Compiler.formatType name ))
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
