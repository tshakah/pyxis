module Examples.Form.Views.InsuranceType exposing (view)

import Commons.Properties.Size as Size
import Components.Field.RadioCardGroup as RadioCardGroup
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
                    |> Legend.withTitle "Scegli il sinistro da denunciare"
                    |> Legend.render
                )
            ]
        |> FieldSet.withContent
            [ Utils.rowLargeWithOneColumn
                ("insurance-type"
                    |> RadioCardGroup.config
                    |> RadioCardGroup.withSize Size.large
                    |> RadioCardGroup.withOptions
                        [ RadioCardGroup.option { value = Data.Motor, title = Just "Veicoli", text = Nothing, addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg" }
                        , RadioCardGroup.option { value = Data.Home, title = Just "Casa e famiglia", text = Nothing, addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg" }
                        ]
                    |> RadioCardGroup.render Model.InsuranceTypeChanged data config.insuranceType
                )
            ]
