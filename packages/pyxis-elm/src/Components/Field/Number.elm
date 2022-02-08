module Components.Field.Number exposing
    ( Model
    , iconAddon
    , textAddon
    , withAddon
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
    , render
    , create
    )

{-|


# Input Number component

@docs Model
@docs create


## Addon

@docs iconAddon
@docs textAddon
@docs withAddon


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

@docs getValue
@docs getValidatedValue


## Rendering

@docs render

-}

import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Properties.Placement exposing (Placement)
import Commons.Properties.Size exposing (Size)
import Components.Field.Input as Input
import Components.IconSet as IconSet
import Html exposing (Html)


{-| The Input Numer model.
-}
type Model ctx msg
    = Model (Configuration ctx msg)


{-| Represent the messages which the Input Number can handle.
-}
type Msg
    = OnInput Int
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


{-| Internal. Represents the Input Number configuration.
-}
type alias Configuration ctx msg =
    { status : FieldStatus.StatusList
    , inputModel : Input.Model msg
    , isSubmitted : Bool
    , msgTagger : Msg -> msg
    , validation : ctx -> Int -> Result String Int
    }


{-| Creates the Model of an Input of type="number"
-}
create : (Msg -> msg) -> String -> Model ctx msg
create msgTagger id =
    Model
        { status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , inputModel =
            Input.number
                { onInput = String.toInt >> Maybe.withDefault 0 >> OnInput >> msgTagger
                , onFocus = msgTagger OnFocus
                , onBlur = msgTagger OnBlur
                }
                id
        , isSubmitted = False
        , msgTagger = msgTagger
        , validation = always Ok
        }


{-| Internal.
-}
mapInputModel : (Input.Model msg -> Input.Model msg) -> Model ctx msg -> Model ctx msg
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Sets an Addon to the Input Number
-}
withAddon : Placement -> Input.AddonType -> Model ctx msg -> Model ctx msg
withAddon placement addon =
    addon
        |> Input.withAddon placement
        |> mapInputModel


{-| Creates an Addon with an Icon from our IconSet.
-}
iconAddon : IconSet.Icon -> Input.AddonType
iconAddon =
    Input.iconAddon


{-| Creates an Addon with a String content.
-}
textAddon : String -> Input.AddonType
textAddon =
    Input.textAddon


{-| Sets a default value to the Input Number.
-}
withDefaultValue : Int -> Model ctx msg -> Model ctx msg
withDefaultValue defaultValue =
    setValue defaultValue
        >> addFieldStatus FieldStatus.default


{-| Sets a ClassList to the Input Number.
-}
withClassList : List ( String, Bool ) -> Model ctx msg -> Model ctx msg
withClassList classes =
    mapInputModel (Input.withClassList classes)


{-| Sets a Name to the Input Number.
-}
withName : String -> Model ctx msg -> Model ctx msg
withName name =
    mapInputModel (Input.withName name)


{-| Sets a Placeholder to the Input Number.
-}
withPlaceholder : String -> Model ctx msg -> Model ctx msg
withPlaceholder placeholder =
    mapInputModel (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Number.
-}
withSize : Size -> Model ctx msg -> Model ctx msg
withSize =
    Input.withSize >> mapInputModel


{-| Add a Validation set of rules to the Input Number.
-}
withValidation : (ctx -> Int -> Result String Int) -> Model ctx msg -> Model ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Model ctx msg -> Model ctx msg
withDisabled =
    Input.withDisabled >> mapInputModel


{-| Render the Input Number.
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


{-| Internal.
-}
setValue : Int -> Model ctx msg -> Model ctx msg
setValue value =
    mapInputModel (Input.withValue (String.fromInt value))


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx msg -> Model ctx msg
validate ctx ((Model { validation, inputModel }) as model) =
    let
        validationResult : Result String Int
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


{-| Returns the current value of the Input Number.
-}
getValue : Model ctx msg -> Int
getValue (Model { inputModel }) =
    inputModel
        |> Input.getValue
        |> String.toInt
        |> Maybe.withDefault 0


{-| Returns the validated value of the Input Number.
-}
getValidatedValue : ctx -> Model ctx msg -> Result String Int
getValidatedValue ctx ((Model { validation }) as model) =
    model
        |> getValue
        |> validation ctx
