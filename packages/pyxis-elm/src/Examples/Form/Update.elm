module Examples.Form.Update exposing (update)

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Date as Date
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model exposing (Model)


update : Model.Msg -> Model -> Model
update msg model =
    case msg of
        Model.Submit ->
            mapData (\(Data d) -> Data { d | isFormSubmitted = True }) model

        Model.DateFieldChanged Data.Birth subMsg ->
            mapData (\(Data d) -> Data { d | birth = Date.update subMsg d.birth }) model

        Model.TextareaFieldChanged Data.Dynamics subMsg ->
            mapData (\(Data d) -> Data { d | dynamic = Textarea.update subMsg d.dynamic }) model

        Model.InsuranceTypeChanged subMsg ->
            mapData (\(Data d) -> Data { d | insuranceType = RadioCardGroup.update subMsg d.insuranceType }) model

        Model.TextFieldChanged Data.Plate subMsg ->
            mapData (\(Data d) -> Data { d | plate = Text.update subMsg d.plate }) model

        Model.DateFieldChanged Data.ClaimDate subMsg ->
            mapData (\(Data d) -> Data { d | claimDate = Date.update subMsg d.claimDate }) model

        Model.PrivacyChanged subMsg ->
            mapData (\(Data d) -> Data { d | privacyCheck = CheckboxGroup.update subMsg d.privacyCheck }) model

        Model.ClaimTypeChanged subMsg ->
            mapData (\(Data d) -> Data { d | claimType = RadioCardGroup.update subMsg d.claimType }) model

        Model.PeopleInvolvedChanged subMsg ->
            mapData (\(Data d) -> Data { d | peopleInvolved = RadioCardGroup.update subMsg d.peopleInvolved }) model


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }
