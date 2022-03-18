module Components.Field.RadioGroup exposing
    ( Model
    , init
    , Config
    , config
    , Layout
    , horizontal
    , vertical
    , withLayout
    , withIsSubmitted
    , withStrategy
    , withAdditionalContent
    , withClassList
    , withDisabled
    , withHint
    , withLabel
    , withName
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , Option
    , option
    , withOptions
    , render
    )

{-|


# Input RadioGroup component


## Model

@docs Model
@docs init


## Config

@docs Config
@docs config


# Layout

@docs Layout
@docs horizontal
@docs vertical
@docs withLayout
@docs withIsSubmitted
@docs withStrategy


## Generics

@docs withAdditionalContent
@docs withClassList
@docs withDisabled
@docs withHint
@docs withLabel
@docs withName


## Update

@docs Msg
@docs isOnCheck
@docs update
@docs validate


## Readers

@docs getValue


## Options

@docs Option
@docs option
@docs withOptions


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.String
import Components.Field.Error as Error
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as InternalStrategy
import Components.Field.FormItem as FormItem
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.State as FieldState
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Result.Extra


{-| The RadioGroup model.
-}
type Model ctx value parsed
    = Model
        { selectedValue : Maybe value
        , validation : ctx -> Maybe value -> Result String parsed
        , fieldState : FieldState.State
        }


{-| Initialize the RadioGroup Model.
-}
init : Maybe value -> (ctx -> Maybe value -> Result String parsed) -> Model ctx value parsed
init initialValue validation =
    Model
        { selectedValue = initialValue
        , validation = validation
        , fieldState = FieldState.Untouched
        }


type alias ConfigData value msg =
    { additionalContent : Maybe (Html msg)
    , classList : List ( String, Bool )
    , hint : Maybe Hint.Config
    , id : String
    , isDisabled : Bool
    , isSubmitted : Bool
    , label : Maybe Label.Config
    , layout : Layout
    , name : Maybe String
    , options : List (Option value)
    , strategy : Strategy
    }


{-| The RadioGroup configuration.
-}
type Config value msg
    = Config (ConfigData value msg)


{-| Initialize the RadioGroup Config.
-}
config : String -> Config value msg
config id =
    Config
        { additionalContent = Nothing
        , classList = []
        , hint = Nothing
        , id = id
        , isDisabled = False
        , isSubmitted = False
        , label = Nothing
        , layout = Horizontal
        , name = Nothing
        , options = []
        , strategy = Strategy.onBlur
        }


{-| Represent the single Radio option.
-}
type Option value
    = Option (OptionConfig value)


{-| Internal.
-}
type alias OptionConfig value =
    { value : value
    , label : String
    }


{-| Represent the messages which the RadioGroup can handle.
-}
type Msg value
    = OnCheck value
    | Focused value
    | Blurred value


{-| Returns True if the message is triggered by `Html.Events.onCheck`
-}
isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        OnCheck _ ->
            True

        _ ->
            False


{-| Represent the layout of the group.
-}
type Layout
    = Horizontal
    | Vertical


{-| Horizontal layout.
-}
horizontal : Layout
horizontal =
    Horizontal


{-| Vertical layout.
-}
vertical : Layout
vertical =
    Vertical


{-| Add the classes to the group wrapper.
-}
withClassList : List ( String, Bool ) -> Config value msg -> Config value msg
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Define if the group is disabled or not.
-}
withDisabled : Bool -> Config value msg -> Config value msg
withDisabled isDisabled (Config configuration) =
    Config { configuration | isDisabled = isDisabled }


{-| Adds the hint to the RadioGroup.
-}
withHint : String -> Config value msg -> Config value msg
withHint hintMessage (Config configuration) =
    Config
        { configuration
            | hint =
                Hint.config hintMessage
                    |> Hint.withFieldId configuration.id
                    |> Just
        }


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config value msg -> Config value msg
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config value msg -> Config value msg
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


{-| Add a name to the inputs.
-}
withName : String -> Config value msg -> Config value msg
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Add a label to the inputs.
-}
withLabel : Label.Config -> Config value msg -> Config value msg
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


{-| Define the visible options in the radio group.
-}
withOptions : List (Option value) -> Config value msg -> Config value msg
withOptions options (Config configuration) =
    Config { configuration | options = options }


{-| Change the visual layout. The default one is horizontal.
-}
withLayout : Layout -> Config value msg -> Config value msg
withLayout layout (Config configuration) =
    Config { configuration | layout = layout }


{-| Append an additional custom html.
-}
withAdditionalContent : Html msg -> Config value msg -> Config value msg
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = Just additionalContent }


{-| Generate a Radio Option
-}
option : OptionConfig value -> Option value
option =
    Option


{-| Render the RadioGroup.
-}
render : (Msg value -> msg) -> ctx -> Model ctx value parsed -> Config value msg -> Html.Html msg
render tagger ctx ((Model modelData) as model) ((Config configData) as configuration) =
    let
        shownValidation : Result String ()
        shownValidation =
            InternalStrategy.getShownValidation
                modelData.fieldState
                (modelData.validation ctx modelData.selectedValue)
                configData.isSubmitted
                configData.strategy
    in
    renderField shownValidation model configuration
        |> Html.map tagger
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation


renderField : Result String () -> Model ctx value parsed -> Config value msg -> Html.Html (Msg value)
renderField shownValidation model ((Config configData) as configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-control-group", True )
            , ( "form-control-group--column", configData.layout == Vertical )
            ]
        , Attributes.classList configData.classList
        , Attributes.id configData.id
        , Commons.Attributes.role "radiogroup"
        , Commons.Attributes.ariaLabelledbyBy (labelId configData.id)
        , shownValidation
            |> Error.fromResult
            |> Maybe.map (always (Error.toId configData.id))
            |> Commons.Attributes.ariaDescribedByErrorOrHint
                (Maybe.map (always (Hint.toId configData.id)) configData.hint)
        ]
        (List.map (renderRadio shownValidation model configuration) configData.options)


{-| Internal.
-}
labelId : String -> String
labelId =
    (++) "label-"


{-| Internal.
-}
renderRadio : Result String x -> Model ctx value parsed -> Config value msg -> Option value -> Html.Html (Msg value)
renderRadio validationResult (Model { validation, selectedValue }) (Config { id, name, isDisabled }) (Option { value, label }) =
    Html.label
        [ Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", Result.Extra.isErr validationResult )
            ]
        ]
        [ Html.input
            [ Attributes.type_ "radio"
            , Attributes.classList [ ( "form-control__radio", True ) ]
            , Attributes.checked (selectedValue == Just value)
            , Attributes.disabled isDisabled
            , Attributes.id (radioId id label)
            , Commons.Attributes.testId (radioId id label)
            , Commons.Attributes.maybe Attributes.name name
            , Events.onCheck (always (OnCheck value))
            , Events.onFocus (Focused value)
            , Events.onBlur (Blurred value)
            ]
            []
        , Html.text label
        ]


{-| Internal.
-}
radioId : String -> String -> String
radioId id label =
    [ id, label |> Commons.String.toKebabCase, "option" ]
        |> String.join "-"


{-| Update the RadioGroup Model.
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg model =
    case msg of
        OnCheck value ->
            model
                |> setValue value
                |> mapFieldState FieldState.onChange

        Blurred _ ->
            model
                |> mapFieldState FieldState.onBlur

        Focused _ ->
            model
                |> mapFieldState FieldState.onFocus


{-| Set the radiogroup value
-}
setValue : value -> Model ctx value parsed -> Model ctx value parsed
setValue value (Model model) =
    Model { model | selectedValue = Just value }


{-| Internal
-}
mapFieldState : (FieldState.State -> FieldState.State) -> Model ctx value parsed -> Model ctx value parsed
mapFieldState f (Model model) =
    Model { model | fieldState = f model.fieldState }


{-| Return the selected value.
-}
getValue : Model ctx value parsed -> Maybe value
getValue (Model { selectedValue }) =
    selectedValue


{-| Get the (parsed) value
-}
validate : ctx -> Model ctx value parsed -> Result String parsed
validate ctx (Model { selectedValue, validation }) =
    validation ctx selectedValue
