module Examples.Form.Views.BaseInformation exposing (view)

import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Date as Date
import Components.Field.Label as Label
import Components.Field.Text as Text
import Components.Form.FieldSet as FieldSet
import Components.Form.Legend as Legend
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Examples.Form.Utils as Utils


view : Data -> FieldSet.FieldSet Model.Msg
view ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withHeader
            [ Utils.rowSmallWithOneColumn
                (Legend.create
                    |> Legend.withTitle "Inserisci alcune informazioni di base"
                    |> Legend.render
                )
            ]
        |> FieldSet.withContent
            [ Utils.rowSmallWithOneColumn
                ("plate"
                    |> Text.text
                    |> Text.withPlaceholder "AA123BC"
                    |> Text.withLabel
                        ("Targa del veicolo assicurato con Prima"
                            |> Label.config
                            |> Label.withSubText "(Veicolo A)"
                        )
                    |> Text.render (Model.TextFieldChanged Data.Plate) data config.plate
                )
            , Utils.rowSmallWithOneColumn
                ("birth_date"
                    |> Date.config
                    |> Date.withLabel (Label.config "Data di nascita del proprietario")
                    |> Date.render (Model.DateFieldChanged Data.Birth) data config.birth
                )
            , Utils.rowSmallWithOneColumn
                ("claim_date"
                    |> Date.config
                    |> Date.withLabel (Label.config "Data del sinistro")
                    |> Date.render (Model.DateFieldChanged Data.ClaimDate) data config.claimDate
                )
            , Utils.rowSmallWithOneColumn
                ("checkbox-id"
                    |> CheckboxGroup.single
                        "Dichiaro di aver letto l’Informativa Privacy, disposta ai sensi degli articoli 13 e 14 del Regolamento UE 2016/679. "
                    |> CheckboxGroup.withName "checkbox-group-single"
                    |> CheckboxGroup.render Model.PrivacyChanged data config.privacyCheck
                )
            ]
