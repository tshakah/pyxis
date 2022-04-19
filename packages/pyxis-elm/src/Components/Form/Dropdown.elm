module Components.Form.Dropdown exposing
    ( Content
    , options
    , headerAndOptions
    , noResult
    , suggestion
    , SuggestionData
    , render
    )

{-|


# Dropdown

@docs action
@docs Content
@docs options
@docs headerAndOptions
@docs noResult
@docs suggestion
@docs SuggestionData


## Rendering

@docs render

-}

import Commons.Properties.Size as Size
import Commons.Render
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Html.Keyed


type Content msg
    = NoResult (NoResultData msg)
    | HeaderAndOptions (HeaderAndOptionsData msg)
    | Options (List (Html msg))
    | Suggestion SuggestionData


type alias NoResultData msg =
    { label : String
    , action : Maybe (Html msg)
    }


type alias HeaderAndOptionsData msg =
    { header : Html msg
    , options : List (Html msg)
    }


type alias SuggestionData =
    { icon : IconSet.Icon
    , title : String
    , subtitle : Maybe String
    }


{-| Creates the action.
-}
noResult : NoResultData msg -> Content msg
noResult =
    NoResult


{-| Creates a content with and header.
-}
headerAndOptions : HeaderAndOptionsData msg -> Content msg
headerAndOptions =
    HeaderAndOptions


{-| Creates the most simple content.
-}
options : List (Html msg) -> Content msg
options =
    Options


{-| Creates a suggestion.
-}
suggestion : SuggestionData -> Content msg
suggestion =
    Suggestion


{-| Internal.
-}
hasHeader : Content msg -> Bool
hasHeader content_ =
    case content_ of
        HeaderAndOptions _ ->
            True

        _ ->
            False


{-| Renders the Dropdown.
-}
render : String -> msg -> Content msg -> Html msg
render id onBlur content_ =
    Html.div
        [ Attributes.class "form-dropdown-wrapper"
        , Events.onBlur onBlur
        ]
        [ Html.Keyed.node "div"
            [ Attributes.attribute "role" "listbox"
            , Attributes.classList
                [ ( "form-dropdown", True )
                , ( "form-dropdown--with-header", hasHeader content_ )
                ]
            , Attributes.id (id ++ "-dropdown-list")
            ]
            (content_
                |> renderContent
                |> List.indexedMap (\index item -> ( String.fromInt index, item ))
            )
        ]


{-| Internal.
-}
renderContent : Content msg -> List (Html msg)
renderContent content_ =
    case content_ of
        HeaderAndOptions config ->
            renderHeader config.header :: config.options

        Options options_ ->
            options_

        NoResult noResultData ->
            [ renderNoResult noResultData ]

        Suggestion config ->
            [ renderSuggestion config ]


{-| Internal.
-}
renderNoResult : NoResultData msg -> Html msg
renderNoResult { label, action } =
    Html.div
        [ Attributes.class "form-dropdown__no-results" ]
        [ Html.text label
        , action
            |> Maybe.map (List.singleton >> Html.div [ Attributes.class "form-dropdown__no-results__action" ])
            |> Commons.Render.renderMaybe
        ]


{-| Internal.
-}
renderHeader : Html msg -> Html msg
renderHeader content_ =
    Html.div [ Attributes.class "form-dropdown__header" ] [ content_ ]


{-| Internal.
-}
renderSuggestion : SuggestionData -> Html msg
renderSuggestion { icon, title, subtitle } =
    Html.div
        [ Attributes.class "form-dropdown__suggestion" ]
        [ renderSuggestionIcon icon
        , Html.div
            [ Attributes.class "form-dropdown__suggestion__wrapper" ]
            [ renderSuggestionTitle title
            , subtitle
                |> Maybe.map renderSuggestionSubtitle
                |> Commons.Render.renderMaybe
            ]
        ]


{-| Internal.
-}
renderSuggestionIcon : IconSet.Icon -> Html msg
renderSuggestionIcon =
    Icon.config
        >> Icon.withSize Size.medium
        >> Icon.withClassList [ ( "form-dropdown__suggestion__icon", True ) ]
        >> Icon.render


{-| Internal.
-}
renderSuggestionTitle : String -> Html msg
renderSuggestionTitle title =
    Html.div
        [ Attributes.class "form-dropdown__suggestion__title" ]
        [ Html.text title ]


{-| Internal.
-}
renderSuggestionSubtitle : String -> Html msg
renderSuggestionSubtitle subtitle =
    Html.div
        [ Attributes.class "form-dropdown__suggestion__subtitle" ]
        [ Html.text subtitle ]
