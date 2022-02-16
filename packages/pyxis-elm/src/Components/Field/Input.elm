module Components.Field.Input exposing
    ( Model
    , date
    , email
    , number
    , text
    , password
    , Events
    , Addon
    , AddonType
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withClassList
    , withDisabled
    , withErrorMessage
    , withName
    , withPlaceholder
    , withValue
    , getValue
    , render
    )

{-|


# Input component

@docs Model, Type
@docs date
@docs email
@docs number
@docs text
@docs password


## Events

@docs Events


## Addon

@docs Addon
@docs AddonType
@docs iconAddon
@docs textAddon
@docs withAddon


## Size

@docs withSize


## Generics

@docs withClassList
@docs withDisabled
@docs withErrorMessage
@docs withName
@docs withPlaceholder
@docs withValue


## Readers

@docs getValue


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render as CommonsRender
import Components.Field.Error as Error
import Components.Icon as Icon
import Components.IconSet as IconSet
import Date
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Maybe.Extra
import Result.Extra


{-| The Input model.
-}
type Model msg
    = Model (Configuration msg)


{-| Internal. The internal Input configuration.
-}
type alias Configuration msg =
    { addon : Maybe Addon
    , classList : List ( String, Bool )
    , id : String
    , events : Events msg
    , name : Maybe String
    , placeholder : Maybe String
    , size : Size
    , type_ : Type
    , value : String
    , disabled : Bool
    , errorMessage : Maybe String
    }


{-| Events dispatched after messages.
-}
type alias Events msg =
    { onBlur : msg
    , onInput : String -> msg
    , onFocus : msg
    }


{-| Represent the Type(s) an Input could be.
-}
type Type
    = Date
    | Email
    | Number
    | Password
    | Text


{-| Internal. Creates an Input field.
-}
create : Type -> Events msg -> String -> Model msg
create inputType events id =
    Model
        { classList = []
        , id = id
        , events = events
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , type_ = inputType
        , addon = Nothing
        , value = ""
        , disabled = False
        , errorMessage = Nothing
        }


{-| Creates an input with [type="email"].
-}
email : Events msg -> String -> Model msg
email =
    create Email


{-| Creates an input with [type="date"].
-}
date : Events msg -> String -> Model msg
date =
    create Date


{-| Creates an input with [type="number"].
-}
number : Events msg -> String -> Model msg
number =
    create Number


{-| Creates an input with [type="text"].
-}
text : Events msg -> String -> Model msg
text =
    create Text


{-| Creates an input with [type="password"].
-}
password : Events msg -> String -> Model msg
password =
    create Password


{-| Internal.
-}
typeToAttribute : Type -> Html.Attribute msg
typeToAttribute a =
    case a of
        Date ->
            Attributes.type_ "date"

        Email ->
            Attributes.type_ "email"

        Number ->
            Attributes.type_ "number"

        Password ->
            Attributes.type_ "password"

        Text ->
            Attributes.type_ "text"


type AddonType
    = IconAddon IconSet.Icon
    | TextAddon String


type alias Addon =
    { placement : Placement
    , type_ : AddonType
    }


{-| Internal
-}
addonTypeToString : AddonType -> String
addonTypeToString addonType =
    case addonType of
        IconAddon _ ->
            "icon"

        TextAddon _ ->
            "text"


{-| Creates an Addon with an Icon from our IconSet.
-}
iconAddon : IconSet.Icon -> AddonType
iconAddon =
    IconAddon


{-| Creates an Addon with a String content.
-}
textAddon : String -> AddonType
textAddon =
    TextAddon


{-| Sets an Addon to the Input.
-}
withAddon : Placement -> AddonType -> Model msg -> Model msg
withAddon placement type_ (Model configuration) =
    Model { configuration | addon = Just { placement = placement, type_ = type_ } }


{-| Sets the input value attribute
-}
withValue : String -> Model msg -> Model msg
withValue value (Model configuration) =
    Model { configuration | value = value }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Model msg -> Model msg
withDisabled isDisabled (Model configuration) =
    Model { configuration | disabled = isDisabled }


{-| Internal.
-}
addonToAttribute : Addon -> Html.Attribute msg
addonToAttribute { type_, placement } =
    [ "form-field--with"
    , Placement.toString placement
    , addonTypeToString type_
    ]
        |> String.join "-"
        |> Attributes.class


{-| Sets a Size to the Input.
-}
withSize : Size -> Model msg -> Model msg
withSize size (Model configuration) =
    Model { configuration | size = size }


{-| Sets a ClassList to the Input.
-}
withClassList : List ( String, Bool ) -> Model msg -> Model msg
withClassList classes (Model configuration) =
    Model { configuration | classList = classes }


{-| Sets a Name to the Input.
-}
withName : String -> Model msg -> Model msg
withName name (Model configuration) =
    Model { configuration | name = Just name }


{-| Sets a Placeholder to the Input.
-}
withPlaceholder : String -> Model msg -> Model msg
withPlaceholder placeholder (Model configuration) =
    Model { configuration | placeholder = Just placeholder }


{-| Define the error message
-}
withErrorMessage : Maybe String -> Model msg -> Model msg
withErrorMessage mError (Model configuration) =
    Model { configuration | errorMessage = mError }


{-| Renders the Input.
-}
render : Model msg -> Html msg
render (Model configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--error", configuration.errorMessage /= Nothing )
            , ( "form-field--disabled", configuration.disabled )
            ]
        , Commons.Attributes.maybe addonToAttribute configuration.addon
        ]
        [ configuration.addon
            |> Maybe.map (renderAddon configuration)
            |> Maybe.withDefault (viewInput configuration)
        , configuration.errorMessage
            |> Maybe.map
                (Error.create
                    >> Error.withId configuration.id
                    >> Error.render
                )
            |> CommonsRender.renderMaybe
        ]


{-| Internal.
-}
renderAddon : Configuration msg -> Addon -> Html msg
renderAddon configuration addon =
    Html.label
        [ Attributes.class "form-field__wrapper" ]
        [ CommonsRender.renderIf (Placement.isPrepend addon.placement) (renderAddonByType addon.type_)
        , viewInput configuration
        , CommonsRender.renderIf (Placement.isAppend addon.placement) (renderAddonByType addon.type_)
        ]


{-| Internal.
-}
renderAddonByType : AddonType -> Html msg
renderAddonByType type_ =
    case type_ of
        IconAddon icon ->
            Html.div
                [ Attributes.class "form-field__addon" ]
                [ icon
                    |> Icon.create
                    |> Icon.render
                ]

        TextAddon str ->
            Html.span
                [ Attributes.class "form-field__addon" ]
                [ Html.text str ]


{-| Internal.
-}
viewInput : Configuration msg -> Html msg
viewInput configuration =
    Html.input
        [ Attributes.id configuration.id
        , Attributes.classList
            [ -- Types
              ( "form-field__date", configuration.type_ == Date )
            , ( "form-field__date--filled", configuration.type_ == Date && Result.Extra.isOk (Date.fromIsoString configuration.value) )
            , ( "form-field__text", configuration.type_ == Text )
            , ( "form-field__text", configuration.type_ == Number )
            , ( "form-field__text", configuration.type_ == Password )
            , ( "form-field__text", configuration.type_ == Email )

            -- Size
            , ( "form-field__text--small", Size.isSmall configuration.size )
            ]
        , Attributes.classList configuration.classList
        , Attributes.disabled configuration.disabled
        , Attributes.value configuration.value
        , typeToAttribute configuration.type_
        , Commons.Attributes.testId configuration.id
        , Commons.Attributes.maybe Attributes.name configuration.name
        , Commons.Attributes.maybe Attributes.placeholder configuration.placeholder
        , Commons.Attributes.renderIf (Maybe.Extra.isJust configuration.errorMessage) (Commons.Attributes.ariaDescribedBy (Error.toId configuration.id))
        , Html.Events.onInput configuration.events.onInput
        , Html.Events.onFocus configuration.events.onFocus
        , Html.Events.onBlur configuration.events.onBlur
        ]
        []


{-| Return the input value
-}
getValue : Model msg -> String
getValue (Model { value }) =
    value
