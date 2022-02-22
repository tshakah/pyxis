module Examples.Form.View exposing (view)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Button as Button
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Number as Number
import Components.Field.RadioGroup as RadioGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as GridColumn
import Components.Form.Grid.Row as GridRow
import Components.Icon as Icon
import Components.IconSet as IconSet
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model exposing (Model)
import Html exposing (Html)
import Html.Attributes


view : Model -> Html Model.Msg
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


viewForm : Data -> Html Model.Msg
viewForm data =
    Form.create
        |> Form.withFieldSet (viewUserFieldSet data)
        |> Form.withFieldSet (viewLoginFieldSet data)
        |> Form.render


viewUserFieldSet : Data -> FieldSet.FieldSet Model.Msg
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
                |> Text.text (Model.TextFieldChanged Data.FirstName)
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
                |> Text.text (Model.TextFieldChanged Data.LastName)
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
                |> Number.config (Model.NumberFieldChanged Data.Age)
                |> Number.withLabel (Label.config "Age")
                |> Number.render data config.age
                |> List.singleton
                |> viewTwoColumnsRow
                    ("birth_date"
                        |> Date.config (Model.DateFieldChanged Data.Birth)
                        |> Date.withLabel (Label.config "Birth date")
                        |> Date.render data config.birth
                        |> List.singleton
                    )
            )
        |> FieldSet.withRow
            ("gender"
                |> RadioGroup.config Model.GenderFieldChanged
                |> RadioGroup.withLabel (Label.config "Choose your gender")
                |> RadioGroup.withOptions
                    [ RadioGroup.option { value = Data.Male, label = "Male" }
                    , RadioGroup.option { value = Data.Female, label = "Female" }
                    ]
                |> RadioGroup.render data config.gender
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            ("notes"
                |> Textarea.config (Model.TextareaFieldChanged Data.Notes)
                |> Textarea.withLabel (Label.config "Notes")
                |> Textarea.render data config.notes
                |> List.singleton
                |> viewOneColumnRow
            )


viewLoginFieldSet : Data -> FieldSet.FieldSet Model.Msg
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
                |> Text.text (Model.TextFieldChanged Data.Email)
                |> Text.withLabel (Label.config "Email")
                |> Text.withAddon Placement.append (Text.iconAddon IconSet.Mail)
                |> Text.render data config.email
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            ("password"
                |> Text.text (Model.TextFieldChanged Data.Password)
                |> Text.withLabel (Label.config "Password")
                |> Text.withAddon Placement.append (Text.iconAddon IconSet.Lock)
                |> Text.render data config.password
                |> List.singleton
                |> viewOneColumnRow
            )
        |> FieldSet.withRow
            (Button.primary
                |> Button.withType (Button.button Model.Submit)
                |> Button.withText "Submit"
                |> Button.render
                |> List.singleton
                |> viewOneColumnRow
            )


viewOneColumnRow : List (Html Model.Msg) -> GridRow.Row Model.Msg
viewOneColumnRow content =
    GridRow.create
        |> GridRow.withColumn (GridColumn.withContent content GridColumn.create)
        |> GridRow.withSize Size.small


viewTwoColumnsRow : List (Html Model.Msg) -> List (Html Model.Msg) -> GridRow.Row Model.Msg
viewTwoColumnsRow content1 content2 =
    GridRow.create
        |> GridRow.withColumn
            (GridColumn.create
                |> GridColumn.withContent content1
                |> GridColumn.withColumnSpan GridColumn.threeColumns
            )
        |> GridRow.withColumn (GridColumn.withContent content2 GridColumn.create)
        |> GridRow.withSize Size.small
