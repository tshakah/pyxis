module Components.Field.Textarea exposing
    ( Model
    , init
    , Config
    , config
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
    , validate
    , getValue
    , render
    )

{-|


# Textarea component

@docs Model
@docs init


## Config

@docs Config
@docs config


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
@docs withIsSubmitted
@docs withValueMapper


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update
@docs validate


## Readers

@docs getValue


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Size as Size exposing (Size)
import Components.Field.Error as Error
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as StrategyInternal
import Components.Field.FormItem as FormItem
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.State as FieldState
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Result.Extra


{-| The Textarea model.
-}
type Model ctx
    = Model (ModelData ctx)


{-| Internal.
-}
type alias ModelData ctx =
    { value : String
    , validation : ctx -> String -> Result String String
    , fieldState : FieldState.State
    }


{-| Initializes the Textarea model.
-}
init : String -> (ctx -> String -> Result String String) -> Model ctx
init initialValue validation =
    Model
        { value = initialValue
        , validation = validation
        , fieldState = FieldState.Untouched
        }


{-| The view configuration.
-}
type Config
    = Config ConfigData


{-| Internal.
-}
type alias ConfigData =
    { additionalContent : Maybe (Html Never)
    , classList : List ( String, Bool )
    , disabled : Bool
    , hint : Maybe Hint.Config
    , id : String
    , name : Maybe String
    , placeholder : Maybe String
    , size : Size
    , label : Maybe Label.Config
    , strategy : Strategy
    , isSubmitted : Bool
    , valueMapper : String -> String
    }


{-| Creates a Textarea.
-}
config : String -> Config
config id =
    Config
        { additionalContent = Nothing
        , classList = []
        , disabled = False
        , hint = Nothing
        , id = id
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , label = Nothing
        , strategy = Strategy.onBlur
        , isSubmitted = False
        , valueMapper = identity
        }


{-| Adds a Label to the Textarea.
-}
withLabel : Label.Config -> Config -> Config
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


{-| Sets the Textarea as disabled
-}
withDisabled : Bool -> Config -> Config
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Adds the hint to the TextArea.
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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config -> Config
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Maps the inputted string before the update

    Textarea.config "id"
        |> Textarea.withValueMapper String.toUppercase
        |> Textarea.render Tagger formData model.textareaModel

In this example, if the user inputs "abc", the actual inputted text is "ABC".
This applies to both the user UI and the `getValue`/`validate` functions

-}
withValueMapper : (String -> String) -> Config -> Config
withValueMapper mapper (Config configData) =
    Config { configData | valueMapper = mapper }


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config -> Config
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


{-| Sets a Size to the Textarea
-}
withSize : Size -> Config -> Config
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets a ClassList to the Textarea
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Sets a Name to the Textarea
-}
withName : String -> Config -> Config
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Sets a Placeholder to the Textarea
-}
withPlaceholder : String -> Config -> Config
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = Just placeholder }


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config -> Config
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = Just additionalContent }


{-| Represent the messages which the Textarea can handle.
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


{-| The update function.
-}
update : Msg -> Model ctx -> Model ctx
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


{-| Internal.
-}
setValue : String -> Model ctx -> Model ctx
setValue value (Model data) =
    Model { data | value = value }


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx -> Result String String
validate ctx (Model { validation, value }) =
    validation ctx value


{-| Returns the current value of the Textarea.
-}
getValue : Model ctx -> String
getValue (Model { value }) =
    value


{-| Renders the Textarea.
-}
render : (Msg -> msg) -> ctx -> Model ctx -> Config -> Html msg
render tagger ctx ((Model modelData) as model) ((Config configData) as configuration) =
    let
        customizedLabel : Maybe Label.Config
        customizedLabel =
            Maybe.map (Label.withSize configData.size) configData.label

        shownValidation : Result String ()
        shownValidation =
            StrategyInternal.getShownValidation
                modelData.fieldState
                (modelData.validation ctx modelData.value)
                configData.isSubmitted
                configData.strategy
    in
    configuration
        |> renderTextarea shownValidation model
        |> Html.map tagger
        |> FormItem.config configData
        |> FormItem.withLabel customizedLabel
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation


{-| Internal.
-}
renderTextarea : Result String value -> Model ctx -> Config -> Html Msg
renderTextarea validationResult (Model modelData) (Config configData) =
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--error", Result.Extra.isErr validationResult )
            , ( "form-field--disabled", configData.disabled )
            ]
        ]
        [ Html.textarea
            [ Attributes.id configData.id
            , Attributes.classList
                [ ( "form-field__textarea", True )
                , ( "form-field__textarea--small", Size.isSmall configData.size )
                ]
            , Attributes.classList configData.classList
            , Attributes.disabled configData.disabled
            , Attributes.value modelData.value
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
        ]


{-| Internal
-}
mapFieldState : (FieldState.State -> FieldState.State) -> Model ctx -> Model ctx
mapFieldState f (Model model) =
    Model { model | fieldState = f model.fieldState }
