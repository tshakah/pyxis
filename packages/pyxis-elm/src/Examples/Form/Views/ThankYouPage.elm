module Examples.Form.Views.ThankYouPage exposing (view)

import Commons.Properties.Size as Size
import Components.Button as Button
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html
import Html.Attributes


view : Html.Html msg
view =
    Html.div
        [ Html.Attributes.class "thank-you-wrapper" ]
        [ Html.div
            [ Html.Attributes.class "spacing-v-m" ]
            [ IconSet.CheckCircle
                |> Icon.create
                |> Icon.withSize Size.large
                |> Icon.withStyle Icon.success
                |> Icon.render
            ]
        , Html.p
            [ Html.Attributes.class "title-m-bold spacing-v-s" ]
            [ Html.text "Richiesta inviata con successo!" ]
        , Html.p
            [ Html.Attributes.class "text-l-book spacing-v-l" ]
            [ Html.text
                "Abbiamo ricevuto la richiesta di denuncia: effettueremo alcune verifiche e procederemo all'apertura del sinistro. "
            , Html.span
                [ Html.Attributes.class "text-l-bold" ]
                [ Html.text "In caso di necessità, " ]
            , Html.text
                "utilizzeremo i contatti inseriti per richiedere altri documenti o informazioni."
            ]
        , Html.div
            [ Html.Attributes.class "button-row" ]
            [ Button.secondary
                |> Button.withText "Torna alla pagina sinistri"
                |> Button.render
            ]
        ]
