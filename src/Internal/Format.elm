module Internal.Format exposing (formatDeclarationName, formatType, formatValue, sanitize)

{-|

    This is used as a variable or as a record field.

-}


formatValue : String -> String
formatValue str =
    let
        formatted : String
        formatted =
            String.toLower (String.left 1 str) ++ String.dropLeft 1 str
    in
    sanitize formatted


{-|

    Top level values have the same rules as normal values, but `main` is allowed.

-}
formatDeclarationName : String -> String
formatDeclarationName str =
    case str of
        "main" ->
            "main"

        _ ->
            formatValue str


formatType : String -> String
formatType str =
    String.toUpper (String.left 1 str) ++ String.dropLeft 1 str


sanitize : String -> String
sanitize str =
    case str of
        "in" ->
            "in_"

        "type" ->
            "type_"

        "case" ->
            "case_"

        "let" ->
            "let_"

        "module" ->
            "module_"

        "exposing" ->
            "exposing_"

        "where" ->
            "where_"

        "main" ->
            "main_"

        "port" ->
            "port_"

        "as" ->
            "as_"

        "if" ->
            "if_"

        "import" ->
            "import_"

        _ ->
            String.replace "." "" str
