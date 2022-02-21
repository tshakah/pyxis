module Examples.Form.Main exposing (main)

import Browser
import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Button as Button
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Number as Number
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as GridColumn
import Components.Form.Grid.Row as GridRow
import Components.Icon as Icon
import Components.IconSet as IconSet
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
    = Submit
    | TextFieldChanged TextField Text.Msg
    | TextareaFieldChanged TextareaField Textarea.Msg
    | DateFieldChanged DateField Date.Msg
    | NumberFieldChanged NumberField Number.Msg


type alias Model =
    { data : Data
    }


initialModel : Model
initialModel =
    { data =
        Data
            { firstName = Text.init notEmptyStringValidation
            , lastName = Text.init notEmptyStringValidation
            , notes = Textarea.init notEmptyStringValidation
            , age = Number.init ageValidation
            , birth = Date.init birthValidation
            , email = Text.init notEmptyStringValidation
            , password = Text.init notEmptyStringValidation
            , isFormSubmitted = False
            }
    }


type Data
    = Data
        { firstName : Text.Model Data
        , lastName : Text.Model Data
        , notes : Textarea.Model Data
        , age : Number.Model Data
        , birth : Date.Model Data
        , email : Text.Model Data
        , password : Text.Model Data
        , isFormSubmitted : Bool
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


notEmptyStringValidation : Data -> String -> Result String String
notEmptyStringValidation (Data data) value =
    if data.isFormSubmitted && String.isEmpty value then
        Err "This field cannot be empty"

    else
        Ok value


ageValidation : Data -> Int -> Result String Int
ageValidation (Data data) value =
    if data.isFormSubmitted && value < 18 then
        Err "You should be at least 18 yo"

    else if data.isFormSubmitted && value > 25 then
        Err "You cannot be older then 50 yo"

    else
        Ok value


birthValidation : Data -> Date.Date -> Result String Date.Date
birthValidation (Data data) value =
    if data.isFormSubmitted && Date.isRaw value then
        Err "Enter a valid date."

    else
        Ok value


update : Msg -> Model -> Model
update msg model =
    case msg of
        Submit ->
            mapData (\(Data d) -> Data { d | isFormSubmitted = True }) model

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

        TextareaFieldChanged Notes subMsg ->
            mapData (\(Data d) -> Data { d | notes = Textarea.update (Data d) subMsg d.notes }) model


mapData : (Data -> Data) -> Model -> Model
mapData mapper model =
    { model | data = mapper model.data }


view : Model -> Html Msg
view model =
    Html.div
        [ Html.Attributes.class "container container-from-xsmall padding-v-l" ]
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
        |> FieldSet.withIcon
            (IconSet.User
                |> Icon.create
                |> Icon.withStyle Icon.brand
            )
        |> FieldSet.withTitle "User data"
        |> FieldSet.withText "Lorem ipsum dolor sit amet."
        |> FieldSet.withRow
            ("first_name"
                |> Text.text (TextFieldChanged FirstName)
                |> Text.withLabel
                    ("First name"
                        |> Label.config
                        |> Label.withSubText "Lorem ipsum dolor sit amet."
                    )
                |> Text.render data config.firstName
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            ("last_name"
                |> Text.text (TextFieldChanged LastName)
                |> Text.withLabel
                    ("Last name"
                        |> Label.config
                        |> Label.withSubText "Lorem ipsum dolor sit amet."
                    )
                |> Text.render data config.lastName
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            ("age"
                |> Number.config (NumberFieldChanged Age)
                |> Number.withLabel (Label.config "Age")
                |> Number.render data config.age
                |> List.singleton
                |> viewTwoColumnsRow
                    ("birth_date"
                        |> Date.config (DateFieldChanged Birth)
                        |> Date.withLabel (Label.config "Birth date")
                        |> Date.render data config.birth
                        |> List.singleton
                    )
            )
        |> FieldSet.withRow
            ("notes"
                |> Textarea.config (TextareaFieldChanged Notes)
                |> Textarea.withLabel (Label.config "Notes")
                |> Textarea.render data config.notes
                |> List.singleton
                |> viewOneColumnRow
            )


viewLoginFieldSet : Data -> FieldSet.FieldSet Msg
viewLoginFieldSet ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withIcon
            (IconSet.Lock
                |> Icon.create
                |> Icon.withStyle Icon.brand
            )
        |> FieldSet.withTitle "Login data"
        |> FieldSet.withText "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        |> FieldSet.withRow
            ("email"
                |> Text.text (TextFieldChanged Email)
                |> Text.withLabel (Label.config "Email")
                |> Text.withAddon Placement.append (Text.iconAddon IconSet.Mail)
                |> Text.render data config.email
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            ("password"
                |> Text.text (TextFieldChanged Password)
                |> Text.withLabel (Label.config "Password")
                |> Text.withAddon Placement.append (Text.iconAddon IconSet.Lock)
                |> Text.render data config.password
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            (Button.primary
                |> Button.withType (Button.button Submit)
                |> Button.withText "Submit"
                |> Button.render
                |> List.singleton
                |> viewOneColumnRow
            )


viewOneColumnRow : List (Html Msg) -> GridRow.Row Msg
viewOneColumnRow content =
    GridRow.create
        |> GridRow.withColumn (GridColumn.withContent content GridColumn.create)
        |> GridRow.withSize Size.small


viewTwoColumnsRow : List (Html Msg) -> List (Html Msg) -> GridRow.Row Msg
viewTwoColumnsRow content1 content2 =
    GridRow.create
        |> GridRow.withColumn
            (GridColumn.create
                |> GridColumn.withContent content1
                |> GridColumn.withColumnSpan GridColumn.threeColumns
            )
        |> GridRow.withColumn (GridColumn.withContent content2 GridColumn.create)
        |> GridRow.withSize Size.small
