module Components.Field.Input exposing
    ( Model
    , init
    , setValue
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
    , getValue
    , validate
    , render
    )

{-|


# Input component

@docs Model
@docs init
@docs setValue


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


## Setters

@docs setValue


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update


## Readers

@docs getValue
@docs validate


## Rendering

@docs render

-}

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
import Components.Field.State as FieldState
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
        , fieldState : FieldState.State
        }


{-| Inits the Input model.
-}
init : String -> (ctx -> String -> Result String value) -> Model ctx value
init initialValue validation =
    Model
        { validation = validation
        , value = initialValue
        , fieldState = FieldState.Untouched
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
                |> mapFieldState FieldState.onBlur

        OnFocus ->
            model
                |> mapFieldState FieldState.onFocus

        OnInput value ->
            model
                |> setValue value
                |> mapFieldState FieldState.onInput


{-| The view config.
-}
type Config msg
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


{-| Internal. Creates an Input field.
-}
config : Type -> String -> Config msg
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


{-| Creates an input with [type="email"].
-}
email : String -> Config msg
email =
    config Email


{-| Creates an input with [type="date"].
-}
date : String -> Config msg
date =
    config Date


{-| Creates an input with [type="number"].
-}
number : String -> Config msg
number =
    config Number


{-| Creates an input with [type="text"].
-}
text : String -> Config msg
text =
    config Text


{-| Creates an input with [type="password"].
-}
password : String -> Config msg
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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config msg -> Config msg
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Maps the inputted string before the update
-}
withValueMapper : (String -> String) -> Config msg -> Config msg
withValueMapper mapper (Config configData) =
    Config { configData | valueMapper = mapper }


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config msg -> Config msg
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


{-| Sets an Addon to the Input.
-}
withAddon : Placement -> AddonType -> Config msg -> Config msg
withAddon placement type_ (Config configuration) =
    Config { configuration | addon = Just { placement = placement, type_ = type_ } }


{-| Adds a Label to the Input.
-}
withLabel : Label.Config -> Config msg -> Config msg
withLabel a (Config configuration) =
    Config { configuration | label = Just a }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets the input hint
-}
withHint : String -> Config msg -> Config msg
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


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config msg -> Config msg
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = Just additionalContent }


{-| Sets the input value attribute
-}
setValue : String -> Model ctx value -> Model ctx value
setValue value (Model configuration) =
    Model { configuration | value = value }


{-| Internal
-}
normalizeConfig : Config msg -> Config msg
normalizeConfig ((Config configData) as config_) =
    case configData.type_ of
        Date ->
            config_
                |> withAddon Placement.prepend (iconAddon IconSet.Calendar)

        _ ->
            config_


{-| Renders the Input.Stories/Chapters/DateField.elm
-}
render : (Msg -> msg) -> ctx -> Model ctx value -> Config msg -> Html msg
render tagger ctx ((Model modelData) as model) rawConfig =
    let
        ((Config configData) as config_) =
            normalizeConfig rawConfig

        shownValidation : Result String ()
        shownValidation =
            StrategyInternal.getShownValidation
                modelData.fieldState
                (modelData.validation ctx modelData.value)
                configData.isSubmitted
                configData.strategy
    in
    renderField shownValidation config_ model
        |> Html.map tagger
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation


{-| Internal.
-}
renderField : Result String () -> Config msg -> Model ctx value -> Html Msg
renderField shownValidation ((Config { disabled, addon }) as configuration) model =
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
renderAddon : Result String () -> Model ctx value -> Config msg -> Addon -> Html Msg
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
renderInput : Result String () -> Model ctx value -> Config msg -> Html Msg
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


{-| Internal
-}
mapFieldState : (FieldState.State -> FieldState.State) -> Model ctx value -> Model ctx value
mapFieldState f (Model model) =
    Model { model | fieldState = f model.fieldState }
