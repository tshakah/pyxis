module Examples.Form.Model exposing
    ( Model
    , Msg(..)
    , initialModel
    , updateResponse
    )

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Input as Input
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Textarea as Textarea
import Date exposing (Date)
import Examples.Form.Data as Data exposing (Data(..))


type Msg
    = Submit
    | TextFieldChanged Data.TextField Input.Msg
    | TextareaFieldChanged Data.TextareaField Textarea.Msg
    | DateFieldChanged Data.DateField Input.Msg
    | InsuranceTypeChanged (RadioCardGroup.Msg Data.InsuranceType)
    | PrivacyChanged (CheckboxGroup.Msg ())
    | ClaimTypeChanged (RadioCardGroup.Msg Data.ClaimType)
    | PeopleInvolvedChanged (RadioCardGroup.Msg Data.PeopleInvolved)


type alias Model =
    { data : Data
    , response : Maybe (Result String Response)
    }


type alias Response =
    { birth : Date
    , claimDate : Date
    , claimType : Data.ClaimType
    , dynamic : String
    , insuranceType : Data.InsuranceType
    , peopleInvolved : Data.PeopleInvolved
    , plate : String
    }


initialModel : Model
initialModel =
    { data = Data.initialData
    , response = Nothing
    }


updateResponse : Model -> Model
updateResponse model =
    { model | response = Just (validate model.data) }


validate : Data -> Result String Response
validate ((Data config) as data) =
    Ok Response
        |> parseAndThen (Input.validate data config.birth)
        |> parseAndThen (Input.validate data config.claimDate)
        |> parseAndThen (RadioCardGroup.validate data config.claimType)
        |> parseAndThen (Textarea.validate data config.dynamic)
        |> parseAndThen (RadioCardGroup.validate data config.insuranceType)
        |> parseAndThen (RadioCardGroup.validate data config.peopleInvolved)
        |> parseAndThen (Input.validate data config.plate)


parseAndThen : Result x a -> Result x (a -> b) -> Result x b
parseAndThen result =
    Result.andThen (\partial -> Result.map partial result)
