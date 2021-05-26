module Elm.Gen.GraphQL.Engine exposing (arg, decodeId, encodeId, enum, field, fieldWith, id_, map, map2, maybeEnum, maybeScalarEncode, moduleName_, mutation, nullable, object, objectWith, query, queryString, recover, select, union, with)

import Elm
import Elm.Annotation


{-| The name of this module. -}
moduleName_ : Elm.Module
moduleName_ =
    Elm.moduleName [ "GraphQL", "Engine" ]


{-| Every value/function in this module in case you need to refer to it directly. -}
id_ :
    { nullable : Elm.Expression
    , field : Elm.Expression
    , fieldWith : Elm.Expression
    , object : Elm.Expression
    , objectWith : Elm.Expression
    , enum : Elm.Expression
    , maybeEnum : Elm.Expression
    , union : Elm.Expression
    , select : Elm.Expression
    , with : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , recover : Elm.Expression
    , arg : Elm.Expression
    , query : Elm.Expression
    , mutation : Elm.Expression
    , queryString : Elm.Expression
    , maybeScalarEncode : Elm.Expression
    , encodeId : Elm.Expression
    , decodeId : Elm.Expression
    }
id_ =
    { nullable = Elm.valueFrom moduleName_ "nullable"
    , field = Elm.valueFrom moduleName_ "field"
    , fieldWith = Elm.valueFrom moduleName_ "fieldWith"
    , object = Elm.valueFrom moduleName_ "object"
    , objectWith = Elm.valueFrom moduleName_ "objectWith"
    , enum = Elm.valueFrom moduleName_ "enum"
    , maybeEnum = Elm.valueFrom moduleName_ "maybeEnum"
    , union = Elm.valueFrom moduleName_ "union"
    , select = Elm.valueFrom moduleName_ "select"
    , with = Elm.valueFrom moduleName_ "with"
    , map = Elm.valueFrom moduleName_ "map"
    , map2 = Elm.valueFrom moduleName_ "map2"
    , recover = Elm.valueFrom moduleName_ "recover"
    , arg = Elm.valueFrom moduleName_ "arg"
    , query = Elm.valueFrom moduleName_ "query"
    , mutation = Elm.valueFrom moduleName_ "mutation"
    , queryString = Elm.valueFrom moduleName_ "queryString"
    , maybeScalarEncode = Elm.valueFrom moduleName_ "maybeScalarEncode"
    , encodeId = Elm.valueFrom moduleName_ "encodeId"
    , decodeId = Elm.valueFrom moduleName_ "decodeId"
    }


{-|
Used in generated code to handle maybes
-}
nullable : Elm.Expression -> Elm.Expression
nullable arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "nullable") [ arg1 ]


{-| -}
field : Elm.Expression -> Elm.Expression -> Elm.Expression
field arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "field") [ arg1, arg2 ]


{-| -}
fieldWith : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
fieldWith arg1 arg2 arg3 =
    Elm.apply (Elm.valueFrom moduleName_ "fieldWith") [ arg1, arg2, arg3 ]


{-| -}
object : Elm.Expression -> Elm.Expression -> Elm.Expression
object arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "object") [ arg1, arg2 ]


{-| -}
objectWith :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
objectWith arg1 arg2 arg3 =
    Elm.apply (Elm.valueFrom moduleName_ "objectWith") [ arg1, arg2, arg3 ]


{-| -}
enum : Elm.Expression -> Elm.Expression
enum arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "enum") [ arg1 ]


{-| -}
maybeEnum : Elm.Expression -> Elm.Expression
maybeEnum arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "maybeEnum") [ arg1 ]


{-| -}
union : Elm.Expression -> Elm.Expression
union arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "union") [ arg1 ]


{-| -}
typeSelection : { annotation : Elm.Annotation.Annotation }
typeSelection =
    { annotation = Elm.Annotation.named moduleName_ "Selection" }


{-| -}
select : Elm.Expression -> Elm.Expression
select arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "select") [ arg1 ]


{-| -}
with : Elm.Expression -> Elm.Expression -> Elm.Expression
with arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "with") [ arg1, arg2 ]


{-| -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "map") [ arg1 Elm.pass, arg2 ]


{-| -}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueFrom moduleName_ "map2")
        [ arg1 Elm.pass Elm.pass, arg2, arg3 ]


{-| -}
recover :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
recover arg1 arg2 arg3 =
    Elm.apply
        (Elm.valueFrom moduleName_ "recover")
        [ arg1, arg2 Elm.pass, arg3 ]


{-| The encoded value and the name of the expected type for this argument
-}
arg : Elm.Expression -> Elm.Expression -> Elm.Expression
arg arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "arg") [ arg1, arg2 ]


{-|-}
typeQuery : { annotation : Elm.Annotation.Annotation }
typeQuery =
    { annotation = Elm.Annotation.named moduleName_ "Query" }


{-|-}
query : Elm.Expression -> Elm.Expression -> Elm.Expression
query arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "query") [ arg1, arg2 ]


{-|-}
typeMutation : { annotation : Elm.Annotation.Annotation }
typeMutation =
    { annotation = Elm.Annotation.named moduleName_ "Mutation" }


{-|-}
mutation : Elm.Expression -> Elm.Expression -> Elm.Expression
mutation arg1 arg2 =
    Elm.apply (Elm.valueFrom moduleName_ "mutation") [ arg1, arg2 ]


{-|

-}
queryString : Elm.Expression -> Elm.Expression
queryString arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "queryString") [ arg1 ]


{-| We can also accept:

  - Enum values (unquoted)
  - custom scalars

But we can define anything else in terms of these:

-}
typeArgument :
    { annotation : Elm.Annotation.Annotation
    , argValue : Elm.Expression
    , var : Elm.Expression
    }
typeArgument =
    { annotation = Elm.Annotation.named moduleName_ "Argument"
    , argValue = Elm.valueFrom moduleName_ "ArgValue"
    , var = Elm.valueFrom moduleName_ "Var"
    }


{-|-}
maybeScalarEncode :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
maybeScalarEncode arg1 arg2 =
    Elm.apply
        (Elm.valueFrom moduleName_ "maybeScalarEncode")
        [ arg1 Elm.pass, arg2 ]


{-|-}
typeId : { annotation : Elm.Annotation.Annotation }
typeId =
    { annotation = Elm.Annotation.named moduleName_ "Id" }


{-|-}
encodeId : Elm.Expression -> Elm.Expression
encodeId arg1 =
    Elm.apply (Elm.valueFrom moduleName_ "encodeId") [ arg1 ]


{-|-}
decodeId : Elm.Expression
decodeId =
    Elm.valueFrom moduleName_ "decodeId"


{-|-}
typeOptional :
    { annotation : Elm.Annotation.Annotation, optional : Elm.Expression }
typeOptional =
    { annotation = Elm.Annotation.named moduleName_ "Optional"
    , optional = Elm.valueFrom moduleName_ "Optional"
    }
