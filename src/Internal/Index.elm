module Internal.Index exposing
    ( Index, startIndex, startChecked
    , next, dive
    , getName, indexToString, protectTypeName
    , typecheck
    , getImport, hasModuleName
    )

{-|

@docs Index, startIndex, startChecked

@docs next, dive

@docs getName, indexToString, protectTypeName

@docs typecheck

@docs getImport, hasModuleName

-}

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
    = Index (Maybe ModuleName) Int (List Int) Scope Bool


hasModuleName : Index -> Bool
hasModuleName (Index maybeModName _ _ _ _) =
    case maybeModName of
        Just _ ->
            True

        Nothing ->
            False


getImport : Index -> List String -> List String
getImport (Index maybeModName _ _ _ _) importedAs =
    case maybeModName of
        Just modName ->
            if modName == importedAs then
                []

            else
                importedAs

        Nothing ->
            importedAs


type alias ModuleName =
    List String


typecheck : Index -> Bool
typecheck (Index _ _ _ _ check) =
    check


type alias Scope =
    Set String


{-| -}
startIndex : Maybe ModuleName -> Index
startIndex modName =
    Index modName 0 [] Set.empty True


{-| -}
startChecked : Maybe ModuleName -> Bool -> Index
startChecked modName checked =
    Index modName 0 [] Set.empty checked


next : Index -> Index
next (Index modName top tail scope check) =
    Index modName (top + 1) tail scope check


nextN : Int -> Index -> Index
nextN n (Index modName top tail scope check) =
    Index modName (top + n) tail scope check


dive : Index -> Index
dive (Index modName top tail scope check) =
    Index modName 0 (top :: tail) scope check


getName : String -> Index -> ( String, Index )
getName desiredName ((Index modName top tail scope check) as index) =
    let
        formattedName : String
        formattedName =
            Format.formatValue desiredName
    in
    if not (Set.member formattedName scope) then
        ( formattedName, Index modName top tail (Set.insert formattedName scope) check )

    else
        let
            protectedName : String
            protectedName =
                formattedName ++ String.fromInt top
        in
        if not (Set.member protectedName scope) then
            ( protectedName
            , Index modName (top + 1) tail (Set.insert protectedName scope) check
            )

        else
            let
                protectedNameLevel2 : String
                protectedNameLevel2 =
                    formattedName ++ indexToString index
            in
            ( protectedNameLevel2
            , Index modName (top + 1) tail (Set.insert protectedNameLevel2 scope) check
            )


protectTypeName : String -> Index -> String
protectTypeName base ((Index _ _ tail _ _) as index) =
    case tail of
        [] ->
            Format.formatValue base

        _ ->
            Format.formatValue
                (base ++ indexToString index)


indexToString : Index -> String
indexToString (Index _ top tail _ _) =
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
