module Components.Field.Autocomplete exposing
    ( Model
    , init
    , Config
    , config
    , withAdditionalContent
    , withDisabled
    , withHint
    , withIsSubmitted
    , withLabel
    , withName
    , withNoResultsFoundMessage
    , withPlaceholder
    , withSize
    , withStrategy
    , withAddonAction
    , withAddonHeader
    , withAddonSuggestion
    , Msg
    , update
    , setOptions
    , validate
    , isOnInput
    , isOnSelect
    , isOnReset
    , getValue
    , getFilter
    , render
    )

{-|


# Autocomplete

@docs Model
@docs init


## Configuration

@docs Config
@docs config


## Generics

@docs withAdditionalContent
@docs withDisabled
@docs withHint
@docs withIsSubmitted
@docs withLabel
@docs withName

@docs withNoResultsFoundMessage
@docs withPlaceholder
@docs withSize
@docs withStrategy


## Suggestions Addon

@docs withAddonAction
@docs withAddonHeader
@docs withAddonSuggestion


## Update

@docs Msg
@docs update
@docs setOptions
@docs validate
@docs isOnInput
@docs isOnSelect
@docs isOnReset


## Readers

@docs getValue
@docs getFilter


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render
import Components.Field.Error as Error
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as StrategyInternal
import Components.Field.FormItem as FormItem
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.Status as Status
import Components.Form.Dropdown as FormDropdown
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Http
import Maybe.Extra
import RemoteData exposing (RemoteData)
import Result.Extra


{-| Represents the Autocomplete state.
-}
type Model ctx value
    = Model
        { dropdownOpen : Bool
        , fieldState : Status.Status
        , filter : String
        , filtering : Bool
        , options : RemoteData Http.Error (List value)
        , validation : ctx -> Maybe value -> Result String value
        , value : Maybe value
        }


{-| Initializes the Autocomplete state.
-}
init : Maybe value -> (ctx -> Maybe value -> Result String value) -> Model ctx value
init value validation =
    Model
        { dropdownOpen = False
        , fieldState = Status.Untouched
        , filter = ""
        , filtering = False
        , options = RemoteData.NotAsked
        , validation = validation
        , value = value
        }


{-| Allow to updates the options list.
-}
setOptions : RemoteData Http.Error (List value) -> Model ctx value -> Model ctx value
setOptions optionsRemoteData (Model modelData) =
    Model { modelData | options = optionsRemoteData, dropdownOpen = True }


{-| Represents the Autocomplete message.
-}
type Msg value
    = OnBlur
    | OnFocus
    | OnInput String
    | OnReset
    | OnSelect value


{-| Tells if the Autocomplete is currently filtering options or at least the filter has been modified.
-}
isOnInput : Msg value -> Bool
isOnInput msg =
    case msg of
        OnInput _ ->
            True

        _ ->
            False


{-| Tells if the Autocomplete is currently selecting a option.
-}
isOnSelect : Msg value -> Bool
isOnSelect msg =
    case msg of
        OnSelect _ ->
            True

        _ ->
            False


{-| Tells if the Autocomplete filter has been erased by reset icon click..
-}
isOnReset : Msg value -> Bool
isOnReset msg =
    case msg of
        OnReset ->
            True

        _ ->
            False


{-| Updates the Autocomplete.
-}
update : Msg value -> Model ctx value -> Model ctx value
update msg (Model modelData) =
    case msg of
        OnBlur ->
            Model
                { modelData
                    | filtering = False
                    , dropdownOpen = False
                }
                |> mapFieldState Status.onBlur

        OnFocus ->
            Model
                { modelData
                    | dropdownOpen = True
                }
                |> mapFieldState Status.onFocus

        OnInput value ->
            Model
                { modelData
                    | filter = value
                    , filtering = True
                }
                |> mapFieldState Status.onInput

        OnReset ->
            modelData.validation
                |> init Nothing
                |> mapFieldState Status.onInput

        OnSelect value ->
            Model
                { modelData
                    | value = Just value
                    , filtering = False
                    , dropdownOpen = False
                }
                |> mapFieldState Status.onInput


{-| Return the input value
-}
getValue : Model ctx value -> Maybe value
getValue (Model { value }) =
    value


{-| Return the input value
-}
getFilter : Model ctx value -> String
getFilter (Model { filter }) =
    filter


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx value -> Result String value
validate ctx (Model { validation, value }) =
    validation ctx value


{-| Internal.
-}
mapFieldState : (Status.Status -> Status.Status) -> Model ctx value -> Model ctx value
mapFieldState f (Model modelData) =
    Model { modelData | fieldState = f modelData.fieldState }


{-| Internal.
-}
getOptions : Model ctx value -> Config value msg -> List value
getOptions (Model modelData) (Config configData) =
    modelData.options
        |> RemoteData.toMaybe
        |> Maybe.withDefault []
        |> List.filter (configData.optionsFilter modelData.filter)


{-| Represents the Autocomplete view configuration.
-}
type Config value msg
    = Config
        { additionalContent : Maybe (Html Never)
        , disabled : Bool
        , addonHeader : Maybe String
        , hint : Maybe Hint.Config
        , id : String
        , isSubmitted : Bool
        , label : Maybe Label.Config
        , name : Maybe String
        , noResultsFoundMessage : String
        , addonAction : Maybe (Html msg)
        , addonSuggestion : Maybe FormDropdown.SuggestionData
        , placeholder : String
        , size : Size
        , strategy : Strategy
        , optionsFilter : String -> value -> Bool
        , optionToString : value -> String
        }


{-| Creates the Autocomplete view configuration..
-}
config : (String -> value -> Bool) -> (value -> String) -> String -> Config value msg
config optionsFilter optionToString id =
    Config
        { additionalContent = Nothing
        , disabled = False
        , addonHeader = Nothing
        , hint = Nothing
        , id = id
        , isSubmitted = False
        , label = Nothing
        , name = Nothing
        , noResultsFoundMessage = "No results found."
        , addonAction = Nothing
        , addonSuggestion = Nothing
        , placeholder = ""
        , strategy = Strategy.onBlur
        , size = Size.medium
        , optionsFilter = optionsFilter
        , optionToString = optionToString
        }


{-| Add an addon which suggest or help the user during search.
Will be prepended to options.
-}
withAddonHeader : String -> Config value msg -> Config value msg
withAddonHeader addonHeader (Config configData) =
    Config { configData | addonHeader = Just addonHeader }


{-| Add an addon with a call to action to be shown when no options are found.
-}
withAddonAction : Html msg -> Config value msg -> Config value msg
withAddonAction addonAction (Config configData) =
    Config { configData | addonAction = Just addonAction }


{-| Add an addon which suggest or help the user during search.
Will be appended to options.
-}
withAddonSuggestion : FormDropdown.SuggestionData -> Config value msg -> Config value msg
withAddonSuggestion addonSuggestion (Config configData) =
    Config { configData | addonSuggestion = Just addonSuggestion }


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config value msg -> Config value msg
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = Just additionalContent }


{-| Sets whether the Autocomplete is disabled.
-}
withDisabled : Bool -> Config value msg -> Config value msg
withDisabled disabled (Config configuration) =
    Config { configuration | disabled = disabled }


{-| Sets the Autocomplete hint.
-}
withHint : String -> Config value msg -> Config value msg
withHint hintMessage (Config configuration) =
    Config
        { configuration
            | hint =
                hintMessage
                    |> Hint.config
                    |> Hint.withFieldId configuration.id
                    |> Just
        }


{-| Sets whether the form was submitted.
-}
withIsSubmitted : Bool -> Config value msg -> Config value msg
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


{-| Adds a label to the Autocomplete.
-}
withLabel : Label.Config -> Config value msg -> Config value msg
withLabel label (Config configData) =
    Config { configData | label = Just label }


{-| Adds a name to the Autocomplete.
-}
withName : String -> Config value msg -> Config value msg
withName name (Config configData) =
    Config { configData | name = Just name }


{-| Adds custom message instead of the default "No results found".
-}
withNoResultsFoundMessage : String -> Config value msg -> Config value msg
withNoResultsFoundMessage message (Config configuration) =
    Config { configuration | noResultsFoundMessage = message }


{-| Sets the Autocomplete placeholder.
-}
withPlaceholder : String -> Config value msg -> Config value msg
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = placeholder }


{-| Sets the Autocomplete size.
-}
withSize : Size -> Config value msg -> Config value msg
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets the validation strategy (when to show the error, if present).
-}
withStrategy : Strategy -> Config value msg -> Config value msg
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Renders the Autocomplete.
-}
render : (Msg value -> msg) -> ctx -> Model ctx value -> Config value msg -> Html msg
render msgMapper ctx ((Model modelData) as model) ((Config configData) as configuration) =
    let
        shownValidation : Result String ()
        shownValidation =
            StrategyInternal.getShownValidation
                modelData.fieldState
                (modelData.validation ctx modelData.value)
                configData.isSubmitted
                configData.strategy

        dropdown : Maybe (Html msg)
        dropdown =
            renderDropdown msgMapper model configuration
    in
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--with-opened-dropdown", modelData.dropdownOpen && Maybe.Extra.isJust dropdown )
            , ( "form-field--error", Result.Extra.isErr shownValidation )
            , ( "form-field--disabled", configData.disabled )
            ]

        {--The onBlur event should be set at this level in order to allow option selection.
        Setting it to the input element causes dropdown items flashing. --}
        , Events.onBlur (msgMapper OnBlur)
        ]
        [ renderField shownValidation msgMapper model configuration
        , Commons.Render.renderMaybe dropdown
        ]
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation


{-| Internal.
-}
renderField : Result String () -> (Msg value -> msg) -> Model ctx value -> Config value msg -> Html msg
renderField validationResult msgMapper ((Model modelData) as model) (Config configData) =
    Html.label
        [ Attributes.class "form-field__wrapper" ]
        [ Html.input
            [ Attributes.classList
                [ ( "form-field__autocomplete", True )
                , ( "form-field__autocomplete--small", Size.isSmall configData.size )
                , ( "form-field__autocomplete--filled", Maybe.Extra.isJust modelData.value )
                ]

            {--Remove this onBlur--}
            , Events.onBlur OnBlur
            , Events.onFocus OnFocus
            , Events.onInput OnInput
            , Attributes.id configData.id
            , Commons.Attributes.maybe Attributes.name configData.name
            , Attributes.attribute "aria-autocomplete" "both"
            , Commons.Attributes.renderIf modelData.dropdownOpen (Attributes.attribute "aria-expanded" "true")
            , Attributes.attribute "role" "combobox"
            , Attributes.attribute "aria-owns" (configData.id ++ "-dropdown-list")
            , Attributes.autocomplete False
            , Attributes.disabled configData.disabled
            , Attributes.placeholder configData.placeholder
            , Attributes.type_ "text"
            , Commons.Attributes.testId configData.id
            , modelData.value
                |> Maybe.map configData.optionToString
                |> Maybe.withDefault modelData.filter
                |> Attributes.value
                |> Commons.Attributes.renderIf (not modelData.filtering)
            , modelData.filter
                |> Attributes.value
                |> Commons.Attributes.renderIf modelData.filtering
            , validationResult
                |> Error.fromResult
                |> Maybe.map (always (Error.toId configData.id))
                |> Commons.Attributes.ariaDescribedByErrorOrHint
                    (Maybe.map (always (Hint.toId configData.id)) configData.hint)
            ]
            []
        , renderFieldIconAddon model
        ]
        |> Html.map msgMapper


{-| Internal.
-}
renderFieldIconAddon : Model ctx value -> Html (Msg value)
renderFieldIconAddon ((Model modelData) as model) =
    Html.div
        [ Attributes.class "form-field__addon"
        ]
        [ model
            |> getFieldAddonIcon
            |> Icon.withSize Size.small
            |> Icon.render
            |> Commons.Render.renderIf (Maybe.Extra.isNothing modelData.value)
        , Html.button
            [ Attributes.class "form-field__addon__reset"
            , Events.onClick OnReset
            ]
            [ model
                |> getFieldAddonIcon
                |> Icon.withSize Size.small
                |> Icon.render
            ]
            |> Commons.Render.renderIf (Maybe.Extra.isJust modelData.value)
        ]


{-| Internal.
-}
getFieldAddonIcon : Model ctx value -> Icon.Config
getFieldAddonIcon (Model modelData) =
    if RemoteData.isLoading modelData.options then
        IconSet.Loader
            |> Icon.config
            |> Icon.withSpinner True

    else if Maybe.Extra.isJust modelData.value then
        Icon.config IconSet.Close

    else
        Icon.config IconSet.Search


{-| Internal.
-}
renderDropdown : (Msg value -> msg) -> Model ctx value -> Config value msg -> Maybe (Html msg)
renderDropdown msgMapper ((Model modelData) as model) ((Config configData) as configuration) =
    let
        renderedOptions : List (Html msg)
        renderedOptions =
            configuration
                |> getOptions model
                |> List.map (renderOptionsItem msgMapper model configuration)

        noAvailableOptions : Bool
        noAvailableOptions =
            List.length (getOptions model configuration) == 0 && RemoteData.isSuccess modelData.options

        nothingRetrievedYet : Bool
        nothingRetrievedYet =
            List.length (getOptions model configuration) == 0 && RemoteData.isNotAsked modelData.options
    in
    if nothingRetrievedYet then
        configData.addonSuggestion
            |> Maybe.map FormDropdown.suggestion
            |> Maybe.map (FormDropdown.render configData.id (msgMapper OnBlur))

    else
        FormDropdown.render
            configData.id
            (msgMapper OnBlur)
            (if noAvailableOptions then
                FormDropdown.noResult
                    { label = configData.noResultsFoundMessage
                    , action = configData.addonAction
                    }

             else
                case
                    ( configData.addonHeader
                    , configData.addonSuggestion
                    )
                of
                    ( Just headerLabel, _ ) ->
                        FormDropdown.headerAndOptions
                            { header = Html.text headerLabel
                            , options = renderedOptions
                            }

                    ( Nothing, Just suggestionConfig ) ->
                        if not (RemoteData.isSuccess modelData.options) && String.isEmpty modelData.filter then
                            FormDropdown.suggestion suggestionConfig

                        else
                            FormDropdown.options renderedOptions

                    ( Nothing, Nothing ) ->
                        FormDropdown.options renderedOptions
            )
            |> Just


{-| Internal.
-}
renderOptionsItem : (Msg value -> msg) -> Model ctx value -> Config value msg -> value -> Html msg
renderOptionsItem msgMapper (Model modelData) (Config configData) option =
    Html.div
        [ Attributes.class "form-dropdown__item"
        , option
            |> OnSelect
            |> msgMapper
            |> Events.onClick
        ]
        [ option
            |> configData.optionToString
            |> String.trim
            |> renderOptionText modelData.filter
            |> Html.span []
        ]


{-| Internal.
-}
renderOptionText : String -> String -> List (Html msg)
renderOptionText filter label =
    label
        |> String.split filter
        |> List.map Html.text
        |> List.intersperse (Html.strong [ Attributes.class "text-m-bold" ] [ Html.text filter ])
