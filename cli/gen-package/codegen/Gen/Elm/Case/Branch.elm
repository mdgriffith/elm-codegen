module Gen.Elm.Case.Branch exposing (aliasAs, annotation_, call_, char, customType, err, ignore, int, just, list, listWithRemaining, map, moduleName_, nothing, ok, record0, record1, record2, record3, record4, record5, record6, record7, record8, record9, string, toPattern, triple, tuple, unit, values_, var, variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9, withParam)

{-| 
@docs moduleName_, map, var, unit, ignore, int, string, char, tuple, triple, list, listWithRemaining, just, nothing, err, ok, record0, record1, record2, record3, record4, record5, record6, record7, record8, record9, variant0, variant1, variant2, variant3, variant4, variant5, variant6, variant7, variant8, variant9, customType, withParam, toPattern, aliasAs, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Elm", "Case", "Branch" ]


{-| map: (a -> b) -> Elm.Case.Branch.Pattern a -> Elm.Case.Branch.Pattern b -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| This is the most basic kind of pattern - it matches anything and gives it a variable name.

    example =
        Elm.Case.Branch.variant1 "Username"
            (Elm.Case.Branch.var "username")
            |> Elm.Case.Branch.map
                (\username ->
                    Elm.Op.append
                        (Elm.string "Hello ")
                        username
                )

var: String -> Elm.Case.Branch.Pattern Elm.Expression
-}
var : String -> Elm.Expression
var varArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        )
                    )
            }
        )
        [ Elm.string varArg ]


{-| unit: value -> Elm.Case.Branch.Pattern value -}
unit : Elm.Expression -> Elm.Expression
unit unitArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "unit"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ unitArg ]


{-| ignore: value -> Elm.Case.Branch.Pattern value -}
ignore : Elm.Expression -> Elm.Expression
ignore ignoreArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "ignore"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ ignoreArg ]


{-| Pattern match with a literal Int.

    example =
        Elm.Case.Branch.variant1 "Just" (Elm.Case.Branch.int 2)

Results in

    case value of
        Just 2 ->
            2

int: Int -> Elm.Case.Branch.Pattern Int
-}
int : Int -> Elm.Expression
int intArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.int ]
                        )
                    )
            }
        )
        [ Elm.int intArg ]


{-| Matches a literal String.

    example =
        Branch.just (Branch.string "admin")
            |> Branch.map
                (\str ->
                    Elm.string "This user is an admin!"
                )

Results in

    case user.kind of
        Just "admin" ->
            "This user is an admin!"

string: String -> Elm.Case.Branch.Pattern String
-}
string : String -> Elm.Expression
string stringArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.string ]
                        )
                    )
            }
        )
        [ Elm.string stringArg ]


{-| Matches a literal Char.

char: Char.Char -> Elm.Case.Branch.Pattern Char.Char
-}
char : Char.Char -> Elm.Expression
char charArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "char"
            , annotation =
                Just
                    (Type.function
                        [ Type.char ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.char ]
                        )
                    )
            }
        )
        [ Elm.char charArg ]


{-| Branch.tuple (Branch.var "one") (Branch.var "two")
        |> Branch.map
            (\( one, two ) ->
                Elm.Op.append one two
            )

tuple: 
    Elm.Case.Branch.Pattern a
    -> Elm.Case.Branch.Pattern b
    -> Elm.Case.Branch.Pattern ( a, b )
-}
tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
tuple tupleArg tupleArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.tuple (Type.var "a") (Type.var "b") ]
                        )
                    )
            }
        )
        [ tupleArg, tupleArg0 ]


{-| triple: 
    Elm.Case.Branch.Pattern a
    -> Elm.Case.Branch.Pattern b
    -> Elm.Case.Branch.Pattern c
    -> Elm.Case.Branch.Pattern ( a, b, c )
-}
triple : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
triple tripleArg tripleArg0 tripleArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.triple
                                (Type.var "a")
                                (Type.var "b")
                                (Type.var "c")
                            ]
                        )
                    )
            }
        )
        [ tripleArg, tripleArg0, tripleArg1 ]


{-| Match on a list of items

    [ "first", "second" ] ->
        "firstsecond"

Could be represented like

    Branch.list
        { patterns =
            [ Branch.string "first"
            , Branch.string "second"
            ]
        , gather = \item gathered -> item :: gathered
        , startWith = []
        , finally = Elm.string
        }

list: 
    { patterns : List (Elm.Case.Branch.Pattern item)
    , gather : item -> gathered -> gathered
    , startWith : gathered
    , finally : gathered -> list
    }
    -> Elm.Case.Branch.Pattern list
-}
list :
    { patterns : List Elm.Expression
    , gather : Elm.Expression -> Elm.Expression -> Elm.Expression
    , startWith : Elm.Expression
    , finally : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
list listArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "patterns"
                              , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Case", "Branch" ]
                                        "Pattern"
                                        [ Type.var "item" ]
                                    )
                              )
                            , ( "gather"
                              , Type.function
                                    [ Type.var "item", Type.var "gathered" ]
                                    (Type.var "gathered")
                              )
                            , ( "startWith", Type.var "gathered" )
                            , ( "finally"
                              , Type.function
                                    [ Type.var "gathered" ]
                                    (Type.var "list")
                              )
                            ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "list" ]
                        )
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "patterns" (Elm.list listArg.patterns)
            , Tuple.pair
                "gather"
                (Elm.functionReduced
                    "listUnpack"
                    (\functionReducedUnpack ->
                        Elm.functionReduced
                            "unpack"
                            (listArg.gather functionReducedUnpack)
                    )
                )
            , Tuple.pair "startWith" listArg.startWith
            , Tuple.pair
                "finally"
                (Elm.functionReduced "listUnpack" listArg.finally)
            ]
        ]


{-| Pattern match on an open list where you can have access to remaining "tail" of items.

So, something like this:

    "first" :: "second" :: remaining ->
        remaining

Could be represented like

    Branch.listWithRemaining
        { patterns =
            [ Branch.string "first"
            , Branch.string "second"
            ]
        , remaining = Branch.var "remaining"
        , gather = \item gathered -> item :: gathered
        , startWith = []
        , finally =
            \gathered remaining ->
                remaining
        }

listWithRemaining: 
    { patterns : List (Elm.Case.Branch.Pattern item)
    , remaining : Elm.Case.Branch.Pattern remaining
    , gather : item -> gathered -> gathered
    , startWith : gathered
    , finally : gathered -> remaining -> list
    }
    -> Elm.Case.Branch.Pattern list
-}
listWithRemaining :
    { patterns : List Elm.Expression
    , remaining : Elm.Expression
    , gather : Elm.Expression -> Elm.Expression -> Elm.Expression
    , startWith : Elm.Expression
    , finally : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
listWithRemaining listWithRemainingArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "listWithRemaining"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "patterns"
                              , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Case", "Branch" ]
                                        "Pattern"
                                        [ Type.var "item" ]
                                    )
                              )
                            , ( "remaining"
                              , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "remaining" ]
                              )
                            , ( "gather"
                              , Type.function
                                    [ Type.var "item", Type.var "gathered" ]
                                    (Type.var "gathered")
                              )
                            , ( "startWith", Type.var "gathered" )
                            , ( "finally"
                              , Type.function
                                    [ Type.var "gathered"
                                    , Type.var "remaining"
                                    ]
                                    (Type.var "list")
                              )
                            ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "list" ]
                        )
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "patterns" (Elm.list listWithRemainingArg.patterns)
            , Tuple.pair "remaining" listWithRemainingArg.remaining
            , Tuple.pair
                "gather"
                (Elm.functionReduced
                    "listWithRemainingUnpack"
                    (\functionReducedUnpack ->
                        Elm.functionReduced
                            "unpack"
                            (listWithRemainingArg.gather functionReducedUnpack)
                    )
                )
            , Tuple.pair "startWith" listWithRemainingArg.startWith
            , Tuple.pair
                "finally"
                (Elm.functionReduced
                    "listWithRemainingUnpack"
                    (\functionReducedUnpack ->
                        Elm.functionReduced
                            "unpack"
                            (listWithRemainingArg.finally functionReducedUnpack)
                    )
                )
            ]
        ]


{-| just: Elm.Case.Branch.Pattern just -> Elm.Case.Branch.Pattern just -}
just : Elm.Expression -> Elm.Expression
just justArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "just"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "just" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "just" ]
                        )
                    )
            }
        )
        [ justArg ]


{-| nothing: value -> Elm.Case.Branch.Pattern value -}
nothing : Elm.Expression -> Elm.Expression
nothing nothingArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "nothing"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ nothingArg ]


{-| `Err` variant. A simple helper of `variant1 "Err"`.

err: Elm.Case.Branch.Pattern err -> Elm.Case.Branch.Pattern err
-}
err : Elm.Expression -> Elm.Expression
err errArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "err"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "err" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "err" ]
                        )
                    )
            }
        )
        [ errArg ]


{-| `Ok` variant. A simple helper of `variant1 "Ok"`.

ok: Elm.Case.Branch.Pattern ok -> Elm.Case.Branch.Pattern ok
-}
ok : Elm.Expression -> Elm.Expression
ok okArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "ok"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "ok" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "ok" ]
                        )
                    )
            }
        )
        [ okArg ]


{-| An empty record pattern!

record0: record -> Elm.Case.Branch.Pattern record
-}
record0 : Elm.Expression -> Elm.Expression
record0 record0Arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record0"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "record" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "record" ]
                        )
                    )
            }
        )
        [ record0Arg ]


{-| record1: (Elm.Expression -> record) -> String -> Elm.Case.Branch.Pattern record -}
record1 : (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
record1 record1Arg record1Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record1"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.var "record")
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "record" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "record1Unpack" record1Arg
        , Elm.string record1Arg0
        ]


{-| record2: 
    (Elm.Expression -> Elm.Expression -> combined)
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> String
    -> String
    -> Elm.Expression
record2 record2Arg record2Arg0 record2Arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record2Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (record2Arg functionReducedUnpack)
            )
        , Elm.string record2Arg0
        , Elm.string record2Arg1
        ]


{-| record3: 
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> combined)
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> String
    -> String
    -> String
    -> Elm.Expression
record3 record3Arg record3Arg0 record3Arg1 record3Arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record3Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (record3Arg functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
        , Elm.string record3Arg0
        , Elm.string record3Arg1
        , Elm.string record3Arg2
        ]


{-| record4: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record4 record4Arg record4Arg0 record4Arg1 record4Arg2 record4Arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record4Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (record4Arg functionReducedUnpack
                                         functionReducedUnpack0
                                        functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                    )
                            )
                    )
            )
        , Elm.string record4Arg0
        , Elm.string record4Arg1
        , Elm.string record4Arg2
        , Elm.string record4Arg3
        ]


{-| record5: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record5 record5Arg record5Arg0 record5Arg1 record5Arg2 record5Arg3 record5Arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record5Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (record5Arg functionReducedUnpack
                                                 functionReducedUnpack0
                                                 functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                            )
                                    )
                            )
                    )
            )
        , Elm.string record5Arg0
        , Elm.string record5Arg1
        , Elm.string record5Arg2
        , Elm.string record5Arg3
        , Elm.string record5Arg4
        ]


{-| record6: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record6 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record6 record6Arg record6Arg0 record6Arg1 record6Arg2 record6Arg3 record6Arg4 record6Arg5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record6"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record6Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (record6Arg
                                                         functionReducedUnpack
                                                         functionReducedUnpack0
                                                         functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                         functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                        functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                    )
                                            )
                                    )
                            )
                    )
            )
        , Elm.string record6Arg0
        , Elm.string record6Arg1
        , Elm.string record6Arg2
        , Elm.string record6Arg3
        , Elm.string record6Arg4
        , Elm.string record6Arg5
        ]


{-| record7: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record7 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record7 record7Arg record7Arg0 record7Arg1 record7Arg2 record7Arg3 record7Arg4 record7Arg5 record7Arg6 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record7"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record7Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (record7Arg
                                                                 functionReducedUnpack
                                                                 functionReducedUnpack0
                                                                 functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                 functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                 functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        , Elm.string record7Arg0
        , Elm.string record7Arg1
        , Elm.string record7Arg2
        , Elm.string record7Arg3
        , Elm.string record7Arg4
        , Elm.string record7Arg5
        , Elm.string record7Arg6
        ]


{-| record8: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record8 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record8 record8Arg record8Arg0 record8Arg1 record8Arg2 record8Arg3 record8Arg4 record8Arg5 record8Arg6 record8Arg7 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record8"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record8Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                Elm.functionReduced
                                                                    "unpack"
                                                                    (record8Arg
                                                                         functionReducedUnpack
                                                                         functionReducedUnpack0
                                                                         functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                        functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                    )
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        , Elm.string record8Arg0
        , Elm.string record8Arg1
        , Elm.string record8Arg2
        , Elm.string record8Arg3
        , Elm.string record8Arg4
        , Elm.string record8Arg5
        , Elm.string record8Arg6
        , Elm.string record8Arg7
        ]


{-| record9: 
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> combined)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Case.Branch.Pattern combined
-}
record9 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> String
    -> Elm.Expression
record9 record9Arg record9Arg0 record9Arg1 record9Arg2 record9Arg3 record9Arg4 record9Arg5 record9Arg6 record9Arg7 record9Arg8 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record9"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "record9Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                Elm.functionReduced
                                                                    "unpack"
                                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                        Elm.functionReduced
                                                                            "unpack"
                                                                            (record9Arg
                                                                                 functionReducedUnpack
                                                                                 functionReducedUnpack0
                                                                                 functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                            )
                                                                    )
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        , Elm.string record9Arg0
        , Elm.string record9Arg1
        , Elm.string record9Arg2
        , Elm.string record9Arg3
        , Elm.string record9Arg4
        , Elm.string record9Arg5
        , Elm.string record9Arg6
        , Elm.string record9Arg7
        , Elm.string record9Arg8
        ]


{-| variant0: String -> value -> Elm.Case.Branch.Pattern value -}
variant0 : String -> Elm.Expression -> Elm.Expression
variant0 variant0Arg variant0Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant0"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.string variant0Arg, variant0Arg0 ]


{-| variant1: 
    String
    -> Elm.Case.Branch.Pattern value
    -> (value -> result)
    -> Elm.Case.Branch.Pattern result
-}
variant1 :
    String
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
variant1 variant1Arg variant1Arg0 variant1Arg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant1"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        , Type.function [ Type.var "value" ] (Type.var "result")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "result" ]
                        )
                    )
            }
        )
        [ Elm.string variant1Arg
        , variant1Arg0
        , Elm.functionReduced "variant1Unpack" variant1Arg1
        ]


{-| variant2: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> (value1 -> value2 -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant2 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
variant2 variant2Arg variant2Arg0 variant2Arg1 variant2Arg2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.function
                            [ Type.var "value1", Type.var "value2" ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant2Arg
        , variant2Arg0
        , variant2Arg1
        , Elm.functionReduced
            "variant2Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (variant2Arg2 functionReducedUnpack)
            )
        ]


{-| variant3: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> (value1 -> value2 -> value3 -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant3 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
variant3 variant3Arg variant3Arg0 variant3Arg1 variant3Arg2 variant3Arg3 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant3Arg
        , variant3Arg0
        , variant3Arg1
        , variant3Arg2
        , Elm.functionReduced
            "variant3Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (variant3Arg3 functionReducedUnpack
                                functionReducedUnpack0
                            )
                    )
            )
        ]


{-| variant4: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> (value1 -> value2 -> value3 -> value4 -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant4 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant4 variant4Arg variant4Arg0 variant4Arg1 variant4Arg2 variant4Arg3 variant4Arg4 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant4Arg
        , variant4Arg0
        , variant4Arg1
        , variant4Arg2
        , variant4Arg3
        , Elm.functionReduced
            "variant4Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_5_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (variant4Arg4 functionReducedUnpack
                                         functionReducedUnpack0
                                        functionReducedUnpack_2_1_2_0_2_5_2_0_0
                                    )
                            )
                    )
            )
        ]


{-| variant5: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> Elm.Case.Branch.Pattern value5
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant5 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant5 variant5Arg variant5Arg0 variant5Arg1 variant5Arg2 variant5Arg3 variant5Arg4 variant5Arg5 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant5Arg
        , variant5Arg0
        , variant5Arg1
        , variant5Arg2
        , variant5Arg3
        , variant5Arg4
        , Elm.functionReduced
            "variant5Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_6_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (variant5Arg5 functionReducedUnpack
                                                 functionReducedUnpack0
                                                 functionReducedUnpack_2_1_2_0_2_6_2_0_0
                                                functionReducedUnpack_2_1_2_1_2_0_2_6_2_0_0
                                            )
                                    )
                            )
                    )
            )
        ]


{-| variant6: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> Elm.Case.Branch.Pattern value5
    -> Elm.Case.Branch.Pattern value6
    -> (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant6 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant6 variant6Arg variant6Arg0 variant6Arg1 variant6Arg2 variant6Arg3 variant6Arg4 variant6Arg5 variant6Arg6 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant6Arg
        , variant6Arg0
        , variant6Arg1
        , variant6Arg2
        , variant6Arg3
        , variant6Arg4
        , variant6Arg5
        , Elm.functionReduced
            "variant6Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_7_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (variant6Arg6
                                                         functionReducedUnpack
                                                         functionReducedUnpack0
                                                         functionReducedUnpack_2_1_2_0_2_7_2_0_0
                                                         functionReducedUnpack_2_1_2_1_2_0_2_7_2_0_0
                                                        functionReducedUnpack_2_1_2_1_2_1_2_0_2_7_2_0_0
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| variant7: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> Elm.Case.Branch.Pattern value5
    -> Elm.Case.Branch.Pattern value6
    -> Elm.Case.Branch.Pattern value7
    -> (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant7 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant7 variant7Arg variant7Arg0 variant7Arg1 variant7Arg2 variant7Arg3 variant7Arg4 variant7Arg5 variant7Arg6 variant7Arg7 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant7"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant7Arg
        , variant7Arg0
        , variant7Arg1
        , variant7Arg2
        , variant7Arg3
        , variant7Arg4
        , variant7Arg5
        , variant7Arg6
        , Elm.functionReduced
            "variant7Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_8_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_8_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_8_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_8_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (variant7Arg7
                                                                 functionReducedUnpack
                                                                 functionReducedUnpack0
                                                                 functionReducedUnpack_2_1_2_0_2_8_2_0_0
                                                                 functionReducedUnpack_2_1_2_1_2_0_2_8_2_0_0
                                                                 functionReducedUnpack_2_1_2_1_2_1_2_0_2_8_2_0_0
                                                                functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_8_2_0_0
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| variant8: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> Elm.Case.Branch.Pattern value5
    -> Elm.Case.Branch.Pattern value6
    -> Elm.Case.Branch.Pattern value7
    -> Elm.Case.Branch.Pattern value8
    -> (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> value8
    -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant8 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant8 variant8Arg variant8Arg0 variant8Arg1 variant8Arg2 variant8Arg3 variant8Arg4 variant8Arg5 variant8Arg6 variant8Arg7 variant8Arg8 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant8"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value8" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            , Type.var "value8"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant8Arg
        , variant8Arg0
        , variant8Arg1
        , variant8Arg2
        , variant8Arg3
        , variant8Arg4
        , variant8Arg5
        , variant8Arg6
        , variant8Arg7
        , Elm.functionReduced
            "variant8Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_9_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_9_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_9_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_9_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_9_2_0_0 ->
                                                                Elm.functionReduced
                                                                    "unpack"
                                                                    (variant8Arg8
                                                                         functionReducedUnpack
                                                                         functionReducedUnpack0
                                                                         functionReducedUnpack_2_1_2_0_2_9_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_0_2_9_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_1_2_0_2_9_2_0_0
                                                                         functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_9_2_0_0
                                                                        functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_9_2_0_0
                                                                    )
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| variant9: 
    String
    -> Elm.Case.Branch.Pattern value1
    -> Elm.Case.Branch.Pattern value2
    -> Elm.Case.Branch.Pattern value3
    -> Elm.Case.Branch.Pattern value4
    -> Elm.Case.Branch.Pattern value5
    -> Elm.Case.Branch.Pattern value6
    -> Elm.Case.Branch.Pattern value7
    -> Elm.Case.Branch.Pattern value8
    -> Elm.Case.Branch.Pattern value9
    -> (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> value8
    -> value9
    -> combined)
    -> Elm.Case.Branch.Pattern combined
-}
variant9 :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
variant9 variant9Arg variant9Arg0 variant9Arg1 variant9Arg2 variant9Arg3 variant9Arg4 variant9Arg5 variant9Arg6 variant9Arg7 variant9Arg8 variant9Arg9 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant9"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value8" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value9" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            , Type.var "value8"
                            , Type.var "value9"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
        )
        [ Elm.string variant9Arg
        , variant9Arg0
        , variant9Arg1
        , variant9Arg2
        , variant9Arg3
        , variant9Arg4
        , variant9Arg5
        , variant9Arg6
        , variant9Arg7
        , variant9Arg8
        , Elm.functionReduced
            "variant9Unpack"
            (\functionReducedUnpack ->
                Elm.functionReduced
                    "unpack"
                    (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_10_2_0_0 ->
                                Elm.functionReduced
                                    "unpack"
                                    (\functionReducedUnpack_2_1_2_1_2_0_2_10_2_0_0 ->
                                        Elm.functionReduced
                                            "unpack"
                                            (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_10_2_0_0 ->
                                                Elm.functionReduced
                                                    "unpack"
                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0 ->
                                                        Elm.functionReduced
                                                            "unpack"
                                                            (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0 ->
                                                                Elm.functionReduced
                                                                    "unpack"
                                                                    (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0 ->
                                                                        Elm.functionReduced
                                                                            "unpack"
                                                                            (variant9Arg9
                                                                                 functionReducedUnpack
                                                                                 functionReducedUnpack0
                                                                                 functionReducedUnpack_2_1_2_0_2_10_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_0_2_10_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_0_2_10_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0
                                                                                 functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0
                                                                                functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_10_2_0_0
                                                                            )
                                                                    )
                                                            )
                                                    )
                                            )
                                    )
                            )
                    )
            )
        ]


{-| customType: String -> a -> Elm.Case.Branch.CustomType a -}
customType : String -> Elm.Expression -> Elm.Expression
customType customTypeArg customTypeArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.var "a" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.string customTypeArg, customTypeArg0 ]


{-| withParam: 
    Elm.Case.Branch.Pattern a
    -> Elm.Case.Branch.CustomType (a -> b)
    -> Elm.Case.Branch.CustomType b
-}
withParam : Elm.Expression -> Elm.Expression -> Elm.Expression
withParam withParamArg withParamArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "withParam"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.function [ Type.var "a" ] (Type.var "b") ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ withParamArg, withParamArg0 ]


{-| toPattern: Elm.Case.Branch.CustomType a -> Elm.Case.Branch.Pattern a -}
toPattern : Elm.Expression -> Elm.Expression
toPattern toPatternArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "toPattern"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ toPatternArg ]


{-| aliasAs: 
    String
    -> (Elm.Expression -> a -> b)
    -> Elm.Case.Branch.Pattern a
    -> Elm.Case.Branch.Pattern b
-}
aliasAs :
    String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
aliasAs aliasAsArg aliasAsArg0 aliasAsArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "aliasAs"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.var "a"
                            ]
                            (Type.var "b")
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.string aliasAsArg
        , Elm.functionReduced
            "aliasAsUnpack"
            (\functionReducedUnpack ->
                Elm.functionReduced "unpack" (aliasAsArg0 functionReducedUnpack)
            )
        , aliasAsArg1
        ]


annotation_ :
    { branch : Type.Annotation
    , pattern : Type.Annotation -> Type.Annotation
    , customType : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { branch =
        Type.alias
            moduleName_
            "Branch"
            []
            (Type.namedWith [ "Internal", "Branch" ] "Branch" [])
    , pattern =
        \patternArg0 ->
            Type.alias
                moduleName_
                "Pattern"
                [ patternArg0 ]
                (Type.namedWith
                    [ "Internal", "Branch" ]
                    "Pattern"
                    [ Type.var "a" ]
                )
    , customType =
        \customTypeArg0 ->
            Type.namedWith
                [ "Elm", "Case", "Branch" ]
                "CustomType"
                [ customTypeArg0 ]
    }


call_ :
    { map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , var : Elm.Expression -> Elm.Expression
    , unit : Elm.Expression -> Elm.Expression
    , ignore : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , char : Elm.Expression -> Elm.Expression
    , tuple : Elm.Expression -> Elm.Expression -> Elm.Expression
    , triple :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , listWithRemaining : Elm.Expression -> Elm.Expression
    , just : Elm.Expression -> Elm.Expression
    , nothing : Elm.Expression -> Elm.Expression
    , err : Elm.Expression -> Elm.Expression
    , ok : Elm.Expression -> Elm.Expression
    , record0 : Elm.Expression -> Elm.Expression
    , record1 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , record2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , record3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record7 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record8 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , record9 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant0 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant1 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , variant2 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant7 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant8 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , variant9 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , customType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withParam : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toPattern : Elm.Expression -> Elm.Expression
    , aliasAs :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] (Type.var "b")
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ mapArg, mapArg0 ]
    , var =
        \varArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "var"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                )
                            )
                    }
                )
                [ varArg ]
    , unit =
        \unitArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "unit"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "value" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ unitArg ]
    , ignore =
        \ignoreArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "ignore"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "value" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ ignoreArg ]
    , int =
        \intArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "int"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.int ]
                                )
                            )
                    }
                )
                [ intArg ]
    , string =
        \stringArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.string ]
                                )
                            )
                    }
                )
                [ stringArg ]
    , char =
        \charArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "char"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.char ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.char ]
                                )
                            )
                    }
                )
                [ charArg ]
    , tuple =
        \tupleArg tupleArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "tuple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.tuple (Type.var "a") (Type.var "b") ]
                                )
                            )
                    }
                )
                [ tupleArg, tupleArg0 ]
    , triple =
        \tripleArg tripleArg0 tripleArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "triple"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "c" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.triple
                                        (Type.var "a")
                                        (Type.var "b")
                                        (Type.var "c")
                                    ]
                                )
                            )
                    }
                )
                [ tripleArg, tripleArg0, tripleArg1 ]
    , list =
        \listArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "list"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "patterns"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Elm", "Case", "Branch" ]
                                                "Pattern"
                                                [ Type.var "item" ]
                                            )
                                      )
                                    , ( "gather"
                                      , Type.function
                                            [ Type.var "item"
                                            , Type.var "gathered"
                                            ]
                                            (Type.var "gathered")
                                      )
                                    , ( "startWith", Type.var "gathered" )
                                    , ( "finally"
                                      , Type.function
                                            [ Type.var "gathered" ]
                                            (Type.var "list")
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "list" ]
                                )
                            )
                    }
                )
                [ listArg ]
    , listWithRemaining =
        \listWithRemainingArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "listWithRemaining"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "patterns"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Elm", "Case", "Branch" ]
                                                "Pattern"
                                                [ Type.var "item" ]
                                            )
                                      )
                                    , ( "remaining"
                                      , Type.namedWith
                                            [ "Elm", "Case", "Branch" ]
                                            "Pattern"
                                            [ Type.var "remaining" ]
                                      )
                                    , ( "gather"
                                      , Type.function
                                            [ Type.var "item"
                                            , Type.var "gathered"
                                            ]
                                            (Type.var "gathered")
                                      )
                                    , ( "startWith", Type.var "gathered" )
                                    , ( "finally"
                                      , Type.function
                                            [ Type.var "gathered"
                                            , Type.var "remaining"
                                            ]
                                            (Type.var "list")
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "list" ]
                                )
                            )
                    }
                )
                [ listWithRemainingArg ]
    , just =
        \justArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "just"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "just" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "just" ]
                                )
                            )
                    }
                )
                [ justArg ]
    , nothing =
        \nothingArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "nothing"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "value" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ nothingArg ]
    , err =
        \errArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "err"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "err" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "err" ]
                                )
                            )
                    }
                )
                [ errArg ]
    , ok =
        \okArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "ok"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "ok" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "ok" ]
                                )
                            )
                    }
                )
                [ okArg ]
    , record0 =
        \record0Arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record0"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "record" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "record" ]
                                )
                            )
                    }
                )
                [ record0Arg ]
    , record1 =
        \record1Arg record1Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record1"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.var "record")
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "record" ]
                                )
                            )
                    }
                )
                [ record1Arg, record1Arg0 ]
    , record2 =
        \record2Arg record2Arg0 record2Arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record2Arg, record2Arg0, record2Arg1 ]
    , record3 =
        \record3Arg record3Arg0 record3Arg1 record3Arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record3Arg, record3Arg0, record3Arg1, record3Arg2 ]
    , record4 =
        \record4Arg record4Arg0 record4Arg1 record4Arg2 record4Arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record4Arg
                , record4Arg0
                , record4Arg1
                , record4Arg2
                , record4Arg3
                ]
    , record5 =
        \record5Arg record5Arg0 record5Arg1 record5Arg2 record5Arg3 record5Arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record5Arg
                , record5Arg0
                , record5Arg1
                , record5Arg2
                , record5Arg3
                , record5Arg4
                ]
    , record6 =
        \record6Arg record6Arg0 record6Arg1 record6Arg2 record6Arg3 record6Arg4 record6Arg5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record6Arg
                , record6Arg0
                , record6Arg1
                , record6Arg2
                , record6Arg3
                , record6Arg4
                , record6Arg5
                ]
    , record7 =
        \record7Arg record7Arg0 record7Arg1 record7Arg2 record7Arg3 record7Arg4 record7Arg5 record7Arg6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record7"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record7Arg
                , record7Arg0
                , record7Arg1
                , record7Arg2
                , record7Arg3
                , record7Arg4
                , record7Arg5
                , record7Arg6
                ]
    , record8 =
        \record8Arg record8Arg0 record8Arg1 record8Arg2 record8Arg3 record8Arg4 record8Arg5 record8Arg6 record8Arg7 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record8"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record8Arg
                , record8Arg0
                , record8Arg1
                , record8Arg2
                , record8Arg3
                , record8Arg4
                , record8Arg5
                , record8Arg6
                , record8Arg7
                ]
    , record9 =
        \record9Arg record9Arg0 record9Arg1 record9Arg2 record9Arg3 record9Arg4 record9Arg5 record9Arg6 record9Arg7 record9Arg8 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "record9"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.namedWith [ "Elm" ] "Expression" []
                                    ]
                                    (Type.var "combined")
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ record9Arg
                , record9Arg0
                , record9Arg1
                , record9Arg2
                , record9Arg3
                , record9Arg4
                , record9Arg5
                , record9Arg6
                , record9Arg7
                , record9Arg8
                ]
    , variant0 =
        \variant0Arg variant0Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant0"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.var "value" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ variant0Arg, variant0Arg0 ]
    , variant1 =
        \variant1Arg variant1Arg0 variant1Arg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant1"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value" ]
                                , Type.function
                                    [ Type.var "value" ]
                                    (Type.var "result")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "result" ]
                                )
                            )
                    }
                )
                [ variant1Arg, variant1Arg0, variant1Arg1 ]
    , variant2 =
        \variant2Arg variant2Arg0 variant2Arg1 variant2Arg2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.function
                                    [ Type.var "value1", Type.var "value2" ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant2Arg, variant2Arg0, variant2Arg1, variant2Arg2 ]
    , variant3 =
        \variant3Arg variant3Arg0 variant3Arg1 variant3Arg2 variant3Arg3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant3Arg
                , variant3Arg0
                , variant3Arg1
                , variant3Arg2
                , variant3Arg3
                ]
    , variant4 =
        \variant4Arg variant4Arg0 variant4Arg1 variant4Arg2 variant4Arg3 variant4Arg4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant4Arg
                , variant4Arg0
                , variant4Arg1
                , variant4Arg2
                , variant4Arg3
                , variant4Arg4
                ]
    , variant5 =
        \variant5Arg variant5Arg0 variant5Arg1 variant5Arg2 variant5Arg3 variant5Arg4 variant5Arg5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value5" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    , Type.var "value5"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant5Arg
                , variant5Arg0
                , variant5Arg1
                , variant5Arg2
                , variant5Arg3
                , variant5Arg4
                , variant5Arg5
                ]
    , variant6 =
        \variant6Arg variant6Arg0 variant6Arg1 variant6Arg2 variant6Arg3 variant6Arg4 variant6Arg5 variant6Arg6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value5" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value6" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    , Type.var "value5"
                                    , Type.var "value6"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant6Arg
                , variant6Arg0
                , variant6Arg1
                , variant6Arg2
                , variant6Arg3
                , variant6Arg4
                , variant6Arg5
                , variant6Arg6
                ]
    , variant7 =
        \variant7Arg variant7Arg0 variant7Arg1 variant7Arg2 variant7Arg3 variant7Arg4 variant7Arg5 variant7Arg6 variant7Arg7 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant7"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value5" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value6" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value7" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    , Type.var "value5"
                                    , Type.var "value6"
                                    , Type.var "value7"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant7Arg
                , variant7Arg0
                , variant7Arg1
                , variant7Arg2
                , variant7Arg3
                , variant7Arg4
                , variant7Arg5
                , variant7Arg6
                , variant7Arg7
                ]
    , variant8 =
        \variant8Arg variant8Arg0 variant8Arg1 variant8Arg2 variant8Arg3 variant8Arg4 variant8Arg5 variant8Arg6 variant8Arg7 variant8Arg8 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant8"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value5" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value6" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value7" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value8" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    , Type.var "value5"
                                    , Type.var "value6"
                                    , Type.var "value7"
                                    , Type.var "value8"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant8Arg
                , variant8Arg0
                , variant8Arg1
                , variant8Arg2
                , variant8Arg3
                , variant8Arg4
                , variant8Arg5
                , variant8Arg6
                , variant8Arg7
                , variant8Arg8
                ]
    , variant9 =
        \variant9Arg variant9Arg0 variant9Arg1 variant9Arg2 variant9Arg3 variant9Arg4 variant9Arg5 variant9Arg6 variant9Arg7 variant9Arg8 variant9Arg9 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "variant9"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value1" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value2" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value3" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value4" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value5" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value6" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value7" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value8" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "value9" ]
                                , Type.function
                                    [ Type.var "value1"
                                    , Type.var "value2"
                                    , Type.var "value3"
                                    , Type.var "value4"
                                    , Type.var "value5"
                                    , Type.var "value6"
                                    , Type.var "value7"
                                    , Type.var "value8"
                                    , Type.var "value9"
                                    ]
                                    (Type.var "combined")
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ variant9Arg
                , variant9Arg0
                , variant9Arg1
                , variant9Arg2
                , variant9Arg3
                , variant9Arg4
                , variant9Arg5
                , variant9Arg6
                , variant9Arg7
                , variant9Arg8
                , variant9Arg9
                ]
    , customType =
        \customTypeArg customTypeArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "customType"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.var "a" ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "CustomType"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ customTypeArg, customTypeArg0 ]
    , withParam =
        \withParamArg withParamArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "withParam"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "CustomType"
                                    [ Type.function
                                        [ Type.var "a" ]
                                        (Type.var "b")
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "CustomType"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ withParamArg, withParamArg0 ]
    , toPattern =
        \toPatternArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "toPattern"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "CustomType"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ toPatternArg ]
    , aliasAs =
        \aliasAsArg aliasAsArg0 aliasAsArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Elm", "Case", "Branch" ]
                    , name = "aliasAs"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" []
                                    , Type.var "a"
                                    ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ aliasAsArg, aliasAsArg0, aliasAsArg1 ]
    }


values_ :
    { map : Elm.Expression
    , var : Elm.Expression
    , unit : Elm.Expression
    , ignore : Elm.Expression
    , int : Elm.Expression
    , string : Elm.Expression
    , char : Elm.Expression
    , tuple : Elm.Expression
    , triple : Elm.Expression
    , list : Elm.Expression
    , listWithRemaining : Elm.Expression
    , just : Elm.Expression
    , nothing : Elm.Expression
    , err : Elm.Expression
    , ok : Elm.Expression
    , record0 : Elm.Expression
    , record1 : Elm.Expression
    , record2 : Elm.Expression
    , record3 : Elm.Expression
    , record4 : Elm.Expression
    , record5 : Elm.Expression
    , record6 : Elm.Expression
    , record7 : Elm.Expression
    , record8 : Elm.Expression
    , record9 : Elm.Expression
    , variant0 : Elm.Expression
    , variant1 : Elm.Expression
    , variant2 : Elm.Expression
    , variant3 : Elm.Expression
    , variant4 : Elm.Expression
    , variant5 : Elm.Expression
    , variant6 : Elm.Expression
    , variant7 : Elm.Expression
    , variant8 : Elm.Expression
    , variant9 : Elm.Expression
    , customType : Elm.Expression
    , withParam : Elm.Expression
    , toPattern : Elm.Expression
    , aliasAs : Elm.Expression
    }
values_ =
    { map =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        )
                    )
            }
    , var =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "var"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                        )
                    )
            }
    , unit =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "unit"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
    , ignore =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "ignore"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.int ]
                        )
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.string ]
                        )
                    )
            }
    , char =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "char"
            , annotation =
                Just
                    (Type.function
                        [ Type.char ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.char ]
                        )
                    )
            }
    , tuple =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "tuple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.tuple (Type.var "a") (Type.var "b") ]
                        )
                    )
            }
    , triple =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "triple"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.triple
                                (Type.var "a")
                                (Type.var "b")
                                (Type.var "c")
                            ]
                        )
                    )
            }
    , list =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "patterns"
                              , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Case", "Branch" ]
                                        "Pattern"
                                        [ Type.var "item" ]
                                    )
                              )
                            , ( "gather"
                              , Type.function
                                    [ Type.var "item", Type.var "gathered" ]
                                    (Type.var "gathered")
                              )
                            , ( "startWith", Type.var "gathered" )
                            , ( "finally"
                              , Type.function
                                    [ Type.var "gathered" ]
                                    (Type.var "list")
                              )
                            ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "list" ]
                        )
                    )
            }
    , listWithRemaining =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "listWithRemaining"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "patterns"
                              , Type.list
                                    (Type.namedWith
                                        [ "Elm", "Case", "Branch" ]
                                        "Pattern"
                                        [ Type.var "item" ]
                                    )
                              )
                            , ( "remaining"
                              , Type.namedWith
                                    [ "Elm", "Case", "Branch" ]
                                    "Pattern"
                                    [ Type.var "remaining" ]
                              )
                            , ( "gather"
                              , Type.function
                                    [ Type.var "item", Type.var "gathered" ]
                                    (Type.var "gathered")
                              )
                            , ( "startWith", Type.var "gathered" )
                            , ( "finally"
                              , Type.function
                                    [ Type.var "gathered"
                                    , Type.var "remaining"
                                    ]
                                    (Type.var "list")
                              )
                            ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "list" ]
                        )
                    )
            }
    , just =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "just"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "just" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "just" ]
                        )
                    )
            }
    , nothing =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "nothing"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
    , err =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "err"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "err" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "err" ]
                        )
                    )
            }
    , ok =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "ok"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "ok" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "ok" ]
                        )
                    )
            }
    , record0 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record0"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "record" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "record" ]
                        )
                    )
            }
    , record1 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record1"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" [] ]
                            (Type.var "record")
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "record" ]
                        )
                    )
            }
    , record2 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record3 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record4 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record5 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record6 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record6"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record7 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record7"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record8 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record8"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , record9 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "record9"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            , Type.namedWith [ "Elm" ] "Expression" []
                            ]
                            (Type.var "combined")
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant0 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant0"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.var "value" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        )
                    )
            }
    , variant1 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant1"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value" ]
                        , Type.function [ Type.var "value" ] (Type.var "result")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "result" ]
                        )
                    )
            }
    , variant2 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant2"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.function
                            [ Type.var "value1", Type.var "value2" ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant3 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant3"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant4 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant4"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant5 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant5"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant6 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant6"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant7 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant7"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant8 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant8"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value8" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            , Type.var "value8"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , variant9 =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "variant9"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value1" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value2" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value3" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value4" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value5" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value6" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value7" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value8" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "value9" ]
                        , Type.function
                            [ Type.var "value1"
                            , Type.var "value2"
                            , Type.var "value3"
                            , Type.var "value4"
                            , Type.var "value5"
                            , Type.var "value6"
                            , Type.var "value7"
                            , Type.var "value8"
                            , Type.var "value9"
                            ]
                            (Type.var "combined")
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "combined" ]
                        )
                    )
            }
    , customType =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "customType"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.var "a" ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "a" ]
                        )
                    )
            }
    , withParam =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "withParam"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.function [ Type.var "a" ] (Type.var "b") ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "b" ]
                        )
                    )
            }
    , toPattern =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "toPattern"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "CustomType"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        )
                    )
            }
    , aliasAs =
        Elm.value
            { importFrom = [ "Elm", "Case", "Branch" ]
            , name = "aliasAs"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Elm" ] "Expression" []
                            , Type.var "a"
                            ]
                            (Type.var "b")
                        , Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Elm", "Case", "Branch" ]
                            "Pattern"
                            [ Type.var "b" ]
                        )
                    )
            }
    }