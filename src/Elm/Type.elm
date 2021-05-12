module Elm.Type exposing (..)

{-|-}

import Elm.Syntax.Declaration exposing (Declaration(..))
import Elm.Syntax.Exposing as Expose
import Elm.Syntax.Expression as Exp
import Elm.Syntax.File as File
import Elm.Syntax.Import as Import
import Elm.Syntax.Infix as Infix
import Elm.Syntax.Module as Module
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.Range as Range
import Elm.Syntax.Signature as Signature
import Elm.Syntax.Type as Type
import Elm.Syntax.TypeAlias as TypeAlias
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Util as Util

type alias Annotation =
    Annotation.TypeAnnotation





{-| A `Bool` type annotation.
-}
bool : Annotation
bool =
    typed "Bool" []


{-| An `Int` type annotation.
-}
int : Annotation
int =
    typed "Int" []


{-| A `Float` type annotation.
-}
float : Annotation
float =
    typed "Float" []


{-| A `String` type annotation.
-}
string : Annotation
string =
    typed "String" []


{-| A `Char` type annotation.
-}
char : Annotation
char =
    typed "Char" []



{-|-}
unit : Annotation
unit =
    Annotation.Unit



{-|-}
list : Annotation -> Annotation
list inner =
     typed "List" [ inner ]



{-| 
-}
set : Annotation -> Annotation
set setArg =
    typed "Set" [ setArg ]


{-| 
-}
dict : Annotation -> Annotation -> Annotation
dict keyArg valArg =
    typed "Dict" [ keyArg, valArg ]


{-| Creates a `Maybe` type annotation.
-}
maybe : Annotation -> Annotation
maybe maybeArg =
    typed "Maybe" [ maybeArg ]






{-| 
-}
typed : String -> List Annotation -> Annotation
typed name args =
    Annotation.Typed (Util.nodify ( [], name )) (Util.nodifyAll args)
