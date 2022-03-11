module Components.Form.Legend exposing
    ( Config
    , config
    , iconAddon
    , imageAddon
    , withAddon
    , withTitle
    , withDescription
    , withAlignmentLeft
    , render
    )

{-|


# Legend

@docs Config
@docs config


## Addons

@docs iconAddon
@docs imageAddon
@docs withAddon


## Generics

@docs withTitle
@docs withDescription
@docs withAlignmentLeft


## Rendering

@docs render

-}

import Commons.Render
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Legend and its contents.
-}
type Config msg
    = Config ConfigData


{-| Represents the Addon type
-}
type AddonType
    = IconAddon IconSet.Icon
    | ImageAddon String


{-| Internal.
-}
type alias ImageUrl =
    String


{-| Represents the alignment of Legend
-}
type Alignment
    = Center
    | Left


{-| Align the content to left.
-}
isAlignedLeft : Alignment -> Bool
isAlignedLeft =
    (==) Left


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


{-| Internal.
-}
type alias ConfigData =
    { addon : Maybe AddonType
    , title : String
    , alignment : Alignment
    , description : Maybe String
    , icon : Maybe Icon.Model
    , imageUrl : Maybe String
    }


{-| Creates a FieldSet with an empty legend.
-}
config : Config msg
config =
    Config
        { addon = Nothing
        , title = ""
        , alignment = Center
        , description = Nothing
        , icon = Nothing
        , imageUrl = Nothing
        }


{-| Adds a title to the Legend.
-}
withTitle : String -> Config msg -> Config msg
withTitle a (Config configuration) =
    Config { configuration | title = a }


{-| Adds a description to the Legend.
-}
withDescription : String -> Config msg -> Config msg
withDescription a (Config configuration) =
    Config { configuration | description = Just a }


{-| Adds a left alignment to the Legend.
-}
withAlignmentLeft : Config msg -> Config msg
withAlignmentLeft (Config configuration) =
    Config { configuration | alignment = Left }


{-| Sets an Addon by type to the Legend.
-}
withAddon : AddonType -> Config msg -> Config msg
withAddon type_ (Config configuration) =
    Config { configuration | addon = Just type_ }


{-| Internal.
-}
render : Config msg -> Html msg
render (Config configuration) =
    Html.legend
        [ Attributes.classList
            [ ( "form-legend", True )
            , ( "form-legend--align-left", isAlignedLeft configuration.alignment )
            ]
        ]
        [ configuration.addon
            |> Maybe.map renderAddonByType
            |> Commons.Render.renderMaybe
        , renderTitle configuration.title
        , configuration.description
            |> Maybe.map renderDescription
            |> Commons.Render.renderMaybe
        ]


{-| Internal.
-}
renderAddonByType : AddonType -> Html msg
renderAddonByType type_ =
    case type_ of
        IconAddon icon ->
            Html.div
                [ Attributes.class "form-legend__addon" ]
                [ icon
                    |> Icon.create
                    |> Icon.withStyle Icon.brand
                    |> Icon.render
                ]

        ImageAddon url ->
            Html.span
                [ Attributes.class "form-legend__addon" ]
                [ Html.img [ Attributes.src url ] [] ]


{-| Internal.
-}
renderTitle : String -> Html msg
renderTitle str =
    Html.span
        [ Attributes.class "form-legend__title" ]
        [ Html.text str ]


{-| Internal.
-}
renderDescription : String -> Html msg
renderDescription str =
    Html.span
        [ Attributes.class "form-legend__text" ]
        [ Html.text str ]
