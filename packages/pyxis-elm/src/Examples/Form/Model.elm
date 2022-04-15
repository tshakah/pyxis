module Examples.Form.Model exposing
    ( Model
    , Msg(..)
    , initialModel
    , mapData
    , setCitiesApi
    , updateResponse
    )

import Components.Field.Autocomplete as Autocomplete
import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Input as Input
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Textarea as Textarea
import Date exposing (Date)
import Examples.Form.Api.City exposing (City)
import Examples.Form.Data as Data exposing (Data(..))
import Http
import RemoteData exposing (RemoteData)


type Msg
    = CitiesFetched (RemoteData Http.Error (List City))
    | Submit
    | AutocompleteFieldChanged Data.AutocompleteField (Autocomplete.Msg City)
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
    , citiesApi : RemoteData Http.Error (List City)
    }


type alias Response =
    { birth : Date
    , claimDate : Date
    , claimType : Data.ClaimType
    , dynamic : String
    , insuranceType : Data.InsuranceType
    , peopleInvolved : Data.PeopleInvolved
    , plate : String
    , residentialCity : City
    }


initialModel : Model
initialModel =
    { data = Data.initialData
    , citiesApi = RemoteData.NotAsked
    , response = Nothing
    }


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }


setCitiesApi : RemoteData Http.Error (List City) -> Model -> Model
setCitiesApi remoteData model =
    { model | citiesApi = remoteData }
        |> mapData
            (\(Data d) ->
                Data { d | residentialCity = Autocomplete.setOptions remoteData d.residentialCity }
            )


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
        |> parseAndThen (Autocomplete.validate data config.residentialCity)


parseAndThen : Result x a -> Result x (a -> b) -> Result x b
parseAndThen result =
    Result.andThen (\partial -> Result.map partial result)
