module Components.Field.Input exposing
    ( Model
    , init
    , date
    , DateConfig
    , email
    , EmailConfig
    , number
    , NumberConfig
    , password
    , PasswordConfig
    , text
    , TextConfig
    , Addon
    , AddonType
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withAdditionalContent
    , withClassList
    , withDisabled
    , withHint
    , withIsSubmitted
    , withLabel
    , withName
    , withPlaceholder
    , withStrategy
    , withValueMapper
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
    , updateValue
    , getValue
    , validate
    , render
    )

{-|


# Input component

@docs Model
@docs init


## Config

@docs date
@docs DateConfig
@docs email
@docs EmailConfig
@docs number
@docs NumberConfig
@docs password
@docs PasswordConfig
@docs text
@docs TextConfig


## Addon

@docs Addon
@docs AddonType
@docs iconAddon
@docs textAddon
@docs withAddon


## Size

@docs withSize


## Generics

@docs withAdditionalContent
@docs withClassList
@docs withDisabled
@docs withHint
@docs withIsSubmitted
@docs withLabel
@docs withName
@docs withPlaceholder
@docs withStrategy
@docs withValueMapper


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update
@docs updateValue


## Readers

@docs getValue
@docs validate


## Rendering

@docs render

-}

import Commons.ApiConstraints as API
import Commons.Attributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render
import Components.Field.Error as Error
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as StrategyInternal
import Components.Field.FormItem as FormItem
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.Status as FieldStatus
import Components.Icon as Icon
import Components.IconSet as IconSet
import Date
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Result.Extra


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


{-| The Input model.
-}
type Model ctx parsedValue
    = Model
        { validation : ctx -> String -> Result String parsedValue
        , value : String
        , fieldStatus : FieldStatus.Status
        }


{-| Inits the Input model.
-}
init : String -> (ctx -> String -> Result String parsedValue) -> Model ctx parsedValue
init initialValue validation =
    Model
        { validation = validation
        , value = initialValue
        , fieldStatus = FieldStatus.Untouched
        }


{-| Update the input internal model
-}
update : Msg -> Model ctx parsedValue -> Model ctx parsedValue
update msg model =
    case msg of
        OnBlur ->
            model
                |> mapFieldStatus FieldStatus.onBlur

        OnFocus ->
            model
                |> mapFieldStatus FieldStatus.onFocus

        OnInput value ->
            model
                |> setValue value
                |> mapFieldStatus FieldStatus.onInput


{-| Update the field value.
-}
updateValue : String -> Model ctx parsedValue -> Model ctx parsedValue
updateValue value =
    update (OnInput value)


{-| Internal
-}
mapFieldStatus : (FieldStatus.Status -> FieldStatus.Status) -> Model ctx parsedValue -> Model ctx parsedValue
mapFieldStatus mapper (Model model) =
    Model { model | fieldStatus = mapper model.fieldStatus }


{-| Return the input value
-}
getValue : Model ctx parsedValue -> String
getValue (Model { value }) =
    value


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx parsedValue -> Result String parsedValue
validate ctx (Model { value, validation }) =
    validation ctx value


{-| The view config.
-}
type Config constraints
    = Config
        { additionalContent : Maybe (Html Never)
        , addon : Maybe Addon
        , classList : List ( String, Bool )
        , disabled : Bool
        , hint : Maybe Hint.Config
        , id : String
        , isSubmitted : Bool
        , label : Maybe Label.Config
        , name : Maybe String
        , placeholder : Maybe String
        , size : Size
        , strategy : Strategy
        , type_ : Type
        , valueMapper : String -> String
        }


{-| Common constraints.
-}
type alias CommonConstraints specificConstraints =
    { specificConstraints
        | additionalContent : API.Allowed
        , classList : API.Allowed
        , disabled : API.Allowed
        , hint : API.Allowed
        , isSubmitted : API.Allowed
        , label : API.Allowed
        , name : API.Allowed
        , size : API.Allowed
        , strategy : API.Allowed
        , valueMapper : API.Allowed
    }


{-| Date constraints.
-}
type alias DateConstraints =
    CommonConstraints
        {}


{-| Email constraints.
-}
type alias EmailConstraints =
    CommonConstraints
        { addon : API.Allowed
        , placeholder : API.Allowed
        }


{-| Number constraints.
-}
type alias NumberConstraints =
    CommonConstraints
        { addon : API.Allowed
        , placeholder : API.Allowed
        }


{-| Password constraints.
-}
type alias PasswordConstraints =
    CommonConstraints
        { addon : API.Allowed
        , placeholder : API.Allowed
        }


{-| Text constraints.
-}
type alias TextConstraints =
    CommonConstraints
        { addon : API.Allowed
        , placeholder : API.Allowed
        }


{-| Internal. Creates an Input field.
-}
config : Type -> String -> Config constraints
config inputType id =
    Config
        { additionalContent = Nothing
        , addon = Nothing
        , classList = []
        , disabled = False
        , hint = Nothing
        , id = id
        , isSubmitted = False
        , label = Nothing
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , strategy = Strategy.onBlur
        , type_ = inputType
        , valueMapper = identity
        }


{-| Represent the Type(s) an Input could be.
-}
type Type
    = Date
    | Email
    | Number
    | Password
    | Text


{-| Date configuration.
-}
type alias DateConfig =
    Config DateConstraints


{-| Email configuration.
-}
type alias EmailConfig =
    Config EmailConstraints


{-| Number configuration.
-}
type alias NumberConfig =
    Config NumberConstraints


{-| Password configuration.
-}
type alias PasswordConfig =
    Config PasswordConstraints


{-| Text configuration.
-}
type alias TextConfig =
    Config TextConstraints


{-| Creates an input with [type="email"].
-}
email : String -> EmailConfig
email =
    config Email


{-| Creates an input with [type="date"].
-}
date : String -> DateConfig
date =
    config Date


{-| Creates an input with [type="number"].
-}
number : String -> NumberConfig
number =
    config Number


{-| Creates an input with [type="text"].
-}
text : String -> TextConfig
text =
    config Text


{-| Creates an input with [type="password"].
-}
password : String -> PasswordConfig
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


{-| Addon types.
-}
type AddonType
    = IconAddon IconSet.Icon
    | TextAddon String


{-| Addon configuration.
-}
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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy :
    Strategy
    -> Config { c | strategy : API.Allowed }
    -> Config { c | strategy : API.Denied }
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Maps the inputted string before the update

    Text.config "id"
        |> Input.withValueMapper String.toUppercase
        |> Input.render Tagger formData model.textModel

In this example, if the user inputs "abc", the actual inputted text is "ABC".
This applies to both the user UI and the `getValue`/`validate` functions

-}
withValueMapper :
    (String -> String)
    -> Config { c | valueMapper : API.Allowed }
    -> Config { c | valueMapper : API.Denied }
withValueMapper mapper (Config configData) =
    Config { configData | valueMapper = mapper }


{-| Sets whether the form was submitted
-}
withIsSubmitted :
    Bool
    -> Config { c | isSubmitted : API.Allowed }
    -> Config { c | isSubmitted : API.Denied }
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


{-| Sets an Addon to the Input.
-}
withAddon :
    Placement
    -> AddonType
    -> Config { c | addon : API.Allowed }
    -> Config { c | addon : API.Denied }
withAddon placement type_ (Config configuration) =
    Config { configuration | addon = Just { placement = placement, type_ = type_ } }


{-| Adds a Label to the Input.
-}
withLabel :
    Label.Config
    -> Config { c | label : API.Allowed }
    -> Config { c | label : API.Denied }
withLabel a (Config configuration) =
    Config { configuration | label = Just a }


{-| Sets the input as disabled
-}
withDisabled :
    Bool
    -> Config { c | disabled : API.Allowed }
    -> Config { c | disabled : API.Denied }
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets the input hint
-}
withHint :
    String
    -> Config { c | hint : API.Allowed }
    -> Config { c | hint : API.Denied }
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
withSize :
    Size
    -> Config { c | size : API.Allowed }
    -> Config { c | size : API.Denied }
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets a ClassList to the Input.
-}
withClassList :
    List ( String, Bool )
    -> Config { c | classList : API.Allowed }
    -> Config { c | classList : API.Denied }
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Sets a Name to the Input.
-}
withName :
    String
    -> Config { c | name : API.Allowed }
    -> Config { c | name : API.Denied }
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Sets a Placeholder to the Input.
-}
withPlaceholder :
    String
    -> Config { c | placeholder : API.Allowed }
    -> Config { c | placeholder : API.Denied }
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = Just placeholder }


{-| Append an additional custom html.
-}
withAdditionalContent :
    Html Never
    -> Config { c | additionalContent : API.Allowed }
    -> Config { c | additionalContent : API.Denied }
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = Just additionalContent }


{-| Sets the input value attribute
-}
setValue : String -> Model ctx parsedValue -> Model ctx parsedValue
setValue value (Model configuration) =
    Model { configuration | value = value }


{-| Internal
-}
addIconCalendarToDateField : Config constraints -> Config constraints
addIconCalendarToDateField ((Config configData) as config_) =
    case configData.type_ of
        Date ->
            Config { configData | addon = Just { placement = Placement.prepend, type_ = iconAddon IconSet.Calendar } }

        _ ->
            config_


{-| Renders the Input.Stories/Chapters/DateField.elm
-}
render : (Msg -> msg) -> ctx -> Model ctx parsedValue -> Config constraints -> Html msg
render tagger ctx ((Model modelData) as model) ((Config configData) as config_) =
    let
        shownValidation : Result String ()
        shownValidation =
            StrategyInternal.getShownValidation
                modelData.fieldStatus
                (modelData.validation ctx modelData.value)
                configData.isSubmitted
                configData.strategy
    in
    config_
        |> addIconCalendarToDateField
        |> renderField shownValidation model
        |> Html.map tagger
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation


{-| Internal.
-}
renderField : Result String () -> Model ctx parsedValue -> Config constraints -> Html Msg
renderField shownValidation model ((Config { disabled, addon }) as configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--error", Result.Extra.isErr shownValidation )
            , ( "form-field--disabled", disabled )
            ]
        , Commons.Attributes.maybe addonToAttribute addon
        ]
        [ addon
            |> Maybe.map (renderAddon shownValidation model configuration)
            |> Maybe.withDefault (renderInput shownValidation model configuration)
        ]


{-| Internal.
-}
renderAddon : Result String () -> Model ctx parsedValue -> Config constraints -> Addon -> Html Msg
renderAddon validationResult model configuration addon =
    Html.label
        [ Attributes.class "form-field__wrapper" ]
        [ Commons.Render.renderIf (Placement.isPrepend addon.placement) (renderAddonByType addon.type_)
        , renderInput validationResult model configuration
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
renderInput : Result String () -> Model ctx parsedValue -> Config constraints -> Html Msg
renderInput validationResult (Model modelData) (Config configData) =
    Html.input
        [ Attributes.id configData.id
        , Attributes.classList
            [ ( "form-field__date", configData.type_ == Date )
            , ( "form-field__date--filled", configData.type_ == Date && Result.Extra.isOk (Date.fromIsoString modelData.value) )
            , ( "form-field__text", configData.type_ == Text )
            , ( "form-field__text", configData.type_ == Number )
            , ( "form-field__text", configData.type_ == Password )
            , ( "form-field__text", configData.type_ == Email )
            , ( "form-field__text--small", configData.type_ /= Date && Size.isSmall configData.size )
            , ( "form-field__date--small", configData.type_ == Date && Size.isSmall configData.size )
            ]
        , Attributes.classList configData.classList
        , Attributes.disabled configData.disabled
        , Attributes.value modelData.value
        , typeToAttribute configData.type_
        , Commons.Attributes.testId configData.id
        , Commons.Attributes.maybe Attributes.name configData.name
        , Commons.Attributes.maybe Attributes.placeholder configData.placeholder
        , validationResult
            |> Error.fromResult
            |> Maybe.map (always (Error.toId configData.id))
            |> Commons.Attributes.ariaDescribedByErrorOrHint
                (Maybe.map (always (Hint.toId configData.id)) configData.hint)
        , Html.Events.onInput (configData.valueMapper >> OnInput)
        , Html.Events.onFocus OnFocus
        , Html.Events.onBlur OnBlur
        ]
        []
