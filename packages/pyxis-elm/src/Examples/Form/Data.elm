module Examples.Form.Data exposing
    ( ClaimType(..)
    , Data(..)
    , DateField(..)
    , InsuranceType(..)
    , PeopleInvolved(..)
    , TextField(..)
    , TextareaField(..)
    , birthValidation
    , initialData
    , notEmptyStringValidation
    )

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Date as Date
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea


type Data
    = Data
        { isFormSubmitted : Bool
        , birth : Date.Model Data
        , claimDate : Date.Model Data
        , claimType : RadioCardGroup.Model Data ClaimType ClaimType
        , dynamic : Textarea.Model Data
        , insuranceType : RadioCardGroup.Model Data InsuranceType InsuranceType
        , peopleInvolved : RadioCardGroup.Model Data PeopleInvolved PeopleInvolved
        , plate : Text.Model Data
        , privacyCheck : CheckboxGroup.Model Data () Bool
        }


initialData : Data
initialData =
    Data
        { isFormSubmitted = False
        , birth = Date.init birthValidation
        , claimDate = Date.init birthValidation
        , claimType =
            RadioCardGroup.init (always (Result.fromMaybe ""))
                |> RadioCardGroup.setValue CarAccident
        , dynamic = Textarea.init notEmptyStringValidation
        , insuranceType = RadioCardGroup.init (cardValidation Motor)
        , peopleInvolved = RadioCardGroup.init (cardValidation NotInvolved)
        , plate = Text.init notEmptyStringValidation
        , privacyCheck = CheckboxGroup.init privacyValidation
        }


type TextField
    = Plate


type TextareaField
    = Dynamics


type DateField
    = Birth
    | ClaimDate


type InsuranceType
    = Motor
    | Home


type ClaimType
    = CarAccident
    | OtherClaims


type PeopleInvolved
    = Involved
    | NotInvolved


notEmptyStringValidation : Data -> String -> Result String String
notEmptyStringValidation (Data data) value =
    if data.isFormSubmitted && String.isEmpty value then
        Err "This field cannot be empty."

    else
        Ok value


cardValidation : value -> Data -> Maybe value -> Result String value
cardValidation default (Data data) value =
    case value of
        Nothing ->
            if data.isFormSubmitted then
                Err "Select at least one option."

            else
                Ok default

        Just value_ ->
            Ok value_


birthValidation : Data -> Date.Date -> Result String Date.Date
birthValidation (Data data) value =
    if data.isFormSubmitted && Date.isRaw value then
        Err "Enter a valid date."

    else
        Ok value


privacyValidation : Data -> List () -> Result String Bool
privacyValidation (Data data) list =
    if data.isFormSubmitted && (List.member () list |> not) then
        Err "You must agree to privacy policy."

    else
        Ok True
