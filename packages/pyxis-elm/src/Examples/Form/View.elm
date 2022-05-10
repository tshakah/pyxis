module Examples.Form.View exposing (view)

import Examples.Form.Data exposing (Data)
import Examples.Form.Model as Model exposing (Model)
import Examples.Form.Views.BaseInformation as BaseInformation
import Examples.Form.Views.ClaimDetail as ClaimDetail
import Examples.Form.Views.ClaimType as ClaimType
import Examples.Form.Views.InsuranceType as InsuranceType
import Examples.Form.Views.ThankYouPage as ThankYouPage
import Html exposing (Html)
import Html.Attributes
import Pyxis.Commons.Properties.Theme as Theme
import Pyxis.Commons.Render as CommonsRender
import Pyxis.Components.Accordion as Accordion
import Pyxis.Components.Accordion.Item as AccordionItem
import Pyxis.Components.Badge as Badge
import Pyxis.Components.Button as Button
import Pyxis.Components.Form as Form
import Pyxis.Components.Icon as Icon
import Pyxis.Components.IconSet as IconSet
import Pyxis.Components.Modal as Modal
import Pyxis.Components.Modal.Footer as ModalFooter
import Pyxis.Components.Modal.Header as ModalHeader
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
            |> CommonsRender.renderIf
                (model.response
                    |> Maybe.map Result.Extra.isOk
                    |> Maybe.withDefault False
                )
        , modal model.showModal
        , Html.div [ Html.Attributes.class "container-medium padding-v-m" ]
            [ Accordion.config "accordion-id"
                |> Accordion.withItems accordionItems
                |> Accordion.render Model.AccordionChanged model.accordion
            ]
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


modal : Bool -> Html Model.Msg
modal show =
    Modal.config "test-modal"
        |> Modal.withClassList [ ( "class-custom", True ) ]
        |> Modal.withSize Modal.large
        |> Modal.withHeader modalHeader
        |> Modal.withContent modalContent
        |> Modal.withFooter modalFooter
        |> Modal.withCloseMsg (Model.ShowModal False) "Close"
        |> Modal.withAriaDescribedBy "Screen Reader Description"
        |> Modal.render show


modalHeader : ModalHeader.Config Model.Msg
modalHeader =
    ModalHeader.config
        |> ModalHeader.withIsSticky True
        |> ModalHeader.withTitle "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        |> ModalHeader.withBadge (Badge.brand "Hello Prima")
        |> ModalHeader.withIcon modalIcon


modalIcon : Icon.Config
modalIcon =
    IconSet.Car
        |> Icon.config
        |> Icon.withClassList [ ( "c-brand-base", True ) ]
        |> Icon.withSize Icon.large


modalContent : List (Html msg)
modalContent =
    [ Html.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. Integer scelerisque mi at blandit vestibulum. Vivamus nec nibh id lacus lacinia facilisis vel nec felis. Duis rhoncus rutrum volutpat. Quisque at pulvinar enim. Vestibulum ut posuere erat. Quisque cursus ut odio vel faucibus. Duis semper venenatis finibus. Morbi iaculis ligula at justo lobortis vulputate. Duis vestibulum neque at neque fringilla malesuada. Nulla vitae nunc sed lectus varius facilisis in eu nisi. Aliquam erat volutpat. Phasellus sapien elit, suscipit id eleifend sed, posuere ac nulla. Duis volutpat, mauris sit amet tincidunt ornare, nunc erat semper ex, quis rhoncus eros nulla et metus. Vestibulum eu egestas felis, quis porta lectus." ]


modalFooter : ModalFooter.Config Model.Msg
modalFooter =
    ModalFooter.config
        |> ModalFooter.withText (Html.div [] [ Html.text "Lorem" ])
        |> ModalFooter.withTheme Theme.alternative
        |> ModalFooter.withFullWidthButton True
        |> ModalFooter.withButtons
            [ Button.secondary
                |> Button.withText "Secondary"
                |> Button.render
            , Button.primary
                |> Button.withText "Close"
                |> Button.withType Button.button
                |> Button.withOnClick (Model.ShowModal False)
                |> Button.render
            ]


accordionItems : List (AccordionItem.Config msg)
accordionItems =
    [ AccordionItem.config "accordion-1"
        |> AccordionItem.withTitle "Title one"
        |> AccordionItem.withSubtitle "Subtitle"
        |> AccordionItem.withContent
            [ Html.div
                []
                [ Html.text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus.  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ultrices libero ac semper cursus. " ]
            ]
    , AccordionItem.config "accordion-2"
        |> AccordionItem.withTitle "Title two"
        |> AccordionItem.withContent
            [ Html.div
                []
                [ Html.text "Lorem ipsum." ]
            ]
    ]
