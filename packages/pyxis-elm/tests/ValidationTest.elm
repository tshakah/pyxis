module ValidationTest exposing (suite)

import Commons.Validation as Validation
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "The Validation module"
        [ test "pass when a check is satisfied" <|
            \_ ->
                [ \value ->
                    if String.isEmpty value then
                        Validation.invalid "String cannot be empty"

                    else
                        Validation.valid
                ]
                    |> Validation.create
                    |> Validation.passed "Hello World"
                    |> Expect.true "Expected the validation to passed"
        , test "fail when at least a condition is not satisfied" <|
            \_ ->
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
