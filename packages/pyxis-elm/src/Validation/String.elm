module Validation.String exposing
    ( any
    , maxLength
    , minLength
    , notEmpty
    , optional
    , toInt
    , trim
    )

import Validation exposing (Validation)


notEmpty : String -> Validation String String
notEmpty =
    minLength 1


any : (Char -> Bool) -> String -> Validation String String
any =
    String.any >> Validation.filter


minLength : Int -> String -> Validation String String
minLength l =
    Validation.filter (\s -> String.length s >= l)


maxLength : Int -> String -> Validation String String
maxLength l =
    Validation.filter (\s -> String.length s <= l)


trim : Validation String String
trim =
    Validation.map String.trim


optional : Validation String to -> Validation String (Maybe to)
optional validation str =
    if String.isEmpty str then
        Ok Nothing

    else
        Result.map Just (validation str)


toInt : String -> Validation String Int
toInt reason raw =
    case String.toInt raw of
        Nothing ->
            Err reason

        Just n ->
            Ok n
