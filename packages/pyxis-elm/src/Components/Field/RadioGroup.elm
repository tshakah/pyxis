module Components.Field.RadioGroup exposing
    ( Model
    , init
    , Config
    , Option
    , option
    , withAriaLabelledby
    , withClassList
    , withDisabled
    , withName
    , withOptions
    , withVerticalLayout
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    , config, setValidation
    )

{-|


# Input RadioGroup component


## Model

@docs Model
@docs init


## Config

@docs Config
@docs Option
@docs option


## Validation

@docs withValidation


## Generics

@docs withAriaLabelledby
@docs withClassList
@docs withDisabled
@docs withLabel
@docs withName
@docs withOptions
@docs withVerticalLayout


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
import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Render as CR
import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra as ME


{-| The RadioGroup model.
-}
type Model value ctx
    = Model
        { errorMessage : Maybe String
        , selectedValue : value
        , status : FieldStatus.StatusList
        , validation : ctx -> value -> Result String value
        }


{-| Initialize the RadioGroup Model.
-}
init : value -> Model value ctx
init defaultValue =
    Model
        { validation = always Ok
        , errorMessage = Nothing
        , selectedValue = defaultValue
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        }


{-| The RadioGroup configuration.
-}
type Config value
    = Configuration
        { ariaLabelledBy : Maybe String
        , classList : List ( String, Bool )
        , id : String
        , isDisabled : Bool
        , isLayoutVertical : Bool
        , name : Maybe String
        , options : List (Option value)
        }


{-| Initialize the RadioGroup Config.
-}
config : String -> Config value
config id =
    Configuration
        { ariaLabelledBy = Nothing
        , classList = []
        , id = id
        , isDisabled = False
        , isLayoutVertical = False
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
    = OnCheck value Bool


{-| Returns True if the message is triggered by `Html.Events.onCheck`
-}
isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        OnCheck _ _ ->
            True


{-| Add the Validation rule.
-}
setValidation : (ctx -> value -> Result String value) -> Model value ctx -> Model value ctx
setValidation validation (Model model) =
    Model { model | validation = validation }


withAriaLabelledby : String -> Config value -> Config value
withAriaLabelledby ariaLabelledBy (Configuration configuration) =
    Configuration { configuration | ariaLabelledBy = Just ariaLabelledBy }


withClassList : List ( String, Bool ) -> Config value -> Config value
withClassList classList (Configuration configuration) =
    Configuration { configuration | classList = classList }


withDisabled : Bool -> Config value -> Config value
withDisabled isDisabled (Configuration configuration) =
    Configuration { configuration | isDisabled = isDisabled }


withName : String -> Config value -> Config value
withName name (Configuration configuration) =
    Configuration { configuration | name = Just name }


withOptions : List (Option value) -> Config value -> Config value
withOptions options (Configuration configuration) =
    Configuration { configuration | options = options }


withVerticalLayout : Bool -> Config value -> Config value
withVerticalLayout isLayoutVertical (Configuration configuration) =
    Configuration { configuration | isLayoutVertical = isLayoutVertical }


option : OptionConfig value -> Option value
option =
    Option


render : (Msg value -> msg) -> Model value ctx -> Config value -> Html.Html msg
render tagger (Model model) (Configuration configuration) =
    Html.div
        (CA.compose
            [ Attributes.classList
                ([ ( "form-control-group", True )
                 , ( "form-control-group--column", configuration.isLayoutVertical )
                 ]
                    ++ configuration.classList
                )
            , CA.role "radiogroup"
            , CA.ariaDescribedBy (errorMessageId configuration.id)
            ]
            [ Maybe.map CA.ariaLabelledbyBy configuration.ariaLabelledBy
            ]
        )
        (List.map
            (viewRadio
                configuration.id
                configuration.name
                model.selectedValue
                configuration.isDisabled
                model.errorMessage
            )
            configuration.options
            ++ [ Maybe.map (viewError configuration.id) model.errorMessage |> CR.renderMaybe ]
        )
        |> Html.map tagger


viewRadio : String -> Maybe String -> value -> Bool -> Maybe String -> Option value -> Html.Html (Msg value)
viewRadio id name selectedValue isDisabled errorMessage (Option { value, label }) =
    Html.label
        [ Attributes.classList
            [ ( "form-control", True )
            , ( "form-control--error", ME.isJust errorMessage )
            ]
        ]
        [ Html.input
            (CA.compose
                [ Attributes.type_ "radio"
                , Attributes.classList [ ( "form-control__radio", True ) ]
                , Attributes.checked (selectedValue == value)
                , Attributes.disabled isDisabled
                , CA.testId (radioId id label)
                , Events.onCheck (OnCheck value)
                ]
                [ Maybe.map Attributes.name name
                ]
            )
            []
        , Html.text label
        ]


radioId : String -> String -> String
radioId id label =
    let
        labelKebabCase : String
        labelKebabCase =
            label
                |> String.toLower
                |> String.replace " " "-"
    in
    [ id, labelKebabCase, "option" ]
        |> String.join "-"


viewError : String -> String -> Html.Html msg
viewError id errorMessage =
    Html.div
        [ Attributes.classList [ ( "form-control-group__error-message", True ) ]
        , Attributes.id (errorMessageId id)
        ]
        [ Html.text errorMessage ]


update : ctx -> Msg value -> Model value ctx -> Model value ctx
update ctx msg =
    case msg of
        OnCheck value _ ->
            setValue value
                >> validate ctx


{-| Validate and update the internal model.
-}
validate : ctx -> Model value ctx -> Model value ctx
validate ctx ((Model { selectedValue, validation }) as model) =
    let
        validationResult : Result String value
        validationResult =
            validation ctx selectedValue
    in
    model
        |> addFieldStatus (FieldStatus.fromResult validationResult)
        |> setErrorMessage (resultToErrorMessage validationResult)


{-| Internal.
-}
addFieldStatus : FieldStatus -> Model value ctx -> Model value ctx
addFieldStatus fieldStatus (Model model) =
    Model { model | status = FieldStatus.addStatus fieldStatus model.status }


setValue : value -> Model value ctx -> Model value ctx
setValue value (Model model) =
    Model { model | selectedValue = value }


getValue : Model value ctx -> value
getValue (Model { selectedValue }) =
    selectedValue


setErrorMessage : Maybe String -> Model value ctx -> Model value ctx
setErrorMessage errorMessage (Model model) =
    Model { model | errorMessage = errorMessage }


{-| Internal. For screen-reader.
-}
errorMessageId : String -> String
errorMessageId id =
    id ++ "-error"


resultToErrorMessage : Result String value -> Maybe String
resultToErrorMessage result =
    case result of
        Ok _ ->
            Nothing

        Err error ->
            Just error
