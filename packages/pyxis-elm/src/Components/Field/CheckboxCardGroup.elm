module Components.Field.CheckboxCardGroup exposing
    ( Model
    , init
    , Config
    , config
    , Option
    , option
    , Addon
    , iconAddon
    , imgAddon
    , textAddon
    , Layout
    , horizontal
    , vertical
    , withLayout
    , withClassList
    , withHint
    , withLabel
    , withName
    , withOptions
    , withSize
    , withDisabledOption
    , withIsSubmitted
    , withStrategy
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    )

{-|


# Input CheckboxCardGroup component


## Model

@docs Model
@docs init


## Config

@docs Config
@docs config
@docs Option
@docs option


# Addon

@docs Addon
@docs iconAddon
@docs imgAddon
@docs textAddon


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
@docs withSize
@docs withDisabledOption
@docs withIsSubmitted
@docs withStrategy


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

import Commons.Properties.Size as Size exposing (Size)
import Components.CardGroup as CardGroup
import Components.Field.Error.Strategy as Strategy exposing (Strategy)
import Components.Field.Error.Strategy.Internal as InternalStrategy
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Field.State as FieldState
import Components.IconSet as IconSet
import Html exposing (Html)
import PrimaFunction


type alias ModelData ctx value parsed =
    { checkedValues : List value
    , validation : ctx -> List value -> Result String parsed
    , fieldState : FieldState.State
    }


{-| The CheckboxCardGroup model.
-}
type Model ctx value parsed
    = Model (ModelData ctx value parsed)


{-| Initialize the CheckboxCardGroup Model.
-}
init : (ctx -> List value -> Result String parsed) -> Model ctx value parsed
init validation =
    Model
        { checkedValues = []
        , validation = validation
        , fieldState = FieldState.Untouched
        }


type alias ConfigData value =
    { classList : List ( String, Bool )
    , hint : Maybe Hint.Config
    , id : String
    , isDisabled : Bool
    , label : Maybe Label.Config
    , layout : CardGroup.Layout
    , name : Maybe String
    , options : List (Option value)
    , size : Size
    , strategy : Strategy
    , isSubmitted : Bool
    }


{-| The CheckboxCardGroup configuration.
-}
type Config value
    = Config (ConfigData value)


{-| Initialize the CheckboxCardGroup Config.
-}
config : String -> Config value
config id =
    Config
        { classList = []
        , hint = Nothing
        , id = id
        , isDisabled = False
        , layout = CardGroup.Horizontal
        , label = Nothing
        , name = Nothing
        , options = []
        , size = Size.medium
        , strategy = Strategy.onBlur
        , isSubmitted = False
        }


{-| Represent the messages which the CheckboxCardGroup can handle.
-}
type Msg value
    = Checked value Bool
    | Focused value
    | Blurred value


{-| Update the CheckboxGroup Model.
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg model =
    case msg of
        Checked value check ->
            model
                |> PrimaFunction.ifThenElseMap (always check)
                    (checkValue value)
                    (uncheckValue value)
                |> mapFieldState FieldState.onChange

        Focused _ ->
            model
                |> mapFieldState FieldState.onFocus

        Blurred _ ->
            model
                |> mapFieldState FieldState.onBlur


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


{-| Return the selected value.
-}
getValue : Model ctx value parsed -> List value
getValue (Model { checkedValues }) =
    checkedValues


{-| Get the (parsed) value
-}
validate : ctx -> Model ctx value parsed -> Result String parsed
validate ctx (Model { checkedValues, validation }) =
    validation ctx checkedValues


{-| Returns True if the message is triggered by `Html.Events.onCheck`
-}
isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        Checked _ _ ->
            True

        _ ->
            False


{-| Represent the single Checkbox option.
-}
type Option value
    = Option (OptionConfig value)


{-| Internal.
-}
type alias OptionConfig value =
    { value : value
    , text : Maybe String
    , title : Maybe String
    , addon : Maybe Addon
    , disabled : Bool
    }


{-| Generate a CheckboxCard Option
-}
option :
    { value : value
    , text : Maybe String
    , title : Maybe String
    , addon : Maybe Addon
    }
    -> Option value
option args =
    Option
        { value = args.value
        , text = args.text
        , title = args.title
        , addon = args.addon
        , disabled = False
        }


withDisabledOption : Bool -> Option value -> Option value
withDisabledOption disabled (Option option_) =
    Option { option_ | disabled = disabled }


{-| Represent the different types of addon
-}
type Addon
    = Addon CardGroup.Addon


{-| TextAddon for option.
-}
textAddon : String -> Maybe Addon
textAddon =
    CardGroup.TextAddon >> Addon >> Just


{-| IconAddon for option.
-}
iconAddon : IconSet.Icon -> Maybe Addon
iconAddon =
    CardGroup.IconAddon >> Addon >> Just


{-| ImgAddon for option.
-}
imgAddon : String -> Maybe Addon
imgAddon =
    CardGroup.ImgUrlAddon >> Addon >> Just


{-| Represent the layout of the group.
-}
type Layout
    = Layout CardGroup.Layout


{-| Horizontal layout.
-}
horizontal : Layout
horizontal =
    Layout CardGroup.Horizontal


{-| Vertical layout.
-}
vertical : Layout
vertical =
    Layout CardGroup.Vertical


{-| Change the visual layout. The default one is horizontal.
-}
withLayout : Layout -> Config value -> Config value
withLayout (Layout layout) (Config configuration) =
    Config { configuration | layout = layout }


{-| Add the classes to the card group wrapper.
-}
withClassList : List ( String, Bool ) -> Config value -> Config value
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Adds the hint to the CheckboxCardGroup.
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


{-| Add a label to the card group.
-}
withLabel : Label.Config -> Config value -> Config value
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


{-| Define the visible options in the checkbox group.
-}
withOptions : List (Option value) -> Config value -> Config value
withOptions options (Config configuration) =
    Config { configuration | options = options }


{-| Define the size of cards.
-}
withSize : Size -> Config value -> Config value
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Render the checkboxCardGroup
-}
render : (Msg value -> msg) -> ctx -> Model ctx value parsed -> Config value -> Html msg
render tagger ctx (Model modelData) (Config configData) =
    let
        shownValidation : Result String ()
        shownValidation =
            InternalStrategy.getShownValidation
                modelData.fieldState
                (\() -> modelData.validation ctx modelData.checkedValues)
                configData.isSubmitted
                configData.strategy
    in
    CardGroup.renderCheckbox
        shownValidation
        configData
        (List.map (mapOption modelData.checkedValues) configData.options)
        |> Html.map tagger


{-| Internal
-}
mapOption : List value -> Option value -> CardGroup.Option (Msg value)
mapOption checkedValues (Option { value, text, title, addon, disabled }) =
    { onCheck = Checked value
    , onBlur = Blurred value
    , onFocus = Focused value
    , addon = Maybe.map (\(Addon a) -> a) addon
    , text = text
    , title = title
    , isChecked = List.member value checkedValues
    , isDisabled = disabled
    }



-- Getters/Setters boilerplate


{-| Internal
-}
mapCheckedValues : (List value -> List value) -> Model ctx value parsed -> Model ctx value parsed
mapCheckedValues f (Model r) =
    Model { r | checkedValues = f r.checkedValues }


{-| Internal
-}
mapFieldState : (FieldState.State -> FieldState.State) -> Model ctx value parsed -> Model ctx value parsed
mapFieldState f (Model model) =
    Model { model | fieldState = f model.fieldState }
