module Components.Button exposing
    ( Model, Variant
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
type Model msg
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
init : Variant -> Model msg
init variant =
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
        , variant = variant
        }


{-| Creates a Button with a Primary variant.
-}
primary : Model msg
primary =
    init Primary


{-| Creates a Button with a Secondary variant.
-}
secondary : Model msg
secondary =
    init Secondary


{-| Creates a Button with a Tertiary variant.
-}
tertiary : Model msg
tertiary =
    init Tertiary


{-| Creates a Button with a Brand variant.
-}
brand : Model msg
brand =
    init Brand


{-| Creates a Button with a Ghost variant.
-}
ghost : Model msg
ghost =
    init Ghost


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
withType : Type msg -> Model msg -> Model msg
withType a (Model configuration) =
    Model { configuration | type_ = a }


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
withTheme : Theme -> Model msg -> Model msg
withTheme a (Model configuration) =
    Model { configuration | theme = a }


{-| The available Button variant.
-}
type Variant
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost


withSize : Size -> Model msg -> Model msg
withSize a (Model configuration) =
    Model { configuration | size = a }


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withIconPrepend : IconSet.Icon -> Model msg -> Model msg
withIconPrepend icon (Model configuration) =
    Model { configuration | icon = PlacedIcon Placement.prepend icon }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withIconAppend : IconSet.Icon -> Model msg -> Model msg
withIconAppend icon (Model configuration) =
    Model { configuration | icon = PlacedIcon Placement.append icon }


{-| Adds an icon to the Button. This will be the only content of the Button..
-}
withIconOnly : IconSet.Icon -> Model msg -> Model msg
withIconOnly icon (Model configuration) =
    Model { configuration | icon = Standalone icon }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Model msg -> Model msg
withDisabled a (Model configuration) =
    Model { configuration | disabled = a }


{-| Sets an aria-label to the Button.
-}
withAriaLabel : String -> Model msg -> Model msg
withAriaLabel a (Model configuration) =
    Model { configuration | ariaLabel = Just a }


{-| Sets an id to the Button.
-}
withId : String -> Model msg -> Model msg
withId a (Model configuration) =
    Model { configuration | id = Just a }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading : Bool -> Model msg -> Model msg
withLoading a (Model configuration) =
    Model { configuration | loading = a }


{-| Sets whether the Button should have a content width or not.
-}
withContentWidth : Model msg -> Model msg
withContentWidth (Model configuration) =
    Model { configuration | contentWidth = True }


{-| Sets whether the Button should have a shadow or not.
-}
withShadow : Model msg -> Model msg
withShadow (Model configuration) =
    Model { configuration | shadow = True }


{-| Adds a textual content to the Button.
-}
withText : String -> Model msg -> Model msg
withText a (Model configuration) =
    Model { configuration | text = a }


{-| Adds a classList to the Button.
-}
withClassList : List ( String, Bool ) -> Model msg -> Model msg
withClassList a (Model configuration) =
    Model { configuration | classList = a }


{-| Renders the Button.
-}
render : Model msg -> Html msg
render (Model configuration) =
    (if isLinkType configuration.type_ then
        Html.a

     else
        Html.button
    )
        (CA.compose
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
