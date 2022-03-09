module Examples.Form.Views.ClaimDetail exposing (view)

import Components.Button as Button
import Components.Field.Label as Label
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Field.Textarea as Textarea
import Components.Form.FieldSet as FieldSet
import Components.Form.Legend as Legend
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Examples.Form.Utils as Utils
import Html
import Html.Attributes


view : Data -> FieldSet.FieldSet Model.Msg
view ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withHeader
            [ Utils.rowSmallWithOneColumn
                (Legend.create
                    |> Legend.withTitle "Inserisci i dettagli del sinistro"
                    |> Legend.render
                )
            ]
        |> FieldSet.withContent
            [ Utils.rowSmallWithOneColumn
                ("people-involved"
                    |> RadioCardGroup.config
                    |> RadioCardGroup.withOptions
                        [ RadioCardGroup.option { value = Data.Involved, title = Nothing, text = Just "Sì", addon = Nothing }
                        , RadioCardGroup.option { value = Data.NotInvolved, title = Nothing, text = Just "No", addon = Nothing }
                        ]
                    |> RadioCardGroup.render Model.PeopleInvolvedChanged data config.peopleInvolved
                )
            , Utils.rowSmallWithOneColumn
                ("claim-dynamic"
                    |> Textarea.config
                    |> Textarea.withLabel (Label.config "Dinamica del sinistro")
                    |> Textarea.withPlaceholder "Descrivi la dinamica del sinistro (massimo 1.800 caratteri)"
                    |> Textarea.withHint "Massimo 300 parole"
                    |> Textarea.render (Model.TextareaFieldChanged Data.Dynamics) data config.dynamic
                )
            ]
        |> FieldSet.withFooter
            [ Utils.rowSmallWithOneColumn
                (Html.div
                    [ Html.Attributes.class "button-row justify-content-center" ]
                    [ Button.primary
                        |> Button.withType (Button.button Model.Submit)
                        |> Button.withText "Procedi"
                        |> Button.render
                    ]
                )
            ]
