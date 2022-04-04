module Examples.Form.Views.ClaimDetail exposing (view)

import Components.Button as Button
import Components.Field.Error.Strategy as Strategy
import Components.Field.Label as Label
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Textarea as Textarea
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid as Grid
import Components.Form.Grid.Row as Row
import Components.Form.Legend as Legend
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Html
import Html.Attributes


view : Data -> FieldSet.Config Model.Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.simpleOneColRow
                [ Legend.config
                    |> Legend.withTitle "Inserisci i dettagli del sinistro"
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "people-involved"
                        |> RadioCardGroup.config
                        |> RadioCardGroup.withStrategy Strategy.onSubmit
                        |> RadioCardGroup.withLabel (Label.config "Il veicolo era in movimento?")
                        |> RadioCardGroup.withOptions
                            [ RadioCardGroup.option { value = Data.Involved, title = Nothing, text = Just "Sì", addon = Nothing }
                            , RadioCardGroup.option { value = Data.NotInvolved, title = Nothing, text = Just "No", addon = Nothing }
                            ]
                        |> RadioCardGroup.render Model.PeopleInvolvedChanged data config.peopleInvolved
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "claim-dynamic"
                        |> Textarea.config
                        |> Textarea.withStrategy Strategy.onSubmit
                        |> Textarea.withLabel (Label.config "Dinamica del sinistro")
                        |> Textarea.withPlaceholder "Descrivi la dinamica del sinistro (massimo 1.800 caratteri)"
                        |> Textarea.withHint "Massimo 300 parole"
                        |> Textarea.render (Model.TextareaFieldChanged Data.Dynamics) data config.dynamic
                    ]
                ]
            ]
        |> FieldSet.withFooter
            [ Grid.simpleOneColRow
                [ Html.div
                    [ Html.Attributes.class "button-row justify-content-center" ]
                    [ Button.primary
                        |> Button.withType (Button.button Model.Submit)
                        |> Button.withText "Procedi"
                        |> Button.render
                    ]
                ]
            ]
