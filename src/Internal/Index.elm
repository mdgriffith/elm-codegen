module Internal.Index exposing (Index, dive, getName, indexToString, next, nextN, protectTypeName, startIndex)

{-| -}

import Internal.Format as Format
import Set exposing (Set)


{-| Indexes to make type checking work!

Every `Expression` will be passed an index which it can use to add an identifier to variables (both type variables and normal ones).

The "top" is never rendered, which allows for top level identifiers to be rendered with their desired name.

The general flow goes like this:

    declaration: startIndex
        -> a function
            1. Can use the index or a Compiler.next index on it's arguments
            2. Needs to use Compiler.dive index when handing it to it's children.

This means that indices as provided should always be usable at the level they show up at.
If you're handing an index to a lower lever, use Compiler.dive.

-}
type Index
    = Index Int (List Int) Scope


type alias Scope =
    Set String


{-| -}
startIndex : Index
startIndex =
    Index 0 [] Set.empty


next : Index -> Index
next (Index top tail scope) =
    Index (top + 1) tail scope


nextN : Int -> Index -> Index
nextN n (Index top tail scope) =
    Index (top + n) tail scope


dive : Index -> Index
dive (Index top tail scope) =
    Index 0 (top :: tail) scope


getName : String -> Index -> ( String, Index )
getName desiredName ((Index top tail scope) as index) =
    let
        formattedName =
            Format.formatValue desiredName
    in
    if not (Set.member formattedName scope) then
        ( formattedName, Index top tail (Set.insert formattedName scope) )

    else
        let
            protectedName =
                formattedName ++ String.fromInt top
        in
        if not (Set.member protectedName scope) then
            ( protectedName
            , Index (top + 1) tail (Set.insert protectedName scope)
            )

        else
            let
                protectedNameLevel2 =
                    formattedName ++ indexToString index
            in
            ( protectedNameLevel2
            , Index (top + 1) tail (Set.insert protectedNameLevel2 scope)
            )


protectTypeName : String -> Index -> String
protectTypeName base ((Index top tail scope) as index) =
    case tail of
        [] ->
            Format.formatValue base

        _ ->
            Format.formatValue
                (base ++ indexToString index)


indexToString : Index -> String
indexToString (Index top tail scope) =
    (if top == 0 then
        ""

     else
        "_"
            ++ String.fromInt top
    )
        ++ (case tail of
                [] ->
                    ""

                one :: [] ->
                    "_" ++ String.fromInt one

                one :: two :: [] ->
                    "_"
                        ++ String.fromInt one
                        ++ "_"
                        ++ String.fromInt two

                one :: two :: three :: [] ->
                    "_"
                        ++ String.fromInt one
                        ++ "_"
                        ++ String.fromInt two
                        ++ "_"
                        ++ String.fromInt three

                _ ->
                    "_"
                        ++ String.join "_" (List.map String.fromInt tail)
           )
