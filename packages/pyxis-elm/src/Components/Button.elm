module Components.Button exposing
    ( Variant
    , primary
    , secondary
    , tertiary
    , brand
    , ghost
    , Type
    , button
    , submit
    , reset
    , link
    , withType
    , withTheme
    , withSize
    , withIconPrepend
    , withIconAppend
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
    , Config
    )

{-|


# Button component

@docs Model, Variant
@docs primary
@docs secondary
@docs tertiary
@docs brand
@docs ghost


## Type

@docs Type
@docs button
@docs submit
@docs reset
@docs link
@docs withType


## Theme

@docs withTheme


## Size

@docs withSize


## Icon

@docs withIconPrepend
@docs withIconAppend
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

import Commons.Attributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Properties.Theme as Theme exposing (Theme)
import Commons.Render as CR
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events


{-| Internal. The internal Button configuration.
-}
type alias ConfigData msg =
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


{-| The Button configuration.
-}
type Config msg
    = Config (ConfigData msg)


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
config : Variant -> Config msg
config variant =
    Config
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
        , variant = variant
        }


{-| Creates a Button with a Primary variant.
-}
primary : Config msg
primary =
    config Primary


{-| Creates a Button with a Secondary variant.
-}
secondary : Config msg
secondary =
    config Secondary


{-| Creates a Button with a Tertiary variant.
-}
tertiary : Config msg
tertiary =
    config Tertiary


{-| Creates a Button with a Brand variant.
-}
brand : Config msg
brand =
    config Brand


{-| Creates a Button with a Ghost variant.
-}
ghost : Config msg
ghost =
    config Ghost


{-| Internal.
-}
type ButtonIcon
    = PlacedIcon Placement IconSet.Icon
    | Standalone IconSet.Icon
    | None


isPrepend : ButtonIcon -> Bool
isPrepend buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isPrepend placement

        _ ->
            False


isAppend : ButtonIcon -> Bool
isAppend buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isAppend placement

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


{-| Creates a button with [type="button"].
-}
button : msg -> Type msg
button =
    Button


{-| Creates a button with [type="submit"].
-}
submit : Type msg
submit =
    Submit


{-| Creates a button with [type="reset"].
-}
reset : Type msg
reset =
    Reset


{-| Creates an anchor tag with button-like skin.
-}
link : String -> Type msg
link =
    Link


{-| Internal.
-}
isLinkType : Type msg -> Bool
isLinkType a =
    case a of
        Link _ ->
            True

        _ ->
            False


{-| Sets a type to the Button.
-}
withType : Type msg -> Config msg -> Config msg
withType a (Config configuration) =
    Config { configuration | type_ = a }


{-| Internal.
-}
typeToAttribute : Type msg -> Html.Attribute msg
typeToAttribute a =
    case a of
        Submit ->
            Attributes.type_ "submit"

        Reset ->
            Attributes.type_ "reset"

        Button _ ->
            Attributes.type_ "button"

        Link href ->
            Attributes.href href


{-| Internal.
-}
typeToEventAttribute : Type msg -> Html.Attribute msg
typeToEventAttribute a =
    case a of
        Button action ->
            Events.onClick action

        Submit ->
            Commons.Attributes.none

        Reset ->
            Commons.Attributes.none

        Link _ ->
            Commons.Attributes.none


{-| Sets a theme to the Button.
-}
withTheme : Theme -> Config msg -> Config msg
withTheme a (Config configuration) =
    Config { configuration | theme = a }


{-| The available Button variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost


withSize : Size -> Config msg -> Config msg
withSize a (Config configuration) =
    Config { configuration | size = a }


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withIconPrepend : IconSet.Icon -> Config msg -> Config msg
withIconPrepend icon (Config configuration) =
    Config { configuration | icon = PlacedIcon Placement.prepend icon }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withIconAppend : IconSet.Icon -> Config msg -> Config msg
withIconAppend icon (Config configuration) =
    Config { configuration | icon = PlacedIcon Placement.append icon }


{-| Adds an icon to the Button. This will be the only content of the Button..
-}
withIconOnly : IconSet.Icon -> Config msg -> Config msg
withIconOnly icon (Config configuration) =
    Config { configuration | icon = Standalone icon }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled a (Config configuration) =
    Config { configuration | disabled = a }


{-| Sets an aria-label to the Button.
-}
withAriaLabel : String -> Config msg -> Config msg
withAriaLabel a (Config configuration) =
    Config { configuration | ariaLabel = Just a }


{-| Sets an id to the Button.
-}
withId : String -> Config msg -> Config msg
withId a (Config configuration) =
    Config { configuration | id = Just a }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading : Bool -> Config msg -> Config msg
withLoading a (Config configuration) =
    Config { configuration | loading = a }


{-| Sets whether the Button should have a content width or not.
-}
withContentWidth : Config msg -> Config msg
withContentWidth (Config configuration) =
    Config { configuration | contentWidth = True }


{-| Sets whether the Button should have a shadow or not.
-}
withShadow : Config msg -> Config msg
withShadow (Config configuration) =
    Config { configuration | shadow = True }


{-| Adds a textual content to the Button.
-}
withText : String -> Config msg -> Config msg
withText a (Config configuration) =
    Config { configuration | text = a }


{-| Adds a classList to the Button.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList a (Config configuration) =
    Config { configuration | classList = a }


{-| Renders the Button.
-}
render : Config msg -> Html msg
render (Config configuration) =
    (if isLinkType configuration.type_ then
        Html.a

     else
        Html.button
    )
        [ Attributes.classList
            ([ ( "button", True )
             , ( "button--prepend-icon", isPrepend configuration.icon )
             , ( "button--append-icon", isAppend configuration.icon )
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
        , typeToAttribute configuration.type_
        , typeToEventAttribute configuration.type_
        , Commons.Attributes.maybe Attributes.id configuration.id
        , Commons.Attributes.maybe Commons.Attributes.testId configuration.id
        , Commons.Attributes.maybe Commons.Attributes.ariaLabel configuration.ariaLabel
        ]
        [ configuration.icon
            |> renderIcon configuration.size
            |> CR.renderIf (isPrepend configuration.icon || isStandalone configuration.icon)
        , Html.text configuration.text
            |> CR.renderUnless (isStandalone configuration.icon)
        , configuration.icon
            |> renderIcon configuration.size
            |> CR.renderIf (isAppend configuration.icon)
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
applyIconSize : Size -> Icon.Model -> Icon.Model
applyIconSize size =
    if Size.isHuge size then
        Icon.withSize Size.large

    else if Size.isLarge size then
        Icon.withSize Size.medium

    else
        Icon.withSize Size.small
