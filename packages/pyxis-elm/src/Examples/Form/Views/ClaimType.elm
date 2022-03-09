module Examples.Form.Views.ClaimType exposing (view)

import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Form.FieldSet as FieldSet
import Components.Form.Legend as Legend
import Components.IconSet as IconSet
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Examples.Form.Utils as Utils


view : Data -> FieldSet.FieldSet Model.Msg
view ((Data config) as data) =
    FieldSet.create
        |> FieldSet.withHeader
            [ Utils.rowSmallWithOneColumn
                (Legend.create
                    |> Legend.withTitle "Scegli la tipologia di sinistro"
                    |> Legend.withAddon (Legend.imageAddon "../../../assets/placeholder.svg")
                    |> Legend.render
                )
            ]
        |> FieldSet.withContent
            [ Utils.rowSmallWithOneColumn
                ("claim-type"
                    |> RadioCardGroup.config
                    |> RadioCardGroup.withLayout RadioCardGroup.vertical
                    |> RadioCardGroup.withOptions
                        [ RadioCardGroup.option
                            { value = Data.CarAccident
                            , title = Just "Incidenti stradali"
                            , text = Just "Urti, collisioni, uscite di strada..."
                            , addon = RadioCardGroup.iconAddon IconSet.VehicleCollisionKasko
                            }
                        , RadioCardGroup.option
                            { value = Data.OtherClaims
                            , title = Just "Altre tipologie di sinistro"
                            , text = Just "Infortuni, furti, danni ai cristalli..."
                            , addon = RadioCardGroup.iconAddon IconSet.VehicleFullKasko
                            }
                        ]
                    |> RadioCardGroup.render Model.ClaimTypeChanged data config.claimType
                )
            ]
