module Components.Field.Text exposing
    ( Model
    , email
    , password
    , text
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
    )

{-|


# Input Text component

@docs Model
@docs email
@docs password
@docs text


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


{-| The Input Text model.
-}
type Model ctx msg
    = Model (Configuration ctx msg)


{-| Represent the messages which the Input Text can handle.
-}
type Msg
    = OnInput String
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


{-| Internal. Represents the Input Text configuration.
-}
type alias Configuration ctx msg =
    { status : FieldStatus.StatusList
    , inputModel : Input.Model msg
    , isSubmitted : Bool
    , msgTagger : Msg -> msg
    , validation : ctx -> String -> Result String String
    }


{-| Internal.
-}
create : (Input.Events msg -> String -> Input.Model msg) -> (Msg -> msg) -> String -> Model ctx msg
create initInputModel msgTagger id =
    Model
        { status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , inputModel =
            initInputModel
                { onInput = OnInput >> msgTagger
                , onFocus = msgTagger OnFocus
                , onBlur = msgTagger OnBlur
                }
                id
        , isSubmitted = False
        , msgTagger = msgTagger
        , validation = \_ str -> Ok str
        }


text : (Msg -> msg) -> String -> Model ctx msg
text =
    create Input.text


email : (Msg -> msg) -> String -> Model ctx msg
email =
    create Input.email


password : (Msg -> msg) -> String -> Model ctx msg
password =
    create Input.password


{-| Internal.
-}
mapInputModel : (Input.Model msg -> Input.Model msg) -> Model ctx msg -> Model ctx msg
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Sets an Addon to the Input Text
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


{-| Sets a default value to the Input Text.
-}
withDefaultValue : String -> Model ctx msg -> Model ctx msg
withDefaultValue defaultValue =
    setValue defaultValue
        >> addFieldStatus FieldStatus.default


{-| Sets a ClassList to the Input Text.
-}
withClassList : List ( String, Bool ) -> Model ctx msg -> Model ctx msg
withClassList classes =
    mapInputModel (Input.withClassList classes)


{-| Sets a Name to the Input Text.
-}
withName : String -> Model ctx msg -> Model ctx msg
withName name =
    mapInputModel (Input.withName name)


{-| Sets a Placeholder to the Input Text.
-}
withPlaceholder : String -> Model ctx msg -> Model ctx msg
withPlaceholder placeholder =
    mapInputModel (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Text.
-}
withSize : Size -> Model ctx msg -> Model ctx msg
withSize =
    Input.withSize >> mapInputModel


{-| Add a Validation set of rules to the Input Text.
-}
withValidation : (ctx -> String -> Result String String) -> Model ctx msg -> Model ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Model ctx msg -> Model ctx msg
withDisabled =
    Input.withDisabled >> mapInputModel


{-| Render the Input Text.
-}
render : Model ctx msg -> Html msg
render (Model configuration) =
    Input.render configuration.inputModel


{-| The update function.
-}
update : ctx -> Msg -> Model ctx msg -> Model ctx msg
update ctx msg =
    case msg of
        OnBlur ->
            validate ctx

        OnFocus ->
            identity

        OnInput value ->
            setValue value


{-| Internal.
-}
setValue : String -> Model ctx msg -> Model ctx msg
setValue value =
    mapInputModel (Input.withValue value)


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx msg -> Model ctx msg
validate ctx ((Model { validation, inputModel }) as model) =
    let
        validationResult : Result String String
        validationResult =
            inputModel
                |> Input.getValue
                |> validation ctx
    in
    model
        |> addFieldStatus (FieldStatus.fromResult validationResult)
        |> mapInputModel (Input.withErrorMessage (getErrorMessage validationResult))


{-| Internal.
-}
getErrorMessage : Result String String -> Maybe String
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


{-| Returns the current value of the Input Text.
-}
getValue : Model ctx msg -> String
getValue (Model { inputModel }) =
    Input.getValue inputModel


{-| Returns the validated value of the Input Text.
-}
getValidatedValue : ctx -> Model ctx msg -> Result String String
getValidatedValue ctx (Model { validation, inputModel }) =
    inputModel
        |> Input.getValue
        |> validation ctx
