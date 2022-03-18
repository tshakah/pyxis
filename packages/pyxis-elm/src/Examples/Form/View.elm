module Examples.Form.View exposing (view)

import Commons.Render
import Components.Form as Form
import Examples.Form.Data exposing (Data)
import Examples.Form.Model as Model exposing (Model)
import Examples.Form.Views.BaseInformation as BaseInformation
import Examples.Form.Views.ClaimDetail as ClaimDetail
import Examples.Form.Views.ClaimType as ClaimType
import Examples.Form.Views.InsuranceType as InsuranceType
import Examples.Form.Views.ThankYouPage as ThankYouPage
import Html exposing (Html)
import Html.Attributes
import Result.Extra


view : Model -> Html Model.Msg
view model =
    Html.div
        [ Html.Attributes.class "container padding-v-l" ]
        [ Html.node "link"
            [ Html.Attributes.href "../../../dist/pyxis.css"
            , Html.Attributes.rel "stylesheet"
            ]
            []
        , Html.node "link"
            [ Html.Attributes.href "./example.css"
            , Html.Attributes.rel "stylesheet"
            ]
            []
        , Html.node "meta"
            [ Html.Attributes.name "viewport"
            , Html.Attributes.attribute "content" "width=device-width, initial-scale=1"
            ]
            []
        , viewForm model.data
        , ThankYouPage.view
            |> Commons.Render.renderIf
                (model.response
                    |> Maybe.map Result.Extra.isOk
                    |> Maybe.withDefault False
                )
        ]


viewForm : Data -> Html Model.Msg
viewForm data =
    Form.config
        |> Form.withFieldSets
            [ InsuranceType.view data
            , BaseInformation.view data
            , ClaimType.view data
            , ClaimDetail.view data
            ]
        |> Form.render
