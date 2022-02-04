module Result.Extra exposing (void)


void : Result error value -> Result error ()
void result =
    case result of
        Ok _ ->
            Ok ()

        Err e ->
            Err e
