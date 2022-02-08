module Result.Extra exposing (isOk)


isOk : Result error value -> Bool
isOk res =
    case res of
        Ok _ ->
            True

        Err _ ->
            False
