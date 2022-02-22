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


## Validation

@docs isValid


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
init : (ctx -> value -> Result String value) -> value -> Model ctx value
init validation defaultValue =
    Model
        { selectedValue = defaultValue
        , validation = validation
        }


{-| The RadioGroup configuration.
-}
type Config value
    = Config (ConfigData value)


type alias ConfigData value =
    { classList : List ( String, Bool )
    , id : String
    , isDisabled : Bool
    , label : Maybe Label.Config
    , layout : Layout
    , name : Maybe String
    , options : List (Option value)
    }


{-| Initialize the RadioGroup Config.
-}
config : String -> Config value
config id =
    Config
        { classList = []
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


{-| Add a name to the inputs.
-}
withName : String -> Config value -> Config value
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Add a label to the inputs.
-}
withLabel : String -> Config value -> Config value
withLabel label (Config configuration) =
    Config { configuration | name = Just label }


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
render : (Msg value -> msg) -> ctx -> Model ctx value -> Config value -> Html.Html msg
render tagger ctx ((Model modelData) as model) (Config configData) =
    let
        isValueValid : Bool
        isValueValid =
            isValid ctx model
    in
    Html.div [ Attributes.class "form-item" ]
        [ viewLabel configData.label configData.id
        , Html.div [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-control-group", True )
                    , ( "form-control-group--column", configData.layout == Vertical )
                    ]
                , Attributes.classList configData.classList
                , Attributes.id configData.id
                , CommonsAttributes.role "radiogroup"
                , CommonsAttributes.ariaLabelledbyBy (labelId configData.id)
                , CommonsAttributes.renderIf isValueValid (CommonsAttributes.ariaDescribedBy (Error.toId configData.id))
                ]
                (List.map
                    (viewRadio
                        configData
                        modelData.selectedValue
                        isValueValid
                    )
                    configData.options
                )
            , modelData.selectedValue
                |> modelData.validation ctx
                |> Error.fromResult
                |> Maybe.map (Error.withId configData.id >> Error.render)
                |> CommonsRender.renderMaybe
            ]
        ]
        |> Html.map tagger


viewLabel : Maybe Label.Config -> String -> Html.Html msg
viewLabel label id =
    label
        |> Maybe.map (Label.withId (labelId id) >> Label.render)
        |> CommonsRender.renderMaybe


labelId : String -> String
labelId =
    (++) "label-"


{-| Internal.
-}
viewRadio : ConfigData value -> value -> Bool -> Option value -> Html.Html (Msg value)
viewRadio { id, name, isDisabled } selectedValue isValueValid (Option { value, label }) =
    Html.label
        [ Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", not isValueValid )
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
update : Msg value -> Model ctx value -> Model ctx value
update msg =
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


{-| Check if the selected valued is valid.
-}
isValid : ctx -> Model ctx value -> Bool
isValid ctx (Model { validation, selectedValue }) =
    validation ctx selectedValue |> Result.Extra.isOk



-- Utils


toKebabCase : String -> String
toKebabCase =
    String.toLower >> String.replace " " "-"
