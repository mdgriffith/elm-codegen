module Elm.Case.Branch exposing
    ( Branch, Pattern, map
    , var
    , unit, ignore
    , int, string, char
    , tuple, triple
    , list, listWithRemaining
    , just, nothing
    , err, ok
    , record0, record1, record2, record3, record4, record5, record6, record7, record8, record9
    , variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9
    , CustomType, customType, withParam, toPattern
    , aliasAs
    )

{-|

@docs Branch, Pattern, map


## Variables

@docs var


## Exact Matches (No Variables)

@docs unit, ignore


### Literals

@docs int, string, char


## Tuples and Triples

@docs tuple, triple


## Lists

@docs list, listWithRemaining


## Maybe

@docs just, nothing


## Result

@docs err, ok


## Records

@docs record0, record1, record2, record3, record4, record5, record6, record7, record8, record9


## Custom Types

@docs variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9


## Custom Type Builder

These helpers let you define a Custom Type pattern with a builder.

@docs CustomType, customType, withParam, toPattern


## Alias (`as`)

@docs aliasAs

-}

import Elm exposing (Expression)
import Elm.Annotation as Type
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Pattern as Pattern
import Internal.Branch as Branch exposing (Pattern(..))
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index
import Set exposing (Set)


{-| -}
type alias Branch =
    Branch.Branch


{-| -}
type alias Pattern a =
    Branch.Pattern a


{-| -}
unit : Pattern ()
unit =
    Branch.pattern Pattern.UnitPattern ()


{-| -}
ignore : Pattern ()
ignore =
    Branch.pattern Pattern.AllPattern ()


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
    Branch.pattern (Pattern.StringPattern literalString) literalString


{-| Matches a literal Char.
-}
char : Char -> Pattern Char
char literalChar =
    Branch.pattern (Pattern.CharPattern literalChar) literalChar


{-| -}
type Record a
    = Record (Index.Index -> ( Index.Index, Set String, a ))


{-| -}
record0 : record -> Pattern record
record0 value =
    record value
        |> buildRecord


{-| -}
record1 :
    (Expression -> record)
    -> String
    -> Pattern record
record1 combine field1 =
    record combine
        |> withField field1
        |> buildRecord


{-|

    example =
        Elm.Case.Branch.record2 "first" "last" <|
            \first last ->
                Elm.Op.append first last

Results in

    result =
        case { first = "Jane", last = "Doe" } of
            { first, last } ->
                first ++ last

-}
record2 :
    String
    -> String
    -> (Expression -> Expression -> combined)
    -> Pattern combined
record2 field1 field2 combine =
    record combine
        |> withField field1
        |> withField field2
        |> buildRecord


{-| -}
record3 :
    String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record3 field1 field2 field3 combine =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> buildRecord


{-| -}
record4 :
    String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record4 field1 field2 field3 field4 combine =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> buildRecord


{-| -}
record5 :
    String
    -> String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record5 field1 field2 field3 field4 field5 combine =
    record combine
        |> withField field1
        |> withField field2
        |> withField field3
        |> withField field4
        |> withField field5
        |> buildRecord


{-| -}
record6 :
    String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record6 field1 field2 field3 field4 field5 field6 combine =
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
    String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record7 field1 field2 field3 field4 field5 field6 field7 combine =
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
    String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record8 field1 field2 field3 field4 field5 field6 field7 field8 combine =
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
    String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> (Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> Expression -> combined)
    -> Pattern combined
record9 field1 field2 field3 field4 field5 field6 field7 field8 field9 combine =
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
record initial =
    Record
        (\index ->
            ( index
            , Set.empty
            , initial
            )
        )


{-| -}
withField : String -> Record (Expression -> b) -> Record b
withField newField (Record toRecord) =
    Record
        (\index ->
            let
                ( newIndex, existingFields, recordBuilder ) =
                    toRecord index

                new =
                    Compiler.toVarExactName newIndex newField
            in
            ( new.index
            , Set.insert new.name existingFields
            , recordBuilder new.val
            )
        )


{-| -}
buildRecord : Record a -> Pattern a
buildRecord (Record toRecord) =
    Branch.Branch
        (\index ->
            let
                ( newIndex, fields, value ) =
                    toRecord index
            in
            ( newIndex
            , Pattern.RecordPattern
                (fields
                    |> Set.toList
                    |> List.map Compiler.nodify
                )
            , value
            )
        )


{-| -}
type CustomType a
    = CustomType
        (Index.Index
         ->
            { index : Index.Index
            , base : String
            , patterns : List Pattern.Pattern
            , value : a
            }
        )


{-| -}
customType : String -> a -> CustomType a
customType name initial =
    CustomType
        (\index ->
            { index = index
            , base = name
            , patterns = []
            , value = initial
            }
        )


{-| -}
withParam : Pattern a -> CustomType (a -> b) -> CustomType b
withParam (Branch toBranch) (CustomType toCustomType) =
    CustomType
        (\index ->
            let
                ( newIndex, pattern, val ) =
                    toBranch index

                custom =
                    toCustomType newIndex
            in
            { index = custom.index
            , base = custom.base
            , patterns = pattern :: custom.patterns
            , value = custom.value val
            }
        )


{-| -}
toPattern : CustomType a -> Pattern a
toPattern (CustomType toCustomType) =
    Branch.Branch
        (\index ->
            let
                custom =
                    toCustomType index
            in
            ( custom.index
            , Pattern.NamedPattern
                { moduleName = []
                , name = Format.formatType custom.base
                }
                (reverseAndNodify
                    custom.patterns
                )
            , custom.value
            )
        )


{-| -}
variant0 : String -> value -> Pattern value
variant0 variantName value =
    customType variantName value
        |> toPattern


{-| -}
variant1 : String -> Pattern a -> Pattern a
variant1 variantName pattern =
    customType variantName (\a -> a)
        |> withParam pattern
        |> toPattern


{-| -}
variant2 :
    String
    -> Pattern value1
    -> Pattern value2
    -> (value1 -> value2 -> combined)
    -> Pattern combined
variant2 variantName pattern1 pattern2 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> toPattern


{-| -}
variant3 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> (value1 -> value2 -> value3 -> combined)
    -> Pattern combined
variant3 variantName pattern1 pattern2 pattern3 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> toPattern


{-| -}
variant4 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> (value1 -> value2 -> value3 -> value4 -> combined)
    -> Pattern combined
variant4 variantName pattern1 pattern2 pattern3 pattern4 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> toPattern


{-| -}
variant5 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> combined)
    -> Pattern combined
variant5 variantName pattern1 pattern2 pattern3 pattern4 pattern5 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> withParam pattern5
        |> toPattern


{-| -}
variant6 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> combined)
    -> Pattern combined
variant6 variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> withParam pattern5
        |> withParam pattern6
        |> toPattern


{-| -}
variant7 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> combined)
    -> Pattern combined
variant7 variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> withParam pattern5
        |> withParam pattern6
        |> withParam pattern7
        |> toPattern


{-| -}
variant8 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> Pattern value8
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> combined)
    -> Pattern combined
variant8 variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 pattern8 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> withParam pattern5
        |> withParam pattern6
        |> withParam pattern7
        |> withParam pattern8
        |> toPattern


{-| -}
variant9 :
    String
    -> Pattern value1
    -> Pattern value2
    -> Pattern value3
    -> Pattern value4
    -> Pattern value5
    -> Pattern value6
    -> Pattern value7
    -> Pattern value8
    -> Pattern value9
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> value7 -> value8 -> value9 -> combined)
    -> Pattern combined
variant9 variantName pattern1 pattern2 pattern3 pattern4 pattern5 pattern6 pattern7 pattern8 pattern9 combine =
    customType variantName combine
        |> withParam pattern1
        |> withParam pattern2
        |> withParam pattern3
        |> withParam pattern4
        |> withParam pattern5
        |> withParam pattern6
        |> withParam pattern7
        |> withParam pattern8
        |> withParam pattern9
        |> toPattern


{-| -}
aliasAs : String -> (Expression -> a -> b) -> Pattern a -> Pattern b
aliasAs name combine (Branch.Branch branch) =
    Branch.Branch
        (\index ->
            let
                ( newIndex, pattern, destructured ) =
                    branch index

                ( finalIndex, finalName, nameExpression ) =
                    Compiler.var newIndex name
            in
            ( finalIndex
            , Pattern.AsPattern
                (Compiler.nodify pattern)
                (Compiler.nodify finalName)
            , combine nameExpression destructured
            )
        )


{-| Pattern match with a literal Int.

    example =
        Elm.Case.Branch.variant1 "Just" (Elm.Case.Branch.int 2)

Results in

    case value of
        Just 2 ->
            2

-}
int : Int -> Pattern Int
int value =
    Branch.pattern (Pattern.IntPattern value) value


{-| This is the most basic kind of pattern - it matches anything and gives it a variable name.

    example =
        Elm.Case.Branch.variant1 "Username"
            (Elm.Case.Branch.var "username")
            |> Elm.Case.Branch.map
                (\username ->
                    Elm.Op.append
                        (Elm.string "Hello ")
                        username
                )

-}
var : String -> Pattern Expression
var name =
    Branch.Branch
        (\index ->
            let
                ( newIndex, sanitizedName, exp ) =
                    Compiler.var Index.startIndex name
            in
            ( newIndex, Pattern.VarPattern sanitizedName, exp )
        )


{-| -}
map : (a -> b) -> Pattern a -> Pattern b
map mapFn pattern =
    Branch.map mapFn pattern


{-| Match on a list of items

    [ "first", "second" ] ->
        "firstsecond"

Could be represented like

    Branch.list
        (\string gathered ->
            string ++ gathered
        )
        [ Branch.string "first"
        , Branch.string "second"
        ]
        |> Branch.map Elm.string

-}
list : (item -> gathered -> gathered) -> gathered -> List (Pattern item) -> Pattern gathered
list gather start patterns =
    Branch.Branch
        (\startIndex ->
            let
                ( finalIndex, itemPatterns, finalGathered ) =
                    List.foldl
                        (\((Branch toBranch) as branch) ( index, patternList, gathered ) ->
                            let
                                ( newIndex, pattern, value ) =
                                    toBranch index
                            in
                            ( newIndex
                            , pattern :: patternList
                            , gather value gathered
                            )
                        )
                        ( startIndex, [], start )
                        patterns
            in
            ( finalIndex
            , Pattern.ListPattern
                (reverseAndNodify
                    itemPatterns
                )
            , finalGathered
            )
        )


reverseAndNodify : List Pattern.Pattern -> List (Node Pattern.Pattern)
reverseAndNodify items =
    List.foldl
        (\item gatheredList ->
            Compiler.nodify item :: gatheredList
        )
        []
        items


{-| Pattern match on an open list where you can have access to remaining "tail" of items.

So, something like this:

    "first" :: "second" :: remaining ->
        "firstsecond"

Could be represented like

    Branch.listWithRemaining
        (\string gathered ->
            string ++ gathered
        )
        [ Branch.string "first"
        , Branch.string "second"
        ]
        (Branch.var "remaining")
        |> Branch.map
            (\( string, remaining ) ->
                Elm.string string
            )

-}
listWithRemaining : (item -> gathered -> gathered) -> gathered -> List (Pattern item) -> Pattern remaining -> Pattern ( gathered, remaining )
listWithRemaining gather start patterns (Branch toRemaining) =
    Branch.Branch
        (\startIndex ->
            let
                ( restIndex, restPattern, remainingValue ) =
                    toRemaining startIndex

                ( finalIndex, itemPatterns, finalGathered ) =
                    List.foldl
                        (\((Branch toBranch) as branch) ( index, patternList, gathered ) ->
                            let
                                ( newIndex, pattern, value ) =
                                    toBranch index
                            in
                            ( newIndex
                            , pattern :: patternList
                            , gather value gathered
                            )
                        )
                        ( startIndex, [], start )
                        patterns
            in
            ( finalIndex
            , -- Reverse and `nodify` the list of patterns
              List.foldl
                (\pattern soFar ->
                    Pattern.UnConsPattern (Compiler.nodify pattern) (Compiler.nodify soFar)
                )
                restPattern
                itemPatterns
            , ( finalGathered
              , remainingValue
              )
            )
        )


{-| `Ok` variant. A simple helper of `variant1 "Ok"`.
-}
ok : Pattern ok -> Pattern ok
ok =
    variant1 "Ok"


{-| `Err` variant. A simple helper of `variant1 "Err"`.
-}
err : Pattern err -> Pattern err
err =
    variant1 "Err"


{-| `Just` variant.
-}
just : Pattern just -> Pattern just
just =
    variant1 "Ok"


{-| `Err` variant. A simple helper of `variant1 "Err"`.
-}
nothing : value -> Pattern value
nothing value =
    variant0 "Nothing" value


{-|

    Branch.tuple (Branch.var "one") (Branch.var "two")
        |> Branch.map
            (\( one, two ) ->
                Elm.Op.append one two
            )

-}
tuple :
    Pattern a
    -> Pattern b
    -> Pattern ( a, b )
tuple (Branch oneBranch) (Branch twoBranch) =
    Branch.Branch
        (\index ->
            let
                ( oneIndex, onePattern, oneVal ) =
                    oneBranch index

                ( twoIndex, twoPattern, twoVal ) =
                    twoBranch oneIndex
            in
            ( twoIndex
            , Pattern.TuplePattern
                [ Compiler.nodify onePattern
                , Compiler.nodify twoPattern
                ]
            , ( oneVal, twoVal )
            )
        )


{-| -}
triple :
    Pattern a
    -> Pattern b
    -> Pattern c
    -> Pattern ( a, b, c )
triple (Branch oneBranch) (Branch twoBranch) (Branch threeBranch) =
    Branch.Branch
        (\index ->
            let
                ( oneIndex, onePattern, oneVal ) =
                    oneBranch index

                ( twoIndex, twoPattern, twoVal ) =
                    twoBranch oneIndex

                ( threeIndex, threePattern, threeVal ) =
                    threeBranch twoIndex
            in
            ( threeIndex
            , Pattern.TuplePattern
                [ Compiler.nodify onePattern
                , Compiler.nodify twoPattern
                , Compiler.nodify threePattern
                ]
            , ( oneVal, twoVal, threeVal )
            )
        )
