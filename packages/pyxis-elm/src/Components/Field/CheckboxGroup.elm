module Components.Field.CheckboxGroup exposing
    ( Model
    , init
    , Config
    , config
    , Layout(..)
    , horizontal
    , vertical
    , withLayout
    , withAdditionalContent
    , withClassList
    , withIsSubmitted
    , withLabel
    , withName
    , withStrategy
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , Option
    , option
    , withOptions
    , withDisabledOption
    , render
    , single
    )

{-|


# CheckboxGroup component

@docs Model
@docs init


## Config

@docs Config
@docs config


## Layout

@docs Layout
@docs horizontal
@docs vertical
@docs withLayout


## Generics

@docs withAdditionalContent
@docs withClassList
@docs withDisabled
@docs withIsSubmitted
@docs withLabel
@docs withName
@docs withStrategy


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
@docs withDisabledOption


## Rendering

@docs render

-}

import Commons.Attributes
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as InternalStrategy
import Components.Field.FormItem as FormItem
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.Status as FieldStatus
import Html exposing (Html)
import Html.Attributes
import Html.Events
import PrimaFunction
import Result.Extra


type alias ModelData ctx value parsed =
    { checkedValues : List value
    , validation : ctx -> List value -> Result String parsed
    , fieldStatus : FieldStatus.Status
    }


{-| A type representing the CheckboxGroup field internal state.
-}
type Model ctx value parsed
    = Model (ModelData ctx value parsed)


{-| Initialize the CheckboxGroup internal state.
Takes a validation function as argument
-}
init : List value -> (ctx -> List value -> Result String parsed) -> Model ctx value parsed
init initialValues validation =
    Model
        { checkedValues = initialValues
        , validation = validation
        , fieldStatus = FieldStatus.Untouched
        }


{-| A type representing the internal component `Msg`
-}
type Msg value
    = Checked value Bool
    | Focused value
    | Blurred value


isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        Checked _ _ ->
            True

        _ ->
            False


{-| Update the internal state of the CheckboxGroup component
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg model =
    case msg of
        Checked value check ->
            model
                |> PrimaFunction.ifThenElseMap (always check)
                    (checkValue value)
                    (uncheckValue value)
                |> mapFieldStatus FieldStatus.onChange

        Focused _ ->
            model
                |> mapFieldStatus FieldStatus.onFocus

        Blurred _ ->
            model
                |> mapFieldStatus FieldStatus.onBlur


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
        { label : Html (Msg value)
        , value : value
        , disabled : Bool
        }


{-| Create a single Checkbox
-}
option : { label : Html (Msg value), value : value } -> Option value
option { label, value } =
    Option
        { label = label
        , value = value
        , disabled = False
        }


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config value -> Config value
withAdditionalContent additionalContent (Config configData) =
    Config { configData | additionalContent = Just additionalContent }


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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config value -> Config value
withStrategy strategy (Config configuration) =
    Config { configuration | strategy = strategy }


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config value -> Config value
withIsSubmitted isSubmitted (Config configuration) =
    Config { configuration | isSubmitted = isSubmitted }


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
type alias ConfigData value =
    { additionalContent : Maybe (Html Never)
    , ariaLabelledBy : Maybe String
    , classList : List ( String, Bool )
    , hint : Maybe Hint.Config
    , id : String
    , label : Maybe Label.Config
    , layout : Layout
    , name : Maybe String
    , options : List (Option value)
    , strategy : Strategy
    , isSubmitted : Bool
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
        { additionalContent = Nothing
        , ariaLabelledBy = Nothing
        , classList = []
        , hint = Nothing
        , id = id
        , label = Nothing
        , layout = Horizontal
        , name = Nothing
        , options = []
        , strategy = Strategy.onBlur
        , isSubmitted = False
        }


{-| Creates a config with only one one [`CheckboxGroup.Option`](CheckboxGroup#Option) applied

    single "I accept the cookie policy"

    -- Is equivalent to
    config
        |> withOptions
            [ option { value = (), label = "I accept the cookie policy" }
            ]

-}
single : Html (Msg ()) -> String -> Config ()
single label id =
    config id
        |> withOptions
            [ option { value = (), label = label }
            ]


{-| Render the CheckboxGroup
-}
render : (Msg value -> msg) -> ctx -> Model ctx value parsed -> Config value -> Html msg
render tagger ctx (Model modelData) (Config configData) =
    let
        shownValidation : Result String ()
        shownValidation =
            InternalStrategy.getShownValidation
                modelData.fieldStatus
                (modelData.validation ctx modelData.checkedValues)
                configData.isSubmitted
                configData.strategy

        renderCheckbox_ : Option value -> Html (Msg value)
        renderCheckbox_ =
            renderCheckbox
                { hasError = Result.Extra.isErr shownValidation
                , checkedValues = modelData.checkedValues
                }
                configData
    in
    configData.options
        |> List.map renderCheckbox_
        |> renderControlGroup configData
        |> FormItem.config configData
        |> FormItem.withLabel configData.label
        |> FormItem.withAdditionalContent configData.additionalContent
        |> FormItem.render shownValidation
        |> Html.map tagger


{-| Internal
Handles the single input / input group markup difference
-}
renderControlGroup : ConfigData value -> List (Html msg) -> Html msg
renderControlGroup configData children =
    case children of
        [ child ] ->
            child

        _ ->
            Html.div
                [ Html.Attributes.classList
                    [ ( "form-control-group", True )
                    , ( "form-control-group--column", configData.layout == Vertical )
                    ]
                , Html.Attributes.classList configData.classList
                , Html.Attributes.id configData.id
                , Commons.Attributes.testId configData.id
                , Html.Attributes.attribute "role" "group"
                , Commons.Attributes.maybe Commons.Attributes.ariaLabelledbyBy configData.ariaLabelledBy
                ]
                children


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
            , Html.Events.onFocus (Focused optionData.value)
            , Html.Events.onBlur (Blurred optionData.value)
            ]
            []
        , optionData.label
        ]



-- Getters/Setters boilerplate


mapCheckedValues : (List value -> List value) -> Model ctx value parsed -> Model ctx value parsed
mapCheckedValues f (Model modelData) =
    Model { modelData | checkedValues = f modelData.checkedValues }


{-| Internal
-}
mapFieldStatus : (FieldStatus.Status -> FieldStatus.Status) -> Model ctx value parsed -> Model ctx value parsed
mapFieldStatus f (Model model) =
    Model { model | fieldStatus = f model.fieldStatus }
