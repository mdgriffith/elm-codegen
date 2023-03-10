module Elm.Pattern exposing
    ( Pattern
    , map
    , unit, ignore
    , list0, list1, list2, list3, list4, list5, list6, list7, list8, list9
    , int, string, char
    , Sequence, addToSequence, sequence, toUncons, toListPattern
    , tuple, triple
    , CustomType, withVariantParam, customType, buildCustomType
    , variant0, variant1
    , Record
    , buildRecord, record, withField
    , var
    , aliasAs
    )

{-|

@docs Pattern

@docs map


## Exact Matches (No Variables)

@docs unit, ignore


## Lists

@docs list0, list1, list2, list3, list4, list5, list6, list7, list8, list9


### Literals

@docs int, string, char


## Sequences

@docs Sequence, addToSequence, sequence, toUncons, toListPattern


## Tuples and Triples

@docs tuple, triple


## Custom Types

@docs CustomType, withVariantParam, customType, buildCustomType


## Variant Helpers

@docs variant0, variant1


## Record Destructuring

@docs Record

@docs buildRecord, record, withField


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
type Record a
    = Record (Set String) a


{-| -}
record : a -> Record a
record combine =
    Record Set.empty combine


{-| -}
withField : String -> Record (Expression -> b) -> Record b
withField newField (Record fields combine) =
    let
        ( _, _, exp ) =
            Compiler.var Index.startIndex newField
    in
    Record (fields |> Set.insert newField) (combine exp)


{-| -}
variant0 : String -> Pattern ()
variant0 variantName =
    customType () variantName
        |> buildCustomType


{-| -}
variant1 : String -> Pattern a -> Pattern a
variant1 variantName pattern =
    customType (\a -> a) variantName
        |> withVariantParam pattern
        |> buildCustomType


{-| -}
buildRecord : Record a -> Pattern a
buildRecord (Record fields destructure) =
    Pattern
        (Pattern.RecordPattern
            (fields
                |> Set.toList
                |> List.map Compiler.nodify
            )
        )
        destructure


{-| -}
type Sequence a
    = Sequence (List Pattern.Pattern) a


{-| -}
type CustomType a
    = CustomType String (List Pattern.Pattern) a


{-| -}
customType : a -> String -> CustomType a
customType a name =
    CustomType name [] a


{-| -}
withVariantParam : Pattern a -> CustomType (a -> b) -> CustomType b
withVariantParam (Pattern pattern destructure) (CustomType name patterns destructureSoFar) =
    CustomType name (pattern :: patterns) (destructureSoFar destructure)


{-| -}
buildCustomType : CustomType a -> Pattern a
buildCustomType (CustomType name patterns destructure) =
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
toUncons : Pattern rest -> Type.Annotation -> Sequence (rest -> combined) -> Pattern combined
toUncons (Pattern restPattern destructureRest) argType (Sequence patterns toExp) =
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
toListPattern : Sequence a -> Pattern a
toListPattern (Sequence patterns toExp) =
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
sequence : a -> Sequence a
sequence fn =
    Sequence [] fn


{-| -}
list0 : value -> Pattern value
list0 combine =
    Sequence [] combine
        |> toListPattern


{-| -}
list1 : (a -> value) -> Pattern a -> Pattern value
list1 combine (Pattern pattern destructured) =
    Sequence
        [ pattern
        ]
        (combine destructured)
        |> toListPattern


{-| -}
list2 : (a1 -> a2 -> value) -> Pattern a1 -> Pattern a2 -> Pattern value
list2 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) =
    Sequence
        [ pattern1
        , pattern2
        ]
        (combine destructured1 destructured2)
        |> toListPattern


{-| -}
list3 : (a1 -> a2 -> a3 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern value
list3 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        ]
        (combine destructured1 destructured2 destructured3)
        |> toListPattern


{-| -}
list4 : (a1 -> a2 -> a3 -> a4 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern value
list4 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        ]
        (combine destructured1 destructured2 destructured3 destructured4)
        |> toListPattern


{-| -}
list5 : (a1 -> a2 -> a3 -> a4 -> a5 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern a5 -> Pattern value
list5 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) (Pattern pattern5 destructured5) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        , pattern5
        ]
        (combine destructured1 destructured2 destructured3 destructured4 destructured5)
        |> toListPattern


{-| -}
list6 : (a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern a5 -> Pattern a6 -> Pattern value
list6 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) (Pattern pattern5 destructured5) (Pattern pattern6 destructured6) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        , pattern5
        , pattern6
        ]
        (combine destructured1 destructured2 destructured3 destructured4 destructured5 destructured6)
        |> toListPattern


{-| -}
list7 : (a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern a5 -> Pattern a6 -> Pattern a7 -> Pattern value
list7 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) (Pattern pattern5 destructured5) (Pattern pattern6 destructured6) (Pattern pattern7 destructured7) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        , pattern5
        , pattern6
        , pattern7
        ]
        (combine destructured1 destructured2 destructured3 destructured4 destructured5 destructured6 destructured7)
        |> toListPattern


{-| -}
list8 : (a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern a5 -> Pattern a6 -> Pattern a7 -> Pattern a8 -> Pattern value
list8 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) (Pattern pattern5 destructured5) (Pattern pattern6 destructured6) (Pattern pattern7 destructured7) (Pattern pattern8 destructured8) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        , pattern5
        , pattern6
        , pattern7
        , pattern8
        ]
        (combine destructured1 destructured2 destructured3 destructured4 destructured5 destructured6 destructured7 destructured8)
        |> toListPattern


{-| -}
list9 : (a1 -> a2 -> a3 -> a4 -> a5 -> a6 -> a7 -> a8 -> a9 -> value) -> Pattern a1 -> Pattern a2 -> Pattern a3 -> Pattern a4 -> Pattern a5 -> Pattern a6 -> Pattern a7 -> Pattern a8 -> Pattern a9 -> Pattern value
list9 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) (Pattern pattern4 destructured4) (Pattern pattern5 destructured5) (Pattern pattern6 destructured6) (Pattern pattern7 destructured7) (Pattern pattern8 destructured8) (Pattern pattern9 destructured9) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        , pattern4
        , pattern5
        , pattern6
        , pattern7
        , pattern8
        , pattern9
        ]
        (combine destructured1 destructured2 destructured3 destructured4 destructured5 destructured6 destructured7 destructured8 destructured9)
        |> toListPattern


{-| -}
addToSequence : Pattern a -> Sequence (a -> b) -> Sequence b
addToSequence (Pattern pattern destructured) (Sequence patterns builderFn) =
    Sequence
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
