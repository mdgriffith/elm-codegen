module Internal.Util exposing (..)


import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range exposing (emptyRange)
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Declaration  as Declaration


type Declaration
    = Declaration Expose Declaration.Declaration


{-|-}
expose : Declaration -> Declaration
expose (Declaration _ body) =
    Declaration Exposed body




{-|-}
exposeConstructor : Declaration -> Declaration
exposeConstructor (Declaration metadata body) =
    Declaration ExposedConstructor body



type Module =
    Module ModuleName.ModuleName

type Expose
    = NotExposed
    | Exposed
    | ExposedConstructor


emptyModule : Module
emptyModule =
    inModule []

inModule : List String -> Module
inModule mods =
    Module (List.map formatType mods)


unpack : Module -> ModuleName.ModuleName
unpack (Module name) =
    name


denode : Node a -> a
denode =
    Node.value


denodeAll : List (Node a) -> List a
denodeAll =
    List.map denode


denodeMaybe : Maybe (Node a) -> Maybe a
denodeMaybe =
    Maybe.map denode


nodify : a -> Node a
nodify exp =
    Node emptyRange exp


nodifyAll : List a -> List (Node a)
nodifyAll =
    List.map nodify


nodifyMaybe : Maybe a -> Maybe (Node a)
nodifyMaybe =
    Maybe.map nodify



formatValue : String -> String
formatValue str =
    String.toLower (String.left 1 str) ++ String.dropLeft 1 str



formatType : String -> String
formatType str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str