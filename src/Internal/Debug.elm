module Internal.Debug exposing (everything, facts)

import Dict
import Internal.Compiler as Compiler
import Internal.Write



{- DEBUGGING -}


{-| -}
facts : Compiler.Expression -> Result String (List ( String, String ))
facts (Compiler.Expression exp) =
    let
        expresh =
            exp Compiler.startIndex
    in
    case expresh.annotation of
        Ok sig ->
            sig.inferences
                |> Dict.toList
                |> List.map
                    (\( key, type_ ) ->
                        ( key, Internal.Write.writeAnnotation type_ )
                    )
                |> Ok

        Err inferenceError ->
            List.foldl
                (\err str ->
                    case str of
                        "" ->
                            Compiler.inferenceErrorToString err

                        _ ->
                            str ++ "\n\n" ++ Compiler.inferenceErrorToString err
                )
                ""
                inferenceError
                |> Err


{-| -}
everything :
    Compiler.Expression
    ->
        Result
            String
            { facts : List ( String, String )
            , signature : String
            , aliases : List ( String, String )
            }
everything (Compiler.Expression exp) =
    let
        expresh =
            exp Compiler.startIndex
    in
    case expresh.annotation of
        Ok sig ->
            let
                allFacts =
                    sig.inferences
                        |> Dict.toList
                        |> List.map
                            (\( key, type_ ) ->
                                ( key, Internal.Write.writeAnnotation type_ )
                            )
            in
            Ok
                { facts = allFacts
                , signature = Internal.Write.writeAnnotation sig.type_
                , aliases =
                    sig.aliases
                        |> Dict.toList
                        |> List.map
                            (\( key, alias ) ->
                                ( key, Internal.Write.writeAnnotation alias.target )
                            )
                }

        Err inferenceError ->
            List.foldl
                (\err str ->
                    case str of
                        "" ->
                            Compiler.inferenceErrorToString err

                        _ ->
                            str ++ "\n\n" ++ Compiler.inferenceErrorToString err
                )
                ""
                inferenceError
                |> Err
