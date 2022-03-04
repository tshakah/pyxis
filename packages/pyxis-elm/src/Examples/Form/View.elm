module Examples.Form.View exposing (view)

import Commons.Properties.Placement as Placement
import Components.Button as Button
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Number as Number
import Components.Field.RadioGroup as RadioGroup
import Components.Field.Text as Text
import Components.Field.Textarea as Textarea
import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as Column
import Components.Form.Grid.Row as Row
import Components.Form.Legend as Legend
import Components.IconSet as IconSet
import Components.Message as Message
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model exposing (Model)
import Html exposing (Html)
import Html.Attributes


view : Model -> Html Model.Msg
view model =
    Html.div
        [ Html.Attributes.class "container padding-v-l" ]
        [ Html.node "link"
            [ Html.Attributes.href "../../../dist/pyxis.css"
            , Html.Attributes.rel "stylesheet"
            ]
            []
        , Html.node "meta"
            [ Html.Attributes.name "viewport"
            , Html.Attributes.attribute "content" "width=device-width, initial-scale=1"
            ]
            []
        , viewForm model.data
        ]


viewForm : Data -> Html Model.Msg
viewForm data =
    Form.create
        |> Form.withFieldSets
            [ viewUserFieldSet data
            ]
        |> Form.render


viewUserFieldSet : Data -> FieldSet.FieldSet Model.Msg
viewUserFieldSet ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withHeader
            [ Row.large
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            (Message.alert
                                |> Message.withContent
                                    [ Html.text "Message Text" ]
                                |> Message.withTitle "Message Title"
                                |> Message.render
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            (Legend.create
                                |> Legend.withAddon (Legend.imageAddon "../../../assets/placeholder.svg")
                                |> Legend.withTitle "User data"
                                |> Legend.render
                            )
                    ]
            ]
        |> FieldSet.withContent
            [ Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("first_name"
                                |> Text.text
                                |> Text.withLabel
                                    ("First name"
                                        |> Label.config
                                    )
                                |> Text.render (Model.TextFieldChanged Data.FirstName) data config.firstName
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("last_name"
                                |> Text.text
                                |> Text.withLabel
                                    ("Last name"
                                        |> Label.config
                                        |> Label.withSubText "Lorem ipsum dolor sit amet."
                                    )
                                |> Text.render (Model.TextFieldChanged Data.LastName) data config.lastName
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("gender"
                                |> RadioGroup.config
                                |> RadioGroup.withLabel (Label.config "Choose your gender")
                                |> RadioGroup.withLayout RadioGroup.vertical
                                |> RadioGroup.withOptions
                                    [ RadioGroup.option { value = Data.Male, label = "Male" }
                                    , RadioGroup.option { value = Data.Female, label = "Female" }
                                    ]
                                |> RadioGroup.render Model.GenderFieldChanged data config.gender
                            )
                    ]
            , Row.large
                |> Row.withColumns
                    [ Column.fourSpan
                        |> Column.withContent
                            ("birth_date"
                                |> Date.config
                                |> Date.withLabel (Label.config "Birth date")
                                |> Date.render (Model.DateFieldChanged Data.Birth) data config.birth
                            )
                    , Column.twoSpan
                        |> Column.withContent
                            ("age"
                                |> Number.config
                                |> Number.withLabel (Label.config "Age")
                                |> Number.render (Model.NumberFieldChanged Data.Age) data config.age
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("email"
                                |> Text.email
                                |> Text.withLabel (Label.config "Email")
                                |> Text.withAddon Placement.prepend (Text.iconAddon IconSet.Mail)
                                |> Text.render (Model.TextFieldChanged Data.Email) data config.email
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("password"
                                |> Text.password
                                |> Text.withLabel (Label.config "Password")
                                |> Text.withAddon Placement.prepend (Text.iconAddon IconSet.Lock)
                                |> Text.render (Model.TextFieldChanged Data.Password) data config.password
                            )
                    ]
            , Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            ("notes"
                                |> Textarea.config
                                |> Textarea.withLabel (Label.config "Notes")
                                |> Textarea.render (Model.TextareaFieldChanged Data.Notes) data config.notes
                            )
                    ]
            ]
        |> FieldSet.withFooter
            [ Row.small
                |> Row.withColumns
                    [ Column.oneSpan
                        |> Column.withContent
                            (Button.primary
                                |> Button.withType (Button.button Model.Submit)
                                |> Button.withText "Submit"
                                |> Button.render
                            )
                    ]
            ]
