module Components.Button exposing
    ( Model
    , primary
    , secondary
    , tertiary
    , brand
    , ghost
    , Type
    , withSubmitType
    , withResetType
    , withButtonType
    , withLinkType
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
    , withAriaLabel
    , withId
    , withClassList
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
@docs primary
@docs secondary
@docs tertiary
@docs brand
@docs ghost


## Type

@docs Type
@docs withSubmitType
@docs withResetType
@docs withButtonType
@docs withLinkType


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

@docs withAriaLabel
@docs withId
@docs withClassList
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


{-| Internal. The internal Button configuration.
-}
type alias Configuration msg =
    { ariaLabel : Maybe String
    , classList : List ( String, Bool )
    , contentWidth : Bool
    , disabled : Bool
    , icon : Icon
    , id : Maybe String
    , loading : Bool
    , shadow : Bool
    , size : Size
    , text : String
    , theme : Theme
    , type_ : Type msg
    , variant : Variant
    }


{-| Internal. The default configuration which enforces api constraints.
Those keys represent which methods are use-restricted.
You can use the Commons/ApiConstraint.elm module to allow/disallow methods call.
-}
type alias DefaultConfiguration a =
    { a
        | contentWidth : ()
        , hugeSize : ()
        , iconOnly : ()
        , loading : ()
        , shadow : ()
        , smallSize : ()
    }


{-| Inits the Button.

    import Components.Button as Button
    import MyForm

    type Msg
        = OnClick

    myClickableButton : Html Msg
    myClickableButton =
        Button.brand
            |> Button.withButtonType OnClick
            |> Button.withLargeSize
            |> Button.withText "Click me!"
            |> Button.render

    mySubmitButton : Html Msg
    mySubmitButton =
        Button.primary
            |> Button.withSubmitType
            |> Button.withText "Submit form"
            |> Button.withDisabled (not MyForm.canBeSubmitted)
            |> Button.render

-}
init : Model (DefaultConfiguration a) msg
init =
    Model
        { ariaLabel = Nothing
        , classList = []
        , contentWidth = False
        , disabled = False
        , icon = NoIcon
        , id = Nothing
        , loading = False
        , shadow = False
        , size = Large
        , text = ""
        , theme = Light
        , type_ = Submit
        , variant = Primary
        }


{-| Internal.
-}
type alias PrimaryConfiguration a =
    { a
        | hugeSize : Api.Supported
        , smallSize : Api.Supported
        , iconOnly : Api.Supported
        , shadow : Api.Supported
        , contentWidth : Api.Supported
        , loading : Api.Supported
    }


{-| Creates a Button with a Primary variant.
-}
primary : Model (PrimaryConfiguration a) msg
primary =
    withPrimaryVariant init


{-| Internal.
-}
withPrimaryVariant : Model (DefaultConfiguration a) msg -> Model (PrimaryConfiguration a) msg
withPrimaryVariant (Model configuration) =
    Model { configuration | variant = Primary }


{-| Internal.
-}
type alias SecondaryConfiguration a =
    { a
        | hugeSize : Api.NotSupported
        , smallSize : Api.Supported
        , iconOnly : Api.Supported
        , shadow : Api.NotSupported
        , contentWidth : Api.Supported
        , loading : Api.Supported
    }


{-| Creates a Button with a Secondary variant.
-}
secondary : Model (SecondaryConfiguration a) msg
secondary =
    withSecondaryVariant init


{-| Internal.
-}
withSecondaryVariant : Model (DefaultConfiguration a) msg -> Model (SecondaryConfiguration a) msg
withSecondaryVariant (Model configuration) =
    Model { configuration | variant = Secondary }


{-| Internal.
-}
type alias TertiaryConfiguration a =
    { a
        | hugeSize : Api.NotSupported
        , smallSize : Api.Supported
        , iconOnly : Api.Supported
        , shadow : Api.NotSupported
        , contentWidth : Api.Supported
        , loading : Api.Supported
    }


{-| Creates a Button with a Tertiary variant.
-}
tertiary : Model (SecondaryConfiguration a) msg
tertiary =
    withTertiaryVariant init


{-| Internal. Sets a Variant to the Button.
-}
withTertiaryVariant : Model (DefaultConfiguration a) msg -> Model (TertiaryConfiguration a) msg
withTertiaryVariant (Model configuration) =
    Model { configuration | variant = Tertiary }


{-| Internal.
-}
type alias BrandConfiguration a =
    { a
        | hugeSize : Api.NotSupported
        , smallSize : Api.Supported
        , iconOnly : Api.Supported
        , shadow : Api.Supported
        , contentWidth : Api.Supported
        , loading : Api.Supported
    }


{-| Creates a Button with a Brand variant.
-}
brand : Model (BrandConfiguration a) msg
brand =
    withBrandVariant init


{-| Internal. Sets a Variant to the Button.
-}
withBrandVariant : Model (DefaultConfiguration a) msg -> Model (BrandConfiguration a) msg
withBrandVariant (Model configuration) =
    Model { configuration | variant = Brand }


{-| Internal.
-}
type alias GhostConfiguration a =
    { a
        | hugeSize : Api.NotSupported
        , smallSize : Api.Supported
        , iconOnly : Api.Supported
        , shadow : Api.NotSupported
        , contentWidth : Api.NotSupported
        , loading : Api.NotSupported
    }


{-| Creates a Button with a Ghost variant.
-}
ghost : Model (GhostConfiguration a) msg
ghost =
    withGhostVariant init


{-| Internal.
-}
withGhostVariant : Model (DefaultConfiguration a) msg -> Model (GhostConfiguration a) msg
withGhostVariant (Model configuration) =
    Model { configuration | variant = Ghost }


{-| The available Button types.
-}
type Type msg
    = Button msg
    | Submit
    | Reset
    | Link String


{-| Internal.
-}
isLinkType : Type msg -> Bool
isLinkType a =
    case a of
        Link _ ->
            True

        _ ->
            False


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


{-| Using this method you will get an <a> tag instead of a <button> one.
-}
withLinkType : String -> Model a msg -> Model a msg
withLinkType a (Model configuration) =
    Model { configuration | type_ = Link a }


{-| Internal.
-}
typeToAttribute : Type msg -> Maybe (Html.Attribute msg)
typeToAttribute a =
    case a of
        Submit ->
            Just (Attributes.type_ "submit")

        Reset ->
            Just (Attributes.type_ "reset")

        Button _ ->
            Just (Attributes.type_ "button")

        Link href ->
            Just (Attributes.href href)


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

        Link _ ->
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
withIconOnly : IconSet.Icon -> Model { a | iconOnly : Api.Supported } msg -> Model { a | contentWidth : Api.NotSupported } msg
withIconOnly a (Model configuration) =
    Model { configuration | icon = Only a }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Model a msg -> Model a msg
withDisabled a (Model configuration) =
    Model { configuration | disabled = a }


{-| Sets an aria-label to the Button.
-}
withAriaLabel : String -> Model a msg -> Model a msg
withAriaLabel a (Model configuration) =
    Model { configuration | ariaLabel = Just a }


{-| Sets an id to the Button.
-}
withId : String -> Model a msg -> Model a msg
withId a (Model configuration) =
    Model { configuration | id = Just a }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading : Bool -> Model { a | loading : Api.Supported } msg -> Model a msg
withLoading a (Model configuration) =
    Model { configuration | loading = a }


{-| Sets whether the Button should have a content width or not.
-}
withContentWidth : Model { a | contentWidth : Api.Supported } msg -> Model { a | iconOnly : Api.NotSupported } msg
withContentWidth (Model configuration) =
    Model { configuration | contentWidth = True }


{-| Sets whether the Button should have a shadow or not.
-}
withShadow : Model { a | shadow : Api.Supported } msg -> Model a msg
withShadow (Model configuration) =
    Model { configuration | shadow = True }


{-| Adds a textual content to the Button.
-}
withText : String -> Model a msg -> Model a msg
withText a (Model configuration) =
    Model { configuration | text = a }


{-| Adds a classList to the Button.
-}
withClassList : List ( String, Bool ) -> Model a msg -> Model a msg
withClassList a (Model configuration) =
    Model { configuration | classList = a }


{-| Renders the Button.
-}
render : Model a msg -> Html msg
render (Model configuration) =
    (if isLinkType configuration.type_ then
        Html.a

     else
        Html.button
    )
        (CA.compose
            [ Attributes.classList
                ([ ( "button", True )
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
                 , ( "button--shadow", configuration.shadow )
                 ]
                    ++ configuration.classList
                )
            , Attributes.disabled configuration.disabled
            ]
            [ typeToAttribute configuration.type_
            , typeToEventAttribute configuration.type_
            , Maybe.map Attributes.id configuration.id
            , Maybe.map CA.testId configuration.id
            , Maybe.map CA.ariaLabel configuration.ariaLabel
            ]
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
                >> applyIconSize size
                >> Icon.render
            )
        |> CR.renderMaybe


{-| Internal.
-}
applyIconSize : Size -> (Icon.Model a -> Icon.Model a)
applyIconSize size =
    case size of
        Huge ->
            Icon.withLargeSize

        Large ->
            Icon.withMediumSize

        _ ->
            Icon.withSmallSize
