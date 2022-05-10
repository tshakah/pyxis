module ListExtraTest exposing (findNextTests, findPreviousTest, pairedTest, withPreviousAndNextTest)

import Expect
import Fuzz
import Pyxis.Commons.List as CommonsList
import Test exposing (Test)


findNextTests : Test
findNextTests =
    Test.describe "List.Extra.findNext"
        [ Test.fuzz Fuzz.bool "should return Nothing when the list is empty" <|
            \b ->
                []
                    |> CommonsList.findNext (always b)
                    |> Expect.equal Nothing
        , testFindNextAIsB "abc"
        , testFindNextAIsB "  ab"
        , testFindNextAIsB "ab  "
        , testFindNextAIsB "  ab  "
        , testFindNextAIsB "  ab  aZ"
        , testFindNextAIsB "b  a"
        ]


testFindNextAIsB : String -> Test
testFindNextAIsB source =
    Test.test ("searching next('a') in \"" ++ source ++ "\" should return 'b'") <|
        \() ->
            source
                |> String.toList
                |> CommonsList.findNext ((==) 'a')
                |> Expect.equal (Just 'b')


findPreviousTest : Test
findPreviousTest =
    Test.describe "List.Extra.findPrevious"
        [ Test.fuzz Fuzz.bool "should return Nothing when the list is empty" <|
            \b ->
                []
                    |> CommonsList.findPrevious (always b)
                    |> Expect.equal Nothing
        , testFindPreviousAIsB "bac"
        , testFindPreviousAIsB "  ba"
        , testFindPreviousAIsB "ba  "
        , testFindPreviousAIsB "  ba  "
        , testFindPreviousAIsB "  Za  ba"
        ]


testFindPreviousAIsB : String -> Test
testFindPreviousAIsB source =
    Test.test ("applied to ((==) 'a') \"" ++ source ++ "\" should be Just 'b'") <|
        \() ->
            source
                |> String.toList
                |> CommonsList.findPrevious ((==) 'a')
                |> Expect.equal (Just 'b')


pairedTest : Test
pairedTest =
    Test.describe "List.Extra.paired"
        [ Test.test "should return a empty list when a empty list is passed" <|
            \() ->
                []
                    |> CommonsList.paired
                    |> Expect.equal []
        , Test.test "should work on non empty list" <|
            \() ->
                [ 1, 2, 3 ]
                    |> CommonsList.paired
                    |> Expect.equal [ ( 1, 2 ), ( 2, 3 ), ( 3, 1 ) ]
        ]


resultToExpectation : Result String value -> Expect.Expectation
resultToExpectation result =
    case result of
        Err msg ->
            Expect.fail msg

        Ok _ ->
            Expect.pass



-- TODO naming


withPreviousAndNextTest : Test
withPreviousAndNextTest =
    Test.describe "List.Extra.withPreviousAndNext"
        [ Test.test "should return a empty list when a empty list is passed" <|
            \() ->
                []
                    |> CommonsList.withPreviousAndNext
                    |> Expect.equal []
        , Test.test "singleton" <|
            \() ->
                [ 1 ]
                    |> CommonsList.withPreviousAndNext
                    |> Expect.equal [ ( 1, 1, 1 ) ]
        , Test.test "should work on non empty list" <|
            \() ->
                [ 0, 1, 2, 3 ]
                    |> CommonsList.withPreviousAndNext
                    |> Expect.equal [ ( 3, 0, 1 ), ( 0, 1, 2 ), ( 1, 2, 3 ), ( 2, 3, 0 ) ]
        , Test.fuzz (Fuzz.list Fuzz.int) "Invariant check" <|
            \lst ->
                lst
                    |> CommonsList.withPreviousAndNext
                    |> checkPreviousNextInvariant
                    |> resultToExpectation
        , Test.fuzz (Fuzz.list Fuzz.int) "Invariant check 2" <|
            \lst ->
                lst
                    |> CommonsList.withPreviousAndNext
                    |> checkBordersInvariant
                    |> resultToExpectation
        ]


checkBordersInvariant : List ( a, a, a ) -> Result String ()
checkBordersInvariant lst =
    Maybe.map2
        (\( prev, current, _ ) ( _, current1, next1 ) ->
            if prev /= current1 then
                Err "TODO descr"

            else if current /= next1 then
                Err "TODO descr"

            else
                Ok ()
        )
        (List.head lst)
        (CommonsList.last lst)
        |> Maybe.withDefault (Ok ())


checkPreviousNextInvariant : List ( a, a, a ) -> Result String ()
checkPreviousNextInvariant lst =
    case lst of
        ( _, current, next ) :: (( previous1, current1, _ ) as nextHd) :: tl ->
            if next /= current1 then
                Err "TODO err"

            else if current /= previous1 then
                Err "TODO err"

            else
                checkPreviousNextInvariant (nextHd :: tl)

        _ ->
            Ok ()
