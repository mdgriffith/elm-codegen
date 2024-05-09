module Internal.Arg exposing
    ( Arg(..)
    , ArgDetails
    , Expression
    , Module
    , field
    , record
    , toDetails
    , triple
    , tuple
    , unit
    , val
    , var
    , varWith
    )

import Dict
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index


type alias Expression =
    Compiler.Expression


type Arg val
    = Arg
        (Index.Index
         ->
            { details : ArgDetails
            , value : val
            }
        )


type alias Module =
    List String


type alias ArgDetails =
    { imports : List Module
    , pattern : Node.Node Pattern.Pattern
    , annotation :
        Result
            (List Compiler.InferenceError)
            Compiler.Inference
    }


toDetails :
    Index.Index
    -> Arg val
    ->
        { details : ArgDetails
        , value : val
        }
toDetails index (Arg arg) =
    arg index


{-| -}
unit : Arg Expression
unit =
    Arg
        (\index ->
            let
                annotation =
                    Ok (Compiler.inference Annotation.Unit)

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify Pattern.UnitPattern
                , annotation = annotation
                }
            , value =
                Compiler.Expression <|
                    \_ ->
                        { expression = Exp.UnitExpr
                        , annotation = Ok (Compiler.inference Annotation.Unit)
                        , imports = imports
                        }
            }
        )


{-| -}
tuple : Arg one -> Arg two -> Arg ( one, two )
tuple (Arg arg1) (Arg arg2) =
    Arg
        (\index ->
            let
                one =
                    arg1 index

                details1 =
                    one
                        |> .details

                two =
                    arg2 index

                details2 =
                    two
                        |> .details

                annotation =
                    Result.map2
                        (\oneA twoA ->
                            { type_ =
                                Annotation.Tupled
                                    [ Compiler.nodify oneA.type_
                                    , Compiler.nodify twoA.type_
                                    ]
                            , inferences =
                                oneA.inferences
                                    |> Compiler.mergeInferences twoA.inferences
                            , aliases =
                                oneA.aliases
                                    |> Compiler.mergeAliases twoA.aliases
                            }
                        )
                        details1.annotation
                        details1.annotation

                imports =
                    List.concat [ details1.imports, details2.imports ]
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify (Pattern.TuplePattern [ details1.pattern, details2.pattern ])
                , annotation = annotation
                }
            , value =
                ( one.value
                , two.value
                )
            }
        )


{-| -}
triple : Arg one -> Arg two -> Arg three -> Arg ( one, two, three )
triple (Arg arg1) (Arg arg2) (Arg arg3) =
    Arg
        (\index ->
            let
                one =
                    arg1 index

                details1 =
                    one
                        |> .details

                two =
                    arg2 index

                details2 =
                    two
                        |> .details

                three =
                    arg3 index

                details3 =
                    three
                        |> .details

                annotation =
                    Result.map3
                        (\oneA twoA threeA ->
                            { type_ =
                                Annotation.Tupled
                                    [ Compiler.nodify oneA.type_
                                    , Compiler.nodify twoA.type_
                                    , Compiler.nodify threeA.type_
                                    ]
                            , inferences =
                                oneA.inferences
                                    |> Compiler.mergeInferences twoA.inferences
                                    |> Compiler.mergeInferences threeA.inferences
                            , aliases =
                                oneA.aliases
                                    |> Compiler.mergeAliases twoA.aliases
                                    |> Compiler.mergeAliases threeA.aliases
                            }
                        )
                        details1.annotation
                        details2.annotation
                        details3.annotation

                imports =
                    List.concat [ details1.imports, details2.imports, details3.imports ]
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify (Pattern.TuplePattern [ details1.pattern, details2.pattern, details3.pattern ])
                , annotation = annotation
                }
            , value =
                ( one.value
                , two.value
                , three.value
                )
            }
        )


val :
    Index.Index
    -> String
    ->
        ( Compiler.Expression
        , Result
            (List Compiler.InferenceError)
            Compiler.Inference
        , Annotation.TypeAnnotation
        )
val index name =
    let
        type_ =
            Annotation.GenericType name

        annotation =
            let
                typename : String
                typename =
                    Index.protectTypeName name index
            in
            Ok
                { type_ = type_
                , inferences = Dict.empty
                , aliases = Compiler.emptyAliases
                }
    in
    ( Compiler.Expression <|
        \_ ->
            { expression =
                -- This *must* be an un-protected name, where we only use
                -- literally what the dev gives us, because we are trying
                -- to refer to something that already exists.
                Exp.FunctionOrValue []
                    (Format.sanitize name)
            , annotation = annotation
            , imports = []
            }
    , annotation
    , type_
    )


{-| -}
var : String -> Arg Expression
var name =
    Arg
        (\index ->
            let
                ( value, annotation, _ ) =
                    val index name

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.VarPattern name)
                , annotation = annotation
                }
            , value = value
            }
        )


{-| -}
varWith : String -> Compiler.Annotation -> Arg Expression
varWith name ann =
    Arg
        (\index ->
            let
                annotation =
                    Ok (Compiler.getInnerInference index ann)

                imports =
                    Compiler.getAnnotationImports ann
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.VarPattern name)
                , annotation = annotation
                }
            , value =
                Compiler.Expression <|
                    \_ ->
                        { expression =
                            -- This *must* be an un-protected name, where we only use
                            -- literally what the dev gives us, because we are trying
                            -- to refer to something that already exists.
                            Exp.FunctionOrValue []
                                (Format.sanitize name)
                        , annotation = annotation
                        , imports = imports
                        }
            }
        )


record : a -> Arg a
record toRecord =
    Arg
        (\index ->
            let
                annotation =
                    Ok
                        { type_ = Annotation.Record []
                        , inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        }

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify (Pattern.RecordPattern [])
                , annotation = annotation
                }
            , value =
                toRecord
            }
        )


{-| -}
field : String -> Arg (Expression -> a) -> Arg a
field name (Arg arg) =
    Arg
        (\index ->
            let
                toRecord =
                    arg index

                details =
                    toRecord
                        |> .details

                newAnnotation =
                    Result.map
                        (\ann ->
                            { type_ =
                                case ann.type_ of
                                    Annotation.Record fields ->
                                        Annotation.Record
                                            (fields
                                                ++ [ Compiler.nodify
                                                        ( Compiler.nodify name
                                                        , Compiler.nodify fieldType
                                                        )
                                                   ]
                                            )

                                    _ ->
                                        ann.type_
                            , inferences = ann.inferences
                            , aliases = ann.aliases
                            }
                        )
                        details.annotation

                imports =
                    details.imports

                ( fieldExpression, fieldAnnotation, fieldType ) =
                    val index name
            in
            { details =
                { imports = imports
                , pattern =
                    case Compiler.denode details.pattern of
                        Pattern.RecordPattern fields ->
                            Compiler.nodify (Pattern.RecordPattern (fields ++ [ Compiler.nodify name ]))

                        _ ->
                            Compiler.nodify (Pattern.RecordPattern [ Compiler.nodify name ])
                , annotation = newAnnotation
                }
            , value =
                toRecord.value fieldExpression
            }
        )
