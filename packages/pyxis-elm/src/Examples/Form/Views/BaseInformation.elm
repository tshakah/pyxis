module Examples.Form.Views.BaseInformation exposing (view)

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Text as Text
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid as Grid
import Components.Form.Grid.Row as Row
import Components.Form.Legend as Legend
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Html
import Html.Attributes as Attributes


view : Data -> FieldSet.Config Model.Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.simpleOneColRow
                [ Legend.config
                    |> Legend.withTitle "Inserisci alcune informazioni di base"
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "plate"
                        |> Text.text
                        |> Text.withPlaceholder "AA123BC"
                        |> Text.withLabel
                            ("Targa del veicolo assicurato con Prima"
                                |> Label.config
                                |> Label.withSubText "(Veicolo A)"
                            )
                        |> Text.render (Model.TextFieldChanged Data.Plate) data config.plate
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "birth_date"
                        |> Date.config
                        |> Date.withLabel (Label.config "Data di nascita del proprietario")
                        |> Date.render (Model.DateFieldChanged Data.Birth) data config.birth
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "claim_date"
                        |> Date.config
                        |> Date.withLabel (Label.config "Data del sinistro")
                        |> Date.render (Model.DateFieldChanged Data.ClaimDate) data config.claimDate
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "checkbox-id"
                        |> CheckboxGroup.single
                            (Html.div []
                                [ Html.text
                                    "Dichiaro di aver letto l’"
                                , Html.a [ Attributes.href "https://www.prima.it/app/privacy-policy" ]
                                    [ Html.text "Informativa Privacy" ]
                                , Html.text
                                    ", disposta ai sensi degli articoli 13 e 14 del Regolamento UE 2016/679. "
                                ]
                            )
                        |> CheckboxGroup.withName "checkbox-group-single"
                        |> CheckboxGroup.render Model.PrivacyChanged data config.privacyCheck
                    ]
                ]
            ]
