module Components.Field.Input exposing
    ( Model
    , init
    , Config
    , date
    , email
    , number
    , text
    , password
    , Addon
    , AddonType
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withLabel
    , withClassList
    , withDisabled
    , withHint
    , withName
    , withPlaceholder
    , setValue
    , getValue
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
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
@docs withHint
@docs withName
@docs withPlaceholder
@docs setValue


## Setters

@docs setValue


## Getters

@docs getValue


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update
@docs validate


## Validation

@docs validate


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render
import Components.Field.Error as Error
import Components.Field.Hint as Hint
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
        { validation : ctx -> String -> Result String value
        , value : String
        }


{-| Inits the Input model.
-}
init : (ctx -> String -> Result String value) -> Model ctx value
init validation =
    Model
        { validation = validation
        , value = ""
        }


{-| Represent the messages the Input Text can handle.
-}
type Msg
    = OnInput String
    | OnFocus
    | OnBlur


{-| Returns True if the message is triggered by `Html.Events.onInput`
-}
isOnInput : Msg -> Bool
isOnInput msg =
    case msg of
        OnInput _ ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onFocus`
-}
isOnFocus : Msg -> Bool
isOnFocus msg =
    case msg of
        OnFocus ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onBlur`
-}
isOnBlur : Msg -> Bool
isOnBlur msg =
    case msg of
        OnBlur ->
            True

        _ ->
            False


{-| Update the input internal model
-}
update : Msg -> Model ctx value -> Model ctx value
update msg model =
    case msg of
        OnBlur ->
            model

        OnFocus ->
            model

        OnInput value ->
            setValue value model


{-| The view config.
-}
type Config
    = Config
        { addon : Maybe Addon
        , classList : List ( String, Bool )
        , hint : Maybe Hint.Config
        , id : String
        , name : Maybe String
        , placeholder : Maybe String
        , size : Size
        , type_ : Type
        , disabled : Bool
        , label : Maybe Label.Config
        }


{-| Internal. Creates an Input field.
-}
config : Type -> String -> Config
config inputType id =
    Config
        { classList = []
        , hint = Nothing
        , id = id
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
email : String -> Config
email =
    config Email


{-| Creates an input with [type="date"].
-}
date : String -> Config
date =
    config Date


{-| Creates an input with [type="number"].
-}
number : String -> Config
number =
    config Number


{-| Creates an input with [type="text"].
-}
text : String -> Config
text =
    config Text


{-| Creates an input with [type="password"].
-}
password : String -> Config
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
withAddon : Placement -> AddonType -> Config -> Config
withAddon placement type_ (Config configuration) =
    Config { configuration | addon = Just { placement = placement, type_ = type_ } }


{-| Adds a Label to the Input.
-}
withLabel : Label.Config -> Config -> Config
withLabel a (Config configuration) =
    Config { configuration | label = Just a }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config -> Config
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets the input hint
-}
withHint : String -> Config -> Config
withHint hintMessage (Config configuration) =
    Config
        { configuration
            | hint =
                Hint.config hintMessage
                    |> Hint.withFieldId configuration.id
                    |> Just
        }


{-| Sets a Size to the Input.
-}
withSize : Size -> Config -> Config
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets a ClassList to the Input.
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Sets a Name to the Input.
-}
withName : String -> Config -> Config
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Sets a Placeholder to the Input.
-}
withPlaceholder : String -> Config -> Config
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = Just placeholder }


{-| Sets the input value attribute
-}
setValue : String -> Model ctx value -> Model ctx value
setValue value (Model configuration) =
    Model { configuration | value = value }


{-| Internal
-}
normalizeConfig : Config -> Config
normalizeConfig ((Config configData) as config_) =
    case configData.type_ of
        Date ->
            config_
                |> withAddon Placement.prepend (iconAddon IconSet.Calendar)

        _ ->
            config_


{-| Renders the Input.Stories/Chapters/DateField.elm
-}
render : (Msg -> msg) -> ctx -> Model ctx value -> Config -> Html msg
render tagger ctx ((Model state) as model) rawConfig =
    let
        ((Config configuration) as config_) =
            normalizeConfig rawConfig
    in
    Html.div
        [ Attributes.class "form-item" ]
        [ configuration.label
            |> Maybe.map Label.render
            |> Commons.Render.renderMaybe
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-field", True )
                    , ( "form-field--error", Result.Extra.isErr (state.validation ctx state.value) )
                    , ( "form-field--disabled", configuration.disabled )
                    ]
                , Commons.Attributes.maybe addonToAttribute configuration.addon
                ]
                [ configuration.addon
                    |> Maybe.map (renderAddon ctx model config_)
                    |> Maybe.withDefault (renderInput ctx model config_)
                ]
            , state.value
                |> state.validation ctx
                |> Error.fromResult
                |> Commons.Render.renderErrorOrHint configuration.id configuration.hint
            ]
        ]
        |> Html.map tagger


{-| Internal.
-}
renderAddon : ctx -> Model ctx value -> Config -> Addon -> Html Msg
renderAddon ctx model configuration addon =
    Html.label
        [ Attributes.class "form-field__wrapper" ]
        [ Commons.Render.renderIf (Placement.isPrepend addon.placement) (renderAddonByType addon.type_)
        , renderInput ctx model configuration
        , Commons.Render.renderIf (Placement.isAppend addon.placement) (renderAddonByType addon.type_)
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
renderInput : ctx -> Model ctx value -> Config -> Html Msg
renderInput ctx (Model modelData) (Config configData) =
    Html.input
        [ Attributes.id configData.id
        , Attributes.classList
            [ ( "form-field__date", configData.type_ == Date )
            , ( "form-field__date--filled", configData.type_ == Date && Result.Extra.isOk (Date.fromIsoString modelData.value) )
            , ( "form-field__text", configData.type_ == Text )
            , ( "form-field__text", configData.type_ == Number )
            , ( "form-field__text", configData.type_ == Password )
            , ( "form-field__text", configData.type_ == Email )
            , ( "form-field__text--small", Size.isSmall configData.size )
            ]
        , Attributes.classList configData.classList
        , Attributes.disabled configData.disabled
        , Attributes.value modelData.value
        , typeToAttribute configData.type_
        , Commons.Attributes.testId configData.id
        , Commons.Attributes.maybe Attributes.name configData.name
        , Commons.Attributes.maybe Attributes.placeholder configData.placeholder
        , modelData.value
            |> modelData.validation ctx
            |> Error.fromResult
            |> Maybe.map (always (Error.toId configData.id))
            |> Commons.Attributes.ariaDescribedByErrorOrHint
                (Maybe.map (always (Hint.toId configData.id)) configData.hint)
        , Html.Events.onInput OnInput
        , Html.Events.onFocus OnFocus
        , Html.Events.onBlur OnBlur
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
validate ctx (Model { value, validation }) =
    validation ctx value
