module Components.Field.Text exposing
    ( Model
    , create
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withAfterOnBlur
    , withAfterOnFocus
    , withAfterOnInput
    , withValidation
    , withClassList
    , withDefaultValue
    , withDisabled
    , withName
    , withPlaceholder
    , Msg
    , update
    , getValue
    , render
    )

{-|


# Input Text component

@docs Model
@docs create


## Addon

@docs iconAddon
@docs textAddon
@docs withAddon


## Size

@docs withSize


## Callbacks

@docs withAfterOnBlur
@docs withAfterOnFocus
@docs withAfterOnInput


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
@docs update


## Readers

@docs getValue


## Rendering

@docs render

-}

import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Properties.Placement exposing (Placement)
import Commons.Properties.Size exposing (Size)
import Commons.Validation as Validation exposing (Validation)
import Components.Field.Input as Input
import Components.IconSet as IconSet
import Html exposing (Html)
import PrimaFunction
import PrimaUpdate


{-| The Input Text model.
-}
type Model msg
    = Model (Configuration msg)


{-| Represent the messages which the Input Text can handle.
-}
type Msg
    = OnInput String
    | OnFocus
    | OnBlur


{-| Internal. Represents the Input Text configuration.
-}
type alias Configuration msg =
    { afterOnBlur : Cmd msg
    , afterOnFocus : Cmd msg
    , afterOnInput : Cmd msg
    , status : FieldStatus.StatusList
    , inputModel : Input.Model msg
    , isSubmitted : Bool
    , msgTagger : Msg -> msg
    , validation : Validation (Maybe String)
    , value : Maybe String
    }


{-| Creates the Input Text.
-}
create : (Msg -> msg) -> String -> Model msg
create msgTagger id =
    Model
        { afterOnBlur = Cmd.none
        , afterOnFocus = Cmd.none
        , afterOnInput = Cmd.none
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , inputModel = initInputModel id msgTagger
        , isSubmitted = False
        , msgTagger = msgTagger
        , validation = Validation.create []
        , value = Nothing
        }


{-| Internal.
-}
initInputModel : String -> (Msg -> msg) -> Input.Model msg
initInputModel id tagger =
    Input.text
        { onInput = OnInput >> tagger
        , onFocus = tagger OnFocus
        , onBlur = tagger OnBlur
        }
        id


{-| Internal.
-}
mapInputModel : (Input.Model msg -> Input.Model msg) -> Model msg -> Model msg
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Sets an Addon to the Input Text
-}
withAddon : Placement -> Input.AddonType -> Model msg -> Model msg
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


{-| Sets a Cmd to be executed after OnBlur message has been triggered.
-}
withAfterOnBlur : Cmd msg -> Model msg -> Model msg
withAfterOnBlur cmd (Model configuration) =
    Model { configuration | afterOnBlur = cmd }


{-| Sets a Cmd to be executed after OnFocus message has been triggered.
-}
withAfterOnFocus : Cmd msg -> Model msg -> Model msg
withAfterOnFocus cmd (Model configuration) =
    Model { configuration | afterOnFocus = cmd }


{-| Sets a Cmd to be executed after OnBlur message has been triggered.
-}
withAfterOnInput : Cmd msg -> Model msg -> Model msg
withAfterOnInput cmd (Model configuration) =
    Model { configuration | afterOnInput = cmd }


{-| Sets a default value to the Input Text.
-}
withDefaultValue : String -> Model msg -> Model msg
withDefaultValue defaultValue (Model configuration) =
    Model { configuration | value = Just defaultValue }
        |> addFieldStatus FieldStatus.default


{-| Sets a ClassList to the Input Text.
-}
withClassList : List ( String, Bool ) -> Model msg -> Model msg
withClassList classes =
    mapInputModel (Input.withClassList classes)


{-| Sets a Name to the Input Text.
-}
withName : String -> Model msg -> Model msg
withName name =
    mapInputModel (Input.withName name)


{-| Sets a Placeholder to the Input Text.
-}
withPlaceholder : String -> Model msg -> Model msg
withPlaceholder placeholder =
    mapInputModel (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Text.
-}
withSize : Size -> Model msg -> Model msg
withSize =
    Input.withSize >> mapInputModel


{-| Add a Validation set of rules to the Input Text.
-}
withValidation : List (Maybe String -> Validation.Response) -> Model msg -> Model msg
withValidation checks (Model configuration) =
    Model { configuration | validation = Validation.create checks }


{-| Sets the input as disabled
-}
withDisabled : Bool -> Model msg -> Model msg
withDisabled =
    Input.withDisabled >> mapInputModel


{-| Render the Input Text.
-}
render : Model msg -> Html msg
render (Model configuration) =
    Input.render configuration.inputModel


{-| The update function.
-}
update : Msg -> Model msg -> ( Model msg, Cmd msg )
update msg ((Model configuration) as model) =
    case msg of
        OnBlur ->
            model
                |> validateAndUpdateStatus
                |> PrimaUpdate.withCmd configuration.afterOnBlur

        OnFocus ->
            model
                |> PrimaUpdate.withCmd configuration.afterOnFocus

        OnInput value ->
            model
                |> setValue value
                |> PrimaUpdate.withCmd configuration.afterOnInput


{-| Internal.
-}
setValue : String -> Model msg -> Model msg
setValue value (Model configuration) =
    Model { configuration | value = Just value }


{-| Internal.
-}
validateAndUpdateStatus : Model msg -> Model msg
validateAndUpdateStatus ((Model { validation, value }) as model) =
    addFieldStatus
        (PrimaFunction.ifThenElse
            (Validation.passed value validation)
            FieldStatus.valid
            (validation
                |> Validation.errorMessages value
                |> List.head
                |> Maybe.withDefault ""
                |> FieldStatus.error
            )
        )
        model


{-| Internal.
-}
addFieldStatus : FieldStatus -> Model msg -> Model msg
addFieldStatus fieldStatus (Model configuration) =
    Model { configuration | status = FieldStatus.addStatus fieldStatus configuration.status }


{-| Returns the current value of the Input Text.
-}
getValue : Model msg -> Maybe String
getValue (Model configuration) =
    configuration.value
