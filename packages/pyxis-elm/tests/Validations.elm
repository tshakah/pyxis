module Validations exposing (isUppercaseValidation, notEmptyValidation)


notEmptyValidation : String -> Result String String
notEmptyValidation src =
    if String.isEmpty src then
        Err "Required field"

    else
        Ok src


isUppercaseValidation : String -> Result String String
isUppercaseValidation str =
    if String.all Char.isUpper str then
        Ok str

    else
        Err "String must be uppercase"
