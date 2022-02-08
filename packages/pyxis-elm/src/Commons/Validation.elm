module Commons.Validation exposing
    ( Validation
    , create
    , Response
    , valid
    , invalid
    , passed
    , ErrorMessage
    , errorMessages
    , errorMessage
    , fromBool
    )

{-|


# Validation

@docs Validation
@docs create


## Response

@docs Response
@docs valid
@docs invalid
@docs passed


## Error

@docs ErrorMessage
@docs errorMessages
@docs errorMessage

-}


{-| Represents a Validation policy.
-}
type Validation value
    = Validation (Configuration value)


{-| Internal. Represents the Validation configuration.
-}
type alias Configuration value =
    { checks : List (value -> Response)
    }


{-| Creates a validation policy
-}
create : List (value -> Response) -> Validation value
create checks =
    Validation { checks = checks }


{-| Convenient alias to work with error strings.
-}
type alias ErrorMessage =
    String


{-| Represent a Response from a validation check.
-}
type Response
    = Passed
    | NotPassed ErrorMessage


{-| Creates a valid response. Only valid values allow the validation to be passed.
-}
valid : Response
valid =
    Passed


{-| Creates a invalid response. Invalid values will mandatory show an error message.
-}
invalid : ErrorMessage -> Response
invalid =
    NotPassed


{-| Returns all the error messages from a failed validation.
-}
errorMessages : value -> Validation value -> List String
errorMessages val (Validation configuration) =
    configuration.checks
        |> List.filter (\check -> not (check val == valid))
        |> List.map (\check -> errorMessage (check val))


{-| Returns the error message from a failed validation.
-}
errorMessage : Response -> String
errorMessage a =
    case a of
        NotPassed error ->
            error

        Passed ->
            ""


{-| Execute the validation and returns `True` if all the given checks passed, `False` otherwise.
-}
passed : value -> Validation value -> Bool
passed val (Validation configuration) =
    List.all (\check -> check val == valid) configuration.checks


fromBool : ErrorMessage -> Bool -> Response
fromBool errorMessage_ condition =
    if condition then
        Passed

    else
        NotPassed errorMessage_
