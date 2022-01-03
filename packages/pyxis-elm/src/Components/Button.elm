module Components.Button exposing
    ( Model
    , create
    , Type
    , withSubmitType
    , withResetType
    , withButtonType
    , Variant
    , withPrimaryVariant
    , withSecondaryVariant
    , withTertiaryVariant
    , withBrandVariant
    , withGhostVariant
    , Theme
    , withLightTheme
    , withDarkTheme
    , Size
    , withHugeSize
    , withLargeSize
    , withMediumSize
    , withSmallSize
    , Icon
    , withLeadingIcon
    , withTrailingIcon
    , withIconOnly
    , withDisabled
    , withLoading
    , withContentWidth
    , withShadow
    , withText
    , render
    )

{-|


# Button component

@docs Model
@docs create


## Type

@docs Type
@docs withSubmitType
@docs withResetType
@docs withButtonType


## Variant

@docs Variant
@docs withPrimaryVariant
@docs withSecondaryVariant
@docs withTertiaryVariant
@docs withBrandVariant
@docs withGhostVariant


## Theme

@docs Theme
@docs withLightTheme
@docs withDarkTheme


## Size

@docs Size
@docs withHugeSize
@docs withLargeSize
@docs withMediumSize
@docs withSmallSize


## Icon

@docs Icon
@docs withLeadingIcon
@docs withTrailingIcon
@docs withIconOnly


## Generics

@docs withDisabled
@docs withLoading
@docs withContentWidth
@docs withShadow
@docs withText


## Rendering

@docs render

-}

import Commons.ApiConstraint as Api
import Commons.Attributes as CA
import Commons.Render as CR
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events


{-| The Button model.
-}
type Model a msg
    = Model (Configuration msg)


{-| Inits the Button.

    import Components.Button as Button
    import MyForm

    type Msg
        = OnClick

    myClickableButton : Button.Model Msg
    myClickableButton =
        Button.create
            |> Button.withButtonType OnClick
            |> Button.withVariantBrand
            |> Button.withSizeLarge
            |> Button.withText "Click me!"

    mySubmitButton : Button.Model Msg
    mySubmitButton =
        Button.create
            |> Button.withSubmitType
            |> Button.create
            |> Button.withVariantPrimary
            |> Button.withText "Submit form"
            |> Button.withDisabled (not MyForm.canBeSubmitted)

-}
create : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg
create =
    Model
        { disabled = False
        , variant = Primary
        , icon = NoIcon
        , loading = False
        , contentWidth = False
        , shadow = False
        , size = Large
        , text = ""
        , theme = Light
        , type_ = Submit
        }


{-| Internal. The internal Button configuration.
-}
type alias Configuration msg =
    { disabled : Bool
    , variant : Variant
    , icon : Icon
    , loading : Bool
    , contentWidth : Bool
    , shadow : Bool
    , size : Size
    , text : String
    , theme : Theme
    , type_ : Type msg
    }


{-| The available Button types.
-}
type Type msg
    = Button msg
    | Submit
    | Reset


{-| Sets a type="submit" to the Button.
-}
withSubmitType : Model a msg -> Model a msg
withSubmitType (Model configuration) =
    Model { configuration | type_ = Submit }


{-| Sets a type="button" to the Button.
-}
withButtonType : msg -> Model a msg -> Model a msg
withButtonType msg (Model configuration) =
    Model { configuration | type_ = Button msg }


{-| Sets a type="reset" to the Button.
-}
withResetType : Model a msg -> Model a msg
withResetType (Model configuration) =
    Model { configuration | type_ = Reset }


{-| Internal.
-}
typeToAttribute : Type msg -> Html.Attribute msg
typeToAttribute a =
    Attributes.type_
        (case a of
            Submit ->
                "submit"

            Reset ->
                "reset"

            Button _ ->
                "button"
        )


{-| Internal.
-}
typeToEventAttribute : Type msg -> Maybe (Html.Attribute msg)
typeToEventAttribute a =
    case a of
        Button action ->
            Just (Events.onClick action)

        Submit ->
            Nothing

        Reset ->
            Nothing


{-| The available skin theme.
-}
type Theme
    = Light
    | Dark


{-| Sets a theme to the Button.
-}
withLightTheme : Model a msg -> Model a msg
withLightTheme (Model configuration) =
    Model { configuration | theme = Light }


{-| Sets a theme to the Button.
-}
withDarkTheme : Model a msg -> Model a msg
withDarkTheme (Model configuration) =
    Model { configuration | theme = Dark }


{-| The available Button variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost


{-| Sets a Variant to then Button.
-}
withPrimaryVariant : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg -> Model { a | hugeSize : Api.Supported, smallSize : Api.Supported, iconOnly : Api.Supported } msg
withPrimaryVariant (Model configuration) =
    Model { configuration | variant = Primary }


{-| Sets a Variant to then Button.
-}
withSecondaryVariant : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg -> Model { a | hugeSize : Api.NotSupported, smallSize : Api.Supported, iconOnly : Api.Supported } msg
withSecondaryVariant (Model configuration) =
    Model { configuration | variant = Secondary }


{-| Sets a Variant to then Button.
-}
withTertiaryVariant : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg -> Model { a | hugeSize : Api.NotSupported, smallSize : Api.Supported, iconOnly : Api.Supported } msg
withTertiaryVariant (Model configuration) =
    Model { configuration | variant = Tertiary }


{-| Sets a Variant to then Button.
-}
withBrandVariant : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg -> Model { a | hugeSize : Api.NotSupported, smallSize : Api.Supported, iconOnly : Api.Supported } msg
withBrandVariant (Model configuration) =
    Model { configuration | variant = Brand }


{-| Sets a Variant to then Button.
-}
withGhostVariant : Model { a | hugeSize : (), smallSize : (), iconOnly : () } msg -> Model { a | hugeSize : Api.NotSupported, smallSize : Api.Supported, iconOnly : Api.Supported } msg
withGhostVariant (Model configuration) =
    Model { configuration | variant = Ghost }


{-| The available Button sizes.
-}
type Size
    = Huge
    | Large
    | Medium
    | Small


withHugeSize : Model { a | hugeSize : Api.Supported } msg -> Model { a | iconOnly : Api.Supported } msg
withHugeSize (Model configuration) =
    Model { configuration | size = Huge }


withLargeSize : Model a msg -> Model { a | iconOnly : Api.Supported } msg
withLargeSize (Model configuration) =
    Model { configuration | size = Large }


withMediumSize : Model a msg -> Model { a | iconOnly : Api.Supported } msg
withMediumSize (Model configuration) =
    Model { configuration | size = Medium }


withSmallSize : Model { a | smallSize : Api.Supported } msg -> Model { a | iconOnly : Api.NotSupported } msg
withSmallSize (Model configuration) =
    Model { configuration | size = Small }


{-| The available Icons positions.
-}
type Icon
    = Leading IconSet.Icon
    | Trailing IconSet.Icon
    | Only IconSet.Icon
    | NoIcon


{-| Internal.
-}
isLeadingIcon : Icon -> Bool
isLeadingIcon a =
    case a of
        Leading _ ->
            True

        _ ->
            False


{-| Internal.
-}
isTrailingIcon : Icon -> Bool
isTrailingIcon a =
    case a of
        Trailing _ ->
            True

        _ ->
            False


{-| Internal.
-}
isIconOnly : Icon -> Bool
isIconOnly a =
    case a of
        Only _ ->
            True

        _ ->
            False


{-| Internal.
-}
pickIcon : Icon -> Maybe IconSet.Icon
pickIcon icon =
    case icon of
        Leading pyxisIcon ->
            Just pyxisIcon

        Trailing pyxisIcon ->
            Just pyxisIcon

        Only pyxisIcon ->
            Just pyxisIcon

        NoIcon ->
            Nothing


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withLeadingIcon : IconSet.Icon -> Model a msg -> Model a msg
withLeadingIcon a (Model configuration) =
    Model { configuration | icon = Leading a }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withTrailingIcon : IconSet.Icon -> Model a msg -> Model a msg
withTrailingIcon a (Model configuration) =
    Model { configuration | icon = Trailing a }


{-| Adds an icon to the Button. This will be the only content of the Button..
-}
withIconOnly : IconSet.Icon -> Model { a | iconOnly : Api.Supported } msg -> Model a msg
withIconOnly a (Model configuration) =
    Model { configuration | icon = Only a }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Model a msg -> Model a msg
withDisabled a (Model configuration) =
    Model { configuration | disabled = a }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading : Bool -> Model a msg -> Model a msg
withLoading a (Model configuration) =
    Model { configuration | loading = a }


{-| Sets whether the Button should be have a content width or not.
-}
withContentWidth : Model a msg -> Model a msg
withContentWidth (Model configuration) =
    Model { configuration | contentWidth = True }


{-| Sets whether the Button should be have a content width or not.
-}
withShadow : Model a msg -> Model a msg
withShadow (Model configuration) =
    Model { configuration | contentWidth = True }


{-| Adds a textual content to the Button.
-}
withText : String -> Model a msg -> Model a msg
withText a (Model configuration) =
    Model { configuration | text = a }


{-| Renders the Button.
-}
render : Model a msg -> Html msg
render (Model configuration) =
    Html.button
        (CA.compose
            [ Attributes.classList
                [ ( "button", True )
                , ( "button--leading-icon", isLeadingIcon configuration.icon )
                , ( "button--trailing-icon", isTrailingIcon configuration.icon )
                , ( "button--icon-only", isIconOnly configuration.icon )
                , ( "button--alt", configuration.theme == Dark )
                , ( "button--primary", configuration.variant == Primary )
                , ( "button--secondary", configuration.variant == Secondary )
                , ( "button--tertiary", configuration.variant == Tertiary )
                , ( "button--brand", configuration.variant == Brand )
                , ( "button--ghost", configuration.variant == Ghost )
                , ( "button--huge", configuration.size == Huge )
                , ( "button--large", configuration.size == Large )
                , ( "button--medium", configuration.size == Medium )
                , ( "button--small", configuration.size == Small )
                , ( "button--loading", configuration.loading )
                , ( "button--content-width", configuration.contentWidth )
                , ( "button--shadow", configuration.contentWidth )
                ]
            , Attributes.disabled configuration.disabled
            , typeToAttribute configuration.type_
            ]
            [ typeToEventAttribute configuration.type_ ]
        )
        [ configuration.icon
            |> renderIcon configuration.size
            |> CR.renderIf (isLeadingIcon configuration.icon || isIconOnly configuration.icon)
        , Html.text configuration.text
            |> CR.renderUnless (isIconOnly configuration.icon)
        , configuration.icon
            |> renderIcon configuration.size
            |> CR.renderIf (isTrailingIcon configuration.icon)
        ]


{-| Internal.
-}
renderIcon : Size -> Icon -> Html msg
renderIcon size icon =
    icon
        |> pickIcon
        |> Maybe.map
            (Icon.create
                >> Icon.withSize (getIconSize size)
                >> Icon.render
            )
        |> CR.renderMaybe


{-| Internal.
-}
getIconSize : Size -> Icon.Size
getIconSize size =
    case size of
        Huge ->
            Icon.large

        Large ->
            Icon.medium

        _ ->
            Icon.small
