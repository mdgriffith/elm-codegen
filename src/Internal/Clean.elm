module Internal.Clean exposing (clean)

{-| For cleaning up signatures that look like

        Html msg_0_1_5

to

        Html msg

-}

import Dict exposing (Dict)
import Elm.Syntax.Node as Node
import Elm.Syntax.TypeAnnotation as Type
import Set exposing (Set)


{-| -}
clean : Type.TypeAnnotation -> Type.TypeAnnotation
clean ann =
    let
        renames : Dict String String
        renames =
            prepareRename ann Set.empty
                |> verify
    in
    doRename renames ann


{-| -}
verify : Set String -> Dict String String
verify set =
    Set.foldl
        (\name gathered ->
            let
                newName : String
                newName =
                    findClean 0 (sanitized name) set
            in
            Dict.insert name newName gathered
        )
        Dict.empty
        set


findClean : Int -> String -> Set String -> String
findClean i name set =
    let
        newName : String
        newName =
            if i == 0 then
                name

            else
                name ++ String.fromInt i
    in
    if Set.member newName set then
        findClean (i + 1) name set

    else
        name


sanitized : String -> String
sanitized str =
    case String.split "_" str of
        [] ->
            str

        top :: _ ->
            top


prepareRename : Type.TypeAnnotation -> Set String -> Set String
prepareRename ann dict =
    case ann of
        Type.GenericType generic ->
            dict |> Set.insert generic

        Type.Typed _ nodedVars ->
            List.foldl (\(Node.Node _ tipe) d -> prepareRename tipe d) dict nodedVars

        Type.Unit ->
            dict

        Type.Tupled nodedVars ->
            List.foldl (\(Node.Node _ tipe) d -> prepareRename tipe d) dict nodedVars

        Type.Record record ->
            List.foldl (\(Node.Node _ ( _, Node.Node _ field )) d -> prepareRename field d) dict record

        Type.GenericRecord _ (Node.Node _ record) ->
            List.foldl (\(Node.Node _ ( _, Node.Node _ field )) d -> prepareRename field d) dict record

        Type.FunctionTypeAnnotation (Node.Node _ one) (Node.Node _ two) ->
            dict
                |> prepareRename one
                |> prepareRename two


doRename : Dict String String -> Type.TypeAnnotation -> Type.TypeAnnotation
doRename dict ann =
    case ann of
        Type.GenericType generic ->
            case Dict.get generic dict of
                Nothing ->
                    ann

                Just renamed ->
                    Type.GenericType renamed

        Type.Typed name nodedVars ->
            Type.Typed name (List.map (Node.map (doRename dict)) nodedVars)

        Type.Unit ->
            ann

        Type.Tupled nodedVars ->
            Type.Tupled (List.map (Node.map (doRename dict)) nodedVars)

        Type.Record record ->
            Type.Record (List.map (Node.map (Tuple.mapSecond (Node.map (doRename dict)))) record)

        Type.GenericRecord name (Node.Node range record) ->
            Type.GenericRecord name (Node.Node range (List.map (Node.map (Tuple.mapSecond (Node.map (doRename dict)))) record))

        Type.FunctionTypeAnnotation nodeOne nodeTwo ->
            Type.FunctionTypeAnnotation (Node.map (doRename dict) nodeOne) (Node.map (doRename dict) nodeTwo)
