module Examples.Form.Views.ClaimType exposing (view)

import Components.Button as Button
import Components.Field.Error.Strategy as Strategy
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid as Grid
import Components.Form.Grid.Row as Row
import Components.Form.Legend as Legend
import Components.IconSet as IconSet
import Examples.Form.Data as Data exposing (Data(..))
import Examples.Form.Model as Model
import Html
import Html.Attributes


view : Data -> FieldSet.Config Model.Msg
view ((Data config) as data) =
    FieldSet.config
        |> FieldSet.withHeader
            [ Grid.simpleOneColRow
                [ Legend.config "Scegli la tipologia di sinistro"
                    |> Legend.withAddon (Legend.imageAddon "../../../assets/placeholder.svg")
                    |> Legend.render
                ]
            ]
        |> FieldSet.withContent
            [ Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "claim-type"
                        |> RadioCardGroup.config
                        |> RadioCardGroup.withStrategy Strategy.onSubmit
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
                    ]
                ]
            ]
        |> FieldSet.withFooter
            [ Grid.simpleOneColRow
                [ Html.div
                    [ Html.Attributes.class "button-row justify-content-center" ]
                    [ Button.secondary
                        |> Button.withType Button.button
                        |> Button.withOnClick (Model.ShowModal True)
                        |> Button.withText "Show Modal"
                        |> Button.render
                    ]
                ]
            ]
