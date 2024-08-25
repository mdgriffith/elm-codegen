module Internal.Clean exposing (clean)

{-| For cleaning up signatures that look like

    Html msg_0_1_5

to

    Html msg

Will also adjust qualification of the type based on if this is used in the module it's declared in or not.'

-}

import Dict exposing (Dict)
import Elm.Syntax.ModuleName as ModuleName
import Elm.Syntax.Node as Node
import Elm.Syntax.TypeAnnotation as Type
import Internal.Index as Index
import Set exposing (Set)


{-| -}
clean : Index.Index -> Type.TypeAnnotation -> Type.TypeAnnotation
clean index ann =
    let
        renames : Dict String String
        renames =
            prepareRename ann Set.empty
                |> verify
    in
    if Dict.isEmpty renames && not (Index.hasModuleName index) then
        ann

    else
        doRename index renames ann


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


{-| Adjust the qualification of this type based on if it's used in the module it's defiend in or not.
-}
adjustQualification :
    Index.Index
    -> Node.Node ( ModuleName.ModuleName, String )
    -> Node.Node ( ModuleName.ModuleName, String )
adjustQualification index (Node.Node range ( modName, name )) =
    Node.Node range
        ( Index.getImport index modName
        , name
        )


doRename : Index.Index -> Dict String String -> Type.TypeAnnotation -> Type.TypeAnnotation
doRename index dict ann =
    case ann of
        Type.GenericType generic ->
            case Dict.get generic dict of
                Nothing ->
                    ann

                Just renamed ->
                    Type.GenericType renamed

        Type.Typed name nodedVars ->
            Type.Typed (adjustQualification index name)
                (List.map (Node.map (doRename index dict)) nodedVars)

        Type.Unit ->
            ann

        Type.Tupled nodedVars ->
            Type.Tupled (List.map (Node.map (doRename index dict)) nodedVars)

        Type.Record record ->
            Type.Record
                (List.map
                    (Node.map
                        (Tuple.mapSecond
                            (Node.map (doRename index dict))
                        )
                    )
                    record
                )

        Type.GenericRecord name (Node.Node range record) ->
            Type.GenericRecord name
                (Node.Node range
                    (List.map
                        (Node.map
                            (Tuple.mapSecond
                                (Node.map
                                    (doRename index dict)
                                )
                            )
                        )
                        record
                    )
                )

        Type.FunctionTypeAnnotation nodeOne nodeTwo ->
            Type.FunctionTypeAnnotation
                (Node.map (doRename index dict) nodeOne)
                (Node.map (doRename index dict) nodeTwo)
