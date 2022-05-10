module Pyxis.Components.Field.Autocomplete exposing
    ( Model
    , init
    , Config
    , config
    , withAdditionalContent
    , withDisabled
    , withHint
    , withIsSubmitted
    , withLabel
    , withNoResultsFoundMessage
    , withPlaceholder
    , withStrategy
    , withId
    , Size
    , small
    , medium
    , withSize
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

@docs withNoResultsFoundMessage
@docs withPlaceholder
@docs withStrategy
@docs withId


## Size

@docs Size
@docs small
@docs medium
@docs withSize


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

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Http
import Maybe.Extra
import Pyxis.Commons.Attributes as CommonsAttributes
import Pyxis.Commons.Render as CommonsRender
import Pyxis.Components.Field.Error as Error
import Pyxis.Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Pyxis.Components.Field.Error.Strategy.Internal as StrategyInternal
import Pyxis.Components.Field.Hint as Hint
import Pyxis.Components.Field.Label as Label
import Pyxis.Components.Field.Status as Status
import Pyxis.Components.Form.Dropdown as FormDropdown
import Pyxis.Components.Form.FormItem as FormItem
import Pyxis.Components.Icon as Icon
import Pyxis.Components.IconSet as IconSet
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


{-| Autocomplete size
-}
type Size
    = Small
    | Medium


{-| Autocomplete size small
-}
small : Size
small =
    Small


{-| Autocomplete size medium
-}
medium : Size
medium =
    Medium


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
        , name : String
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
config optionsFilter optionToString name =
    Config
        { additionalContent = Nothing
        , disabled = False
        , addonHeader = Nothing
        , hint = Nothing
        , id = "id-" ++ name
        , isSubmitted = False
        , label = Nothing
        , name = name
        , noResultsFoundMessage = "No results found."
        , addonAction = Nothing
        , addonSuggestion = Nothing
        , placeholder = ""
        , strategy = Strategy.onBlur
        , size = Medium
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


{-| Adds an id to the Autocomplete.
-}
withId : String -> Config value msg -> Config value msg
withId id (Config configData) =
    Config { configData | id = id }


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
        [ Html.Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--with-opened-dropdown", modelData.dropdownOpen && Maybe.Extra.isJust dropdown )
            , ( "form-field--error", Result.Extra.isErr shownValidation )
            , ( "form-field--disabled", configData.disabled )
            ]

        {--The onBlur event should be set at this level in order to allow option selection.
        Setting it to the input element causes dropdown items flashing. --}
        , Html.Events.onBlur (msgMapper OnBlur)
        ]
        [ renderField shownValidation msgMapper model configuration
        , CommonsRender.renderMaybe dropdown
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
        [ Html.Attributes.class "form-field__wrapper" ]
        [ Html.input
            [ Html.Attributes.classList
                [ ( "form-field__autocomplete", True )
                , ( "form-field__autocomplete--small", Small == configData.size )
                , ( "form-field__autocomplete--filled", Maybe.Extra.isJust modelData.value )
                ]

            {--Remove this onBlur--}
            , Html.Events.onBlur OnBlur
            , Html.Events.onFocus OnFocus
            , Html.Events.onInput OnInput
            , Html.Attributes.id configData.id
            , Html.Attributes.name configData.name
            , Html.Attributes.attribute "aria-autocomplete" "both"
            , CommonsAttributes.renderIf modelData.dropdownOpen (Html.Attributes.attribute "aria-expanded" "true")
            , Html.Attributes.attribute "role" "combobox"
            , Html.Attributes.attribute "aria-owns" (configData.id ++ "-dropdown-list")
            , Html.Attributes.autocomplete False
            , Html.Attributes.disabled configData.disabled
            , Html.Attributes.placeholder configData.placeholder
            , Html.Attributes.type_ "text"
            , CommonsAttributes.testId configData.id
            , modelData.value
                |> Maybe.map configData.optionToString
                |> Maybe.withDefault modelData.filter
                |> Html.Attributes.value
                |> CommonsAttributes.renderIf (not modelData.filtering)
            , modelData.filter
                |> Html.Attributes.value
                |> CommonsAttributes.renderIf modelData.filtering
            , validationResult
                |> Error.fromResult
                |> Maybe.map (always (Error.toId configData.id))
                |> CommonsAttributes.ariaDescribedByErrorOrHint
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
        [ Html.Attributes.class "form-field__addon"
        ]
        [ model
            |> getFieldAddonIcon
            |> Icon.withSize Icon.small
            |> Icon.render
            |> CommonsRender.renderIf (Maybe.Extra.isNothing modelData.value)
        , Html.button
            [ Html.Attributes.class "form-field__addon__reset"
            , Html.Events.onClick OnReset
            ]
            [ model
                |> getFieldAddonIcon
                |> Icon.withSize Icon.small
                |> Icon.render
            ]
            |> CommonsRender.renderIf (Maybe.Extra.isJust modelData.value)
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
    in
    if String.isEmpty modelData.filter then
        configData.addonSuggestion
            |> Maybe.map FormDropdown.suggestion
            |> Maybe.map (FormDropdown.render configData.id (msgMapper OnBlur) (mapDropdownSize configData.size))

    else
        FormDropdown.render
            configData.id
            (msgMapper OnBlur)
            (mapDropdownSize configData.size)
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
        [ Html.Attributes.class "form-dropdown__item"
        , option
            |> OnSelect
            |> msgMapper
            |> Html.Events.onClick
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
    let
        matchStartIndex : Int
        matchStartIndex =
            label
                |> String.toLower
                |> String.indexes (String.toLower filter)
                |> List.head
                |> Maybe.withDefault 0

        matchEndIndex : Int
        matchEndIndex =
            matchStartIndex + String.length filter

        labelStart : String
        labelStart =
            String.slice 0 matchStartIndex label

        labelCenter : String
        labelCenter =
            String.slice matchStartIndex matchEndIndex label

        labelEnd : String
        labelEnd =
            String.slice matchEndIndex (String.length label) label
    in
    [ Html.strong [ Html.Attributes.class "text-m-bold" ] [ Html.text labelStart ]
    , Html.text labelCenter
    , Html.strong [ Html.Attributes.class "text-m-bold" ] [ Html.text labelEnd ]
    ]


mapDropdownSize : Size -> FormDropdown.Size
mapDropdownSize size =
    case size of
        Small ->
            FormDropdown.small

        Medium ->
            FormDropdown.medium
