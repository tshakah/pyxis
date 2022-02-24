module Components.Field.Number exposing
    ( Model
    , init
    , Config
    , config
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withLabel
    , withClassList
    , withDisabled
    , withHint
    , withName
    , withPlaceholder
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
    , validate
    , getValue
    , render
    )

{-|


# Input Number component

@docs Model
@docs init


## Configuration

@docs Config
@docs config


## Addon

@docs iconAddon
@docs textAddon
@docs withAddon


## Size

@docs withSize


## Generics

@docs withLabel
@docs withClassList
@docs withDisabled
@docs withHint
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


## Rendering

@docs render

-}

import Commons.Properties.Placement exposing (Placement)
import Commons.Properties.Size exposing (Size)
import Components.Field.Input as Input
import Components.Field.Label as Label
import Components.IconSet as IconSet
import Html exposing (Html)


{-| The Input Number model.
-}
type Model ctx
    = Model
        { inputModel : Input.Model ctx Int
        }


{-| Inits the model.
-}
init : (ctx -> Int -> Result String Int) -> Model ctx
init validation =
    Model
        { inputModel = Input.init (String.toInt >> Maybe.withDefault 0) validation
        }


{-| The view configuration.
-}
type Config msg
    = Config (Input.Config msg)


{-| Creates the Model of an Input of type="number"
-}
config : (Msg -> msg) -> String -> Config msg
config tagger id =
    Config
        (Input.number
            { onInput = String.toInt >> Maybe.withDefault 0 >> OnInput >> tagger
            , onFocus = tagger OnFocus
            , onBlur = tagger OnBlur
            }
            id
        )


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


{-| Internal.
-}
mapInputModel : (Input.Model ctx Int -> Input.Model ctx Int) -> Model ctx -> Model ctx
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Internal.
-}
mapInputConfig : (Input.Config msg -> Input.Config msg) -> Config msg -> Config msg
mapInputConfig builder (Config configuration) =
    Config (builder configuration)


{-| Sets an Addon to the Input Number
-}
withAddon : Placement -> Input.AddonType -> Config msg -> Config msg
withAddon placement addon =
    addon
        |> Input.withAddon placement
        |> mapInputConfig


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


{-| Adds a Label to the Input.
-}
withLabel : Label.Config -> Config msg -> Config msg
withLabel label =
    mapInputConfig (Input.withLabel label)


{-| Sets a ClassList to the Input Number.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classes =
    mapInputConfig (Input.withClassList classes)


{-| Sets a Name to the Input Number.
-}
withName : String -> Config msg -> Config msg
withName name =
    mapInputConfig (Input.withName name)


{-| Sets a Placeholder to the Input Number.
-}
withPlaceholder : String -> Config msg -> Config msg
withPlaceholder placeholder =
    mapInputConfig (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Number.
-}
withSize : Size -> Config msg -> Config msg
withSize =
    Input.withSize >> mapInputConfig


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled =
    Input.withDisabled >> mapInputConfig


{-| Adds the hint to the Input.
-}
withHint : String -> Config msg -> Config msg
withHint hint =
    mapInputConfig (Input.withHint hint)


{-| Render the Input Number.
-}
render : ctx -> Model ctx -> Config msg -> Html msg
render ctx (Model state) (Config configuration) =
    Input.render ctx state.inputModel configuration


{-| The update function.
-}
update : Msg -> Model ctx -> Model ctx
update msg model =
    case msg of
        OnBlur ->
            model

        OnFocus ->
            model

        OnInput value ->
            setValue value model


{-| Internal.
-}
setValue : Int -> Model ctx -> Model ctx
setValue value =
    mapInputModel (Input.setValue (String.fromInt value))


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx -> Result String Int
validate ctx (Model { inputModel }) =
    Input.validate ctx inputModel


{-| Returns the current value of the Input Number.
-}
getValue : Model ctx -> Int
getValue (Model { inputModel }) =
    inputModel
        |> Input.getValue
        |> String.toInt
        |> Maybe.withDefault 0
