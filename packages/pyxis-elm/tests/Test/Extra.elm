module Test.Extra exposing (fuzzDistinctClassNames3, triggerMsg)

import Expect
import Fuzz.Extra as Fuzz
import Json.Encode as Encode
import Test exposing (Test)
import Test.Html.Event as Event
import Test.Html.Query as Query


fuzzDistinctClassNames3 : String -> (String -> String -> String -> Expect.Expectation) -> Test
fuzzDistinctClassNames3 descr expectation =
    Test.fuzz3 Fuzz.className Fuzz.className Fuzz.className descr <|
        \c1 c2 c3 ->
            expectation ("c1-" ++ c1) ("c2-" ++ c2) ("c3-" ++ c3)


triggerMsg : ( String, Encode.Value ) -> (msg -> Expect.Expectation) -> Query.Single msg -> Expect.Expectation
triggerMsg evt expectation single =
    single
        |> Event.simulate evt
        |> Event.toResult
        |> (\res ->
                case res of
                    Err err ->
                        Expect.fail err

                    Ok msg ->
                        expectation msg
           )
