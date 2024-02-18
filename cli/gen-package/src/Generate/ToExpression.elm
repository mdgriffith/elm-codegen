module Generate.ToExpression exposing (ToExpressionDict, generate)

import Dict exposing (Dict)
import Elm
import Elm.Annotation as Annotation
import Elm.Case
import Elm.Case.Branch
import Elm.Docs
import Elm.Let
import Elm.Type
import Gen.Debug
import Gen.Dict
import Gen.Elm
import Gen.List
import Gen.Tuple
import Maybe.Extra
import Result.Extra


type alias ToExpressionDict =
    Dict String (Dict String Elm.Declaration)


elm : List String
elm =
    [ "Elm" ]


expressionType : Annotation.Annotation
expressionType =
    Annotation.named elm "Expression"


generate : List ( Elm.Docs.Module, List Elm.Docs.Block ) -> ToExpressionDict
generate modules =
    let
        go : Int -> ToExpressionDict -> ToExpressionDict
        go budget acc =
            if budget <= 0 then
                acc

            else
                let
                    ( result, continue ) =
                        List.foldl
                            (\( module_, blocks ) ( dacc, cacc ) ->
                                let
                                    dict : Dict String Elm.Declaration
                                    dict =
                                        generateToExpressionForModule dacc module_ blocks

                                    existing : Dict String Elm.Declaration
                                    existing =
                                        Dict.get module_.name dacc
                                            |> Maybe.withDefault Dict.empty
                                in
                                ( Dict.insert module_.name dict dacc
                                , cacc || Dict.size dict > Dict.size existing
                                )
                            )
                            ( acc, False )
                            modules
                in
                if continue then
                    go (budget - 1) result

                else
                    result
    in
    go 100 Dict.empty


generateToExpressionForModule :
    ToExpressionDict
    -> Elm.Docs.Module
    -> List Elm.Docs.Block
    -> Dict String Elm.Declaration
generateToExpressionForModule availableToExpressions module_ blocks =
    if List.member module_.name [ "Dict", "Array", "Result", "Maybe", "Basics" ] then
        Dict.empty

    else
        let
            thisModule =
                String.split "." module_.name
        in
        blocks
            |> List.filterMap (toExpression availableToExpressions thisModule)
            |> Dict.fromList


toExpression :
    ToExpressionDict
    -> List String
    -> Elm.Docs.Block
    -> Maybe ( String, Elm.Declaration )
toExpression availableToExpressions thisModule block =
    let
        inner : Maybe ( String, Elm.Expression )
        inner =
            case ( thisModule, block ) of
                ( _, Elm.Docs.UnionBlock union ) ->
                    case union.tags of
                        [] ->
                            -- This type has not been exposed and can't be constructed
                            Nothing

                        _ ->
                            union.tags
                                |> Maybe.Extra.traverse
                                    (\(( name, tags ) as tag) ->
                                        case
                                            tags
                                                |> Result.Extra.combineMap (innerToExpression availableToExpressions thisModule)
                                                |> Result.map Maybe.Extra.combine
                                        of
                                            Ok Nothing ->
                                                Nothing

                                            Ok (Just converters) ->
                                                Elm.Case.Branch.map
                                                    (\args ->
                                                        Elm.apply
                                                            (Elm.get name (Elm.val "make_"))
                                                            (List.map2 identity converters args)
                                                    )
                                                    (buildBranch tag)
                                                    |> Just

                                            Err e ->
                                                buildBranch tag
                                                    |> Elm.Case.Branch.map (\args -> Gen.Debug.todo e)
                                                    |> Just
                                    )
                                |> Maybe.map
                                    (\branches ->
                                        let
                                            valueAnnotation : Annotation.Annotation
                                            valueAnnotation =
                                                Annotation.namedWith thisModule
                                                    union.name
                                                    (List.map Annotation.var union.args)

                                            fn value =
                                                Elm.Case.custom value valueAnnotation branches
                                        in
                                        ( union.name
                                        , Elm.fn ( "input_", Just valueAnnotation ) fn
                                        )
                                    )

                ( _, Elm.Docs.AliasBlock alias ) ->
                    let
                        valueAnnotation : Annotation.Annotation
                        valueAnnotation =
                            Annotation.namedWith thisModule
                                alias.name
                                (List.map Annotation.var alias.args)
                    in
                    case innerToExpression availableToExpressions thisModule alias.tipe of
                        Ok Nothing ->
                            Nothing

                        Ok (Just simple) ->
                            Just
                                ( alias.name
                                , Elm.withType
                                    (Annotation.function [ valueAnnotation ] expressionType)
                                  <|
                                    Elm.functionReduced "input_" simple
                                )

                        Err e ->
                            case alias.tipe of
                                Elm.Type.Type name args ->
                                    Just ( alias.name, Gen.Debug.todo <| "Grab from available (" ++ name ++ ")" )

                                _ ->
                                    Just
                                        ( alias.name
                                        , Elm.withType
                                            (Annotation.function [ valueAnnotation ] expressionType)
                                          <|
                                            Elm.functionReduced "_" <|
                                                \_ -> Gen.Debug.todo e
                                        )

                ( _, Elm.Docs.MarkdownBlock _ ) ->
                    Nothing

                ( _, Elm.Docs.ValueBlock _ ) ->
                    Nothing

                ( _, Elm.Docs.BinopBlock _ ) ->
                    Nothing

                ( _, Elm.Docs.UnknownBlock _ ) ->
                    Nothing
    in
    Maybe.map
        (\( name, value ) ->
            ( name
            , Elm.exposeWith
                { exposeConstructor = False
                , group = Just "toExpression"
                }
                (Elm.declaration ("toExpression_" ++ name) value)
            )
        )
        inner


buildBranch : ( String, List Elm.Type.Type ) -> Elm.Case.Branch.Pattern (List Elm.Expression)
buildBranch ( name, tags ) =
    case tags of
        [] ->
            Elm.Case.Branch.variant0 name []

        [ _ ] ->
            Elm.Case.Branch.variant1 name
                (Elm.Case.Branch.var "arg0")
                (\arg0 -> [ arg0 ])

        [ _, _ ] ->
            Elm.Case.Branch.variant2 name
                (Elm.Case.Branch.var "arg0")
                (Elm.Case.Branch.var "arg1")
                (\arg0 arg1 -> [ arg0, arg1 ])

        [ _, _, _ ] ->
            Elm.Case.Branch.variant3 name
                (Elm.Case.Branch.var "arg0")
                (Elm.Case.Branch.var "arg1")
                (Elm.Case.Branch.var "arg2")
                (\arg0 arg1 arg2 -> [ arg0, arg1, arg2 ])

        [ _, _, _, _ ] ->
            Elm.Case.Branch.variant4 name
                (Elm.Case.Branch.var "arg0")
                (Elm.Case.Branch.var "arg1")
                (Elm.Case.Branch.var "arg2")
                (Elm.Case.Branch.var "arg3")
                (\arg0 arg1 arg2 arg3 -> [ arg0, arg1, arg2, arg3 ])

        [ _, _, _, _, _ ] ->
            Elm.Case.Branch.variant5 name
                (Elm.Case.Branch.var "arg0")
                (Elm.Case.Branch.var "arg1")
                (Elm.Case.Branch.var "arg2")
                (Elm.Case.Branch.var "arg3")
                (Elm.Case.Branch.var "arg4")
                (\arg0 arg1 arg2 arg3 arg4 -> [ arg0, arg1, arg2, arg3, arg4 ])

        _ :: _ :: _ ->
            Elm.Case.Branch.variant0 name
                [ Gen.Debug.todo <|
                    "buildBranch: branch for length "
                        ++ String.fromInt (List.length tags)
                        ++ " not implemented"
                ]


innerToExpression : ToExpressionDict -> List String -> Elm.Type.Type -> Result String (Maybe (Elm.Expression -> Elm.Expression))
innerToExpression availableToExpressions thisModule =
    let
        go tipe =
            let
                ok : a -> Result error (Maybe a)
                ok value =
                    Ok (Just value)

                map : (a -> b) -> Result x (Maybe a) -> Result x (Maybe b)
                map f value =
                    Result.map (Maybe.map f) value

                map2 : (a -> b -> value) -> Result x (Maybe a) -> Result x (Maybe b) -> Result x (Maybe value)
                map2 f value0 value1 =
                    Result.map2 (Maybe.map2 f) value0 value1

                map3 : (a -> b -> c -> value) -> Result x (Maybe a) -> Result x (Maybe b) -> Result x (Maybe c) -> Result x (Maybe value)
                map3 f value0 value1 value2 =
                    Result.map3 (Maybe.map3 f) value0 value1 value2
            in
            case tipe of
                Elm.Type.Type "Basics.Int" [] ->
                    ok Gen.Elm.call_.int

                Elm.Type.Type "Basics.Float" [] ->
                    ok Gen.Elm.call_.float

                Elm.Type.Type "Basics.Bool" [] ->
                    ok Gen.Elm.call_.bool

                Elm.Type.Type "String.String" [] ->
                    ok Gen.Elm.call_.string

                Elm.Type.Type "Char.Char" [] ->
                    ok Gen.Elm.call_.char

                Elm.Type.Type "List.List" [ itemType ] ->
                    map
                        (\itemToExpression expression ->
                            Gen.Elm.call_.list <|
                                Gen.List.call_.map
                                    (Elm.functionReduced "item" itemToExpression)
                                    expression
                        )
                        (go itemType)

                Elm.Type.Type "Maybe.Maybe" [ itemType ] ->
                    map
                        (\itemToExpression expression ->
                            Elm.Case.maybe expression
                                { nothing = Gen.Elm.nothing
                                , just = ( "value", \value -> Gen.Elm.just (itemToExpression value) )
                                }
                        )
                        (go itemType)

                Elm.Type.Type "Dict.Dict" [ keyType, valueType ] ->
                    map2
                        (\keyToExpression valueToExpression expression ->
                            Elm.apply
                                (Elm.value { importFrom = [ "Gen", "Dict" ], annotation = Nothing, name = "fromList" })
                                [ Gen.List.call_.map
                                    (Elm.functionReduced "tuple" <|
                                        \tuple ->
                                            Gen.Elm.tuple
                                                (keyToExpression <| Gen.Tuple.first tuple)
                                                (valueToExpression <| Gen.Tuple.second tuple)
                                    )
                                    (Gen.Dict.toList expression)
                                ]
                        )
                        (go keyType)
                        (go valueType)

                Elm.Type.Type name args ->
                    let
                        splat : List String
                        splat =
                            List.reverse <| String.split "." name

                        moduleName : List String
                        moduleName =
                            List.reverse <| List.drop 1 splat

                        typeName : String
                        typeName =
                            String.concat <| List.take 1 splat

                        targetName : String
                        targetName =
                            "toExpression_" ++ typeName
                    in
                    if
                        Dict.get (String.join "." moduleName) availableToExpressions
                            |> Maybe.withDefault Dict.empty
                            |> Dict.member targetName
                    then
                        let
                            toExpressionValue : Elm.Expression
                            toExpressionValue =
                                if thisModule == moduleName then
                                    Elm.val targetName

                                else
                                    Elm.value
                                        { importFrom = "Gen" :: moduleName
                                        , name = targetName
                                        , annotation = Nothing
                                        }
                        in
                        ok <|
                            \expression ->
                                Elm.apply
                                    toExpressionValue
                                    [ expression ]

                    else
                        Ok Nothing

                Elm.Type.Record fields Nothing ->
                    fields
                        |> Result.Extra.combineMap
                            (\( fieldName, fieldType ) ->
                                go fieldType
                                    |> map (\f e -> Elm.tuple (Elm.string fieldName) (f (Elm.get fieldName e)))
                            )
                        |> Result.map Maybe.Extra.combine
                        |> map
                            (\fieldMappers expression ->
                                fieldMappers
                                    |> List.map (\f -> f expression)
                                    |> Gen.Elm.record
                            )

                Elm.Type.Var _ ->
                    -- Err "innerToExpression: branch 'Var _' not implemented"
                    Ok Nothing

                Elm.Type.Record _ (Just _) ->
                    Err "innerToExpression: branch 'Record _ (Just _)' not implemented"

                Elm.Type.Lambda _ _ ->
                    Err "innerToExpression: branch 'Lambda _ _' not implemented"

                Elm.Type.Tuple [ l, r ] ->
                    map2
                        (\lToExpression rToExpression expression ->
                            Elm.Let.letIn
                                (\( lv, rv ) ->
                                    Gen.Elm.tuple
                                        (lToExpression lv)
                                        (rToExpression rv)
                                )
                                |> Elm.Let.tuple "l" "r" expression
                                |> Elm.Let.toExpression
                        )
                        (go l)
                        (go r)

                Elm.Type.Tuple [ l, m, r ] ->
                    map3
                        (\lToExpression mToExpression rToExpression expression ->
                            Elm.Let.letIn
                                (\( lv, mv, rv ) ->
                                    Gen.Elm.triple
                                        (lToExpression lv)
                                        (mToExpression mv)
                                        (rToExpression rv)
                                )
                                |> Elm.Let.triple "l" "m" "r" expression
                                |> Elm.Let.toExpression
                        )
                        (go l)
                        (go m)
                        (go r)

                Elm.Type.Tuple [] ->
                    ok <| \_ -> Gen.Elm.unit

                Elm.Type.Tuple _ ->
                    -- This does not happen in practice
                    Ok Nothing
    in
    go
