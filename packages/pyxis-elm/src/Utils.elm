module Utils exposing (concatArgs)


concatArgs : (List a -> b) -> List (List a) -> b
concatArgs f args =
    f (List.concat args)
