module Result.Extra exposing (getError, void)


void : Result error value -> Result error ()
void result =
    case result of
        Ok _ ->
            Ok ()

        Err e ->
            Err e


getError : Result error x -> Maybe error
getError result =
    case result of
        Err e ->
            Just e

        Ok _ ->
            Nothing
