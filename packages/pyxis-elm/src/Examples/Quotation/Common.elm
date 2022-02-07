module Examples.Quotation.Common exposing (viewFormItem)

import Html exposing (Html)
import Html.Attributes exposing (class)


viewFormItem : String -> Html msg -> Html msg
viewFormItem str input =
    Html.div [ class "form-item" ]
        [ Html.label [ class "form-label" ] [ Html.text str ]
        , input
        ]
