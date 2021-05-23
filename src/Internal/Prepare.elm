module Internal.Prepare exposing (..)

{-| -}

import Elm.Syntax.Declaration as Declaration
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
import Internal.Compiler as Util


{-| Note, when gathering information, we also rewrite the existing declarations to use the aliases the have if necessary.
-}
type alias Prepared =
    { aliased : List Declaration.Declaration
    , imports : List ( Util.Module, String )
    , exposed : List ( Util.Expose, String )
    }



-- {-|-}
-- prepare :
--     List (Util.Module, String)
--         ->  List Util.Declaration
--         -> Prepared
-- prepare aliases declarations =
--     prepareHelper declarations
--         { aliased = []
--         , imports = aliases
--         , exposed = []
--         }
-- prepareHelper : List Util.Declaration -> Prepared -> Prepared
-- prepareHelper declarations prepared =
--     case declarations of
--         [] ->
--             prepared
--         dec :: remaining ->
--             prepareHelper remaining
--                 (prepareDeclaration prepared dec)
-- prepareDeclaration : Prepared -> Util.Declaration -> Prepared
-- prepareDeclaration prepared (Util.Declaration exposed body) =
--     -- let
--     -- in
--     -- { aliased = prepared.aliased
--     -- , imports = prepared.imports
--     -- , exposed =
--     --     case exposed of
--     --         Util.NotExposed ->
--     --             prepared.exposed
--     --         Util.Exposed ->
--     --             prepared.exposed
--     --         Util.ExposedConstructor ->
--     --             prepared.exposed
--     -- }
--     case body of
--         Declaration.FunctionDeclaration fn ->
--             -- type alias Function =
--             --     { documentation : Maybe (Node Documentation)
--             --     , signature : Maybe (Node Signature)
--             --     , declaration : Node FunctionImplementation
--             --     }
--             { aliased = body :: prepared.aliased
--             , imports = prepared.imports
--             , exposed =
--                 case exposed of
--                     Util.NotExposed ->
--                         prepared.exposed
--                     _ ->
--                         let
--                             functionName = getFunctionName fn
--                         in
--                         (exposed, functionName) :: prepared.exposed
--             }
--         Declaration.AliasDeclaration typeAlias ->
--             prepared
--         Declaration.CustomTypeDeclaration type_ ->
--             prepared
--         Declaration.PortDeclaration sig ->
--             prepared
--         Declaration.InfixDeclaration infix ->
--             prepared
--         Declaration.Destructuring nodePattern nodeExpression ->
--             prepared
-- getFunctionName : Exp.Function -> String
-- getFunctionName fn =
--     case fn.declaration of
--         Node.Node _ dec ->
--             case dec.name of
--                 Node.Node _ name ->
--                     name
-- prepareFunction : Prepared -> Exp.Function -> { prepared : Exp.Function, imports : List (Util.Module, String)  }
-- prepareFunction prepared fn =
--     let
--         prepped =
--             case fn.declaration of
--                 Node.Node range impl ->
--                     let
--                         prepImpl =
--                             case impl.expression of
--                                 Node.Node expRange exp ->
--                                     let
--                                         prepExp = prepareExpression prepared exp
--                                     in
--                                     { prepped = Node.Node expRange prepExp.prepped
--                                     , imports = prepExp.imports
--                                     }
--                     in
--                     { prepped = Node.Node range { impl | expression = (prepImpl.prepped) }
--                     , imports = prepImpl.imports
--                     }
--     in
--     { prepared = { fn | declaration = prepped.prepped  }
--     , imports = prepped.imports
--     }
-- {-|
--     type Expression
--         = UnitExpr
--         | Application (List (Node Expression))
--         | OperatorApplication
--             String
--             InfixDirection
--             (Node Expression)
--             (Node Expression)
--         | FunctionOrValue ModuleName String
--         | IfBlock (Node Expression) (Node Expression) (Node Expression)
--         | PrefixOperator String
--         | Operator String
--         | Integer Int
--         | Hex Int
--         | Floatable Float
--         | Negation (Node Expression)
--         | Literal String
--         | CharLiteral Char
--         | TupledExpression (List (Node Expression))
--         | ParenthesizedExpression (Node Expression)
--         | LetExpression LetBlock
--         | CaseExpression CaseBlock
--         | LambdaExpression Lambda
--         | RecordExpr (List (Node RecordSetter))
--         | ListExpr (List (Node Expression))
--         | RecordAccess (Node Expression) (Node String)
--         | RecordAccessFunction String
--         | RecordUpdateExpression (Node String) (List (Node RecordSetter))
--         | GLSLExpression String
-- -}
-- prepareExpression : Prepared -> b -> { prepped : b, imports : List c }
-- prepareExpression prepared exp =
--     { prepped = exp
--     , imports = []
--     }
