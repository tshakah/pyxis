module ValidationTest exposing (suite)

import Commons.Validation as Validation
import Expect
import Test exposing (Test)


suite : Test
suite =
    Test.describe "The Validation module"
        [ Test.test "pass when a check is satisfied" <|
            \() ->
                [ \value ->
                    if String.isEmpty value then
                        Validation.invalid "String cannot be empty"

                    else
                        Validation.valid
                ]
                    |> Validation.create
                    |> Validation.passed "Hello World"
                    |> Expect.true "Expected the validation to passed"
        , Test.test "fail when at least a condition is not satisfied" <|
            \() ->
                [ \value ->
                    if value > 30 then
                        Validation.invalid "Cannot get a float value from a previous conversion."

                    else
                        Validation.valid
                ]
                    |> Validation.create
                    |> Validation.passed 32.5
                    |> Expect.false "Expected the validation to fail"
        ]
