module Components.Button exposing
    ( Model
    , primary
    , secondary
    , tertiary
    , brand
    , ghost
    , Type
    , withTypeSubmit
    , withTypeReset
    , withTypeButton
    , withTypeLink
    , withThemeDefault
    , withThemeAlternative
    , withSizeHuge
    , withSizeLarge
    , withSizeMedium
    , withSizeSmall
    , withIconLeading
    , withIconTrailing
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
@docs withTypeSubmit
@docs withTypeReset
@docs withTypeButton
@docs withTypeLink


## Theme

@docs withThemeDefault
@docs withThemeAlternative


## Size

@docs withSizeHuge
@docs withSizeLarge
@docs withSizeMedium
@docs withSizeSmall


## Icon

@docs withIconLeading
@docs withIconTrailing
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
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Properties.Theme as Theme exposing (Theme)
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
    , icon : ButtonIcon
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
            |> Button.withTypeButton OnClick
            |> Button.withLargeSize
            |> Button.withText "Click me!"
            |> Button.render

    mySubmitButton : Html Msg
    mySubmitButton =
        Button.primary
            |> Button.withTypeSubmit
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
        , icon = None
        , id = Nothing
        , loading = False
        , shadow = False
        , size = Size.large
        , text = ""
        , theme = Theme.default
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


{-| Internal.
-}
type ButtonIcon
    = PlacedIcon Placement IconSet.Icon
    | Standalone IconSet.Icon
    | None


isLeading : ButtonIcon -> Bool
isLeading buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isLeading placement

        _ ->
            False


isTrailing : ButtonIcon -> Bool
isTrailing buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isTrailing placement

        _ ->
            False


isStandalone : ButtonIcon -> Bool
isStandalone buttonIcon =
    case buttonIcon of
        Standalone _ ->
            True

        _ ->
            False


pickIcon : ButtonIcon -> Maybe IconSet.Icon
pickIcon buttonIcon =
    case buttonIcon of
        PlacedIcon _ icon ->
            Just icon

        Standalone icon ->
            Just icon

        None ->
            Nothing


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
withTypeSubmit : Model a msg -> Model a msg
withTypeSubmit (Model configuration) =
    Model { configuration | type_ = Submit }


{-| Sets a type="button" to the Button.
-}
withTypeButton : msg -> Model a msg -> Model a msg
withTypeButton msg (Model configuration) =
    Model { configuration | type_ = Button msg }


{-| Sets a type="reset" to the Button.
-}
withTypeReset : Model a msg -> Model a msg
withTypeReset (Model configuration) =
    Model { configuration | type_ = Reset }


{-| Using this method you will get an <a> tag instead of a <button> one.
-}
withTypeLink : String -> Model a msg -> Model a msg
withTypeLink a (Model configuration) =
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


{-| Sets a theme to the Button.
-}
withThemeDefault : Model a msg -> Model a msg
withThemeDefault (Model configuration) =
    Model { configuration | theme = Theme.default }


{-| Sets a theme to the Button.
-}
withThemeAlternative : Model a msg -> Model a msg
withThemeAlternative (Model configuration) =
    Model { configuration | theme = Theme.alternative }


{-| The available Button variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost


withSizeHuge : Model { a | hugeSize : Api.Supported } msg -> Model { a | iconOnly : Api.Supported } msg
withSizeHuge (Model configuration) =
    Model { configuration | size = Size.huge }


withSizeLarge : Model a msg -> Model { a | iconOnly : Api.Supported } msg
withSizeLarge (Model configuration) =
    Model { configuration | size = Size.large }


withSizeMedium : Model a msg -> Model { a | iconOnly : Api.Supported } msg
withSizeMedium (Model configuration) =
    Model { configuration | size = Size.medium }


withSizeSmall : Model { a | smallSize : Api.Supported } msg -> Model { a | iconOnly : Api.NotSupported } msg
withSizeSmall (Model configuration) =
    Model { configuration | size = Size.small }


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withIconLeading : IconSet.Icon -> Model a msg -> Model a msg
withIconLeading icon (Model configuration) =
    Model { configuration | icon = PlacedIcon Placement.leading icon }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withIconTrailing : IconSet.Icon -> Model a msg -> Model a msg
withIconTrailing icon (Model configuration) =
    Model { configuration | icon = PlacedIcon Placement.trailing icon }


{-| Adds an icon to the Button. This will be the only content of the Button..
-}
withIconOnly : IconSet.Icon -> Model { a | iconOnly : Api.Supported } msg -> Model { a | contentWidth : Api.NotSupported } msg
withIconOnly icon (Model configuration) =
    Model { configuration | icon = Standalone icon }


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
                 , ( "button--leading-icon", isLeading configuration.icon )
                 , ( "button--trailing-icon", isTrailing configuration.icon )
                 , ( "button--icon-only", isStandalone configuration.icon )
                 , ( "button--alt", Theme.isAlternative configuration.theme )
                 , ( "button--primary", configuration.variant == Primary )
                 , ( "button--secondary", configuration.variant == Secondary )
                 , ( "button--tertiary", configuration.variant == Tertiary )
                 , ( "button--brand", configuration.variant == Brand )
                 , ( "button--ghost", configuration.variant == Ghost )
                 , ( "button--huge", Size.isHuge configuration.size )
                 , ( "button--large", Size.isLarge configuration.size )
                 , ( "button--medium", Size.isMedium configuration.size )
                 , ( "button--small", Size.isSmall configuration.size )
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
            |> CR.renderIf (isLeading configuration.icon || isStandalone configuration.icon)
        , Html.text configuration.text
            |> CR.renderUnless (isStandalone configuration.icon)
        , configuration.icon
            |> renderIcon configuration.size
            |> CR.renderIf (isTrailing configuration.icon)
        ]


{-| Internal.
-}
renderIcon : Size -> ButtonIcon -> Html msg
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
applyIconSize : Size -> Icon.Model a -> Icon.Model a
applyIconSize size =
    if Size.isHuge size then
        Icon.withSizeLarge

    else if Size.isLarge size then
        Icon.withSizeMedium

    else
        Icon.withSizeSmall
