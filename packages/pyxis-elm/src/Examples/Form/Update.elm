module Examples.Form.Update exposing (update)

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Input as Input
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Textarea as Textarea
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model exposing (Model)


update : Model.Msg -> Model -> Model
update msg model =
    case msg of
        Model.Submit ->
            model
                |> mapData (\(Data d) -> Data { d | isFormSubmitted = True })
                |> Model.updateResponse

        --setSuccessResponse
        Model.DateFieldChanged Data.Birth subMsg ->
            mapData (\(Data d) -> Data { d | birth = Input.update subMsg d.birth }) model

        Model.TextareaFieldChanged Data.Dynamics subMsg ->
            mapData (\(Data d) -> Data { d | dynamic = Textarea.update subMsg d.dynamic }) model

        Model.InsuranceTypeChanged subMsg ->
            mapData (\(Data d) -> Data { d | insuranceType = RadioCardGroup.update subMsg d.insuranceType }) model

        Model.TextFieldChanged Data.Plate subMsg ->
            mapData (\(Data d) -> Data { d | plate = Input.update subMsg d.plate }) model

        Model.DateFieldChanged Data.ClaimDate subMsg ->
            mapData (\(Data d) -> Data { d | claimDate = Input.update subMsg d.claimDate }) model

        Model.PrivacyChanged subMsg ->
            mapData (\(Data d) -> Data { d | privacyCheck = CheckboxGroup.update subMsg d.privacyCheck }) model

        Model.ClaimTypeChanged subMsg ->
            mapData (\(Data d) -> Data { d | claimType = RadioCardGroup.update subMsg d.claimType }) model

        Model.PeopleInvolvedChanged subMsg ->
            mapData (\(Data d) -> Data { d | peopleInvolved = RadioCardGroup.update subMsg d.peopleInvolved }) model


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }
