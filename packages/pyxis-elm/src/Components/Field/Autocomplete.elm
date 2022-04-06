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
    , Addon
    , headerAddon
    , noResultsActionAddon
    , suggestionAddon
    , withAddon
    , Msg
    , update
    , setSuggestions
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

@docs Addon
@docs headerAddon
@docs noResultsActionAddon
@docs suggestionAddon
@docs withAddon


## Update

@docs Msg
@docs update
@docs setSuggestions
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
import Components.Button as Button
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
        , suggestions : RemoteData Http.Error (List value)
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
        , suggestions = RemoteData.NotAsked
        , validation = validation
        , value = value
        }


{-| Allow to updates the suggestions list.
-}
setSuggestions : RemoteData Http.Error (List value) -> Model ctx value -> Model ctx value
setSuggestions suggestionsRemoteData (Model modelData) =
    Model { modelData | suggestions = suggestionsRemoteData, dropdownOpen = True }


{-| Represents the Autocomplete message.
-}
type Msg value
    = OnBlur
    | OnFocus
    | OnInput String
    | OnReset
    | OnSelect value


{-| Tells if the Autocomplete is currently filtering suggestions or at least the filter has been modified.
-}
isOnInput : Msg value -> Bool
isOnInput msg =
    case msg of
        OnInput _ ->
            True

        _ ->
            False


{-| Tells if the Autocomplete is currently selecting a suggestion.
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
getSuggestions : Model ctx value -> Config value msg -> List value
getSuggestions (Model modelData) (Config configData) =
    modelData.suggestions
        |> RemoteData.toMaybe
        |> Maybe.withDefault []
        |> List.filter (configData.suggestionsFilter modelData.filter)


{-| Represents the Autocomplete view configuration.
-}
type Config value msg
    = Config
        { additionalContent : Maybe (Html Never)
        , addon : Maybe (Addon msg)
        , disabled : Bool
        , hint : Maybe Hint.Config
        , id : String
        , isSubmitted : Bool
        , label : Maybe Label.Config
        , name : Maybe String
        , noResultsFoundMessage : String
        , placeholder : String
        , size : Size
        , strategy : Strategy
        , suggestionsFilter : String -> value -> Bool
        , suggestionToString : value -> String
        }


{-| Creates the Autocomplete view configuration..
-}
config : (String -> value -> Bool) -> (value -> String) -> String -> Config value msg
config suggestionsFilter suggestionRenderer id =
    Config
        { additionalContent = Nothing
        , addon = Nothing
        , disabled = False
        , hint = Nothing
        , id = id
        , isSubmitted = False
        , label = Nothing
        , name = Nothing
        , noResultsFoundMessage = "No results found."
        , placeholder = ""
        , strategy = Strategy.onBlur
        , size = Size.medium
        , suggestionsFilter = suggestionsFilter
        , suggestionToString = suggestionRenderer
        }


{-| Represents an Autocomplete addon.
-}
type Addon msg
    = Header String
    | NoResultAction (Button.Config () msg)
    | Suggestion { icon : IconSet.Icon, title : String, subtitle : Maybe String }


{-| Creates an addon which suggest or help the user during search.
Will be prepended to suggestions.
-}
headerAddon : String -> Addon msg
headerAddon =
    Header


{-| Creates an addon with a call to action to be shown when no suggestions are found.
-}
noResultsActionAddon : Button.Config () msg -> Addon msg
noResultsActionAddon =
    NoResultAction


{-| Creates an addon which suggest or help the user during search.
Will be appended to suggestions.
-}
suggestionAddon :
    { icon : IconSet.Icon
    , title : String
    , subtitle : Maybe String
    }
    -> Addon msg
suggestionAddon =
    Suggestion


{-| Internal.
-}
getHeaderAddonContent : Addon msg -> Maybe String
getHeaderAddonContent addon =
    case addon of
        Header label ->
            Just label

        _ ->
            Nothing


{-| Internal.
-}
getNoResultsActionAddonContent : Addon msg -> Maybe (Button.Config () msg)
getNoResultsActionAddonContent addon =
    case addon of
        NoResultAction config_ ->
            Just config_

        _ ->
            Nothing


{-| Internal.
-}
getSuggestionAddonContent : Addon msg -> Maybe { icon : IconSet.Icon, title : String, subtitle : Maybe String }
getSuggestionAddonContent addon =
    case addon of
        Suggestion config_ ->
            Just config_

        _ ->
            Nothing


{-| Sets an addon to be placed inside the Autocomplete's dropdown.
-}
withAddon : Addon msg -> Config value msg -> Config value msg
withAddon addon (Config configuration) =
    Config { configuration | addon = Just addon }


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

        {--The onBlur event should be set at this level in order to allow suggestion selection.
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
            , Events.onFocus OnFocus
            , Events.onInput OnInput
            , Attributes.id configData.id
            , Commons.Attributes.maybe Attributes.name configData.name
            , Attributes.attribute "aria-autocomplete" "both"
            , Commons.Attributes.renderIf modelData.dropdownOpen (Attributes.attribute "aria-expanded" "true")
            , Attributes.attribute "role" "combobox"
            , Attributes.autocomplete False
            , Attributes.disabled configData.disabled
            , Attributes.placeholder configData.placeholder
            , Attributes.type_ "text"
            , Commons.Attributes.testId configData.id
            , modelData.value
                |> Maybe.map configData.suggestionToString
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
    if RemoteData.isLoading modelData.suggestions then
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
        renderedSuggestions : List (Html msg)
        renderedSuggestions =
            configuration
                |> getSuggestions model
                |> List.map (renderSuggestionsItem msgMapper model configuration)

        noAvailableSuggestions : Bool
        noAvailableSuggestions =
            List.length (getSuggestions model configuration) == 0 && RemoteData.isSuccess modelData.suggestions

        nothingRetrievedYet : Bool
        nothingRetrievedYet =
            List.length (getSuggestions model configuration) == 0 && RemoteData.isNotAsked modelData.suggestions
    in
    if nothingRetrievedYet then
        Nothing

    else
        FormDropdown.render
            configData.id
            (if noAvailableSuggestions then
                FormDropdown.action
                    { label = configData.noResultsFoundMessage
                    , content =
                        configData.addon
                            |> Maybe.andThen getNoResultsActionAddonContent
                            |> Maybe.map (Button.render >> List.singleton)
                            |> Commons.Render.renderListMaybe
                    }

             else
                case
                    ( Maybe.andThen getHeaderAddonContent configData.addon
                    , Maybe.andThen getSuggestionAddonContent configData.addon
                    )
                of
                    ( Just headerLabel, _ ) ->
                        FormDropdown.headerAndContent
                            { header = Html.text headerLabel
                            , content = renderedSuggestions
                            }

                    ( Nothing, Just suggestionConfig ) ->
                        if not (RemoteData.isSuccess modelData.suggestions) && String.isEmpty modelData.filter then
                            FormDropdown.suggestion suggestionConfig

                        else
                            FormDropdown.content renderedSuggestions

                    ( Nothing, Nothing ) ->
                        FormDropdown.content renderedSuggestions
            )
            |> Just


{-| Internal.
-}
renderSuggestionsItem : (Msg value -> msg) -> Model ctx value -> Config value msg -> value -> Html msg
renderSuggestionsItem msgMapper (Model modelData) (Config configData) suggestion =
    Html.div
        [ Attributes.class "form-dropdown__item"
        , suggestion
            |> OnSelect
            |> msgMapper
            |> Events.onClick
        ]
        [ suggestion
            |> configData.suggestionToString
            |> String.trim
            |> renderSuggestionText modelData.filter
            |> Html.span []
        ]


{-| Internal.
-}
renderSuggestionText : String -> String -> List (Html msg)
renderSuggestionText filter label =
    label
        |> String.split filter
        |> List.map Html.text
        |> List.intersperse (Html.strong [ Attributes.class "text-m-bold" ] [ Html.text filter ])
