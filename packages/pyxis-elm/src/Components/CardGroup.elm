-- Constructors are exposed by design, since it's internal and there isn't a reason to make it opaque


module Components.CardGroup exposing
    ( Addon(..)
    , Config
    , Layout(..)
    , Option
    , Size(..)
    , renderCheckbox
    , renderRadio
    )

{-| Common Card fields view
-}

import Commons.Attributes
import Commons.Render
import Commons.String
import Components.Field.Error as Error
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Form.FormItem as FormItem
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra
import Result.Extra


{-| Represent the layout of the group.
-}
type Layout
    = Horizontal
    | Vertical


type Type
    = Radio
    | Checkbox


{-| Card group size
-}
type Size
    = Medium
    | Large


{-| This is non opaque by design
-}
type alias Config r =
    { r
        | size : Size
        , name : String
        , id : String
        , label : Maybe Label.Config
        , classList : List ( String, Bool )
        , layout : Layout
        , hint : Maybe Hint.Config
        , additionalContent : Maybe (Html Never)
    }


type alias Option msg =
    { onCheck : Bool -> msg
    , onFocus : msg
    , onBlur : msg
    , addon : Maybe Addon
    , text : Maybe String
    , title : Maybe String
    , isChecked : Bool
    , isDisabled : Bool
    }


toType : Type -> String
toType type_ =
    case type_ of
        Radio ->
            "radio"

        Checkbox ->
            "checkbox"


getRole : Type -> String
getRole type_ =
    case type_ of
        Radio ->
            "radiogroup"

        Checkbox ->
            "group"


renderCheckbox : Result String value -> Config r -> List (Option msg) -> Html msg
renderCheckbox =
    render Checkbox


renderRadio : Result String value -> Config r -> List (Option msg) -> Html msg
renderRadio =
    render Radio


render : Type -> Result String value -> Config r -> List (Option msg) -> Html msg
render type_ validationResult configData options =
    Html.div
        [ Attributes.classList
            [ ( "form-card-group", True )
            , ( "form-card-group--column", configData.layout == Vertical )
            ]
        , Attributes.classList configData.classList
        , Attributes.id configData.id
        , Commons.Attributes.testId configData.id
        , Commons.Attributes.role (getRole type_)
        , Commons.Attributes.ariaLabelledbyBy (labelId configData.id)
        , Commons.Attributes.renderIf (Result.Extra.isErr validationResult)
            (Commons.Attributes.ariaDescribedBy (Error.toId configData.id))
        ]
        (List.indexedMap (renderCard type_ validationResult configData) options)
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render validationResult


{-| Internal.
-}
labelId : String -> String
labelId id =
    id ++ "-label"


renderCard : Type -> Result String value -> Config r -> Int -> Option msg -> Html msg
renderCard type_ validationResult config index option =
    let
        id_ : String
        id_ =
            makeId config option index
    in
    Html.label
        [ Attributes.classList
            [ ( "form-card", True )
            , ( "form-card--error", Result.Extra.isErr validationResult )
            , ( "form-card--checked", option.isChecked )
            , ( "form-card--disabled", option.isDisabled )
            , ( "form-card--large", config.size == Large )
            ]
        ]
        [ option.addon
            |> Maybe.map renderPrependAddon
            |> Commons.Render.renderMaybe
        , Html.span
            [ Attributes.class "form-card__content-wrapper" ]
            [ option.title
                |> Maybe.map (renderContent "title")
                |> Commons.Render.renderMaybe
            , option.text
                |> Maybe.map (renderContent "text")
                |> Commons.Render.renderMaybe
            ]
        , option.addon
            |> Maybe.map renderAppendAddon
            |> Commons.Render.renderMaybe
        , Html.input
            [ Attributes.type_ (toType type_)
            , Attributes.class ("form-control__" ++ toType type_)
            , Attributes.checked option.isChecked
            , Attributes.disabled option.isDisabled
            , Attributes.id id_
            , Commons.Attributes.testId id_
            , Attributes.name config.name
            , Events.onCheck option.onCheck
            , Events.onFocus option.onFocus
            , Events.onBlur option.onBlur
            ]
            []
        ]


{-| Internal.
-}
renderContent : String -> String -> Html msg
renderContent identifier str =
    Html.span [ Attributes.class ("form-card__" ++ identifier) ] [ Html.text str ]


{-| Internal.
-}
makeId : { m | id : String } -> { c | text : Maybe String, title : Maybe String } -> Int -> String
makeId { id } { text, title } index =
    [ id
    , Maybe.Extra.or title text
        |> Maybe.withDefault (String.fromInt index)
        |> String.left 25
        |> Commons.String.toKebabCase
    , "option"
    ]
        |> String.join "-"


{-| Represent the different types of addon
-}
type Addon
    = TextAddon String
    | IconAddon IconSet.Icon
    | ImgUrlAddon String


{-| Internal.
-}
renderPrependAddon : Addon -> Html msg
renderPrependAddon addon =
    case addon of
        IconAddon icon ->
            Html.span
                [ Attributes.class "form-card__addon form-card__addon--with-icon"
                , Commons.Attributes.testId (IconSet.toLabel icon)
                ]
                [ icon
                    |> Icon.config
                    |> Icon.withSize Icon.large
                    |> Icon.render
                ]

        ImgUrlAddon url ->
            Html.span
                [ Attributes.class "form-card__addon" ]
                [ Html.img
                    [ Attributes.src url
                    , Attributes.width 70
                    , Attributes.height 70
                    , Attributes.alt ""
                    , Commons.Attributes.ariaHidden True
                    ]
                    []
                ]

        _ ->
            Html.text ""


{-| Internal.
-}
renderAppendAddon : Addon -> Html msg
renderAppendAddon addon =
    case addon of
        TextAddon str ->
            Html.span [ Attributes.class "form-card__addon" ] [ Html.text str ]

        _ ->
            Html.text ""
