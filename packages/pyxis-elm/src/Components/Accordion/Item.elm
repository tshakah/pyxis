module Components.Accordion.Item exposing
    ( Config
    , config
    , withTitle
    , withSubtitle
    , withContent
    , ActionText
    , withActionText
    , withAddon
    , iconAddon
    , imageAddon
    , setContentId
    , render
    )

{-|


# Accordion Item


## Configuration

@docs Config
@docs config


## Content

@docs withTitle
@docs withSubtitle
@docs withContent


# Item Addon

@docs ActionText
@docs withActionText
@docs withAddon
@docs iconAddon
@docs imageAddon


# Generics

@docs setContentId


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Render
import Commons.String
import Components.Icon as Icon
import Components.IconSet as IconSet
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events


{-| Internal. Alias for ActionText.
-}
type alias ActionText =
    { open : String
    , close : String
    }


{-| Internal. Alias for ImageUrl.
-}
type alias ImageUrl =
    String


{-| Addon types.
-}
type AddonType
    = IconAddon IconSet.Icon
    | ImageAddon ImageUrl


{-| Internal. The internal item configuration
-}
type alias ConfigData msg =
    { actionText : Maybe ActionText
    , addon : Maybe AddonType
    , content : List (Html msg)
    , height : Float
    , id : String
    , subtitle : Maybe String
    , title : Maybe String
    }


{-| The item's view configuration
-}
type Config msg
    = Config (ConfigData msg)


{-| Creates an accordion item
-}
config : String -> Config msg
config id =
    Config
        { actionText = Nothing
        , addon = Nothing
        , content = []
        , height = 0
        , id = id
        , subtitle = Nothing
        , title = Nothing
        }


{-| Creates an Addon with an Icon from our IconSet.
-}
iconAddon : IconSet.Icon -> AddonType
iconAddon =
    IconAddon


{-| Creates an Addon with an Image
-}
imageAddon : ImageUrl -> AddonType
imageAddon =
    ImageAddon


{-| Sets the title.
-}
withTitle : String -> Config msg -> Config msg
withTitle title (Config itemConfig) =
    Config { itemConfig | title = Just title }


{-| Sets the subtitle.
-}
withSubtitle : String -> Config msg -> Config msg
withSubtitle subtitle (Config itemConfig) =
    Config { itemConfig | subtitle = Just subtitle }


{-| Sets the action texts.
-}
withActionText : ActionText -> Config msg -> Config msg
withActionText actionText (Config itemConfig) =
    Config { itemConfig | actionText = Just actionText }


{-| Sets an Addon by type.
-}
withAddon : AddonType -> Config msg -> Config msg
withAddon type_ (Config itemConfig) =
    Config { itemConfig | addon = Just type_ }


{-| Sets the content.
-}
withContent : List (Html msg) -> Config msg -> Config msg
withContent content (Config itemConfig) =
    Config { itemConfig | content = content }


{-| Internal. The internal render data configuration
-}
type alias RenderData msg =
    { onClick : String -> msg
    , onFocus : String -> msg
    , classList : List ( String, Bool )
    , isOpen : String -> Bool
    , itemsHeight : Dict String Float
    }


{-| Render the accordion item.
-}
render : RenderData msg -> Config msg -> Html.Html msg
render { onClick, onFocus, classList, isOpen, itemsHeight } ((Config { content, id }) as configuration) =
    Html.div
        [ Attributes.class "accordion-item"
        , Attributes.classList classList
        , Attributes.id id
        ]
        [ renderButton (onClick id) (onFocus id) (isOpen id) configuration
        , renderSection (isOpen id) id content itemsHeight
        ]


{-| Internal. Render subtitle.
-}
renderTitle : String -> Html msg
renderTitle title =
    Html.div
        [ Attributes.class "accordion-item__header__title" ]
        [ Html.text title ]


{-| Internal. Render subtitle.
-}
renderSubtitle : String -> Html msg
renderSubtitle subtitle =
    Html.div
        [ Attributes.class "accordion-item__header__subtitle" ]
        [ Html.text subtitle ]


{-| Internal. Render action text.
-}
renderActionText : Bool -> ActionText -> Html msg
renderActionText open actionTexts =
    Html.span
        [ Attributes.class "accordion-item__header__action-label" ]
        [ Html.text
            (if open then
                actionTexts.close

             else
                actionTexts.open
            )
        ]


{-| Internal. Render an Addon by type.
-}
renderAddonByType : AddonType -> Html msg
renderAddonByType type_ =
    case type_ of
        IconAddon icon ->
            Html.div
                [ Attributes.class "accordion-item__header__addon" ]
                [ icon
                    |> Icon.config
                    |> Icon.withSize Icon.large
                    |> Icon.render
                ]

        ImageAddon url ->
            Html.div
                [ Attributes.class "accordion-item__header__addon" ]
                [ Html.img
                    [ Attributes.src url
                    , Attributes.height 60
                    , Attributes.width 60
                    ]
                    []
                ]


{-| Internal. Render accordion item button
-}
renderButton : msg -> msg -> Bool -> Config msg -> Html msg
renderButton onClick onFocus open (Config { title, subtitle, actionText, addon, id }) =
    Html.h6
        []
        [ Html.button
            [ Attributes.class "accordion-item__header"
            , Attributes.attribute "aria-controls" (setSectionId id)
            , Attributes.attribute "aria-expanded" (Commons.String.fromBool open)
            , Attributes.id (setHeaderId id)
            , Events.onClick onClick
            , Events.onFocus onFocus
            ]
            [ addon
                |> Maybe.map renderAddonByType
                |> Commons.Render.renderMaybe
            , Html.div
                [ Attributes.class "accordion-item__header__content-wrapper" ]
                [ title
                    |> Maybe.map renderTitle
                    |> Commons.Render.renderMaybe
                , subtitle
                    |> Maybe.map renderSubtitle
                    |> Commons.Render.renderMaybe
                ]
            , Html.div
                [ Attributes.class "accordion-item__header__action-wrapper" ]
                [ actionText
                    |> Maybe.map (renderActionText open)
                    |> Commons.Render.renderMaybe
                , Html.span
                    [ Attributes.class "accordion-item__header__action-icon"
                    , Attributes.classList [ ( "accordion-item__header__action-icon--open", open ) ]
                    ]
                    [ Icon.config IconSet.ChevronDown
                        |> Icon.withSize Icon.large
                        |> Icon.render
                    ]
                ]
            ]
        ]


{-| Internal. Render accordion item section
-}
renderSection : Bool -> String -> List (Html msg) -> Dict String Float -> Html msg
renderSection open id content itemsHeight =
    Html.section
        [ Attributes.class "accordion-item__panel"
        , Attributes.classList [ ( "accordion-item__panel--open", open ) ]
        , Commons.Attributes.ariaLabelledbyBy (setHeaderId id)
        , Attributes.id (setSectionId id)
        , Attributes.style "max-height" (setMaxHeight open id itemsHeight ++ "px")
        ]
        [ Html.div
            [ Attributes.class "accordion-item__panel__inner-wrapper"
            , Attributes.id (setContentId id)
            ]
            content
        ]


{-| Internal. Set item content height if accordion is open.
-}
setMaxHeight : Bool -> String -> Dict String Float -> String
setMaxHeight open id itemsHeight =
    if open then
        Dict.get id itemsHeight
            |> Maybe.map String.fromFloat
            |> Maybe.withDefault ""

    else
        "0"


{-| Internal. Generate accordion section id.
-}
setHeaderId : String -> String
setHeaderId id =
    Commons.String.toKebabCase (id ++ "-header")


{-| Internal. Generate accordion section id.
-}
setSectionId : String -> String
setSectionId id =
    Commons.String.toKebabCase (id ++ "-section")


{-| Generate accordion content id.
-}
setContentId : String -> String
setContentId id =
    Commons.String.toKebabCase (id ++ "-content")
