module Internal.Debug exposing (everything, everythingFormatted, facts)

import Dict
import Internal.Compiler as Compiler
import Internal.Index as Index
import Internal.Write



{- DEBUGGING -}


{-| -}
facts : Compiler.Expression -> Result String (List ( String, String ))
facts (Compiler.Expression exp) =
    let
        expresh : Compiler.ExpressionDetails
        expresh =
            exp (Index.startIndex Nothing)
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
            inferenceError
                |> List.map Compiler.inferenceErrorToString
                |> String.join "\n\n"
                |> Err


everythingFormatted :
    (String -> String)
    -> Compiler.Expression
    -> List String
everythingFormatted log exp =
    let
        every : Result String { facts : List ( String, String ), signature : String, aliases : List ( String, String ) }
        every =
            everything exp

        _ =
            log "    ---"
    in
    case every of
        Err err ->
            [ err ]

        Ok e ->
            List.concat
                [ [ "Signature"
                  , "  " ++ e.signature
                  ]
                , List.map
                    (\( key, val ) ->
                        "  " ++ key ++ ": " ++ val
                    )
                    e.facts
                ]
                |> List.reverse
                |> List.map log


annotationFormatted :
    (String -> String)
    ->
        Result
            (List Compiler.InferenceError)
            Compiler.Inference
    -> List String
annotationFormatted log ann =
    let
        every : Result String { facts : List ( String, String ), signature : String, aliases : List ( String, String ) }
        every =
            annotation ann

        _ =
            log "    ---"
    in
    case every of
        Err err ->
            [ err ]

        Ok e ->
            List.concat
                [ [ "Signature"
                  , "  " ++ e.signature
                  ]
                , List.map
                    (\( key, val ) ->
                        "  " ++ key ++ ": " ++ val
                    )
                    e.facts
                ]
                |> List.reverse
                |> List.map log


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
        expresh : Compiler.ExpressionDetails
        expresh =
            exp (Index.startIndex Nothing)
    in
    annotation expresh.annotation


{-| -}
annotation :
    Result
        (List Compiler.InferenceError)
        Compiler.Inference
    ->
        Result
            String
            { facts : List ( String, String )
            , signature : String
            , aliases : List ( String, String )
            }
annotation ann =
    case ann of
        Ok sig ->
            let
                allFacts : List ( String, String )
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
            inferenceError
                |> List.map Compiler.inferenceErrorToString
                |> String.join "\n\n"
                |> Err
