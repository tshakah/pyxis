module Examples.Form.Views.InsuranceType exposing (view)

import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Pyxis.Components.Field.Error.Strategy as Strategy
import Pyxis.Components.Field.RadioCardGroup as RadioCardGroup
import Pyxis.Components.Form.FieldSet as FieldSet
import Pyxis.Components.Form.Grid as Grid
import Pyxis.Components.Form.Grid.Row as Row
import Pyxis.Components.Form.Legend as Legend


view : Data -> FieldSet.Config Model.Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.simpleOneColRow
                [ Legend.config "Scegli il sinistro da denunciare"
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.row
                [ Row.mediumSize ]
                [ Grid.simpleCol
                    [ "insurance-type"
                        |> RadioCardGroup.config
                        |> RadioCardGroup.withStrategy Strategy.onSubmit
                        |> RadioCardGroup.withSize RadioCardGroup.large
                        |> RadioCardGroup.withOptions
                            [ RadioCardGroup.option { value = Data.Motor, title = Just "Veicoli", text = Nothing, addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg" }
                            , RadioCardGroup.option { value = Data.Home, title = Just "Casa e famiglia", text = Nothing, addon = RadioCardGroup.imgAddon "../../../../assets/placeholder.svg" }
                            ]
                        |> RadioCardGroup.render Model.InsuranceTypeChanged data config.insuranceType
                    ]
                ]
            ]
