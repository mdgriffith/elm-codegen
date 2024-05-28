module Internal.Arg exposing
    ( Arg(..), ArgDetails, Expression, Module, toDetails
    , aliasAs
    , var, varWith
    , triple, tuple
    , char, string
    , customType
    , item, list, listRemaining, record, field
    , ignore, unit
    )

{-|

@docs Arg, ArgDetails, Expression, Module, toDetails

@docs aliasAs

@docs var, varWith

@docs triple, tuple

@docs char, string

@docs customType

@docs item, list, listRemaining, record, field

@docs ignore, unit

-}

import Dict
import Elm.Syntax.Expression as Exp
import Elm.Syntax.Node as Node
import Elm.Syntax.Pattern as Pattern
import Elm.Syntax.TypeAnnotation as Annotation
import Internal.Compiler as Compiler
import Internal.Format as Format
import Internal.Index as Index
import Internal.Types


type alias Expression =
    Compiler.Expression


type Arg val
    = Arg
        (Index.Index
         ->
            { details : ArgDetails
            , value : val
            , index : Index.Index
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
        , index : Index.Index
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
            in
            { details =
                { imports = []
                , pattern = Compiler.nodify Pattern.UnitPattern
                , annotation = annotation
                }
            , index = Index.next index
            , value =
                Compiler.Expression <|
                    \_ ->
                        { expression = Exp.UnitExpr
                        , annotation = Ok (Compiler.inference Annotation.Unit)
                        , imports = []
                        }
            }
        )


{-| -}
string : String -> Arg Expression
string str =
    Arg
        (\index ->
            let
                annotation =
                    Ok
                        { inferences = Dict.empty
                        , type_ = Internal.Types.string
                        , aliases = Compiler.emptyAliases
                        }

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.StringPattern str)
                , annotation = annotation
                }
            , index = Index.next index
            , value =
                Compiler.Expression <|
                    \_ ->
                        { expression = Exp.Literal str
                        , annotation = annotation
                        , imports = imports
                        }
            }
        )


{-| -}
aliasAs : String -> Arg arg -> Arg ( arg, Expression )
aliasAs aliasName (Arg toArgDetails) =
    Arg
        (\index ->
            let
                innerArgDetails =
                    toArgDetails index

                ( aliasVal, _, _ ) =
                    val innerArgDetails.index aliasName
            in
            { details =
                { imports = innerArgDetails.details.imports
                , pattern =
                    Pattern.AsPattern
                        innerArgDetails.details.pattern
                        (Compiler.nodify aliasName)
                        |> Compiler.nodify
                , annotation = innerArgDetails.details.annotation
                }
            , index = Index.next innerArgDetails.index
            , value =
                ( innerArgDetails.value
                , aliasVal
                )
            }
        )


{-| -}
char : Char -> Arg Expression
char c =
    Arg
        (\index ->
            let
                annotation =
                    Ok
                        { inferences = Dict.empty
                        , type_ = Internal.Types.char
                        , aliases = Compiler.emptyAliases
                        }

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.CharPattern c)
                , annotation = annotation
                }
            , index = Index.next index
            , value =
                Compiler.Expression <|
                    \_ ->
                        { expression = Exp.CharLiteral c
                        , annotation = annotation
                        , imports = imports
                        }
            }
        )


{-| -}
ignore : Arg Expression
ignore =
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
                , pattern = Compiler.nodify Pattern.AllPattern
                , annotation = annotation
                }
            , index = Index.next index
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
                    arg2 one.index

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
                        details2.annotation

                imports =
                    details1.imports ++ details2.imports
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify
                        (Pattern.TuplePattern
                            [ details1.pattern
                            , details2.pattern
                            ]
                        )
                , annotation = annotation
                }
            , index = Index.next two.index
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
                    arg2 one.index

                details2 =
                    two
                        |> .details

                three =
                    arg3 two.index

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
            , index = Index.next three.index
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
        typename : String
        typename =
            Index.protectTypeName name index

        type_ =
            Annotation.GenericType typename

        annotation =
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
var rawName =
    Arg
        (\index ->
            let
                ( name, nameIndex ) =
                    Index.getName rawName index

                ( value, annotation, _ ) =
                    val nameIndex name

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.VarPattern name)
                , annotation = annotation
                }
            , index = Index.next nameIndex
            , value = value
            }
        )


{-| -}
varWith : String -> Compiler.Annotation -> Arg Expression
varWith rawName ann =
    Arg
        (\index ->
            let
                ( name, nameIndex ) =
                    Index.getName rawName index

                annotation =
                    Ok (Compiler.getInnerInference nameIndex ann)

                imports =
                    Compiler.getAnnotationImports ann
            in
            { details =
                { imports = imports
                , pattern = Compiler.nodify (Pattern.VarPattern name)
                , annotation = annotation
                }
            , index = Index.next nameIndex
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


list : a -> Arg a
list toList =
    Arg
        (\index ->
            let
                annotation =
                    Ok
                        { type_ = Internal.Types.list (Annotation.GenericType "list")
                        , inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        }

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify (Pattern.ListPattern [])
                , annotation = annotation
                }
            , index = Index.next index
            , value =
                toList
            }
        )


customType : String -> a -> Arg a
customType name toType =
    Arg
        (\index ->
            let
                annotation =
                    Ok
                        { type_ = Internal.Types.custom [] name []
                        , inferences = Dict.empty
                        , aliases = Compiler.emptyAliases
                        }

                imports =
                    []
            in
            { details =
                { imports = imports
                , pattern =
                    Compiler.nodify
                        (Pattern.NamedPattern
                            { moduleName = []
                            , name = name
                            }
                            []
                        )
                , annotation = annotation
                }
            , index = Index.dive index
            , value =
                toType
            }
        )


toUncons : List (Node.Node Pattern.Pattern) -> Pattern.Pattern -> Node.Node Pattern.Pattern
toUncons listItems lastItem =
    case listItems of
        [] ->
            Compiler.nodify lastItem

        first :: rest ->
            Compiler.nodify
                (Pattern.UnConsPattern
                    first
                    (toUncons rest lastItem)
                )


listRemaining : String -> Arg (Expression -> a) -> Arg a
listRemaining variableName (Arg toRemaining) =
    Arg
        (\index ->
            let
                toSequence =
                    toRemaining index

                imports =
                    []

                ( variable, _, _ ) =
                    val toSequence.index variableName
            in
            { details =
                { imports = imports
                , pattern =
                    case Compiler.denode toSequence.details.pattern of
                        Pattern.ListPattern listItems ->
                            toUncons listItems (Pattern.VarPattern variableName)

                        _ ->
                            toSequence.details.pattern
                , annotation = toSequence.details.annotation
                }
            , index = Index.next toSequence.index
            , value =
                toSequence.value variable
            }
        )


item : Arg arg -> Arg (arg -> a) -> Arg a
item (Arg itemArg) (Arg arg) =
    Arg
        (\index ->
            let
                toSequence =
                    arg index

                itemDetails =
                    itemArg toSequence.index

                details =
                    toSequence
                        |> .details

                newAnnotation =
                    Result.map
                        (\ann ->
                            { type_ =
                                ann.type_
                            , inferences = ann.inferences
                            , aliases = ann.aliases
                            }
                        )
                        details.annotation

                imports =
                    details.imports
            in
            { details =
                { imports = imports
                , pattern =
                    case Compiler.denode details.pattern of
                        Pattern.ListPattern listItems ->
                            Compiler.nodify (Pattern.ListPattern (listItems ++ [ itemDetails.details.pattern ]))

                        Pattern.NamedPattern base variantItems ->
                            Compiler.nodify (Pattern.NamedPattern base (variantItems ++ [ itemDetails.details.pattern ]))

                        _ ->
                            details.pattern
                , annotation = newAnnotation
                }
            , index = Index.next itemDetails.index
            , value =
                toSequence.value itemDetails.value
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
            , index = Index.next index
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

                ( fieldExpression, _, fieldType ) =
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
            , index = Index.next index
            , value =
                toRecord.value fieldExpression
            }
        )
