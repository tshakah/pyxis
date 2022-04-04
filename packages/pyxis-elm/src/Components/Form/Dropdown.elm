module Components.Form.Dropdown exposing
    ( Content
    , action
    , content
    , headerAndContent
    , suggestion
    , render
    )

{-|


# Dropdown

@docs Content
@docs action
@docs content
@docs headerAndContent
@docs suggestion


## Rendering

@docs render

-}

import Commons.Properties.Size as Size
import Commons.Render
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Keyed


type Content msg
    = Action
        { label : String
        , content : List (Html msg)
        }
    | HeaderAndContent
        { header : Html msg
        , content : List (Html msg)
        }
    | Content (List (Html msg))
    | Suggestion
        { icon : IconSet.Icon
        , title : String
        , subtitle : Maybe String
        }


{-| Creates the action.
-}
action : { label : String, content : List (Html msg) } -> Content msg
action =
    Action


{-| Creates a content with and header.
-}
headerAndContent : { header : Html msg, content : List (Html msg) } -> Content msg
headerAndContent =
    HeaderAndContent


{-| Creates the most simple content.
-}
content : List (Html msg) -> Content msg
content =
    Content


{-| Creates a suggestion.
-}
suggestion :
    { icon : IconSet.Icon
    , title : String
    , subtitle : Maybe String
    }
    -> Content msg
suggestion =
    Suggestion


{-| Internal.
-}
hasHeader : Content msg -> Bool
hasHeader content_ =
    case content_ of
        HeaderAndContent _ ->
            True

        _ ->
            False


{-| Renders the Dropdown.
-}
render : String -> Content msg -> Html msg
render id content_ =
    Html.div
        [ Attributes.class "form-dropdown-wrapper"
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
        HeaderAndContent config ->
            renderHeader config.header :: config.content

        Content content__ ->
            content__

        Action config ->
            [ renderAction config.label config.content ]

        Suggestion config ->
            [ renderSuggestion config ]


{-| Internal.
-}
renderAction : String -> List (Html msg) -> Html msg
renderAction label content_ =
    Html.div
        [ Attributes.class "form-dropdown__no-results" ]
        [ Html.text label
        , content_
            |> Html.div [ Attributes.class "form-dropdown__no-results__action" ]
            |> Commons.Render.renderIf (List.length content_ > 0)
        ]


{-| Internal.
-}
renderHeader : Html msg -> Html msg
renderHeader content_ =
    Html.div [ Attributes.class "form-dropdown__header" ] [ content_ ]


{-| Internal.
-}
renderSuggestion :
    { icon : IconSet.Icon
    , title : String
    , subtitle : Maybe String
    }
    -> Html msg
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
