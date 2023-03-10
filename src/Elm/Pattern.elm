module Elm.Pattern exposing
    ( Pattern
    , var
    , unit, ignore
    , int, string, char
    , tuple, triple
    , err, ok
    , record1, record2, record3, record4, record5, record6, record7, record8, record9
    , map
    , variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9
    , list0, list1, list2, list3, list4, list5, list6, list7, list8, list9
    , Sequence, sequence, addToSequence, toUncons, toListPattern
    , CustomType, withVariantParam, customType, buildCustomType
    , Record
    , buildRecord, record, withField
    , aliasAs
    )

{-|

@docs Pattern


## Variables

@docs var


## Exact Matches (No Variables)

@docs unit, ignore


### Literals

@docs int, string, char


## Tuples and Triples

@docs tuple, triple


## Ok and Err

@docs err, ok


## Record Destructuring

@docs record1, record2, record3, record4, record5, record6, record7, record8, record9


## Mapping

@docs map


## Custom Types

@docs variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9


## Lists

@docs list0, list1, list2, list3, list4, list5, list6, list7, list8, list9


## Sequence Builder

The `list0` through `list9` helpers are the easiest way to define a list pattern. Sometimes you want to pattern match
using the cons operator (`::`). List pattern matches allow you to match an exact number of list items, whereas uncons
pattern matches allow you to match a list with `n` or more items.

@docs Sequence, sequence, addToSequence, toUncons, toListPattern


## Custom Type Builder

These helpers let you define a Custom Type pattern with a builder.

@docs CustomType, withVariantParam, customType, buildCustomType


## Record Builder

@docs Record

@docs buildRecord, record, withField


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


{-| Matches a literal String.

    example =
        Pattern.variant1 "Just" (Pattern.string "admin")
            |> Pattern.map
                (\kind ->
                    Elm.string "This user is an admin!"
                )
            |> Elm.Case.fromPattern

Results in

    case user.kind of
        Just "admin" ->
            "This user is an admin!"

-}
string : String -> Pattern String
string literalString =
    Pattern (Pattern.StringPattern literalString) literalString


{-| Matches a literal Char.
-}
char : Char -> Pattern Char
char literalChar =
    Pattern (Pattern.CharPattern literalChar) literalChar


{-| -}
type Record a
    = Record (Set String) a


{-| -}
record1 :
    (Expression -> combined)
    -> String
    -> Pattern combined
record1 combine field1 =
    record combine
        |> withField field1
        |> buildRecord


{-|

    example =
        Pattern.record2
            (\first last ->
                Elm.Op.append first last
            )
            "first"
            "last"
            |> Elm.Case.fromPattern

Results in

    result =
        case { first = "Jane", last = "Doe" } of
            { first, last } ->
                first ++ last

-}
record2 :
    (Expression -> Expression -> combined)
    -> String
    -> String
    -> Pattern combined
record2 combine field1 field2 =
    record combine
        |> withField field1
        |> withField field2
        |> buildRecord


{-| -}
record3 :
    (Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> Pattern combined
record3 combine field1 field2 field3 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> buildRecord


{-| -}
record4 :
    (Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record4 combine field1 field2 field3 field4 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> buildRecord


{-| -}
record5 :
    (Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record5 combine field1 field2 field3 field4 field5 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> buildRecord


{-| -}
record6 :
    (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record6 combine field1 field2 field3 field4 field5 field6 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> withField field6
        |> buildRecord


{-| -}
record7 :
    (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record7 combine field1 field2 field3 field4 field5 field6 field7 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> withField field6
        |> withField field7
        |> buildRecord


{-| -}
record8 :
    (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record8 combine field1 field2 field3 field4 field5 field6 field7 field8 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> withField field6
        |> withField field7
        |> withField field8
        |> buildRecord


{-| -}
record9 :
    (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Pattern combined
record9 combine field1 field2 field3 field4 field5 field6 field7 field8 field9 =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> withField field6
        |> withField field7
        |> withField field8
        |> withField field9
        |> buildRecord


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
variant2 :
    (value1 -> value2 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern combined
variant2 combine variantName pattern1 pattern2 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> buildCustomType


{-| -}
variant3 :
    (value1 -> value2 -> value3 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern combined
variant3 combine variantName pattern1 pattern2 pattern3 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> buildCustomType


{-| -}
variant4 :
    (value1 -> value2 -> value3 -> value4 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern combined
variant4 combine variantName pattern1 pattern2 pattern3 pattern4 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> buildCustomType


{-| -}
variant5 :
    (value1 -> value2 -> value3 -> value4 -> value5 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern combined
variant5 combine variantName pattern1 pattern2 pattern3 pattern4 pattern5 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> withVariantParam pattern5
        |> buildCustomType


{-| -}
variant6 :
    (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern combined
variant6 combine variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> withVariantParam pattern5
        |> withVariantParam pattern6
        |> buildCustomType


{-| -}
variant7 :
    (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> Pattern combined
variant7 combine variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> withVariantParam pattern5
        |> withVariantParam pattern6
        |> withVariantParam pattern7
        |> buildCustomType


{-| -}
variant8 :
    (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> Pattern value8
    -> Pattern combined
variant8 combine variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 pattern8 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> withVariantParam pattern5
        |> withVariantParam pattern6
        |> withVariantParam pattern7
        |> withVariantParam pattern8
        |> buildCustomType


{-| -}
variant9 :
    (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> value9 -> combined)
    -> String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> Pattern value8
    -> Pattern value9
    -> Pattern combined
variant9 combine variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 pattern8 pattern9 =
    customType combine variantName
        |> withVariantParam pattern1
        |> withVariantParam pattern2
        |> withVariantParam pattern3
        |> withVariantParam pattern4
        |> withVariantParam pattern5
        |> withVariantParam pattern6
        |> withVariantParam pattern7
        |> withVariantParam pattern8
        |> withVariantParam pattern9
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


{-| Pattern match with a literal Int.

    example =
        Pattern.variant1 "Just" (Pattern.int 2)

Results in

    case value of
        Just 2 ->
            2

-}
int : Int -> Pattern Int
int value =
    Pattern (Pattern.IntPattern value) value


{-| This is the most basic kind of pattern - it matches anything and gives it a variable name.

    example =
        Pattern.variant1 "Username"
            (Pattern.var "username")
            |> Pattern.map
                (\username ->
                    Elm.Op.append
                        (Elm.string "Hello ")
                        username
                )
            |> Elm.Case.fromPattern

-}
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


{-| Matches an empty List.

    example =
        Pattern.list0
            (Elm.string "Zero")
            |> Elm.Case.fromPattern

Results in

    case value of
        [] -> "Zero

-}
list0 : value -> Pattern value
list0 combine =
    Sequence [] combine
        |> toListPattern


{-| -}
list1 : (a -> combined) -> Pattern a -> Pattern combined
list1 combine (Pattern pattern destructured) =
    Sequence
        [ pattern
        ]
        (combine destructured)
        |> toListPattern


{-| -}
list2 : (value1 -> value2 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern combined
list2 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) =
    Sequence
        [ pattern1
        , pattern2
        ]
        (combine destructured1 destructured2)
        |> toListPattern


{-| -}
list3 : (value1 -> value2 -> value3 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern combined
list3 combine (Pattern pattern1 destructured1) (Pattern pattern2 destructured2) (Pattern pattern3 destructured3) =
    Sequence
        [ pattern1
        , pattern2
        , pattern3
        ]
        (combine destructured1 destructured2 destructured3)
        |> toListPattern


{-| -}
list4 : (value1 -> value2 -> value3 -> value4 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern combined
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
list5 : (value1 -> value2 -> value3 -> value4 -> value5 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern value5 -> Pattern combined
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
list6 : (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern value5 -> Pattern value6 -> Pattern combined
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
list7 : (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern value5 -> Pattern value6 -> Pattern value7 -> Pattern combined
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
list8 : (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern value5 -> Pattern value6 -> Pattern value7 -> Pattern value8 -> Pattern combined
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
list9 : (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> value9 -> combined) -> Pattern value1 -> Pattern value2 -> Pattern value3 -> Pattern value4 -> Pattern value5 -> Pattern value6 -> Pattern value7 -> Pattern value8 -> Pattern value9 -> Pattern combined
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


{-| `Ok` variant. A simple helper of `variant1 "Ok"`.
-}
ok : Pattern a -> Pattern a
ok =
    variant1 "Ok"


{-| `Err` variant. A simple helper of `variant1 "Err"`.
-}
err : Pattern a -> Pattern a
err =
    variant1 "Err"


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


{-| A Pattern in Elm is an expression that lets you pattern match.

Pattern matching is used for both control flow and for defining variables. For example, in the case where you have an `Admin` user
you might want to use the `id` field from a record in the `Admin` variant:

    type User
        = Admin { id : AdminId, name : String }
        | Guest
        | RegularUser { id : Id, name : String }

    maybeAdminId user =
        case user of
            Admin { id } ->
                Just id

            _ ->
                Nothing

The `Pattern` type represents one of these expressions. In Elm's syntax, patterns can be used in 3 places:

  - Case expressions ([`Elm.Case.fromPattern`](Elm-Case#fromPattern))
  - Let expressions ([`Elm.Let.destructure`](Elm-Let#destructure))
  - Function parameters (can't currently use `Elm.Pattern.Pattern`'s for function parameters in `elm-codegen`)

-}
type alias Pattern a =
    Internal.Pattern.Pattern a
