module Components.Field.Input exposing
    ( Model
    , init
    , Config
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
    , withLabel
    , withClassList
    , withDisabled
    , withName
    , withPlaceholder
    , setValue
    , getValue
    , validate
    , render
    )

{-|


# Input component

@docs Model
@docs init


## Config

@docs Config
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

@docs withLabel
@docs withClassList
@docs withDisabled
@docs withName
@docs withPlaceholder
@docs setValue


## Setters

@docs setValue


## Getters

@docs getValue


## Validation

@docs validate


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render as CommonsRender
import Components.Field.Error as Error
import Components.Field.Label as Label
import Components.Icon as Icon
import Components.IconSet as IconSet
import Date
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Result.Extra


{-| The Input model.
-}
type Model ctx value
    = Model
        { validation : ctx -> value -> Result String value
        , valueMapper : String -> value
        , value : String
        }


{-| Inits the Input model.
-}
init : (String -> value) -> (ctx -> value -> Result String value) -> Model ctx value
init valueMapper validation =
    Model
        { validation = validation
        , valueMapper = valueMapper
        , value = ""
        }


{-| Events dispatched after messages.
-}
type alias Events msg =
    { onBlur : msg
    , onInput : String -> msg
    , onFocus : msg
    }


{-| The view config.
-}
type Config msg
    = Config
        { addon : Maybe Addon
        , classList : List ( String, Bool )
        , id : String
        , events : Events msg
        , name : Maybe String
        , placeholder : Maybe String
        , size : Size
        , type_ : Type
        , disabled : Bool
        , label : Maybe Label.Model
        }


{-| Internal. Creates an Input field.
-}
config : Type -> Events msg -> String -> Config msg
config inputType events id =
    Config
        { classList = []
        , id = id
        , events = events
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , type_ = inputType
        , addon = Nothing
        , disabled = False
        , label = Nothing
        }


{-| Represent the Type(s) an Input could be.
-}
type Type
    = Date
    | Email
    | Number
    | Password
    | Text


{-| Creates an input with [type="email"].
-}
email : Events msg -> String -> Config msg
email =
    config Email


{-| Creates an input with [type="date"].
-}
date : Events msg -> String -> Config msg
date =
    config Date


{-| Creates an input with [type="number"].
-}
number : Events msg -> String -> Config msg
number =
    config Number


{-| Creates an input with [type="text"].
-}
text : Events msg -> String -> Config msg
text =
    config Text


{-| Creates an input with [type="password"].
-}
password : Events msg -> String -> Config msg
password =
    config Password


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


{-| Sets an Addon to the Input.
-}
withAddon : Placement -> AddonType -> Config msg -> Config msg
withAddon placement type_ (Config configuration) =
    Config { configuration | addon = Just { placement = placement, type_ = type_ } }


{-| Adds a Label to the Input.
-}
withLabel : Label.Model -> Config msg -> Config msg
withLabel a (Config configuration) =
    Config { configuration | label = Just a }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets a Size to the Input.
-}
withSize : Size -> Config msg -> Config msg
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets a ClassList to the Input.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Sets a Name to the Input.
-}
withName : String -> Config msg -> Config msg
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Sets a Placeholder to the Input.
-}
withPlaceholder : String -> Config msg -> Config msg
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = Just placeholder }


{-| Sets the input value attribute
-}
setValue : String -> Model ctx value -> Model ctx value
setValue value (Model configuration) =
    Model { configuration | value = value }


{-| Renders the Input.Stories/Chapters/DateField.elm
-}
render : ctx -> Model ctx value -> Config msg -> Html msg
render ctx ((Model state) as model) ((Config configuration) as config_) =
    Html.div
        [ Attributes.class "form-item" ]
        [ configuration.label
            |> Maybe.map Label.render
            |> CommonsRender.renderMaybe
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-field", True )
                    , ( "form-field--error", Result.Extra.isErr (state.validation ctx (state.valueMapper state.value)) )
                    , ( "form-field--disabled", configuration.disabled )
                    ]
                , Commons.Attributes.maybe addonToAttribute configuration.addon
                ]
                [ configuration.addon
                    |> Maybe.map (renderAddon ctx model config_)
                    |> Maybe.withDefault (renderInput ctx model config_)
                ]
            , state.value
                |> state.valueMapper
                |> state.validation ctx
                |> Error.fromResult
                |> Maybe.map (Error.withId configuration.id >> Error.render)
                |> CommonsRender.renderMaybe
            ]
        ]


{-| Internal.
-}
renderAddon : ctx -> Model ctx value -> Config msg -> Addon -> Html msg
renderAddon ctx model configuration addon =
    Html.label
        [ Attributes.class "form-field__wrapper" ]
        [ CommonsRender.renderIf (Placement.isPrepend addon.placement) (renderAddonByType addon.type_)
        , renderInput ctx model configuration
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
renderInput : ctx -> Model ctx value -> Config msg -> Html msg
renderInput ctx (Model state) (Config configuration) =
    Html.input
        [ Attributes.id configuration.id
        , Attributes.classList
            [ ( "form-field__date", configuration.type_ == Date )
            , ( "form-field__date--filled", configuration.type_ == Date && Result.Extra.isOk (Date.fromIsoString state.value) )
            , ( "form-field__text", configuration.type_ == Text )
            , ( "form-field__text", configuration.type_ == Number )
            , ( "form-field__text", configuration.type_ == Password )
            , ( "form-field__text", configuration.type_ == Email )
            , ( "form-field__text--small", Size.isSmall configuration.size )
            ]
        , Attributes.classList configuration.classList
        , Attributes.disabled configuration.disabled
        , Attributes.value state.value
        , typeToAttribute configuration.type_
        , Commons.Attributes.testId configuration.id
        , Commons.Attributes.maybe Attributes.name configuration.name
        , Commons.Attributes.maybe Attributes.placeholder configuration.placeholder
        , Commons.Attributes.renderIf
            (Result.Extra.isOk (state.validation ctx (state.valueMapper state.value)))
            (Commons.Attributes.ariaDescribedBy (Error.toId configuration.id))
        , Html.Events.onInput configuration.events.onInput
        , Html.Events.onFocus configuration.events.onFocus
        , Html.Events.onBlur configuration.events.onBlur
        ]
        []


{-| Return the input value
-}
getValue : Model ctx value -> String
getValue (Model { value }) =
    value


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx value -> Result String value
validate ctx (Model { value, valueMapper, validation }) =
    value
        |> valueMapper
        |> validation ctx
