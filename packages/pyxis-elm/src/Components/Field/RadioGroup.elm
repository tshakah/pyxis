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
    , withLabel
    , withName
    , withOptions
    , Msg
    , isOnCheck
    , update
    , getValue
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

import Commons.Attributes as CommonsAttributes
import Commons.Render as CommonsRender
import Components.Field.Error as Error
import Components.Field.Label as Label
import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Result.Extra


{-| The RadioGroup model.
-}
type Model ctx value
    = Model
        { selectedValue : value
        , validation : ctx -> value -> Result String value
        }


{-| Initialize the RadioGroup Model.
-}
init : value -> (ctx -> value -> Result String value) -> Model ctx value
init defaultValue validation =
    Model
        { selectedValue = defaultValue
        , validation = validation
        }


{-| The RadioGroup configuration.
-}
type Config msg value
    = Config (ConfigData msg value)


type alias ConfigData msg value =
    { tagger : Msg value -> msg
    , classList : List ( String, Bool )
    , id : String
    , isDisabled : Bool
    , label : Maybe Label.Config
    , layout : Layout
    , name : Maybe String
    , options : List (Option value)
    }


{-| Initialize the RadioGroup Config.
-}
config : (Msg value -> msg) -> String -> Config msg value
config tagger id =
    Config
        { tagger = tagger
        , classList = []
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
withClassList : List ( String, Bool ) -> Config msg value -> Config msg value
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Define if the group is disabled or not.
-}
withDisabled : Bool -> Config msg value -> Config msg value
withDisabled isDisabled (Config configuration) =
    Config { configuration | isDisabled = isDisabled }


{-| Add a name to the inputs.
-}
withName : String -> Config msg value -> Config msg value
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Add a label to the inputs.
-}
withLabel : Label.Config -> Config msg value -> Config msg value
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


{-| Define the visible options in the radio group.
-}
withOptions : List (Option value) -> Config msg value -> Config msg value
withOptions options (Config configuration) =
    Config { configuration | options = options }


{-| Change the visual layout. The default one is horizontal.
-}
withLayout : Layout -> Config msg value -> Config msg value
withLayout layout (Config configuration) =
    Config { configuration | layout = layout }


{-| Generate a Radio Option
-}
option : OptionConfig value -> Option value
option =
    Option


{-| Render the RadioGroup.
-}
render : ctx -> Model ctx value -> Config msg value -> Html.Html msg
render ctx ((Model modelData) as model) ((Config configData) as config_) =
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
                , CommonsAttributes.role "radiogroup"
                , CommonsAttributes.ariaLabelledbyBy (labelId configData.id)
                , CommonsAttributes.renderIf
                    (Result.Extra.isErr (modelData.validation ctx modelData.selectedValue))
                    (CommonsAttributes.ariaDescribedBy (Error.toId configData.id))
                ]
                (List.map (renderRadio ctx model config_) configData.options)
            , modelData.selectedValue
                |> modelData.validation ctx
                |> Error.fromResult
                |> Maybe.map (Error.withId configData.id >> Error.render)
                |> CommonsRender.renderMaybe
            ]
        ]
        |> Html.map configData.tagger


{-| Internal.
-}
renderLabel : Maybe Label.Config -> String -> Html.Html msg
renderLabel label id =
    label
        |> Maybe.map (Label.withId (labelId id) >> Label.render)
        |> CommonsRender.renderMaybe


{-| Internal.
-}
labelId : String -> String
labelId =
    (++) "label-"


{-| Internal.
-}
renderRadio : ctx -> Model ctx value -> Config msg value -> Option value -> Html.Html (Msg value)
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
            , Attributes.checked (selectedValue == value)
            , Attributes.disabled isDisabled
            , Attributes.id (radioId id label)
            , CommonsAttributes.testId (radioId id label)
            , CommonsAttributes.maybe Attributes.name name
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
update : ctx -> Msg value -> Model ctx value -> Model ctx value
update ctx msg =
    case msg of
        OnCheck value ->
            setValue value


{-| Internal.
-}
setValue : value -> Model ctx value -> Model ctx value
setValue value (Model model) =
    Model { model | selectedValue = value }


{-| Return the selected value.
-}
getValue : Model ctx value -> value
getValue (Model { selectedValue }) =
    selectedValue



-- Utils


toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"
