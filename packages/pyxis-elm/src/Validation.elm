module Validation exposing
    ( Validation
    , filter
    , fromMaybe
    , map
    )


type alias Validation from to =
    from -> Result String to


filter : (a -> Bool) -> String -> Validation a a
filter pred reason x =
    if pred x then
        Ok x

    else
        Err reason


fromMaybe : String -> (a -> Maybe b) -> Validation a b
fromMaybe reason toMaybe src =
    case toMaybe src of
        Nothing ->
            Err reason

        Just x ->
            Ok x


map : (from -> to) -> Validation from to
map f from =
    Ok (f from)
