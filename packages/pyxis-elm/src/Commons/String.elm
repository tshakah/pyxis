module Commons.String exposing (fromBool, toKebabCase)

{-| Utilities around `String` type
-}


{-| Transform a String in kebab-case
-}
toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"


{-| Transform a Bool to String.
-}
fromBool : Bool -> String
fromBool bool =
    if bool then
        "true"

    else
        "false"
