module Components.Field.Date exposing
    ( Model
    , create
    , withSize
    , withValidation
    , withClassList
    , withDefaultValue
    , withDisabled
    , withName
    , withPlaceholder
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
    , validate
    , getValue
    , getValidatedValue
    , Date(..)
    , isParsed
    , isRaw
    , render
    )

{-|


# Input Date component

@docs Model
@docs create


## Size

@docs withSize


## Validation

@docs withValidation


## Generics

@docs withClassList
@docs withDefaultValue
@docs withDisabled
@docs withName
@docs withPlaceholder


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update
@docs validate


## Readers

@docs Date
@docs isParsed
@docs isRaw
@docs getValue
@docs getValidatedValue


## Rendering

@docs render

-}

import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Properties.Placement as Placement
import Commons.Properties.Size exposing (Size)
import Components.Field.Input as Input
import Components.IconSet as IconSet
import Date
import Html exposing (Html)


{-| A type representing a date that can be either successfully parsed or not
-}
type Date
    = Parsed Date.Date
    | Raw String


{-| Returns True when the given Date is `Parsed`
-}
isParsed : Date -> Bool
isParsed id =
    case id of
        Parsed _ ->
            True

        Raw _ ->
            False


{-| Returns True when the given Date is `Raw`
-}
isRaw : Date -> Bool
isRaw id =
    case id of
        Raw _ ->
            True

        Parsed _ ->
            False


{-| The Input Date model.
-}
type Model ctx msg
    = Model (Configuration ctx msg)


{-| Represent the messages which the Input Date can handle.
-}
type Msg
    = OnInput Date
    | OnFocus
    | OnBlur


{-| Returns True if the message is triggered by `Html.Events.onInput`
-}
isOnInput : Msg -> Bool
isOnInput msg =
    case msg of
        OnInput _ ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onFocus`
-}
isOnFocus : Msg -> Bool
isOnFocus msg =
    case msg of
        OnFocus ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onBlur`
-}
isOnBlur : Msg -> Bool
isOnBlur msg =
    case msg of
        OnBlur ->
            True

        _ ->
            False


{-| Internal. Represents the Input Date configuration.
-}
type alias Configuration ctx msg =
    { status : FieldStatus.StatusList
    , inputModel : Input.Model msg
    , isSubmitted : Bool
    , msgTagger : Msg -> msg
    , validation : ctx -> Date -> Result String Date
    }


parseDate : String -> Date
parseDate str =
    str
        |> Date.fromIsoString
        |> Result.map Parsed
        |> Result.withDefault (Raw str)


{-| Creates the Model of an Input of type="date"
-}
create : (Msg -> msg) -> String -> Model ctx msg
create msgTagger id =
    Model
        { status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , inputModel =
            Input.date
                { onInput = parseDate >> OnInput >> msgTagger
                , onFocus = msgTagger OnFocus
                , onBlur = msgTagger OnBlur
                }
                id
                |> Input.withAddon Placement.prepend (Input.iconAddon IconSet.Calendar)
        , isSubmitted = False
        , msgTagger = msgTagger
        , validation = always Ok
        }


{-| Internal.
-}
mapInputModel : (Input.Model msg -> Input.Model msg) -> Model ctx msg -> Model ctx msg
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Sets a default value to the Input Date.
-}
withDefaultValue : Date.Date -> Model ctx msg -> Model ctx msg
withDefaultValue defaultValue =
    setValue (Parsed defaultValue)
        >> addFieldStatus FieldStatus.default


{-| Sets a ClassList to the Input Date.
-}
withClassList : List ( String, Bool ) -> Model ctx msg -> Model ctx msg
withClassList classes =
    mapInputModel (Input.withClassList classes)


{-| Sets a Name to the Input Date.
-}
withName : String -> Model ctx msg -> Model ctx msg
withName name =
    mapInputModel (Input.withName name)


{-| Sets a Placeholder to the Input Date.
-}
withPlaceholder : String -> Model ctx msg -> Model ctx msg
withPlaceholder placeholder =
    mapInputModel (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Date.
-}
withSize : Size -> Model ctx msg -> Model ctx msg
withSize =
    Input.withSize >> mapInputModel


{-| Add a Validation set of rules to the Input Date.
-}
withValidation : (ctx -> Date -> Result String Date) -> Model ctx msg -> Model ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Model ctx msg -> Model ctx msg
withDisabled =
    Input.withDisabled >> mapInputModel


{-| Render the Input Date.
-}
render : Model ctx msg -> Html msg
render (Model configuration) =
    Input.render configuration.inputModel


{-| The update function.
-}
update : ctx -> Msg -> Model ctx msg -> Model ctx msg
update ctx msg model =
    case msg of
        OnBlur ->
            validate ctx model

        OnFocus ->
            model

        OnInput value ->
            setValue value model


inputDateToString : Date -> String
inputDateToString d =
    case d of
        Raw str ->
            str

        Parsed date ->
            Date.toIsoString date


{-| Internal.
-}
setValue : Date -> Model ctx msg -> Model ctx msg
setValue =
    inputDateToString >> Input.withValue >> mapInputModel


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx msg -> Model ctx msg
validate ctx ((Model { validation, inputModel }) as model) =
    let
        validationResult : Result String Date
        validationResult =
            model
                |> getValue
                |> validation ctx
    in
    model
        |> addFieldStatus (FieldStatus.fromResult validationResult)
        |> mapInputModel (Input.withErrorMessage (getErrorMessage validationResult))


{-| Internal.
-}
getErrorMessage : Result String x -> Maybe String
getErrorMessage result =
    case result of
        Ok _ ->
            Nothing

        Err error ->
            Just error


{-| Internal.
-}
addFieldStatus : FieldStatus -> Model ctx msg -> Model ctx msg
addFieldStatus fieldStatus (Model configuration) =
    Model { configuration | status = FieldStatus.addStatus fieldStatus configuration.status }


{-| Returns the current value of the Input Date.
-}
getValue : Model ctx msg -> Date
getValue (Model { inputModel }) =
    parseDate (Input.getValue inputModel)


{-| Returns the validated value of the Input Date.
-}
getValidatedValue : ctx -> Model ctx msg -> Result String Date
getValidatedValue ctx ((Model { validation }) as model) =
    model
        |> getValue
        |> validation ctx
