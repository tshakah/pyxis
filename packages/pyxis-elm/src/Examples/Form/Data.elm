module Examples.Form.Data exposing
    ( Data(..)
    , DateField(..)
    , Gender(..)
    , NumberField(..)
    , TextField(..)
    , TextareaField(..)
    , ageValidation
    , birthValidation
    , genderFromString
    , genderToString
    , initialData
    , notEmptyStringValidation
    )

import Components.Field.Date as Date
import Components.Field.Number as Number
import Components.Field.RadioGroup as RadioGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea


type Data
    = Data
        { firstName : Text.Model Data
        , lastName : Text.Model Data
        , notes : Textarea.Model Data
        , age : Number.Model Data
        , birth : Date.Model Data
        , email : Text.Model Data
        , password : Text.Model Data
        , gender : RadioGroup.Model Data Gender (Maybe Gender)
        , isFormSubmitted : Bool
        }


initialData : Data
initialData =
    Data
        { firstName = Text.init notEmptyStringValidation
        , lastName = Text.init notEmptyStringValidation
        , notes = Textarea.init notEmptyStringValidation
        , age = Number.init ageValidation
        , birth = Date.init birthValidation
        , email = Text.init notEmptyStringValidation
        , password = Text.init notEmptyStringValidation
        , gender =
            RadioGroup.init genderValidation
                |> RadioGroup.setValue Male
        , isFormSubmitted = False
        }


type TextField
    = FirstName
    | LastName
    | Email
    | Password


type TextareaField
    = Notes


type NumberField
    = Age


type DateField
    = Birth


type Gender
    = Male
    | Female


genderFromString : String -> Maybe Gender
genderFromString str =
    case String.toLower str of
        "male" ->
            Just Male

        "female" ->
            Just Female

        _ ->
            Nothing


genderToString : Gender -> String
genderToString gender =
    case gender of
        Male ->
            "male"

        Female ->
            "female"


notEmptyStringValidation : Data -> String -> Result String String
notEmptyStringValidation (Data data) value =
    if data.isFormSubmitted && String.isEmpty value then
        Err "This field cannot be empty"

    else
        Ok value


ageValidation : Data -> Int -> Result String Int
ageValidation (Data data) value =
    if data.isFormSubmitted && value < 18 then
        Err "You should be at least 18 years old"

    else if data.isFormSubmitted && value > 25 then
        Err "You cannot be older then 50 years old"

    else
        Ok value


birthValidation : Data -> Date.Date -> Result String Date.Date
birthValidation (Data data) value =
    if data.isFormSubmitted && Date.isRaw value then
        Err "Enter a valid date."

    else
        Ok value


genderValidation : Data -> Maybe Gender -> Result String (Maybe Gender)
genderValidation (Data data) value =
    Ok value
