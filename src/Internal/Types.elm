module Internal.Types exposing (appendable, bool, char, comparable, custom, float, function, int, list, string, var)

import Elm.Syntax.Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Format as Format


nodify : a -> Node a
nodify exp =
    Node Range.emptyRange exp


{-|

    This is used as a variable or as a record field.

-}
formatValue : String -> String
formatValue str =
    let
        formatted : String
        formatted =
            if String.toUpper str == str then
                String.toLower str

            else
                String.toLower (String.left 1 str) ++ String.dropLeft 1 str
    in
    Format.sanitize formatted


custom : List String -> String -> List Annotation.TypeAnnotation -> Annotation.TypeAnnotation
custom mod_ name vars =
    Annotation.Typed
        (nodify ( mod_, name ))
        (List.map nodify vars)


list : Annotation.TypeAnnotation -> Annotation.TypeAnnotation
list inner =
    Annotation.Typed
        (nodify ( [], "List" ))
        [ nodify inner
        ]


bool : Annotation.TypeAnnotation
bool =
    Annotation.Typed
        (nodify ( [], "Bool" ))
        []


string : Annotation.TypeAnnotation
string =
    Annotation.Typed
        (nodify ( [], "String" ))
        []


char : Annotation.TypeAnnotation
char =
    Annotation.Typed
        (nodify ( [ "Char" ], "Char" ))
        []


int : Annotation.TypeAnnotation
int =
    Annotation.Typed
        (nodify ( [], "Int" ))
        []


float : Annotation.TypeAnnotation
float =
    Annotation.Typed
        (nodify ( [], "Float" ))
        []


comparable : Annotation.TypeAnnotation
comparable =
    var "comparable"


appendable : Annotation.TypeAnnotation
appendable =
    var "appendable"


var : String -> Annotation.TypeAnnotation
var name =
    Annotation.GenericType (formatValue name)


function : List Annotation.TypeAnnotation -> Annotation.TypeAnnotation -> Annotation.TypeAnnotation
function args return =
    List.foldr
        (\ann fn ->
            Annotation.FunctionTypeAnnotation
                (nodify ann)
                (nodify fn)
        )
        return
        args
