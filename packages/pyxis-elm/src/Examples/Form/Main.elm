module Examples.Form.Main exposing (main)

import Browser
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Number as Number
import Components.Field.Text as Text
import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as GridColumn
import Components.Form.Grid.Row as GridRow
import Html exposing (Html)
import Html.Attributes


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }


type Msg
    = TextFieldChanged TextField Text.Msg
    | DateFieldChanged DateField Date.Msg
    | NumberFieldChanged NumberField Number.Msg


type alias Model =
    { data : Data
    }


initialModel : Model
initialModel =
    { data =
        Data
            { firstName = Text.init (always Ok)
            , lastName = Text.init (always Ok)
            , age = Number.init (always Ok)
            , birth = Date.init (always Ok)
            , email = Text.init (always Ok)
            , password = Text.init (always Ok)
            }
    }


type Data
    = Data
        { firstName : Text.Model Data
        , lastName : Text.Model Data
        , age : Number.Model Data
        , birth : Date.Model Data
        , email : Text.Model Data
        , password : Text.Model Data
        }


type TextField
    = FirstName
    | LastName
    | Email
    | Password


type NumberField
    = Age


type DateField
    = Birth


update : Msg -> Model -> Model
update msg model =
    case msg of
        TextFieldChanged FirstName subMsg ->
            mapData (\(Data d) -> Data { d | firstName = Text.update (Data d) subMsg d.firstName }) model

        TextFieldChanged LastName subMsg ->
            mapData (\(Data d) -> Data { d | lastName = Text.update (Data d) subMsg d.lastName }) model

        TextFieldChanged Email subMsg ->
            mapData (\(Data d) -> Data { d | email = Text.update (Data d) subMsg d.email }) model

        TextFieldChanged Password subMsg ->
            mapData (\(Data d) -> Data { d | password = Text.update (Data d) subMsg d.password }) model

        NumberFieldChanged Age subMsg ->
            mapData (\(Data d) -> Data { d | age = Number.update (Data d) subMsg d.age }) model

        DateFieldChanged Birth subMsg ->
            mapData (\(Data d) -> Data { d | birth = Date.update (Data d) subMsg d.birth }) model


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.class "container" ]
        [ Html.node "link"
            [ Html.Attributes.href "../../../dist/pyxis.css"
            , Html.Attributes.rel "stylesheet"
            ]
            []
        , viewForm model.data
        ]


viewForm : Data -> Html Msg
viewForm data =
    Form.create
        |> Form.withFieldSet (viewUserFieldSet data)
        |> Form.withFieldSet (viewLoginFieldSet data)
        |> Form.render


viewUserFieldSet : Data -> FieldSet.FieldSet Msg
viewUserFieldSet ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withRow
            ("first_name"
                |> Text.text (TextFieldChanged FirstName)
                |> Text.withLabel (Label.create "First name")
                |> Text.render data config.firstName
                |> List.singleton
                |> viewRow
            )
        |> FieldSet.withRow
            ("last_name"
                |> Text.text (TextFieldChanged LastName)
                |> Text.withLabel (Label.create "Last name")
                |> Text.render data config.lastName
                |> List.singleton
                |> viewRow
            )
        |> FieldSet.withRow
            ("age"
                |> Number.config (NumberFieldChanged Age)
                |> Number.withLabel (Label.create "Age")
                |> Number.render data config.age
                |> List.singleton
                |> viewRow
            )
        |> FieldSet.withRow
            ("birth_date"
                |> Date.config (DateFieldChanged Birth)
                |> Date.withLabel (Label.create "Birth date")
                |> Date.render data config.birth
                |> List.singleton
                |> viewRow
            )


viewLoginFieldSet : Data -> FieldSet.FieldSet Msg
viewLoginFieldSet ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withRow
            ("email"
                |> Text.text (TextFieldChanged Email)
                |> Text.withLabel (Label.create "Email")
                |> Text.render data config.email
                |> List.singleton
                |> viewRow
            )
        |> FieldSet.withRow
            ("password"
                |> Text.text (TextFieldChanged Password)
                |> Text.withLabel (Label.create "Password")
                |> Text.render data config.password
                |> List.singleton
                |> viewRow
            )


viewRow : List (Html Msg) -> GridRow.Row Msg
viewRow content =
    GridRow.withColumn (GridColumn.withContent content GridColumn.create) GridRow.create
