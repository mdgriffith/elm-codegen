module Elm.Pattern exposing
    ( unit
    , UnconsBranch(..), addUncons, startUncons, toUncons, toListPattern
    , tuple, triple
    , CustomPattern(..), customWithParam, initCustom, buildCustom
    , varPattern
    , int
    , newBranch0, newBranch1
    , Pattern(..)
    )

{-|


## Exact Matches (No Variables)

@docs unit


## Uncons

@docs UnconsBranch, addUncons, startUncons, toUncons, toListPattern

@docs Tuples and Triples

@docs tuple, triple


## Custom Types

@docs CustomPattern, customWithParam, initCustom, buildCustom


## Variables

@docs varPattern


## Literals

@docs int


## Temporary

@docs newBranch0, newBranch1

-}

import Dict exposing (Dict)
import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler
import Internal.Debug as Debug
import Internal.Format as Format
import Internal.Index as Index


{-| -}
unit : Pattern ()
unit =
    Pattern Pattern.UnitPattern ()


{-| -}
type UnconsBranch a
    = UnconsBranch (List Pattern.Pattern) a


{-| -}
type CustomPattern a
    = CustomPattern String (List Pattern.Pattern) a


{-| -}
initCustom : a -> String -> CustomPattern a
initCustom a name =
    CustomPattern name [] a


{-| -}
customWithParam : Pattern a -> CustomPattern (a -> b) -> CustomPattern b
customWithParam (Pattern pattern destructure) (CustomPattern name patterns destructureSoFar) =
    CustomPattern name (pattern :: patterns) (destructureSoFar destructure)


{-| -}
buildCustom : CustomPattern a -> Pattern a
buildCustom (CustomPattern name patterns destructure) =
    Pattern
        (Pattern.NamedPattern
            { moduleName = []
            , name = Format.formatType name
            }
            (patterns |> List.map Compiler.nodify)
        )
        destructure


{-| -}
int : Int -> Pattern Int
int value =
    Pattern (Pattern.IntPattern value) value


{-| -}
varPattern : String -> Pattern Expression
varPattern name =
    let
        ( _, _, exp ) =
            Compiler.var Index.startIndex name
    in
    Pattern (Pattern.VarPattern name) exp


{-| -}
toUncons : String -> Type.Annotation -> UnconsBranch (Expression -> Expression) -> Pattern Expression
toUncons restName argType (UnconsBranch patterns toExp) =
    let
        var =
            Compiler.toVarWithType Index.startIndex restName argType

        restPattern : Pattern.Pattern
        restPattern =
            Pattern.VarPattern var.name
    in
    Pattern
        (patterns
            |> List.foldl
                (\pattern soFar ->
                    Pattern.UnConsPattern (Compiler.nodify pattern) (Compiler.nodify soFar)
                )
                restPattern
        )
        (toExp var.exp)


{-| -}
toListPattern : UnconsBranch a -> Pattern a
toListPattern (UnconsBranch patterns toExp) =
    Pattern
        (patterns
            |> List.map
                (\pattern ->
                    Compiler.nodify pattern
                )
            |> Pattern.ListPattern
        )
        toExp


{-| -}
startUncons : a -> UnconsBranch a
startUncons fn =
    UnconsBranch [] fn


{-| -}
addUncons : Pattern a -> UnconsBranch (a -> b) -> UnconsBranch b
addUncons (Pattern pattern destructured) (UnconsBranch patterns builderFn) =
    UnconsBranch
        (pattern :: patterns)
        (builderFn destructured)


{-| -}
tuple :
    Pattern a
    -> Pattern b
    -> Pattern ( a, b )
tuple (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) =
    Pattern
        (Pattern.TuplePattern
            [ Compiler.nodify pattern1
            , Compiler.nodify pattern2
            ]
        )
        ( destructured1, destructured2 )


{-| -}
triple :
    Pattern a
    -> Pattern b
    -> Pattern c
    -> Pattern ( a, b, c )
triple (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) =
    Pattern
        (Pattern.TuplePattern
            [ Compiler.nodify pattern1
            , Compiler.nodify pattern2
            , Compiler.nodify pattern3
            ]
        )
        ( destructured1, destructured2, destructured3 )


{-| -}
type Pattern a
    = Pattern Pattern.Pattern a


{-| -}
newBranch0 : String -> Pattern ()
newBranch0 name =
    Pattern
        (Pattern.NamedPattern { moduleName = [], name = Format.formatType name } [])
        ()


{-| -}
newBranch1 : String -> ( String, Type.Annotation ) -> Pattern Expression
newBranch1 name ( argName, argType ) =
    let
        var : { name : String, exp : Compiler.Expression, index : Index.Index }
        var =
            Compiler.toVarWithType Index.startIndex argName argType
    in
    Pattern
        (Pattern.NamedPattern
            { moduleName = []
            , name = Format.formatType name
            }
            [ Compiler.nodify (Pattern.VarPattern argName) ]
        )
        var.exp
