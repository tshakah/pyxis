module Components.Form.Legend exposing
    ( Legend
    , create
    , withAddon
    , iconAddon
    , imageAddon
    , withTitle
    , withDescription
    , withAlignmentLeft
    , render
    )

{-|


# Legend

@docs Legend
@docs create


## Addons

@docs withAddon
@docs iconAddon
@docs imageAddon


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
type Legend msg
    = Legend Configuration


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
type alias Configuration =
    { addon : Maybe AddonType
    , title : String
    , alignment : Alignment
    , description : Maybe String
    , icon : Maybe Icon.Model
    , imageUrl : Maybe String
    }


{-| Creates a FieldSet with an empty legend.
-}
create : Legend msg
create =
    Legend
        { addon = Nothing
        , title = ""
        , alignment = Center
        , description = Nothing
        , icon = Nothing
        , imageUrl = Nothing
        }


{-| Adds a title to the Legend.
-}
withTitle : String -> Legend msg -> Legend msg
withTitle a (Legend configuration) =
    Legend { configuration | title = a }


{-| Adds a description to the Legend.
-}
withDescription : String -> Legend msg -> Legend msg
withDescription a (Legend configuration) =
    Legend { configuration | description = Just a }


{-| Adds a left alignment to the Legend.
-}
withAlignmentLeft : Legend msg -> Legend msg
withAlignmentLeft (Legend configuration) =
    Legend { configuration | alignment = Left }


{-| Sets an Addon by type to the Legend.
-}
withAddon : AddonType -> Legend msg -> Legend msg
withAddon type_ (Legend configuration) =
    Legend { configuration | addon = Just type_ }


{-| Internal.
-}
render : Legend msg -> Html msg
render (Legend configuration) =
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
