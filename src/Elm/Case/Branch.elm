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

{-| This module is for creating more advanced pattern matches in your case expressions.

The general usage looks something like this

    import Elm.Case as Case
    import Elm.Case.Branch as Branch

    example =
        Case.custom myValue
            (Elm.Annotation.named [] "Msg")
            -- Define all the branches in your case
            [ Branch.variant1 "ButtonClicked" (Branch.var "id") <|
                \id -> Elm.Op.append id (Elm.string " was clicked!")

            -- A branch which also destructures a record
            , Branch.variant1 "FormSubmitted" (Branch.record2 Tuple.pair "id" "isValid") <|
                \( id, isValid ) ->
                    Elm.ifThen isValue
                        (Elm.string "Form is valid")
                        (Elm.string "Form is NOT valid")
            ]

Which generates

    case myValue of
        ButtonClicked id ->
            "Button " ++ id ++ " was clicked!"

        FormSubmitted { id, isValid } ->
            if isValid then
                "Form is valid"

            else
                "Form is NOT valid"

@docs Branch, Pattern, map


## Variables

@docs var


## Exact Matches

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

This will help destructure record fields if you know what fields you want.

Here's an example using an intermediate record to help us out!

    {-| We define a record to help us out!
    -}
    type alias Details =
        { id : Elm.Expression
        , name : Elm.Expression
        }

    Case.custom (Elm.val "msg") (Type.named [] "Msg")
        [ Branch.variant1 "ButtonClicked" (Branch.record2 Details "id" "name") <|
            \{ id, name } ->
               Elm.tuple id name
        ]

Which generates

    case msg of
        ButtonClicked { id, name } ->
            ( id, name )

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
import Elm.Syntax.Node exposing (Node)
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
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
unit : value -> Pattern value
unit val =
    Branch.pattern Pattern.UnitPattern val


{-| -}
ignore : value -> Pattern value
ignore val =
    Branch.pattern Pattern.AllPattern val


{-| Matches a literal String.

    example =
        Branch.just (Branch.string "admin")
            |> Branch.map
                (\str ->
                    Elm.string "This user is an admin!"
                )

Results in

    case user.kind of
        Just "admin" ->
            "This user is an admin!"

-}
string : String -> value -> Pattern value
string literalString value =
    Branch.pattern (Pattern.StringPattern literalString) value


{-| Matches a literal Char.
-}
char : Char -> a -> Pattern a
char literalChar value =
    Branch.pattern (Pattern.CharPattern literalChar) value


{-| -}
type Record a
    = Record (Index.Index -> ( Index.Index, Set String, a ))


{-| An empty record pattern!
-}
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


{-| -}
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

                new : { name : String, typename : String, val : Expression, index : Index.Index }
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

                custom : { index : Index.Index, base : String, patterns : List Pattern.Pattern, value : a -> b }
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
                custom : { index : Index.Index, base : String, patterns : List Pattern.Pattern, value : a }
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
variant1 : String -> Pattern value -> (value -> result) -> Pattern result
variant1 variantName pattern mapper =
    customType variantName mapper
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

                aliased : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                aliased =
                    Compiler.toVarMaybeType newIndex name Nothing
            in
            ( aliased.index
            , Pattern.AsPattern
                (Compiler.nodify pattern)
                (Compiler.nodify aliased.name)
            , combine aliased.val destructured
            )
        )


{-| Pattern match with a literal Int.

    import Elm.Case.Branch as Branch

    Branch.just (Branch.int 2 (Elm.int 5))

Results in

    Just 2 ->
        5

-}
int : Int -> value -> Pattern value
int i value =
    Branch.pattern (Pattern.IntPattern i) value


{-| This is the most basic kind of pattern - it matches anything and gives it a variable name.

    import Elm.Case.Branch as Branch


    Branch.variant1 "Username" (Branch.var "username") <|
        \username ->
            Elm.Op.append
                (Elm.string "Hello ")
                username

Results in

    Username username ->
        "Hello " ++ username

-}
var : String -> Pattern Expression
var name =
    Branch.Branch
        (\index ->
            let
                variable : { name : String, type_ : Annotation.TypeAnnotation, val : Expression, index : Index.Index }
                variable =
                    Compiler.toVarMaybeType index name Nothing
            in
            ( variable.index
            , Pattern.VarPattern variable.name
            , variable.val
            )
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
        { patterns =
            [ Branch.string "first"
            , Branch.string "second"
            ]
        , gather = \item gathered -> item :: gathered
        , startWith = []
        , finally = Elm.string
        }

-}
list :
    { patterns : List (Pattern item)
    , gather : item -> gathered -> gathered
    , startWith : gathered
    , finally : gathered -> list
    }
    -> Pattern list
list { patterns, gather, startWith, finally } =
    Branch.Branch
        (\startIndex ->
            let
                ( finalIndex, itemPatterns, finalGathered ) =
                    List.foldl
                        (\(Branch toBranch) ( index, patternList, gathered ) ->
                            let
                                ( newIndex, pattern, value ) =
                                    toBranch index
                            in
                            ( newIndex
                            , pattern :: patternList
                            , gather value gathered
                            )
                        )
                        ( startIndex, [], startWith )
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
        |> map finally


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
        remaining

Could be represented like

    Branch.listWithRemaining
        { patterns =
            [ Branch.string "first"
            , Branch.string "second"
            ]
        , remaining = Branch.var "remaining"
        , gather = \item gathered -> item :: gathered
        , startWith = []
        , finally =
            \gathered remaining ->
                remaining
        }

-}
listWithRemaining :
    { patterns : List (Pattern item)
    , remaining : Pattern remaining
    , gather : item -> gathered -> gathered
    , startWith : gathered
    , finally : gathered -> remaining -> list
    }
    -> Pattern list
listWithRemaining { patterns, gather, startWith, remaining, finally } =
    Branch.Branch
        (\startIndex ->
            let
                (Branch toRemaining) =
                    remaining

                ( _, restPattern, remainingValue ) =
                    toRemaining startIndex

                ( finalIndex, itemPatterns, finalGathered ) =
                    List.foldl
                        (\(Branch toBranch) ( index, patternList, gathered ) ->
                            let
                                ( newIndex, pattern, value ) =
                                    toBranch index
                            in
                            ( newIndex
                            , pattern :: patternList
                            , gather value gathered
                            )
                        )
                        ( startIndex, [], startWith )
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
            , finally finalGathered remainingValue
            )
        )


{-| The `Ok` value for a `Result`
-}
ok : Pattern ok -> Pattern ok
ok pattern =
    variant1 "Ok" pattern identity


{-| The `Err` value of a result.
-}
err : Pattern err -> Pattern err
err pattern =
    variant1 "Err" pattern identity


{-| -}
just : Pattern just -> Pattern just
just pattern =
    variant1 "Just" pattern identity


{-| -}
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
