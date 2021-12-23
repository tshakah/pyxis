module QualifiedImportsTest exposing (suite)

import Custom.QualifiedImports as QualifiedImports
import Review.Test
import Test exposing (..)


suite : Test
suite =
    describe "NoPipeRecordGetterRule test"
        [ test "should not report anything when nothing is exposed" <|
            \() ->
                """module M exposing (..)
import A.B.C
"""
                    |> Review.Test.run QualifiedImports.rule
                    |> Review.Test.expectNoErrors
        , test "should not report infix functions exports" <|
            \() ->
                """module M exposing ()
import A.B.C exposing ((|>))
         """
                    |> Review.Test.run QualifiedImports.rule
                    |> Review.Test.expectNoErrors
        , test "should not report anything when the import is the module Type" <|
            \() ->
                """module M exposing (..)
import A.B.C exposing (C)
"""
                    |> Review.Test.run QualifiedImports.rule
                    |> Review.Test.expectNoErrors
        , test "should report invalid imports" <|
            \() ->
                """module M exposing (..)
import A.B.C exposing (map)
"""
                    |> Review.Test.run QualifiedImports.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = QualifiedImports.message
                            , details = QualifiedImports.details
                            , under = "map"
                            }
                        ]
        , test "should report exposing(..) usage" <|
            \() ->
                """module M exposing (..)
import A.B.C exposing (..)
"""
                    |> Review.Test.run QualifiedImports.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = QualifiedImports.message
                            , details = QualifiedImports.details
                            , under = "import A.B.C exposing (..)"
                            }
                        ]
        ]
