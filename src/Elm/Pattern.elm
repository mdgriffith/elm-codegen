module Elm.Pattern exposing
    ( unit, ignore
    , int, string, char
    , SequencePattern(..), addToSequence, initSequence, toUncons, toListPattern
    , tuple, triple
    , CustomPattern(..), customWithParam, initCustom, buildCustom
    , Pattern(..), buildRecordDestructure, initRecordDestructure, withField
    , varPattern
    , newBranch0, newBranch1
    )

{-|


## Exact Matches (No Variables)

@docs unit, ignore


### Literals

@docs int, string, char


## Sequences

@docs SequencePattern, addToSequence, initSequence, toUncons, toListPattern


## Tuples and Triples

@docs tuple, triple


## Custom Types

@docs CustomPattern, customWithParam, initCustom, buildCustom


## Record Destructuring

@docs Pattern, buildRecordDestructure, initRecordDestructure, withField


## Variables

@docs varPattern


## Temporary

@docs newBranch0, newBranch1

-}

import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Syntax.Pattern as Pattern
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index
import Set exposing (Set)


{-| -}
unit : Pattern ()
unit =
    Pattern Pattern.UnitPattern ()


{-| -}
ignore : Pattern ()
ignore =
    Pattern Pattern.AllPattern ()


{-| -}
string : String -> Pattern String
string literalString =
    Pattern (Pattern.StringPattern literalString) literalString


{-| -}
char : Char -> Pattern Char
char literalChar =
    Pattern (Pattern.CharPattern literalChar) literalChar


{-| -}
type RecordDestructure a
    = RecordDestructure (Set String) a


{-| -}
initRecordDestructure : a -> RecordDestructure a
initRecordDestructure combine =
    RecordDestructure Set.empty combine


{-| -}
withField : String -> RecordDestructure (Expression -> b) -> RecordDestructure b
withField newField (RecordDestructure fields combine) =
    let
        ( _, _, exp ) =
            Compiler.var Index.startIndex newField
    in
    RecordDestructure (fields |> Set.insert newField) (combine exp)


{-| -}
buildRecordDestructure : RecordDestructure a -> Pattern a
buildRecordDestructure (RecordDestructure fields destructure) =
    Pattern
        (Pattern.RecordPattern
            (fields
                |> Set.toList
                |> List.map Compiler.nodify
            )
        )
        destructure


{-| -}
type SequencePattern a
    = SequencePattern (List Pattern.Pattern) a


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
toUncons : String -> Type.Annotation -> SequencePattern (Expression -> Expression) -> Pattern Expression
toUncons restName argType (SequencePattern patterns toExp) =
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
toListPattern : SequencePattern a -> Pattern a
toListPattern (SequencePattern patterns toExp) =
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
initSequence : a -> SequencePattern a
initSequence fn =
    SequencePattern [] fn


{-| -}
addToSequence : Pattern a -> SequencePattern (a -> b) -> SequencePattern b
addToSequence (Pattern pattern destructured) (SequencePattern patterns builderFn) =
    SequencePattern
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
