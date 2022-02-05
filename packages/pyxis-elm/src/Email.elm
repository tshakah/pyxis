module Email exposing
    ( Email
    , fromString
    , toString
    )

import Regex exposing (Regex)
import Validation exposing (Validation)


email : Regex
email =
    "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        |> Regex.fromString
        |> Maybe.withDefault Regex.never


type Email
    = Email String


fromString : String -> Validation String Email
fromString errorMsg source =
    if Regex.contains email source then
        Ok (Email source)

    else
        Err errorMsg


toString : Email -> String
toString (Email source) =
    source
