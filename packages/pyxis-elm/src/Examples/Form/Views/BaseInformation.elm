module Examples.Form.Views.BaseInformation exposing (view)

import Components.Field.Autocomplete as Autocomplete
import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Error.Strategy as Strategy
import Components.Field.Input as Input
import Components.Field.Label as Label
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid as Grid
import Components.Form.Grid.Row as Row
import Components.Form.Legend as Legend
import Components.IconSet as IconSet
import Examples.Form.Api.City as City
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
                        |> Input.text
                        |> Input.withPlaceholder "AA123BC"
                        |> Input.withLabel
                            ("Targa del veicolo assicurato con Prima"
                                |> Label.config
                                |> Label.withSubText "(Veicolo A)"
                            )
                        |> Input.withAdditionalContent (Html.button [] [])
                        |> Input.render (Model.TextFieldChanged Data.Plate) data config.plate
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "birth_date"
                        |> Input.date
                        |> Input.withLabel (Label.config "Data di nascita del proprietario")
                        |> Input.render (Model.DateFieldChanged Data.Birth) data config.birth
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "residential_city"
                        |> Autocomplete.config City.startsWith City.getName
                        |> Autocomplete.withStrategy Strategy.onSubmit
                        |> Autocomplete.withNoResultsFoundMessage "Nessun risultato trovato."
                        |> Autocomplete.withLabel (Label.config "Città di residenza")
                        |> Autocomplete.withHint "Min. 3 caratteri"
                        |> Autocomplete.withPlaceholder "Milano"
                        |> Autocomplete.withAddonSuggestion
                            { icon = IconSet.InfoCircle
                            , title = "Lorem ipsum"
                            , subtitle = Just "Lorem ipsum dolor sit amet."
                            }
                        --(Autocomplete.headerAddon "Lorem ipsum")
                        |> Autocomplete.render (Model.AutocompleteFieldChanged Data.ResidentialCity) data config.residentialCity
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "claim_date"
                        |> Input.date
                        |> Input.withLabel (Label.config "Data del sinistro")
                        |> Input.render (Model.DateFieldChanged Data.ClaimDate) data config.claimDate
                    ]
                ]
            , Grid.row
                [ Row.smallSize ]
                [ Grid.simpleCol
                    [ "checkbox-id"
                        |> CheckboxGroup.single
                            (Html.div
                                []
                                [ Html.text
                                    "Dichiaro di aver letto l’"
                                , Html.a [ Attributes.href "https://www.prima.it/app/privacy-policy" ]
                                    [ Html.text "Informativa Privacy" ]
                                , Html.text
                                    ", disposta ai sensi degli articoli 13 e 14 del Regolamento UE 2016/679. "
                                ]
                            )
                        |> CheckboxGroup.withStrategy Strategy.onSubmit
                        |> CheckboxGroup.withName "checkbox-group-single"
                        |> CheckboxGroup.render Model.PrivacyChanged data config.privacyCheck
                    ]
                ]
            ]
