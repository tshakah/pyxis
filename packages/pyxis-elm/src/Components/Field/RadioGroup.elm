module Components.Field.RadioGroup exposing
    ( Model
    , create
    , option
    , withValidation
    , withClassList
    , withDisabled
    , withName
    , withOptions
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    , Option
    )

{-|


# Input RadioGroup component

@docs Model
@docs create
@docs option


## Validation

@docs withValidation


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

import Commons.Attributes as CA
import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Render as CR
import Html
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra as ME


type Model value ctx msg
    = Model (Configuration value ctx msg)


type alias Configuration value ctx msg =
    { classList : List ( String, Bool )
    , errorMessage : Maybe String
    , id : String
    , isDisabled : Bool
    , name : Maybe String
    , options : List (Option value)
    , selectedValue : value
    , status : FieldStatus.StatusList
    , tagger : Msg value -> msg
    , validation : ctx -> value -> Result String value
    }


type Option value
    = Option (OptionConfig value)


type alias OptionConfig value =
    { value : value
    , label : String
    }


create : String -> (Msg value -> msg) -> value -> Model value ctx msg
create id tagger defaultValue =
    Model
        { classList = []
        , errorMessage = Nothing
        , id = id
        , isDisabled = False
        , name = Nothing
        , options = []
        , selectedValue = defaultValue
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , tagger = tagger
        , validation = always Ok
        }


type Msg value
    = OnCheck value Bool


isOnCheck : Msg value -> Bool
isOnCheck msg =
    case msg of
        OnCheck _ _ ->
            True


withClassList : List ( String, Bool ) -> Model value ctx msg -> Model value ctx msg
withClassList classList (Model configuration) =
    Model { configuration | classList = classList }


withDisabled : Bool -> Model value ctx msg -> Model value ctx msg
withDisabled isDisabled (Model configuration) =
    Model { configuration | isDisabled = isDisabled }


withName : String -> Model value ctx msg -> Model value ctx msg
withName name (Model configuration) =
    Model { configuration | name = Just name }


withOptions : List (Option value) -> Model value ctx msg -> Model value ctx msg
withOptions options (Model configuration) =
    Model { configuration | options = options }


withValidation : (ctx -> value -> Result String value) -> Model value ctx msg -> Model value ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


option : OptionConfig value -> Option value
option =
    Option


render : Model value ctx msg -> Html.Html msg
render (Model { selectedValue, options, tagger, name, classList, errorMessage, id }) =
    Html.div
        [ Attributes.classList [ ( "form-control-group", True ) ]
        , CA.role "radiogroup"
        , CA.ariaDescribedBy (errorMessageId id)
        ]
        (List.map (viewRadio name selectedValue errorMessage) options
            ++ [ Maybe.map (viewError id) errorMessage |> CR.renderMaybe ]
        )
        |> Html.map tagger


viewRadio : Maybe String -> value -> Maybe String -> Option value -> Html.Html (Msg value)
viewRadio name selectedValue errorMessage (Option { value, label }) =
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
                , Events.onCheck (OnCheck value)
                ]
                [ Maybe.map Attributes.name name
                ]
            )
            []
        , Html.text label
        ]


viewError : String -> String -> Html.Html msg
viewError id errorMessage =
    Html.div
        [ Attributes.classList [ ( "form-control-group__error-message", True ) ]
        , Attributes.id (errorMessageId id)
        ]
        [ Html.text errorMessage ]


update : ctx -> Msg value -> Model value ctx msg -> Model value ctx msg
update ctx msg =
    case msg of
        OnCheck value _ ->
            setValue value
                >> validate ctx


{-| Validate and update the internal model.
-}
validate : ctx -> Model value ctx msg -> Model value ctx msg
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
addFieldStatus : FieldStatus -> Model value ctx msg -> Model value ctx msg
addFieldStatus fieldStatus (Model configuration) =
    Model { configuration | status = FieldStatus.addStatus fieldStatus configuration.status }


setValue : value -> Model value ctx msg -> Model value ctx msg
setValue value (Model configuration) =
    Model { configuration | selectedValue = value }


getValue : Model value ctx msg -> value
getValue (Model { selectedValue }) =
    selectedValue


setErrorMessage : Maybe String -> Model value ctx msg -> Model value ctx msg
setErrorMessage errorMessage (Model configuration) =
    Model { configuration | errorMessage = errorMessage }


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
