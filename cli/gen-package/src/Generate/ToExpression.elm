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
import Set exposing (Set)


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
                                in
                                if Dict.isEmpty dict then
                                    ( dacc, cacc )

                                else
                                    let
                                        existing : Dict String Elm.Declaration
                                        existing =
                                            Dict.get module_.name dacc
                                                |> Maybe.withDefault Dict.empty
                                    in
                                    ( Dict.insert module_.name dict dacc
                                    , cacc || Dict.size (Dict.remove "error" dict) > Dict.size (Dict.remove "error" existing)
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
    if List.member module_.name [ "Dict", "Array", "Result", "Maybe", "Basics", "Task", "Platform" ] then
        Dict.empty

    else
        let
            thisModule =
                String.split "." module_.name
        in
        blocks
            |> List.concatMap
                (\block ->
                    case
                        toExpression availableToExpressions thisModule block
                            |> Result.map (Tuple.mapSecond Set.toList)
                    of
                        Ok ( Just ( name, result ), [] ) ->
                            [ ( name, result ) ]

                        Ok ( Just ( name, result ), logs ) ->
                            [ ( name, Elm.withDocumentation ("Gen error [1]: " ++ String.join "\n" logs) result ) ]

                        Ok ( Nothing, [] ) ->
                            []

                        Ok ( Nothing, [ err ] ) ->
                            if
                                String.startsWith "Module " err
                                    && String.contains "Internal." err
                                    && String.endsWith "not found" err
                                    || (err == "Module Platform not found")
                            then
                                []

                            else
                                [ ( "error"
                                  , Elm.withDocumentation ("Gen error [2]: " ++ err) (Elm.declaration "Error" Elm.unit)
                                  )
                                ]

                        Ok ( Nothing, logs ) ->
                            [ ( "error"
                              , Elm.withDocumentation ("Gen error [3]: " ++ String.join "\n" logs) (Elm.declaration "Error" Elm.unit)
                              )
                            ]

                        Err e ->
                            [ ( "error"
                              , Elm.declaration "error" (Gen.Debug.todo e)
                              )
                            ]
                )
            |> Dict.fromList


toExpression :
    ToExpressionDict
    -> List String
    -> Elm.Docs.Block
    -> Monad ( String, Elm.Declaration )
toExpression availableToExpressions thisModule block =
    let
        inner : Monad ( String, Elm.Expression )
        inner =
            case ( thisModule, block ) of
                ( _, Elm.Docs.UnionBlock union ) ->
                    case union.tags of
                        [] ->
                            -- This type has not been exposed and can't be constructed
                            nothing

                        _ ->
                            let
                                args : List String
                                args =
                                    union.args

                                converterAnnotations : List ( String, Maybe Annotation.Annotation )
                                converterAnnotations =
                                    args
                                        |> List.map
                                            (\arg ->
                                                ( "toExpression__" ++ arg
                                                , Just (Annotation.function [ Annotation.var arg ] expressionType)
                                                )
                                            )

                                converterNames : List String
                                converterNames =
                                    List.map Tuple.first converterAnnotations

                                converters : Dict String Elm.Expression
                                converters =
                                    Dict.fromList <| List.map2 (\k v -> ( k, Elm.val v )) args converterNames
                            in
                            union.tags
                                |> combineMap
                                    (\(( name, tags ) as tag) ->
                                        tags
                                            |> combineMap
                                                (innerToExpression availableToExpressions thisModule union.name converters)
                                            |> map
                                                (\k ->
                                                    Elm.Case.Branch.map
                                                        (\makeArgs ->
                                                            Elm.apply
                                                                (Elm.get name (Elm.val "make_"))
                                                                (List.map2 identity k makeArgs)
                                                        )
                                                        (buildBranch tag)
                                                )
                                    )
                                |> map
                                    (\branches ->
                                        let
                                            valueAnnotation : Annotation.Annotation
                                            valueAnnotation =
                                                Annotation.namedWith thisModule
                                                    union.name
                                                    (List.map Annotation.var union.args)

                                            fn values =
                                                let
                                                    value =
                                                        values
                                                            |> List.reverse
                                                            |> List.head
                                                            |> Maybe.withDefault Elm.unit
                                                in
                                                Elm.Case.custom value valueAnnotation branches
                                                    |> Elm.withType expressionType
                                        in
                                        ( union.name
                                        , Elm.function (converterAnnotations ++ [ ( "input_", Just valueAnnotation ) ]) fn
                                        )
                                    )

                ( _, Elm.Docs.AliasBlock alias ) ->
                    let
                        valueAnnotation : Annotation.Annotation
                        valueAnnotation =
                            Annotation.namedWith thisModule
                                alias.name
                                (List.map Annotation.var alias.args)

                        args : List String
                        args =
                            alias.args

                        converterAnnotations : List ( String, Maybe Annotation.Annotation )
                        converterAnnotations =
                            args
                                |> List.map
                                    (\arg ->
                                        ( "toExpression__" ++ arg
                                        , Just (Annotation.function [ Annotation.var arg ] expressionType)
                                        )
                                    )

                        converterNames : List String
                        converterNames =
                            List.map Tuple.first converterAnnotations

                        converters : Dict String Elm.Expression
                        converters =
                            Dict.fromList <| List.map2 (\k v -> ( k, Elm.val v )) args converterNames
                    in
                    case innerToExpression availableToExpressions thisModule alias.name converters alias.tipe of
                        Ok ( Nothing, log ) ->
                            Ok ( Nothing, log )

                        Ok ( Just simple, log ) ->
                            let
                                fn values =
                                    let
                                        value =
                                            values
                                                |> List.reverse
                                                |> List.head
                                                |> Maybe.withDefault Elm.unit
                                    in
                                    simple value
                                        |> Elm.withType expressionType
                            in
                            Ok
                                ( Just
                                    ( alias.name
                                    , Elm.function (converterAnnotations ++ [ ( "input_", Just valueAnnotation ) ]) fn
                                    )
                                , log
                                )

                        Err e ->
                            return <|
                                ( alias.name
                                , Elm.withType
                                    (Annotation.function [ valueAnnotation ] expressionType)
                                  <|
                                    Elm.functionReduced "_" <|
                                        \_ -> Gen.Debug.todo e
                                )

                ( _, Elm.Docs.MarkdownBlock _ ) ->
                    nothing

                ( _, Elm.Docs.ValueBlock _ ) ->
                    nothing

                ( _, Elm.Docs.BinopBlock _ ) ->
                    nothing

                ( _, Elm.Docs.UnknownBlock _ ) ->
                    nothing
    in
    map
        (\( name, value ) ->
            let
                targetName =
                    "toExpression_" ++ name
            in
            ( targetName
            , Elm.exposeWith
                { exposeConstructor = False
                , group = Just "toExpression"
                }
                (Elm.declaration targetName value)
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


type alias Monad a =
    Result String ( Maybe a, Set String )


return : a -> Monad a
return x =
    Ok ( Just x, Set.empty )


nothing : Monad a
nothing =
    Ok ( Nothing, Set.empty )


map : (a -> b) -> Monad a -> Monad b
map f value =
    Result.map (\( a, al ) -> ( Maybe.map f a, al )) value


map2 : (a -> b -> value) -> Monad a -> Monad b -> Monad value
map2 f value0 value1 =
    Result.map2 (\( a, al ) ( b, bl ) -> ( Maybe.map2 f a b, al |> Set.union bl )) value0 value1


map3 : (a -> b -> c -> value) -> Monad a -> Monad b -> Monad c -> Monad value
map3 f value0 value1 value2 =
    Result.map3 (\( a, al ) ( b, bl ) ( c, cl ) -> ( Maybe.map3 f a b c, al |> Set.union bl |> Set.union cl )) value0 value1 value2


combine : List (Monad a) -> Monad (List a)
combine list =
    List.foldl (map2 (::)) (return []) (List.reverse list)


combineMap : (a -> Monad b) -> List a -> Monad (List b)
combineMap f list =
    list
        |> List.map f
        |> combine


innerToExpression : ToExpressionDict -> List String -> String -> Dict String Elm.Expression -> Elm.Type.Type -> Monad (Elm.Expression -> Elm.Expression)
innerToExpression availableToExpressions thisModule targetType varConverters =
    let
        go : Elm.Type.Type -> Monad (Elm.Expression -> Elm.Expression)
        go tipe =
            case tipe of
                Elm.Type.Type "Basics.Int" [] ->
                    return Gen.Elm.call_.int

                Elm.Type.Type "Basics.Float" [] ->
                    return Gen.Elm.call_.float

                Elm.Type.Type "Basics.Bool" [] ->
                    return Gen.Elm.call_.bool

                Elm.Type.Type "String.String" [] ->
                    return Gen.Elm.call_.string

                Elm.Type.Type "Char.Char" [] ->
                    return Gen.Elm.call_.char

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
                    case Dict.get (String.join "." moduleName) availableToExpressions of
                        Nothing ->
                            Ok ( Nothing, Set.singleton <| "Module " ++ String.join "." moduleName ++ " not found" )

                        Just foundModule ->
                            if
                                Dict.member targetName foundModule
                                    || -- Recursive types
                                       (targetName == "toExpression_" ++ targetType)
                                    || -- TODO: probably do a graph traverse to find mutually recursive types instead of just assuming
                                       True
                            then
                                args
                                    |> combineMap go
                                    |> map
                                        (\argConverters expression ->
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
                                            Elm.apply toExpressionValue
                                                (List.map
                                                    (Elm.functionReduced "v")
                                                    argConverters
                                                    ++ [ expression ]
                                                )
                                        )

                            else
                                Ok
                                    ( Nothing
                                    , Set.singleton <|
                                        targetName
                                            ++ " not found in module "
                                            ++ String.join "." moduleName
                                            ++ " while generating "
                                            ++ targetType
                                            ++ ", keys where: "
                                            ++ String.join ", " (Dict.keys foundModule)
                                    )

                Elm.Type.Record fields Nothing ->
                    fields
                        |> combineMap
                            (\( fieldName, fieldType ) ->
                                go fieldType
                                    |> map (\f e -> Elm.tuple (Elm.string fieldName) (f (Elm.get fieldName e)))
                            )
                        |> map
                            (\fieldMappers expression ->
                                fieldMappers
                                    |> List.map (\f -> f expression)
                                    |> Gen.Elm.record
                            )

                Elm.Type.Var name ->
                    case Dict.get name varConverters of
                        Just f ->
                            return <| \v -> Elm.apply f [ v ]

                        Nothing ->
                            Err "innerToExpression: branch 'Var _' not implemented"

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
                    return <| \_ -> Gen.Elm.unit

                Elm.Type.Tuple _ ->
                    -- This does not happen in practice
                    Err "Empty tuple"
    in
    go
