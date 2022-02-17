module Components.Field.RadioGroup exposing
    ( Model
    , option
    , withValidation
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
    , getValidatedValue
    , getValue
    , render
    , Configuration, Option, config, init
    )

{-|


# Input RadioGroup component

@docs Model
@docs create
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

@docs getValidatedValue
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


type Model value ctx
    = Model (State value ctx)


type alias State value ctx =
    { errorMessage : Maybe String
    , selectedValue : value
    , status : FieldStatus.StatusList
    , validation : ctx -> value -> Result String value
    }


init : value -> Model value ctx
init defaultValue =
    Model
        { validation = always Ok
        , errorMessage = Nothing
        , selectedValue = defaultValue
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        }


type Configuration value
    = Configuration
        { ariaLabelledBy : Maybe String
        , classList : List ( String, Bool )
        , id : String
        , isDisabled : Bool
        , isLayoutVertical : Bool
        , name : Maybe String
        , options : List (Option value)
        }


config : String -> Configuration value
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


type Option value
    = Option (OptionConfig value)


type alias OptionConfig value =
    { value : value
    , label : String
    }


type Msg value
    = OnCheck value Bool


isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        OnCheck _ _ ->
            True


withAriaLabelledby : String -> Configuration value -> Configuration value
withAriaLabelledby ariaLabelledBy (Configuration configuration) =
    Configuration { configuration | ariaLabelledBy = Just ariaLabelledBy }


withClassList : List ( String, Bool ) -> Configuration value -> Configuration value
withClassList classList (Configuration configuration) =
    Configuration { configuration | classList = classList }


withDisabled : Bool -> Configuration value -> Configuration value
withDisabled isDisabled (Configuration configuration) =
    Configuration { configuration | isDisabled = isDisabled }


withName : String -> Configuration value -> Configuration value
withName name (Configuration configuration) =
    Configuration { configuration | name = Just name }


withOptions : List (Option value) -> Configuration value -> Configuration value
withOptions options (Configuration configuration) =
    Configuration { configuration | options = options }


withValidation : (ctx -> value -> Result String value) -> Model value ctx -> Model value ctx
withValidation validation (Model model) =
    Model { model | validation = validation }


withVerticalLayout : Bool -> Configuration value -> Configuration value
withVerticalLayout isLayoutVertical (Configuration configuration) =
    Configuration { configuration | isLayoutVertical = isLayoutVertical }


option : OptionConfig value -> Option value
option =
    Option


render : (Msg value -> msg) -> Model value ctx -> Configuration value -> Html.Html msg
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


getValidatedValue : ctx -> Model value ctx -> Result String value
getValidatedValue ctx (Model { selectedValue, validation }) =
    validation ctx selectedValue


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
