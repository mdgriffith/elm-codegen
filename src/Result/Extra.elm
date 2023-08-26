module Result.Extra exposing (combineMap)


combineMap : (a -> Result e b) -> List a -> Result e (List b)
combineMap f list =
    combineMapHelper f [] list


combineMapHelper : (a -> Result e b) -> List b -> List a -> Result e (List b)
combineMapHelper f acc list =
    case list of
        [] ->
            Ok (List.reverse acc)

        h :: t ->
            case f h of
                Err e ->
                    Err e

                Ok fh ->
                    combineMapHelper f (fh :: acc) t
