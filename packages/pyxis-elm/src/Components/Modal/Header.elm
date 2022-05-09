module Components.Modal.Header exposing
    ( Config
    , config
    , OnCloseData
    , withCloseButton
    , withBadge
    , withIcon
    , withTitle
    , withIsSticky
    , withCustomContent
    , render
    )

{-|


# Modal Header component

@docs Config
@docs config


## Generics

@docs OnCloseData
@docs withCloseButton
@docs withBadge
@docs withIcon
@docs withTitle
@docs withIsSticky
@docs withCustomContent


## Rendering

@docs render

-}

import Commons.Render
import Components.Badge as Badge
import Components.Button as Button
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Maybe.Extra


{-| Internal. The internal Header configuration.
-}
type alias ConfigData msg =
    { badge : Maybe Badge.Config
    , closeButton : Maybe (OnCloseData msg)
    , customContent : Maybe (List (Html msg))
    , icon : Maybe Icon.Config
    , isSticky : Bool
    , title : Maybe String
    }


{-| The configuration for a close button
-}
type alias OnCloseData msg =
    { msg : msg
    , ariaLabel : String
    }


{-| The Header configuration.
-}
type Config msg
    = Config (ConfigData msg)


{-| Inits the Header.

    import Components.Modal as Modal
    import Components.Modal.Header as ModalHeader

    modal : Html msg
    modal =
        Modal.config
            |> Modal.withHeader modalHeader
            |> Modal.render

    modalHeader : ModalHeader.Config msg
    modalHeader =
        ModalHeader.config
            |> ModalHeader.withIsSticky
            |> ModalHeader.withTitle "Title Modal"

-}
config : Config msg
config =
    Config
        { badge = Nothing
        , customContent = Nothing
        , closeButton = Nothing
        , icon = Nothing
        , isSticky = False
        , title = Nothing
        }


{-| Adds the badge to the Header.
-}
withBadge : Badge.Config -> Config msg -> Config msg
withBadge badge (Config configData) =
    Config { configData | badge = Just badge }


{-| Adds the icon to the Header.
-}
withIcon : Icon.Config -> Config msg -> Config msg
withIcon icon (Config configData) =
    Config { configData | icon = Just icon }


{-| Adds the title to the Header.
-}
withTitle : String -> Config msg -> Config msg
withTitle title (Config configData) =
    Config { configData | title = Just title }


{-| Sets the sticky Header.
-}
withIsSticky : Bool -> Config msg -> Config msg
withIsSticky isSticky (Config configData) =
    Config { configData | isSticky = isSticky }


{-| Add the configuration for a close button,
-}
withCloseButton : Maybe (OnCloseData msg) -> Config msg -> Config msg
withCloseButton onCloseData (Config configuration) =
    Config { configuration | closeButton = onCloseData }


{-| Adds the custom content to the Header. This content replace the `title`, `badge` and `icon` if are set.
-}
withCustomContent : List (Html msg) -> Config msg -> Config msg
withCustomContent customContent (Config configData) =
    Config { configData | customContent = Just customContent }


{-| Renders the Header.
-}
render : Config msg -> Html.Html msg
render (Config { closeButton, customContent, isSticky, title, badge, icon }) =
    Html.header
        [ Attributes.classList
            [ ( "modal__header", True )
            , ( "modal__header--sticky", isSticky )
            ]
        ]
        [ Html.div
            [ Attributes.classList
                [ ( "modal__header__wrapper", True )
                , ( "modal__header__wrapper--custom", Maybe.Extra.isJust customContent )
                ]
            ]
            (customContent
                |> Maybe.withDefault
                    [ badge
                        |> Maybe.map renderBadge
                        |> Commons.Render.renderMaybe
                    , icon
                        |> Maybe.map renderIcon
                        |> Commons.Render.renderMaybe
                    , title
                        |> Maybe.map renderTitle
                        |> Commons.Render.renderMaybe
                    ]
            )
        , closeButton
            |> Maybe.map renderCloseButton
            |> Commons.Render.renderMaybe
        ]


{-| Internal. Render the Badge.
-}
renderBadge : Badge.Config -> Html msg
renderBadge badge =
    Html.div
        [ Attributes.class "modal__header__badge" ]
        [ Badge.render badge ]


{-| Internal. Render the Icon.
-}
renderIcon : Icon.Config -> Html msg
renderIcon =
    Icon.render


{-| Internal. Render the title.
-}
renderTitle : String -> Html msg
renderTitle title =
    Html.h3
        [ Attributes.class "modal__header__title" ]
        [ Html.text title ]


{-| Internal. Render the close button.
-}
renderCloseButton : OnCloseData msg -> Html msg
renderCloseButton { msg, ariaLabel } =
    Button.tertiary
        |> Button.withSize Button.medium
        |> Button.withAriaLabel ariaLabel
        |> Button.withType Button.button
        |> Button.withOnClick msg
        |> Button.withIconOnly IconSet.Close
        |> Button.render
