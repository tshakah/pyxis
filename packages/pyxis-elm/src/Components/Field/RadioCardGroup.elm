module Components.Field.RadioCardGroup exposing
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
    , withDisabled
    , withHint
    , withLabel
    , withName
    , withOptions
    , withSize
    , setValue
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    )

{-|


# Input RadioCardGroup component


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
@docs setValue


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
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render
import Commons.String
import Components.Field.Error as Error
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra
import Result.Extra


{-| The RadioCardGroup model.
-}
type Model ctx value parsed
    = Model
        { selectedValue : Maybe value
        , validation : ctx -> Maybe value -> Result String parsed
        }


{-| Initialize the RadioCardGroup Model.
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
    , size : Size
    }


{-| The RadioCardGroup configuration.
-}
type Config value
    = Config (ConfigData value)


{-| Initialize the RadioCardGroup Config.
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
        , size = Size.medium
        }


{-| Represent the messages which the RadioCardGroup can handle.
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


{-| Represent the single Radio option.
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
    }


{-| Generate a RadioCard Option
-}
option : OptionConfig value -> Option value
option =
    Option


{-| Represent the different types of addon
-}
type Addon
    = TextAddon String
    | IconAddon IconSet.Icon
    | ImgUrlAddon String


{-| TextAddon for option.
-}
textAddon : String -> Maybe Addon
textAddon =
    TextAddon >> Just


{-| IconAddon for option.
-}
iconAddon : IconSet.Icon -> Maybe Addon
iconAddon =
    IconAddon >> Just


{-| ImgAddon for option.
-}
imgAddon : String -> Maybe Addon
imgAddon =
    ImgUrlAddon >> Just


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


{-| Change the visual layout. The default one is horizontal.
-}
withLayout : Layout -> Config value -> Config value
withLayout layout (Config configuration) =
    Config { configuration | layout = layout }


{-| Add the classes to the card group wrapper.
-}
withClassList : List ( String, Bool ) -> Config value -> Config value
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Define if the group is disabled or not.
-}
withDisabled : Bool -> Config value -> Config value
withDisabled isDisabled (Config configuration) =
    Config { configuration | isDisabled = isDisabled }


{-| Adds the hint to the RadioCardGroup.
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


{-| Add a label to the card group.
-}
withLabel : Label.Config -> Config value -> Config value
withLabel label (Config configuration) =
    Config { configuration | label = Just label }


{-| Define the visible options in the radio group.
-}
withOptions : List (Option value) -> Config value -> Config value
withOptions options (Config configuration) =
    Config { configuration | options = options }


{-| Define the size of cards.
-}
withSize : Size -> Config value -> Config value
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Render the RadioCardGroup.
-}
render : (Msg value -> msg) -> ctx -> Model ctx value parsed -> Config value -> Html msg
render tagger ctx ((Model modelData) as model) ((Config configData) as config_) =
    Html.div
        [ Attributes.class "form-item" ]
        [ renderLabel configData.label configData.id
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-card-group", True )
                    , ( "form-card-group--column", configData.layout == Vertical )
                    ]
                , Attributes.classList configData.classList
                , Attributes.id configData.id
                , Commons.Attributes.role "radiogroup"
                , Commons.Attributes.ariaLabelledbyBy (labelId configData.id)
                , Commons.Attributes.renderIf
                    (Result.Extra.isErr (modelData.validation ctx modelData.selectedValue))
                    (Commons.Attributes.ariaDescribedBy (Error.toId configData.id))
                ]
                (List.indexedMap (renderCard ctx model config_) configData.options)
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
renderCard : ctx -> Model ctx value parsed -> Config value -> Int -> Option value -> Html.Html (Msg value)
renderCard ctx (Model { validation, selectedValue }) (Config { id, isDisabled, name, size }) index (Option { value, addon, text, title }) =
    Html.label
        [ Attributes.classList
            [ ( "form-card", True )
            , ( "form-card--error", Result.Extra.isErr (validation ctx selectedValue) )
            , ( "form-card--checked", selectedValue == Just value )
            , ( "form-card--disabled", isDisabled )
            , ( "form-card--large", size == Size.large )
            ]
        ]
        [ addon
            |> Maybe.map renderPrependAddon
            |> Commons.Render.renderMaybe
        , Html.span
            [ Attributes.class "form-card__content-wrapper" ]
            [ title
                |> Maybe.map (renderContent "title")
                |> Commons.Render.renderMaybe
            , text
                |> Maybe.map (renderContent "text")
                |> Commons.Render.renderMaybe
            ]
        , addon
            |> Maybe.map renderAppendAddon
            |> Commons.Render.renderMaybe
        , Html.input
            [ Attributes.type_ "radio"
            , Attributes.class "form-control__radio"
            , Attributes.checked (selectedValue == Just value)
            , Attributes.disabled isDisabled
            , Attributes.id (cardId id text title index)
            , Commons.Attributes.testId (cardId id text title index)
            , Commons.Attributes.maybe Attributes.name name
            , Events.onCheck (always (OnCheck value))
            ]
            []
        ]


{-| Internal.
-}
renderPrependAddon : Addon -> Html (Msg value)
renderPrependAddon addon =
    case addon of
        IconAddon icon ->
            Html.span
                [ Attributes.class "form-card__addon form-card__addon--with-icon"
                , Commons.Attributes.testId (IconSet.toLabel icon)
                ]
                [ icon
                    |> Icon.create
                    |> Icon.withSize Size.large
                    |> Icon.render
                ]

        ImgUrlAddon url ->
            Html.span
                [ Attributes.class "form-card__addon" ]
                [ Html.img
                    [ Attributes.src url
                    , Attributes.width 70
                    , Attributes.height 70
                    , Attributes.alt ""
                    , Commons.Attributes.ariaHidden True
                    ]
                    []
                ]

        _ ->
            Html.text ""


{-| Internal.
-}
renderAppendAddon : Addon -> Html (Msg value)
renderAppendAddon addon =
    case addon of
        TextAddon str ->
            Html.span [ Attributes.class "form-card__addon" ] [ Html.text str ]

        _ ->
            Html.text ""


{-| Internal.
-}
renderContent : String -> String -> Html (Msg value)
renderContent identifier str =
    Html.span [ Attributes.class ("form-card__" ++ identifier) ] [ Html.text str ]


{-| Internal.
-}
cardId : String -> Maybe String -> Maybe String -> Int -> String
cardId id text title index =
    [ id
    , Maybe.Extra.or title text
        |> Maybe.withDefault (String.fromInt index)
        |> String.left 25
        |> Commons.String.toKebabCase
    , "option"
    ]
        |> String.join "-"


{-| Update the RadioGroup Model.
-}
update : Msg value -> Model ctx value parsed -> Model ctx value parsed
update msg =
    case msg of
        OnCheck value ->
            setValue value


{-| Internal.
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
