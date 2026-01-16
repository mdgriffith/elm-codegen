module Elm.Annotation exposing
    ( Annotation, var, bool, int, float, string, char, unit
    , cmd, sub
    , named, namedWith
    , maybe, list, tuple, triple, set, dict, result
    , record, extensible, alias
    , function
    , toString
    )

{-|

@docs Annotation, var, bool, int, float, string, char, unit

@docs cmd, sub

@docs named, namedWith

@docs maybe, list, tuple, triple, set, dict, result

@docs record, extensible, alias

@docs function

@docs toString

-}

import Elm.Syntax.TypeAnnotation as Annotation
import Elm.Writer
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index exposing (Index)


{-| -}
type alias Annotation =
    Compiler.Annotation


{-| -}
toString : Annotation -> String
toString (Compiler.Annotation ann) =
    Elm.Writer.writeTypeAnnotation (Compiler.nodify (ann.annotation (Index.startIndex Nothing)))
        |> Elm.Writer.write


{-| A type variable
-}
var : String -> Annotation
var a =
    Compiler.Annotation
        { annotation = \_ -> Annotation.GenericType (Format.formatValue a)
        , imports = []
        , aliases = \_ -> Compiler.emptyAliases
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
        { annotation = \_ -> Annotation.Unit
        , imports = []
        , aliases = \_ -> Compiler.emptyAliases
        }


{-| -}
cmd : Annotation -> Annotation
cmd inner =
    typed [] "Cmd" [ inner ]


{-| -}
sub : Annotation -> Annotation
sub inner =
    typed [] "Sub" [ inner ]


{-| -}
list : Annotation -> Annotation
list inner =
    typed [] "List" [ inner ]


{-| -}
result : Annotation -> Annotation -> Annotation
result err ok =
    typed [] "Result" [ err, ok ]


{-| -}
tuple : Annotation -> Annotation -> Annotation
tuple one two =
    Compiler.Annotation
        { annotation =
            \index ->
                Annotation.Tupled
                    (Compiler.nodifyAll
                        [ Compiler.getInnerAnnotation index one
                        , Compiler.getInnerAnnotation index two
                        ]
                    )
        , imports =
            Compiler.getAnnotationImports one
                ++ Compiler.getAnnotationImports two
        , aliases =
            \index ->
                Compiler.mergeAliases (getAliases index one) (getAliases index two)
        }


getAliases : Index -> Annotation -> Compiler.AliasCache
getAliases index (Compiler.Annotation ann) =
    ann.aliases index


{-| -}
triple : Annotation -> Annotation -> Annotation -> Annotation
triple one two three =
    Compiler.Annotation
        { annotation =
            \index ->
                Annotation.Tupled
                    (Compiler.nodifyAll
                        [ Compiler.getInnerAnnotation index one
                        , Compiler.getInnerAnnotation index two
                        , Compiler.getInnerAnnotation index three
                        ]
                    )
        , imports =
            Compiler.getAnnotationImports one
                ++ Compiler.getAnnotationImports two
                ++ Compiler.getAnnotationImports three
        , aliases =
            \index ->
                Compiler.mergeAliases
                    (Compiler.mergeAliases
                        (getAliases index one)
                        (getAliases index two)
                    )
                    (getAliases index three)
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


{-| The classic example of a Model

    Elm.Annotation.alias []
        "Model"
        []
        (Elm.Annotation.record
            [ ( "hello", Elm.Annotation.string ) ]
        )

would correspond to

    type alias Model =
        { hello : String
        }

-}
alias :
    List String
    -> String
    -> List Annotation
    -> Annotation
    -> Annotation
alias mod name vars target =
    Compiler.Annotation
        { annotation =
            \index ->
                Annotation.Typed
                    (Compiler.nodify
                        ( mod, Format.formatType name )
                    )
                    (List.map (Compiler.nodify << Compiler.getInnerAnnotation index) vars)
        , imports =
            case mod of
                [] ->
                    List.concatMap Compiler.getAnnotationImports vars

                _ ->
                    mod :: List.concatMap Compiler.getAnnotationImports vars
        , aliases =
            \index ->
                List.foldl
                    (\ann aliases ->
                        Compiler.mergeAliases (Compiler.getAliases index ann) aliases
                    )
                    (Compiler.getAliases index target)
                    vars
                    |> Compiler.addAlias mod name index target
        }


{-| -}
record : List ( String, Annotation ) -> Annotation
record fields =
    Compiler.Annotation
        { annotation =
            \index ->
                fields
                    |> List.map
                        (\( name, ann ) ->
                            ( Compiler.nodify (Format.formatValue name)
                            , Compiler.nodify (Compiler.getInnerAnnotation index ann)
                            )
                        )
                    |> Compiler.nodifyAll
                    |> Annotation.Record
        , imports =
            fields
                |> List.concatMap (Tuple.second >> Compiler.getAnnotationImports)
        , aliases =
            \index ->
                List.foldl
                    (\( _, ann ) aliases ->
                        Compiler.mergeAliases (getAliases index ann) aliases
                    )
                    Compiler.emptyAliases
                    fields
        }


{-| -}
extensible : String -> List ( String, Annotation ) -> Annotation
extensible base fields =
    Compiler.Annotation
        { annotation =
            \index ->
                fields
                    |> List.map
                        (\( name, ann ) ->
                            ( Compiler.nodify (Format.formatValue name)
                            , Compiler.nodify (Compiler.getInnerAnnotation index ann)
                            )
                        )
                    |> Compiler.nodifyAll
                    |> Compiler.nodify
                    |> Annotation.GenericRecord (Compiler.nodify (Format.formatValue base))
        , imports =
            fields
                |> List.concatMap (Tuple.second >> Compiler.getAnnotationImports)
        , aliases =
            \index ->
                List.foldl
                    (\( _, ann ) aliases ->
                        Compiler.mergeAliases (getAliases index ann) aliases
                    )
                    Compiler.emptyAliases
                    fields
        }


{-| -}
named : List String -> String -> Annotation
named mod name =
    Compiler.Annotation
        { annotation =
            \index ->
                let
                    importFrom : List String
                    importFrom =
                        Index.getImport index mod
                in
                Annotation.Typed
                    (Compiler.nodify
                        ( importFrom, Format.formatType name )
                    )
                    []
        , imports =
            case mod of
                [] ->
                    []

                _ ->
                    [ mod ]
        , aliases = \_ -> Compiler.emptyAliases
        }


{-| -}
namedWith : List String -> String -> List Annotation -> Annotation
namedWith mod name args =
    Compiler.Annotation
        { annotation =
            \index ->
                let
                    importFrom : List String
                    importFrom =
                        Index.getImport index mod
                in
                Annotation.Typed
                    (Compiler.nodify
                        ( importFrom
                        , Format.formatType name
                        )
                    )
                    (Compiler.nodifyAll
                        (List.map (Compiler.getInnerAnnotation index)
                            args
                        )
                    )
        , imports =
            if List.isEmpty mod then
                List.concatMap Compiler.getAnnotationImports args

            else
                mod :: List.concatMap Compiler.getAnnotationImports args
        , aliases =
            \index ->
                List.foldl
                    (\ann aliases ->
                        Compiler.mergeAliases (getAliases index ann) aliases
                    )
                    Compiler.emptyAliases
                    args
        }


{-| -}
typed : List String -> String -> List Annotation -> Annotation
typed mod name args =
    Compiler.Annotation
        { annotation =
            \index ->
                Annotation.Typed
                    (Compiler.nodify ( mod, name ))
                    (Compiler.nodifyAll
                        (List.map (Compiler.getInnerAnnotation index) args)
                    )
        , imports = List.concatMap Compiler.getAnnotationImports args
        , aliases =
            \index ->
                List.foldl
                    (\ann aliases ->
                        Compiler.mergeAliases (getAliases index ann) aliases
                    )
                    Compiler.emptyAliases
                    args
        }


{-| -}
function : List Annotation -> Annotation -> Annotation
function anns return =
    Compiler.Annotation
        { annotation =
            \index ->
                List.foldr
                    (\ann fn ->
                        Annotation.FunctionTypeAnnotation
                            (Compiler.nodify ann)
                            (Compiler.nodify fn)
                    )
                    (Compiler.getInnerAnnotation index return)
                    (List.map (Compiler.getInnerAnnotation index) anns)
        , imports =
            Compiler.getAnnotationImports return
                ++ List.concatMap Compiler.getAnnotationImports anns
        , aliases =
            \index ->
                List.foldl
                    (\ann aliases ->
                        Compiler.mergeAliases (getAliases index ann) aliases
                    )
                    Compiler.emptyAliases
                    (return :: anns)
        }
