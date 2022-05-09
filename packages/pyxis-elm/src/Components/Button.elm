module Components.Button exposing
    ( Config
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
    , linkWithTarget
    , withType
    , withTheme
    , withSize
    , huge
    , large
    , medium
    , small
    , withIconAppend
    , withIconOnly
    , withIconPrepend
    , withAriaLabel
    , withClassList
    , withContentWidth
    , withDisabled
    , withId
    , withLoading
    , withOnClick
    , withShadow
    , withText
    , render
    )

{-|


# Button component

@docs Config
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
@docs linkWithTarget
@docs withType


## Theme

@docs withTheme


## Size

@docs withSize
@docs huge
@docs large
@docs medium
@docs small


## Icon

@docs withIconAppend
@docs withIconOnly
@docs withIconPrepend


## Generics

@docs withAriaLabel
@docs withClassList
@docs withContentWidth
@docs withDisabled
@docs withId
@docs withLoading
@docs withOnClick
@docs withShadow
@docs withText


## Rendering

@docs render

-}

import Commons.ApiConstraints as API
import Commons.Attributes
import Commons.Attributes.LinkTarget exposing (LinkTarget)
import Commons.Properties.Placement as Placement exposing (Placement)
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
    , onClick : Maybe msg
    , shadow : Bool
    , size : Size
    , text : String
    , theme : Theme
    , type_ : Type
    , variant : Variant
    }


{-| The Button configuration.
-}
type Config constraints msg
    = Config (ConfigData msg)


{-| Internal. Common attribute constraints
-}
type alias CommonConstraints constraints =
    { constraints
        | ariaLabel : API.Allowed
        , classList : API.Allowed
        , disabled : API.Allowed
        , iconAppend : API.Allowed
        , iconPrepend : API.Allowed
        , id : API.Allowed
        , size : API.Allowed
        , sizeSmall : API.Allowed
        , text : API.Allowed
        , theme : API.Allowed
        , type_ : API.Allowed
    }


{-| Internal. Constraints for Primary Button
-}
type alias PrimaryConstraints =
    CommonConstraints
        { contentWidth : API.Allowed
        , iconOnly : API.Allowed
        , loading : API.Allowed
        , shadow : API.Allowed
        , sizeHuge : API.Allowed
        }


{-| Internal. Constraints for Secondary Button
-}
type alias SecondaryConstraints =
    CommonConstraints
        { contentWidth : API.Allowed
        , iconOnly : API.Allowed
        , loading : API.Allowed
        }


{-| Internal. Constraints for Tertiary Button
-}
type alias TertiaryConstraints =
    CommonConstraints
        { contentWidth : API.Allowed
        , iconOnly : API.Allowed
        , loading : API.Allowed
        }


{-| Internal. Constraints for Brand Button
-}
type alias BrandConstraints =
    CommonConstraints
        { contentWidth : API.Allowed
        , iconOnly : API.Allowed
        , loading : API.Allowed
        , shadow : API.Allowed
        }


{-| Internal. Constraints for Ghost Button
-}
type alias GhostConstraints =
    CommonConstraints
        {}


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
config : Variant -> Config constraints msg
config variant =
    Config
        { ariaLabel = Nothing
        , classList = []
        , contentWidth = False
        , disabled = False
        , icon = None
        , id = Nothing
        , loading = False
        , onClick = Nothing
        , shadow = False
        , size = Large
        , text = ""
        , theme = Theme.default
        , type_ = Submit
        , variant = variant
        }


{-| The available Button variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost


{-| Creates a Button with a Primary variant.
-}
primary : Config PrimaryConstraints msg
primary =
    config Primary


{-| Creates a Button with a Secondary variant.
-}
secondary : Config SecondaryConstraints msg
secondary =
    config Secondary


{-| Creates a Button with a Tertiary variant.
-}
tertiary : Config TertiaryConstraints msg
tertiary =
    config Tertiary


{-| Creates a Button with a Brand variant.
-}
brand : Config BrandConstraints msg
brand =
    config Brand


{-| Creates a Button with a Ghost variant.
-}
ghost : Config GhostConstraints msg
ghost =
    config Ghost


{-| The size configuration
-}
type Size
    = Huge
    | Large
    | Medium
    | Small


{-| A huge size
-}
huge :
    Config { c | sizeHuge : API.Allowed, size : API.Allowed } msg
    -> Config { c | sizeHuge : API.Denied, size : API.Denied } msg
huge (Config configuration) =
    Config { configuration | size = Huge }


{-| A large size
-}
large : Config { c | size : API.Allowed } msg -> Config { c | size : API.Denied } msg
large (Config configuration) =
    Config { configuration | size = Large }


{-| A medium size
-}
medium : Config { c | size : API.Allowed } msg -> Config { c | size : API.Denied } msg
medium (Config configuration) =
    Config { configuration | size = Medium }


{-| A small size
-}
small :
    Config { c | sizeSmall : API.Allowed, size : API.Allowed } msg
    -> Config { c | loading : API.Denied, iconOnly : API.Denied, size : API.Denied } msg
small (Config configuration) =
    Config { configuration | size = Small }


{-| Internal.
-}
type ButtonIcon
    = PlacedIcon Placement IconSet.Icon
    | Standalone IconSet.Icon
    | None


{-| Internal.
-}
isPrepend : ButtonIcon -> Bool
isPrepend buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isPrepend placement

        _ ->
            False


{-| Internal.
-}
isAppend : ButtonIcon -> Bool
isAppend buttonIcon =
    case buttonIcon of
        PlacedIcon placement _ ->
            Placement.isAppend placement

        _ ->
            False


{-| Internal.
-}
isStandalone : ButtonIcon -> Bool
isStandalone buttonIcon =
    case buttonIcon of
        Standalone _ ->
            True

        _ ->
            False


{-| Internal.
-}
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
type Type
    = Button
    | Submit
    | Reset
    | Link String (Maybe LinkTarget)


{-| Creates a button with [type="button"].
-}
button : Type
button =
    Button


{-| Creates a button with [type="submit"].
-}
submit : Type
submit =
    Submit


{-| Creates a button with [type="reset"].
-}
reset : Type
reset =
    Reset


{-| Creates an anchor tag with button-like skin.
-}
link : String -> Type
link href =
    Link href Nothing


{-| Creates an anchor tag with button-like skin.
-}
linkWithTarget : String -> LinkTarget -> Type
linkWithTarget href linkTarget =
    Link href (Just linkTarget)


{-| Internal.
-}
isLinkType : Type -> Bool
isLinkType type_ =
    case type_ of
        Link _ _ ->
            True

        _ ->
            False


{-| Sets a type to the Button.
-}
withType :
    Type
    -> Config { c | type_ : API.Allowed } msg
    -> Config { c | type_ : API.Denied } msg
withType type_ (Config configuration) =
    Config { configuration | type_ = type_ }


{-| Internal.
-}
typeToAttribute : Type -> List (Html.Attribute msg)
typeToAttribute type_ =
    case type_ of
        Submit ->
            [ Attributes.type_ "submit" ]

        Reset ->
            [ Attributes.type_ "reset" ]

        Button ->
            [ Attributes.type_ "button" ]

        Link href target ->
            [ Attributes.href href
            , Commons.Attributes.maybe Commons.Attributes.target target
            ]


{-| Sets a theme to the Button.
-}
withTheme :
    Theme
    -> Config { c | theme : API.Allowed } msg
    -> Config { c | theme : API.Denied } msg
withTheme theme (Config configuration) =
    Config { configuration | theme = theme }


{-| Sets the icon size
-}
withSize :
    (Config before msg -> Config after msg)
    -> Config before msg
    -> Config after msg
withSize setSize =
    setSize


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withIconPrepend :
    IconSet.Icon
    -> Config { c | iconPrepend : API.Allowed } msg
    -> Config { c | iconPrepend : API.Denied } msg
withIconPrepend icon (Config configuration) =
    Config { configuration | icon = PlacedIcon Placement.prepend icon }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withIconAppend :
    IconSet.Icon
    -> Config { c | iconAppend : API.Allowed } msg
    -> Config { c | iconAppend : API.Denied } msg
withIconAppend icon (Config configuration) =
    Config { configuration | icon = PlacedIcon Placement.append icon }


{-| Adds an icon to the Button. This will be the only content of the Button.
-}
withIconOnly :
    IconSet.Icon
    -> Config { c | iconOnly : API.Allowed } msg
    -> Config { c | iconOnly : API.Denied, sizeSmall : API.Denied, contentWidth : API.Denied } msg
withIconOnly icon (Config configuration) =
    Config { configuration | icon = Standalone icon }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Config { c | disabled : API.Allowed } msg -> Config { c | disabled : API.Denied } msg
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets an aria-label to the Button.
-}
withAriaLabel : String -> Config { c | ariaLabel : API.Allowed } msg -> Config { c | ariaLabel : API.Denied } msg
withAriaLabel ariaLabel (Config configuration) =
    Config { configuration | ariaLabel = Just ariaLabel }


{-| Sets an id to the Button.
-}
withId : String -> Config { c | id : API.Allowed } msg -> Config { c | id : API.Denied } msg
withId id (Config configuration) =
    Config { configuration | id = Just id }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading :
    Bool
    -> Config { c | loading : API.Allowed } msg
    -> Config { c | loading : API.Denied, sizeSmall : API.Denied } msg
withLoading isLoading (Config configuration) =
    Config { configuration | loading = isLoading }


{-| Sets whether the Button should have a content width or not.
-}
withContentWidth :
    Config { c | contentWidth : API.Allowed } msg
    -> Config { c | contentWidth : API.Denied, iconOnly : API.Denied } msg
withContentWidth (Config configuration) =
    Config { configuration | contentWidth = True }


{-| Sets whether the Button should have a shadow or not.
-}
withShadow :
    Config { c | shadow : API.Allowed } msg
    -> Config { c | shadow : API.Denied } msg
withShadow (Config configuration) =
    Config { configuration | shadow = True }


{-| Adds a textual content to the Button.
-}
withText :
    String
    -> Config { c | text : API.Allowed } msg
    -> Config { c | text : API.Denied } msg
withText text (Config configuration) =
    Config { configuration | text = text }


{-| Adds a classList to the Button.
-}
withClassList :
    List ( String, Bool )
    -> Config { c | classList : API.Allowed } msg
    -> Config { c | classList : API.Denied } msg
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Adds the event onClick to the Button.
-}
withOnClick : msg -> Config constraints msg -> Config a msg
withOnClick onClick (Config configuration) =
    Config { configuration | onClick = Just onClick }


{-| Renders the Button.
-}
render : Config constraints msg -> Html msg
render ((Config configData) as configuration) =
    renderTag
        configuration
        ([ Attributes.classList
            ([ ( "button", True )
             , ( "button--prepend-icon", isPrepend configData.icon )
             , ( "button--append-icon", isAppend configData.icon )
             , ( "button--icon-only", isStandalone configData.icon )
             , ( "button--alt", Theme.isAlternative configData.theme )
             , ( "button--primary", configData.variant == Primary )
             , ( "button--secondary", configData.variant == Secondary )
             , ( "button--tertiary", configData.variant == Tertiary )
             , ( "button--brand", configData.variant == Brand )
             , ( "button--ghost", configData.variant == Ghost )
             , ( "button--huge", configData.size == Huge )
             , ( "button--large", configData.size == Large )
             , ( "button--medium", configData.size == Medium )
             , ( "button--small", configData.size == Small )
             , ( "button--loading", configData.loading )
             , ( "button--content-width", configData.contentWidth )
             , ( "button--shadow", configData.shadow )
             ]
                ++ configData.classList
            )
         , Attributes.disabled configData.disabled
         , Commons.Attributes.maybe Events.onClick configData.onClick
         , Commons.Attributes.maybe Attributes.id configData.id
         , Commons.Attributes.maybe Commons.Attributes.testId configData.id
         , Commons.Attributes.maybe Commons.Attributes.ariaLabel configData.ariaLabel
         ]
            ++ typeToAttribute configData.type_
        )
        [ configData.icon
            |> renderIcon configData.size
            |> CR.renderIf (isPrepend configData.icon || isStandalone configData.icon)
        , Html.text configData.text
            |> CR.renderUnless (isStandalone configData.icon)
        , configData.icon
            |> renderIcon configData.size
            |> CR.renderIf (isAppend configData.icon)
        ]


{-| Internal.
-}
renderTag : Config constraints msg -> (List (Html.Attribute msg) -> List (Html msg) -> Html msg)
renderTag (Config configData) =
    if isLinkType configData.type_ then
        Html.a

    else
        Html.button


{-| Internal.
-}
renderIcon : Size -> ButtonIcon -> Html msg
renderIcon size icon =
    icon
        |> pickIcon
        |> Maybe.map
            (Icon.config
                >> applyIconSize size
                >> Icon.render
            )
        |> CR.renderMaybe


{-| Internal.
-}
applyIconSize : Size -> Icon.Config -> Icon.Config
applyIconSize size =
    if size == Huge then
        Icon.withSize Icon.large

    else if size == Large then
        Icon.withSize Icon.medium

    else
        Icon.withSize Icon.small
