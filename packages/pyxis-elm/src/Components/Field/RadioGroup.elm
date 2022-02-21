module Components.Field.RadioGroup exposing
    ( Model
    , init
    , Config
    , config
    , Option
    , option
    , Layout
    , horizontal
    , vertical
    , withLayout
    , isValid
    , withAriaLabelledby
    , withClassList
    , withDisabled
    , withName
    , withOptions
    , Msg
    , isOnCheck
    , update
    , getValue
    , render
    , setValidation
    )

{-|


# Input RadioGroup component


## Model

@docs Model
@docs init


## Config

@docs Config
@docs config
@docs Option
@docs option


# Layout

@docs Layout
@docs horizontal
@docs vertical
@docs withLayout


## Validation

@docs isValid


## Generics

@docs withAriaLabelledby
@docs withClassList
@docs withDisabled
@docs withLabel
@docs withName
@docs withOptions


## Update

@docs Msg
@docs isOnCheck
@docs update
@docs validate


## Readers

@docs getValue


## Rendering

@docs render

-}

import Commons.Attributes as CA
import Commons.Render as CR
import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra


{-| The RadioGroup model.
-}
type Model value ctx
    = Model
        { selectedValue : value
        , validation : ctx -> value -> Result String value
        }


{-| Initialize the RadioGroup Model.
-}
init : (ctx -> value -> Result String value) -> value -> Model value ctx
init validation defaultValue =
    Model
        { selectedValue = defaultValue
        , validation = validation
        }


{-| The RadioGroup configuration.
-}
type Config value
    = Config
        { ariaLabelledBy : Maybe String
        , classList : List ( String, Bool )
        , id : String
        , isDisabled : Bool
        , layout : Layout
        , name : Maybe String
        , options : List (Option value)
        }


{-| Initialize the RadioGroup Config.
-}
config : String -> Config value
config id =
    Config
        { ariaLabelledBy = Nothing
        , classList = []
        , id = id
        , isDisabled = False
        , layout = Horizontal
        , name = Nothing
        , options = []
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


{-| Returns True if the message is triggered by `Html.Events.onCheck`
-}
isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        OnCheck _ ->
            True


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


{-| Add the aria-labelledby for accessibility.
-}
withAriaLabelledby : String -> Config value -> Config value
withAriaLabelledby ariaLabelledBy (Config configuration) =
    Config { configuration | ariaLabelledBy = Just ariaLabelledBy }


{-| Add the classes to the group wrapper.
-}
withClassList : List ( String, Bool ) -> Config value -> Config value
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Define if the group is disabled or not.
-}
withDisabled : Bool -> Config value -> Config value
withDisabled isDisabled (Config configuration) =
    Config { configuration | isDisabled = isDisabled }


{-| Add a name to the inputs.
-}
withName : String -> Config value -> Config value
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Define the visible options in the radio group.
-}
withOptions : List (Option value) -> Config value -> Config value
withOptions options (Config configuration) =
    Config { configuration | options = options }


{-| Change the visual layout. The default one is horizontal.
-}
withLayout : Layout -> Config value -> Config value
withLayout layout (Config configuration) =
    Config { configuration | layout = layout }


{-| Generate a Radio Option
-}
option : OptionConfig value -> Option value
option =
    Option


{-| Render the RadioGroup.
-}
render : (Msg value -> msg) -> ctx -> Model value ctx -> Config value -> Html.Html msg
render tagger ctx (Model model) (Config configuration) =
    let
        errorMessage : Maybe String
        errorMessage =
            model.validation ctx model.selectedValue |> resultToErrorMessage
    in
    Html.div
        [ Attributes.classList
            ([ ( "form-control-group", True )
             , ( "form-control-group--column", configuration.layout == Vertical )
             ]
                ++ configuration.classList
            )
        , Attributes.id configuration.id
        , CA.role "radiogroup"
        , CA.maybe (always (CA.ariaDescribedBy (errorMessageId configuration.id))) errorMessage
        , CA.maybe CA.ariaLabelledbyBy configuration.ariaLabelledBy
        ]
        (List.map
            (viewRadio
                configuration
                model.selectedValue
                errorMessage
            )
            configuration.options
            ++ [ Maybe.map (viewError configuration.id) errorMessage |> CR.renderMaybe ]
        )
        |> Html.map tagger


{-| Internal.
-}
viewRadio : { a | id : String, name : Maybe String, isDisabled : Bool } -> value -> Maybe String -> Option value -> Html.Html (Msg value)
viewRadio { id, name, isDisabled } selectedValue errorMessage (Option { value, label }) =
    Html.label
        [ Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", Maybe.Extra.isJust errorMessage )
            ]
        ]
        [ Html.input
            [ Attributes.type_ "radio"
            , Attributes.classList [ ( "form-control__radio", True ) ]
            , Attributes.checked (selectedValue == value)
            , Attributes.disabled isDisabled
            , Attributes.id (radioId id label)
            , CA.testId (radioId id label)
            , CA.maybe Attributes.name name
            , Events.onCheck (always (OnCheck value))
            ]
            []
        , Html.text label
        ]


{-| Internal.
-}
radioId : String -> String -> String
radioId id label =
    [ id, label |> toKebabCase, "option" ]
        |> String.join "-"


{-| Internal.
-}
viewError : String -> String -> Html.Html msg
viewError id errorMessage =
    Html.div
        [ Attributes.class "form-control-group__error-message"
        , Attributes.id (errorMessageId id)
        ]
        [ Html.text errorMessage ]


{-| Update the RadioGroup Model.
-}
update : Msg value -> Model value ctx -> Model value ctx
update msg =
    case msg of
        OnCheck value ->
            setValue value


{-| Internal.
-}
setValue : value -> Model value ctx -> Model value ctx
setValue value (Model model) =
    Model { model | selectedValue = value }


{-| Return the selected value.
-}
getValue : Model value ctx -> value
getValue (Model { selectedValue }) =
    selectedValue


{-| Internal. For screen-reader.
-}
errorMessageId : String -> String
errorMessageId id =
    id ++ "-error"


{-| Internal.
-}
resultToErrorMessage : Result String value -> Maybe String
resultToErrorMessage result =
    case result of
        Ok _ ->
            Nothing

        Err error ->
            Just error


{-| Check if the selected valued is valid.
-}
isValid : ctx -> Model value ctx -> Bool
isValid ctx (Model { validation, selectedValue }) =
    case validation ctx selectedValue of
        Ok _ ->
            True

        Err _ ->
            False



-- Utils


toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"
