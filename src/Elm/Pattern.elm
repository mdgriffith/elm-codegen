module Elm.Pattern exposing
    ( Pattern
    , map
    , unit, ignore
    , int, string, char
    , SequencePattern(..), addToSequence, initSequence, toUncons, toListPattern
    , tuple, triple
    , CustomPattern(..), customWithParam, initCustom, buildCustom
    , variant0, variant1
    , RecordDestructure
    , buildRecordDestructure, initRecordDestructure, withField
    , var
    , aliasAs
    )

{-|

@docs Pattern

@docs map


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


## Variant Helpers

@docs variant0, variant1


## Record Destructuring

@docs RecordDestructure

@docs buildRecordDestructure, initRecordDestructure, withField


## Variables

@docs var


## Alias (`as`)

@docs aliasAs

-}

import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Syntax.Pattern as Pattern
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index
import Internal.Pattern exposing (Pattern(..))
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
variant0 : String -> Pattern ()
variant0 variantName =
    initCustom () variantName
        |> buildCustom


{-| -}
variant1 : String -> Pattern a -> Pattern a
variant1 variantName pattern =
    initCustom (\a -> a) variantName
        |> customWithParam pattern
        |> buildCustom


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
aliasAs : String -> (Expression -> a -> b) -> Pattern a -> Pattern b
aliasAs name combine (Pattern pattern destructure) =
    let
        ( _, _, exp ) =
            Compiler.var Index.startIndex name
    in
    Pattern
        (Pattern.AsPattern
            (Compiler.nodify pattern)
            (Compiler.nodify name)
        )
        (combine exp destructure)


{-| -}
int : Int -> Pattern Int
int value =
    Pattern (Pattern.IntPattern value) value


{-| -}
var : String -> Pattern Expression
var name =
    let
        ( _, _, exp ) =
            Compiler.var Index.startIndex name
    in
    Pattern (Pattern.VarPattern name) exp


{-| -}
map : (a -> b) -> Pattern a -> Pattern b
map mapFn (Pattern patterns destructure) =
    Pattern patterns (mapFn destructure)


{-| -}
toUncons : Pattern rest -> Type.Annotation -> SequencePattern (rest -> combined) -> Pattern combined
toUncons (Pattern restPattern destructureRest) argType (SequencePattern patterns toExp) =
    Pattern
        (patterns
            |> List.foldl
                (\pattern soFar ->
                    Pattern.UnConsPattern (Compiler.nodify pattern) (Compiler.nodify soFar)
                )
                restPattern
        )
        (toExp destructureRest)


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
type alias Pattern a =
    Internal.Pattern.Pattern a
