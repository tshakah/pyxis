module Commons.String exposing (toKebabCase)

{-| Utilities around `String` type
-}


{-| Transform a String in kebab-case
-}
toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"
