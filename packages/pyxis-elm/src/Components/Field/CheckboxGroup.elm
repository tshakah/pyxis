module Components.Field.CheckboxGroup exposing
    ( Model
    , init
    , update, Msg
    , getValue, validate
    , Config, config, single
    , withClassList
    , withName
    , withLabel
    , horizontal
    , vertical
    , withLayout
    , option
    , withOptions
    , render
    , withDisabledOption
    )

{-|


# CheckboxGroup component

@docs Model
@docs init
@docs update, Msg


## Readers

@docs getValue, validate


## View

@docs Config, config, single
@docs withClassList
@docs withDisabled
@docs withName
@docs withLabel


### Layout

@docs Layout
@docs horizontal
@docs vertical
@docs withLayout


#### Options

@docs Option, option
@docs withOptions


#### Rendering

@docs render

-}

import Commons.Attributes
import Commons.Render
import Components.Field.Error as Error
import Components.Field.Label as Label
import Html exposing (Html)
import Html.Attributes
import Html.Events
import PrimaFunction
import Result.Extra


{-| Internal
-}
type alias ModelData ctx value parsed =
    { checkedValues : List value
    , validation : ctx -> List value -> Result String parsed
    }


{-| A type representing the CheckboxGroup field internal state.
-}
type Model ctx value parsed
    = Model (ModelData ctx value parsed)


{-| Initialize the CheckboxGroup internal state.
Takes a validation function as argument
-}
init : (ctx -> List value -> Result String parsed) -> Model ctx value parsed
init validation =
    Model
        { checkedValues = []
        , validation = validation
        }


{-| A type representing the internal component `Msg`
-}
type Msg a
    = Checked a Bool


{-| Update the internal state of the CheckboxGroup component
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg model =
    case msg of
        Checked value check ->
            PrimaFunction.ifThenElseMap (always check)
                (checkValue value)
                (uncheckValue value)
                model


{-| Internal
-}
checkValue : value -> Model ctx value parsed -> Model ctx value parsed
checkValue value =
    mapCheckedValues ((::) value)


{-| Internal
-}
uncheckValue : value -> Model ctx value parsed -> Model ctx value parsed
uncheckValue value =
    mapCheckedValues (List.filter ((/=) value))



-- View


{-| A type representing a single checkbox option
-}
type Option value
    = Option
        { label : String
        , value : value
        , disabled : Bool
        }


{-| Create a single Checkbox
-}
option : { label : String, value : value } -> Option value
option { label, value } =
    Option
        { label = label
        , value = value
        , disabled = False
        }


withDisabledOption : Bool -> Option value -> Option value
withDisabledOption disabled (Option optionData) =
    Option { optionData | disabled = disabled }


{-| Set the CheckboxGroup checkboxes options
-}
withOptions : List (Option value) -> Config value -> Config value
withOptions options (Config configData) =
    Config { configData | options = options }


{-| Sets the label attribute
-}
withLabel : Label.Config -> Config value -> Config value
withLabel label (Config configData) =
    Config { configData | label = Just label }


{-| Sets the classList attribute
-}
withClassList : List ( String, Bool ) -> Config value -> Config value
withClassList classList (Config configData) =
    Config { configData | classList = classList }


{-| Sets the name attribute
-}
withName : String -> Config value -> Config value
withName name (Config configData) =
    Config { configData | name = Just name }


{-| Represent the layout of the group.
-}
type Layout
    = Horizontal
    | Vertical


{-| Sets the CheckboxGroup layout
-}
withLayout : Layout -> Config value -> Config value
withLayout layout (Config configData) =
    Config { configData | layout = layout }


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


{-| Internal
-}
type alias ConfigData a =
    { options : List (Option a)
    , label : Maybe Label.Config
    , name : Maybe String
    , ariaLabelledBy : Maybe String
    , id : String
    , classList : List ( String, Bool )
    , layout : Layout
    }


{-| A type representing the select rendering options.
This should not belong to the app `Model`
-}
type Config value
    = Config (ConfigData value)


{-| Create a default [`CheckboxGroup.Config`](CheckboxGroup#Config)
-}
config : String -> Config value
config id =
    Config
        { options = []
        , label = Nothing
        , name = Nothing
        , ariaLabelledBy = Nothing
        , id = id
        , classList = []
        , layout = Horizontal
        }


{-| Creates a config with only one one [`CheckboxGroup.Option`](CheckboxGroup#Option) applied

    single "I accept the cookie policy"

    -- Is equivalent to
    config
        |> withOptions
            [ option { value = (), label = "I accept the cookie policy" }
            ]

-}
single : String -> String -> Config ()
single label id =
    config id
        |> withOptions
            [ option { value = (), label = label }
            ]


{-| Render the CheckboxGroup
-}
render : ctx -> (Msg value -> msg) -> Model ctx value parsed -> Config value -> Html msg
render ctx tagger ((Model modelData) as model) (Config configData) =
    let
        validationResult : Result String parsed
        validationResult =
            validate ctx model

        renderCheckbox_ : Option value -> Html (Msg value)
        renderCheckbox_ =
            renderCheckbox
                { hasError = Result.Extra.isErr validationResult
                , checkedValues = modelData.checkedValues
                }
                configData
    in
    Html.div
        [ Html.Attributes.class "form-item"
        , Html.Attributes.classList configData.classList
        , Html.Attributes.id configData.id
        , Commons.Attributes.testId configData.id
        ]
        [ configData.label
            |> Maybe.map Label.render
            |> Commons.Render.renderMaybe
        , Html.div [ Html.Attributes.class "form-item__wrapper" ]
            (configData.options
                |> List.map renderCheckbox_
                |> renderControlGroup configData
            )
        , validationResult
            |> Error.fromResult
            |> Maybe.map (renderErrorConfig configData)
            |> Commons.Render.renderMaybe
        ]
        |> Html.map tagger


{-| Internal
Handles the single input / input group markup difference
-}
renderControlGroup : { r | ariaLabelledBy : Maybe String, layout : Layout } -> List (Html msg) -> List (Html msg)
renderControlGroup configData children =
    case children of
        [ _ ] ->
            children

        _ ->
            [ Html.div
                [ Html.Attributes.classList
                    [ ( "form-control-group", True )
                    , ( "form-control-group--column", configData.layout == Vertical )
                    ]
                , Html.Attributes.attribute "role" "group"
                , Commons.Attributes.maybe Commons.Attributes.ariaLabelledbyBy configData.ariaLabelledBy
                ]
                children
            ]


{-| Get the (parsed) value
-}
validate : ctx -> Model ctx value parsed -> Result String parsed
validate ctx (Model modelData) =
    modelData.validation ctx modelData.checkedValues


{-| Get the checked options **without** passing through the validation
-}
getValue : Model ctx value parsed -> List value
getValue (Model modelData) =
    modelData.checkedValues


{-| Internal
-}
renderErrorConfig : ConfigData value -> Error.Config -> Html msg
renderErrorConfig configData errorConfig =
    errorConfig
        |> Error.withId configData.id
        |> Error.render


{-| Internal
-}
renderCheckbox : { hasError : Bool, checkedValues : List value } -> { r | name : Maybe String } -> Option value -> Html (Msg value)
renderCheckbox { hasError, checkedValues } configData (Option optionData) =
    Html.label
        [ Html.Attributes.class "form-control"
        , Html.Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", hasError )
            ]
        ]
        [ Html.input
            [ Html.Attributes.type_ "checkbox"
            , Html.Attributes.classList
                [ ( "form-control__checkbox", True )
                , ( "form-control--disabled", optionData.disabled )
                ]
            , Html.Attributes.checked (List.member optionData.value checkedValues)
            , Html.Attributes.disabled optionData.disabled
            , Commons.Attributes.maybe Html.Attributes.name configData.name
            , Html.Events.onCheck (Checked optionData.value)
            ]
            []
        , Html.text optionData.label
        ]



-- Getters/Setters boilerplate


mapCheckedValues : (List value -> List value) -> Model ctx value parsed -> Model ctx value parsed
mapCheckedValues f (Model r) =
    Model { r | checkedValues = f r.checkedValues }
