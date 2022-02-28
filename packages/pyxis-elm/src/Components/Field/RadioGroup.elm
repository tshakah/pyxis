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
    , withClassList
    , withDisabled
    , withHint
    , withLabel
    , withName
    , withOptions
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    , setValue
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


## Generics

@docs withClassList
@docs withDisabled
@docs withHint
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

import Commons.Attributes
import Commons.Render
import Components.Field.Error as Error
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Result.Extra


{-| The RadioGroup model.
-}
type Model ctx value parsed
    = Model
        { selectedValue : Maybe value
        , validation : ctx -> Maybe value -> Result String parsed
        }


{-| Initialize the RadioGroup Model.
-}
init : (ctx -> Maybe value -> Result String parsed) -> Model ctx value parsed
init validation =
    Model
        { selectedValue = Nothing
        , validation = validation
        }


type alias ConfigData value =
    { classList : List ( String, Bool )
    , hint : Maybe Hint.Config
    , id : String
    , isDisabled : Bool
    , label : Maybe Label.Config
    , layout : Layout
    , name : Maybe String
    , options : List (Option value)
    }


{-| The RadioGroup configuration.
-}
type Config value
    = Config (ConfigData value)


{-| Initialize the RadioGroup Config.
-}
config : String -> Config value
config id =
    Config
        { classList = []
        , hint = Nothing
        , id = id
        , isDisabled = False
        , layout = Horizontal
        , label = Nothing
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


{-| Adds the hint to the TextArea.
-}
withHint : String -> Config value -> Config value
withHint hintMessage (Config configuration) =
    Config
        { configuration
            | hint =
                Hint.config hintMessage
                    |> Hint.withFieldId configuration.id
                    |> Just
        }


{-| Add a name to the inputs.
-}
withName : String -> Config value -> Config value
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Add a label to the inputs.
-}
withLabel : Label.Config -> Config value -> Config value
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


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
render : (Msg value -> msg) -> ctx -> Model ctx value parsed -> Config value -> Html.Html msg
render tagger ctx ((Model modelData) as model) ((Config configData) as config_) =
    Html.div
        [ Attributes.class "form-item" ]
        [ renderLabel configData.label configData.id
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-control-group", True )
                    , ( "form-control-group--column", configData.layout == Vertical )
                    ]
                , Attributes.classList configData.classList
                , Attributes.id configData.id
                , Commons.Attributes.role "radiogroup"
                , Commons.Attributes.ariaLabelledbyBy (labelId configData.id)
                , modelData.selectedValue
                    |> modelData.validation ctx
                    |> Error.fromResult
                    |> Maybe.map (always (Error.toId configData.id))
                    |> Commons.Attributes.ariaDescribedByErrorOrHint
                        (Maybe.map (always (Hint.toId configData.id)) configData.hint)
                ]
                (List.map (renderRadio ctx model config_) configData.options)
            , modelData.selectedValue
                |> modelData.validation ctx
                |> Error.fromResult
                |> Commons.Render.renderErrorOrHint configData.id configData.hint
            ]
        ]
        |> Html.map tagger


{-| Internal.
-}
renderLabel : Maybe Label.Config -> String -> Html.Html msg
renderLabel label id =
    label
        |> Maybe.map (Label.withId (labelId id) >> Label.render)
        |> Commons.Render.renderMaybe


{-| Internal.
-}
labelId : String -> String
labelId =
    (++) "label-"


{-| Internal.
-}
renderRadio : ctx -> Model ctx value parsed -> Config value -> Option value -> Html.Html (Msg value)
renderRadio ctx (Model { validation, selectedValue }) (Config { id, name, isDisabled }) (Option { value, label }) =
    Html.label
        [ Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", Result.Extra.isErr (validation ctx selectedValue) )
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


{-| Update the RadioGroup Model.
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg =
    case msg of
        OnCheck value ->
            setValue value


{-| Set the radiogroup value
-}
setValue : value -> Model ctx value parsed -> Model ctx value parsed
setValue value (Model model) =
    Model { model | selectedValue = Just value }


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



-- Utils


toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"
