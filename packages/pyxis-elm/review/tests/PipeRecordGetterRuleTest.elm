module PipeRecordGetterRuleTest exposing (..)

import Custom.NoPipeRecordGetterRule as NoPipeRecordGetterRule
import Review.Test
import Test exposing (..)



-- TODO nested pipes


suite : Test
suite =
    describe "NoPipeRecordGetterRule test"
        [ test "should not report anything when getter is used properly" <|
            \() ->
                """module A exposing (..)
a = x.name |> f
"""
                    |> Review.Test.run NoPipeRecordGetterRule.rule
                    |> Review.Test.expectNoErrors
        , test "should report invalid pipe usages of getters" <|
            \() ->
                """module A exposing (..)
a = x |> .name |> f
"""
                    |> Review.Test.run NoPipeRecordGetterRule.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = NoPipeRecordGetterRule.message
                            , details = NoPipeRecordGetterRule.details
                            , under = "x |> .name"
                            }
                            |> Review.Test.whenFixed """module A exposing (..)
a = x.name |> f
"""
                        ]
        ]
