module Case exposing (elmCaseString)

import Elm
import Elm.Case
import Elm.Expect
import Test exposing (Test, test)


elmCaseString : Test
elmCaseString =
    test "Elm.Case.string" <|
        \_ ->
            Elm.Expect.renderedAs
                (Elm.Case.string (Elm.string "Hello")
                    { cases = [ ( "World", Elm.int 1 ) ]
                    , otherwise = Elm.int 0
                    }
                )
                """
                case "Hello" of
                    "World" ->
                        1

                    _ ->
                        0
                """
