module Result.Extra exposing (getError, isOk, void)

{-| Utilities for Result
-}


{-| Returns True whether the result is `Ok`
-}
isOk : Result error value -> Bool
isOk res =
    case res of
        Ok _ ->
            True

        Err _ ->
            False


{-| Discards the Result `Ok` value
-}
void : Result error value -> Result error ()
void =
    Result.map (always ())


{-| Returns the Result `Err` value
-}
getError : Result error x -> Maybe error
getError res =
    case res of
        Err err ->
            Just err

        Ok _ ->
            Nothing
