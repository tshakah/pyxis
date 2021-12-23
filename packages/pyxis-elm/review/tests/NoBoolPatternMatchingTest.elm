module NoBoolPatternMatchingTest exposing (..)

import Custom.NoBoolPatternMatching as NoBoolPatternMatching
import Review.Test
import Test exposing (..)


suite : Test
suite =
    describe "NoPipeRecordGetterRule test"
        [ test "should not report anything when getter is used properly" <|
            \() ->
                """module A exposing (..)
map f m = case m of
    Just x -> f x
    Nothing -> mw
"""
                    |> Review.Test.run NoBoolPatternMatching.rule
                    |> Review.Test.expectNoErrors
        , test "should report invalid usages of case expressions (1)" <|
            \() ->
                """module A exposing (..)
n = case b of
    True -> 0
    False -> 1

"""
                    |> Review.Test.run NoBoolPatternMatching.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = NoBoolPatternMatching.message
                            , details = NoBoolPatternMatching.details
                            , under = """case b of
    True -> 0
    False -> 1"""
                            }
                            |> Review.Test.whenFixed """module A exposing (..)
n = if b then
  0
else
  1

"""
                        ]
        , test "should report invalid usages of case expressions (2)" <|
            \() ->
                """module A exposing (..)
n = case b of
    False -> 0
    True -> 1

"""
                    |> Review.Test.run NoBoolPatternMatching.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = NoBoolPatternMatching.message
                            , details = NoBoolPatternMatching.details
                            , under = """case b of
    False -> 0
    True -> 1"""
                            }
                            |> Review.Test.whenFixed """module A exposing (..)
n = if b then
  1
else
  0

"""
                        ]
        , test "should report invalid usages of case expressions with catchall (2)" <|
            \() ->
                """module A exposing (..)
n = case b of
    True -> 0
    _ -> 1

"""
                    |> Review.Test.run NoBoolPatternMatching.rule
                    |> Review.Test.expectErrors
                        [ Review.Test.error
                            { message = NoBoolPatternMatching.message
                            , details = NoBoolPatternMatching.details
                            , under = """case b of
    True -> 0
    _ -> 1"""
                            }
                            |> Review.Test.whenFixed """module A exposing (..)
n = if b then
  0
else
  1

"""
                        ]
        ]
