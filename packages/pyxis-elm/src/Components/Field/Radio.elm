module Components.Field.Radio exposing
    ( Model
    , create
    , option
    , withValidation
    , withClassList
    , withLabel
    , withName
    , Msg
    , isOnCheck
    , update
    , validate
    , getValue
    , render
    )

{-|


# Input Radio component

@docs Model
@docs create
@docs option


## Validation

@docs withValidation


## Generics

@docs withClassList
@docs withLabel
@docs withName


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
import Html.Events
import Maybe.Extra as ME


type Model value ctx msg
    = Model (Configuration value ctx msg)


type alias Configuration value ctx msg =
    { classList : List ( String, Bool )
    , disabled : Bool
    , errorMessage : Maybe String
    , id : String
    , label : Maybe LabelConfig
    , name : Maybe String
    , options : List (Option value)
    , status : FieldStatus.StatusList
    , selectedValue : value
    , tagger : Msg value -> msg
    , validation : ctx -> value -> Result String value
    }


type alias LabelConfig =
    { text : String
    , id : String
    }


type Option value
    = Option (OptionConfig value)


type alias OptionConfig value =
    { value : value
    , label : String
    }


create : String -> (Msg value -> msg) -> value -> List (Option value) -> Model value ctx msg
create id tagger value options =
    Model
        { classList = []
        , disabled = False
        , errorMessage = Nothing
        , id = id
        , label = Nothing
        , name = Nothing
        , options = options
        , selectedValue = value
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


withLabel : LabelConfig -> Model value ctx msg -> Model value ctx msg
withLabel label (Model configuration) =
    Model { configuration | label = Just label }


withName : String -> Model value ctx msg -> Model value ctx msg
withName name (Model configuration) =
    Model { configuration | name = Just name }


withValidation : (ctx -> value -> Result String value) -> Model value ctx msg -> Model value ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


option : OptionConfig value -> Option value
option =
    Option


render : Model value ctx msg -> Html.Html msg
render (Model { selectedValue, options, tagger, label, name, classList, errorMessage, id }) =
    Html.div
        [ Attributes.classList ([ ( "form-item", True ) ] ++ classList)
        ]
        [ Html.label
            (CA.compose
                [ Attributes.classList [ ( "form-label", True ) ]
                ]
                [ Maybe.map (.id >> Attributes.id) label ]
            )
            [ Maybe.map (.text >> Html.text) label |> CR.renderMaybe ]
        , Html.div
            (CA.compose
                [ Attributes.classList [ ( "form-control-group", True ) ]
                , CA.role "radiogroup"
                , CA.ariaDescribedBy (errorMessageId id)
                ]
                [ Maybe.map (.id >> CA.ariaLabelledbyBy) label ]
            )
            (List.map (viewRadio name selectedValue errorMessage) options
                ++ [ Maybe.map (viewError "") errorMessage |> CR.renderMaybe ]
            )
        ]
        |> Html.map tagger


viewRadio : Maybe String -> value -> Maybe String -> Option value -> Html.Html (Msg value)
viewRadio name selectedValue errorMessage (Option { value, label }) =
    Html.div
        [ Attributes.classList [ ( "form-control-group", True ) ]
        ]
        [ Html.label
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
                    , Html.Events.onCheck (OnCheck value)
                    ]
                    [ Maybe.map Attributes.name name
                    ]
                )
                []
            , Html.text label
            ]
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
