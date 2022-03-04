module Examples.Form.Update exposing (update)

import Components.Field.Date as Date
import Components.Field.Number as Number
import Components.Field.RadioGroup as RadioGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model exposing (Model)


update : Model.Msg -> Model -> Model
update msg model =
    case msg of
        Model.Submit ->
            mapData (\(Data d) -> Data { d | isFormSubmitted = True }) model

        Model.TextFieldChanged Data.FirstName subMsg ->
            mapData (\(Data d) -> Data { d | firstName = Text.update subMsg d.firstName }) model

        Model.TextFieldChanged Data.LastName subMsg ->
            mapData (\(Data d) -> Data { d | lastName = Text.update subMsg d.lastName }) model

        Model.TextFieldChanged Data.Email subMsg ->
            mapData (\(Data d) -> Data { d | email = Text.update subMsg d.email }) model

        Model.TextFieldChanged Data.Password subMsg ->
            mapData (\(Data d) -> Data { d | password = Text.update subMsg d.password }) model

        Model.NumberFieldChanged Data.Age subMsg ->
            mapData (\(Data d) -> Data { d | age = Number.update subMsg d.age }) model

        Model.DateFieldChanged Data.Birth subMsg ->
            mapData (\(Data d) -> Data { d | birth = Date.update subMsg d.birth }) model

        Model.TextareaFieldChanged Data.Notes subMsg ->
            mapData (\(Data d) -> Data { d | notes = Textarea.update subMsg d.notes }) model

        Model.GenderFieldChanged subMsg ->
            mapData (\(Data d) -> Data { d | gender = RadioGroup.update subMsg d.gender }) model


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }
