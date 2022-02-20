module Examples.Validation.Password exposing
    ( Password
    , toString
    , validation
    )

{-| Domain-specific password validation
-}

import Validation exposing (Validation)
import Validation.String


type Password
    = Password String


isSpecial : Char -> Bool
isSpecial ch =
    String.any ((==) ch) "!@#$%^£€&*(),.?\":{}|<>"


validation : Validation String Password
validation =
    Validation.String.any Char.isUpper "The password should have at least one uppercase character"
        >> Result.andThen (Validation.String.any Char.isLower "The password should have at least one lowercase character")
        >> Result.andThen (Validation.String.any isSpecial "The password should have at least one special character")
        >> Result.andThen (Validation.String.any Char.isDigit "The password should have at least one numberic character")
        >> Result.andThen (Validation.String.minLength 8 "The password should have at least 8 characters")
        >> Result.map Password


toString : Password -> String
toString (Password str) =
    str
