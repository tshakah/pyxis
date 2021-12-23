module Components.Button exposing
    ( Model
    , create
    , Emphasis
    , primary, secondary, tertiary, brand, ghost, icon
    , withEmphasis
    , Theme
    , light, dark
    , withTheme
    , Size
    , huge, large, medium, small
    , withSize
    , Type
    , button, submit
    , withType
    , Icon
    , withLeadingIcon, withTrailingIcon
    , withDisabled
    , withLoading
    , withText
    , render
    )

{-|


# Button component

@docs Model
@docs create


## Emphasis

@docs Emphasis
@docs primary, secondary, tertiary, brand, ghost, icon
@docs withEmphasis


## Theme

@docs Theme
@docs light, dark
@docs withTheme


## Size

@docs Size
@docs huge, large, medium, small
@docs withSize


## Type

@docs Type
@docs button, submit
@docs withType


## Icon

@docs Icon
@docs withLeadingIcon, withTrailingIcon


## Generics

@docs withDisabled
@docs withLoading
@docs withText


## Rendering

@docs render

-}

import Commons.Attributes as CA
import Commons.Render as CR
import Components.Icon as PyxisIcon
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events


{-| The Button model.
-}
type Model msg
    = Model (Configuration msg)


{-| Internal. The initial representation of a Button.
-}
init : Model msg
init =
    Model
        { disabled = False
        , emphasis = Primary
        , icon = NoIcon
        , loading = False
        , size = Medium
        , text = ""
        , theme = Light
        , type_ = Submit
        }


{-| Internal. The internal Button configuration.
-}
type alias Configuration msg =
    { disabled : Bool
    , emphasis : Emphasis
    , icon : Icon
    , loading : Bool
    , size : Size
    , text : String
    , theme : Theme
    , type_ : Type msg
    }


{-| Inits the Button.

    import Components.Button as Button
    import MyForm

    type Msg
        = OnClick

    myClickableButton : Button.Model Msg
    myClickableButton =
        OnClick
            |> Button.button
            |> Button.create
            |> Button.withEmphasis Button.brand
            |> Button.withText "Click me!"

    mySubmitButton : Button.Model Msg
    mySubmitButton =
        Button.submit
            |> Button.create
            |> Button.withEmphasis Button.primary
            |> Button.withText "Submit form"
            |> Button.withDisabled (not MyForm.canBeSubmitted)

-}
create : Type msg -> Model msg
create type_ =
    withType type_ init


{-| The available skin theme.
-}
type Theme
    = Light
    | Dark


{-| Create a light theme.
-}
light : Theme
light =
    Light


{-| Create a dark theme.
-}
dark : Theme
dark =
    Dark


{-| Sets a theme to the Button.
-}
withTheme : Theme -> Model msg -> Model msg
withTheme a (Model configuration) =
    Model { configuration | theme = a }


{-| The available Button emphasis.
-}
type Emphasis
    = Primary
    | Secondary
    | Tertiary
    | Brand
    | Ghost
    | Icon


{-| Creates a primary emphasis.
-}
primary : Emphasis
primary =
    Primary


{-| Creates a secondary emphasis.
-}
secondary : Emphasis
secondary =
    Secondary


{-| Creates a tertiary emphasis.
-}
tertiary : Emphasis
tertiary =
    Tertiary


{-| Creates a brand emphasis.
-}
brand : Emphasis
brand =
    Brand


{-| Creates a ghost emphasis.
-}
ghost : Emphasis
ghost =
    Ghost


{-| Creates a icon emphasis.
-}
icon : Emphasis
icon =
    Icon


{-| Sets an emphasis to the Button.
-}
withEmphasis : Emphasis -> Model msg -> Model msg
withEmphasis a (Model configuration) =
    Model { configuration | emphasis = a }


{-| Internal.
-}
emphasisToAttribute : Emphasis -> Html.Attribute msg
emphasisToAttribute emphasis =
    Attributes.class
        (case emphasis of
            Primary ->
                "button--primary"

            Secondary ->
                "button--secondary"

            Tertiary ->
                "button--tertiary"

            Brand ->
                "button--brand"

            Ghost ->
                "button--ghost"

            Icon ->
                "button--only-icon"
        )


{-| The available Button types.
-}
type Type msg
    = Button msg
    | Submit


{-| A type="button" Button.
-}
button : msg -> Type msg
button msg =
    Button msg


{-| A type="submit" Button.
-}
submit : Type msg
submit =
    Submit


{-| Sets a type to the Button.
-}
withType : Type msg -> Model msg -> Model msg
withType a (Model configuration) =
    Model { configuration | type_ = a }


{-| Internal.
-}
typeToAttribute : Type msg -> Html.Attribute msg
typeToAttribute a =
    Attributes.type_
        (case a of
            Submit ->
                "submit"

            Button _ ->
                "button"
        )


{-| Internal.
-}
typeToEventAttribute : Type msg -> Html.Attribute msg
typeToEventAttribute a =
    case a of
        Button action ->
            Events.onClick action

        Submit ->
            CA.empty


{-| The available Button sizes.
-}
type Size
    = Huge
    | Large
    | Medium
    | Small


{-| A huge Button Size.
-}
huge : Size
huge =
    Huge


{-| A large Button Size.
-}
large : Size
large =
    Large


{-| A medium Button Size.
-}
medium : Size
medium =
    Medium


{-| A small Button Size.
-}
small : Size
small =
    Small


{-| Sets a size to the Button.
-}
withSize : Size -> Model msg -> Model msg
withSize a (Model configuration) =
    Model { configuration | size = a }


{-| Internal.
-}
sizeToAttribute : Size -> Html.Attribute msg
sizeToAttribute size =
    Attributes.class
        (case size of
            Huge ->
                "button--huge"

            Large ->
                "button--large"

            Medium ->
                "button--medium"

            Small ->
                "button--small"
        )


{-| The available Icons positions.
-}
type Icon
    = Leading PyxisIcon.Icon
    | Trailing PyxisIcon.Icon
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


{-| Adds an icon to the Button. The icon will be shown before button's content from ltr.
-}
withLeadingIcon : PyxisIcon.Icon -> Model msg -> Model msg
withLeadingIcon a (Model configuration) =
    Model { configuration | icon = Leading a }


{-| Adds an icon to the Button. The icon will be shown after button's content from ltr.
-}
withTrailingIcon : PyxisIcon.Icon -> Model msg -> Model msg
withTrailingIcon a (Model configuration) =
    Model { configuration | icon = Trailing a }


{-| Sets whether the Button should be disabled or not.
-}
withDisabled : Bool -> Model msg -> Model msg
withDisabled a (Model configuration) =
    Model { configuration | disabled = a }


{-| Sets whether the Button should show a loading spinner or not.
-}
withLoading : Bool -> Model msg -> Model msg
withLoading a (Model configuration) =
    Model { configuration | loading = a }


{-| Adds a textual content to the Button.
-}
withText : String -> Model msg -> Model msg
withText a (Model configuration) =
    Model { configuration | text = a }


{-| Renders the Button.
-}
render : Model msg -> Html msg
render (Model configuration) =
    Html.button
        [ Attributes.classList
            [ ( "button", True )
            , ( "button--light", configuration.theme == light )
            , ( "button--dark", configuration.theme == dark )
            , ( "button--leading-icon", isLeadingIcon configuration.icon )
            , ( "button--trailing-icon", isTrailingIcon configuration.icon )
            , ( "button--primary", configuration.emphasis == primary )
            , ( "button--secondary", configuration.emphasis == secondary )
            , ( "button--tertiary", configuration.emphasis == tertiary )
            , ( "button--brand", configuration.emphasis == brand )
            , ( "button--ghost", configuration.emphasis == ghost )
            , ( "button--only-icon", configuration.emphasis == icon )
            , ( "button--huge", configuration.size == huge )
            , ( "button--large", configuration.size == large )
            , ( "button--medium", configuration.size == medium )
            , ( "button--small", configuration.size == small )
            , ( "button--loading", configuration.loading )
            ]
        , Attributes.disabled configuration.disabled
        , emphasisToAttribute configuration.emphasis
        , sizeToAttribute configuration.size
        , typeToAttribute configuration.type_
        , typeToEventAttribute configuration.type_
        ]
        [ configuration.icon
            |> renderIcon
            |> CR.renderIf (isLeadingIcon configuration.icon)
        , Html.text configuration.text
        , configuration.icon
            |> renderIcon
            |> CR.renderIf (isTrailingIcon configuration.icon)
        ]


{-| Internal.
-}
renderIcon : Icon -> Html msg
renderIcon a =
    case a of
        Leading pyxisIcon ->
            PyxisIcon.render pyxisIcon

        Trailing pyxisIcon ->
            PyxisIcon.render pyxisIcon

        NoIcon ->
            CR.empty
