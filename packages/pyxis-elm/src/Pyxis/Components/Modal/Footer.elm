module Pyxis.Components.Modal.Footer exposing
    ( Config
    , config
    , withButtons
    , withFullWidthButton
    , withText
    , withTheme
    , withIsSticky
    , withCustomContent
    , render
    )

{-|


# Modal Footer component

@docs Config
@docs config


## Buttons

@docs withButtons
@docs withFullWidthButton


## Generics

@docs withText
@docs withTheme
@docs withIsSticky
@docs withCustomContent


## Rendering

@docs render

-}

import Html exposing (Html)
import Html.Attributes
import Maybe.Extra
import Pyxis.Commons.Properties.Theme as Theme exposing (Theme)
import Pyxis.Commons.Render as CommonsRender


{-| Internal. The internal Footer configuration.
-}
type alias ConfigData msg =
    { customContent : Maybe (List (Html msg))
    , buttons : List (Html msg)
    , text : Maybe (Html msg)
    , theme : Theme
    , fullWidthButton : Bool
    , isSticky : Bool
    }


{-| The Footer configuration.
-}
type Config msg
    = Config (ConfigData msg)


{-| Inits the Footer.

    import Pyxis.Components.Modal as Modal
    import Pyxis.Components.Modal.Footer as ModalFooter

    modal : Html msg
    modal =
        Modal.config
            |> Modal.withFooter modalFooter
            |> Modal.render

    modalFooter : ModalFooter.Config msg
    modalFooter =
        ModalFooter.config
            |> ModalFooter.withIsSticky
            |> ModalFooter.withText "Text Footer"

-}
config : Config msg
config =
    Config
        { customContent = Nothing
        , buttons = []
        , text = Nothing
        , theme = Theme.default
        , fullWidthButton = False
        , isSticky = False
        }


{-| Adds the Primary Button to the Footer.
-}
withButtons : List (Html msg) -> Config msg -> Config msg
withButtons buttons (Config configData) =
    Config { configData | buttons = buttons }


{-| Sets the button in full width on mobile.
-}
withFullWidthButton : Bool -> Config msg -> Config msg
withFullWidthButton fullWidthButton (Config configData) =
    Config { configData | fullWidthButton = fullWidthButton }


{-| Adds the text to the Footer.
-}
withText : Html msg -> Config msg -> Config msg
withText text (Config configData) =
    Config { configData | text = Just text }


{-| Sets a theme to the Footer.
-}
withTheme : Theme -> Config msg -> Config msg
withTheme theme (Config configuration) =
    Config { configuration | theme = theme }


{-| Sets the sticky Footer.
-}
withIsSticky : Bool -> Config msg -> Config msg
withIsSticky isSticky (Config configData) =
    Config { configData | isSticky = isSticky }


{-| Adds the custom content to the Footer. This content replace the `primaryButton`, `secondaryButton` and `text` if are set.
-}
withCustomContent : List (Html msg) -> Config msg -> Config msg
withCustomContent customContent (Config configData) =
    Config { configData | customContent = Just customContent }


{-| Renders the Footer.
-}
render : Config msg -> Html.Html msg
render (Config { customContent, isSticky, fullWidthButton, text, buttons, theme }) =
    Html.footer
        [ Html.Attributes.classList
            [ ( "modal__footer", True )
            , ( "modal__footer--sticky", isSticky )
            , ( "modal__footer--alt", Theme.isAlternative theme )
            , ( "modal__footer--custom", Maybe.Extra.isJust customContent )
            ]
        ]
        (customContent
            |> Maybe.withDefault
                [ text
                    |> Maybe.map renderText
                    |> CommonsRender.renderMaybe
                , buttons
                    |> renderButtons fullWidthButton
                ]
        )


{-| Internal. Render the Badge.
-}
renderText : Html msg -> Html msg
renderText text =
    Html.div
        [ Html.Attributes.class "modal__footer__text" ]
        [ text ]


renderButtons : Bool -> List (Html msg) -> Html msg
renderButtons fullWidthButton =
    Html.div
        [ Html.Attributes.classList
            [ ( "modal__footer__buttons", True )
            , ( "modal__footer__buttons--full-width", fullWidthButton )
            ]
        ]
