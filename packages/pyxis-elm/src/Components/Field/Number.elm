module Components.Field.Number exposing
    ( Model
    , init
    , Config
    , config
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withAdditionalContent
    , withClassList
    , withDisabled
    , withHint
    , withIsSubmitted
    , withLabel
    , withName
    , withPlaceholder
    , withStrategy
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

@docs withAdditionalContent
@docs withClassList
@docs withDisabled
@docs withHint
@docs withIsSubmitted
@docs withLabel
@docs withName
@docs withPlaceholder
@docs withStrategy


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
import Components.Field.Error.Strategy exposing (Strategy)
import Components.Field.Input as Input
import Components.Field.Label as Label
import Components.IconSet as IconSet
import Html exposing (Html)


{-| The Input Number model.
-}
type Model ctx
    = Model (Input.Model ctx Int)


{-| Inits the model.
-}
init : String -> (ctx -> Int -> Result String Int) -> Model ctx
init initialValue validation =
    Model (Input.init initialValue (mapValidation validation))


{-| Internal.
-}
mapValidation : (ctx -> Int -> Result String Int) -> (ctx -> String -> Result String Int)
mapValidation validation ctx =
    String.toInt >> Maybe.withDefault 0 >> validation ctx


{-| The view configuration.
-}
type Config msg
    = Config (Input.Config msg)


{-| Creates the Model of an Input of type="number"
-}
config : String -> Config msg
config =
    Input.number >> Config


{-| Represent the messages the Input Text can handle.
-}
type Msg
    = InputMsg Input.Msg


{-| Returns True if the message is triggered by `Html.Events.onInput`
-}
isOnInput : Msg -> Bool
isOnInput (InputMsg msg) =
    Input.isOnInput msg


{-| Returns True if the message is triggered by `Html.Events.onFocus`
-}
isOnFocus : Msg -> Bool
isOnFocus (InputMsg msg) =
    Input.isOnFocus msg


{-| Returns True if the message is triggered by `Html.Events.onBlur`
-}
isOnBlur : Msg -> Bool
isOnBlur (InputMsg msg) =
    Input.isOnBlur msg


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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config msg -> Config msg
withStrategy strategy =
    mapInputConfig (Input.withStrategy strategy)


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config msg -> Config msg
withIsSubmitted b =
    mapInputConfig (Input.withIsSubmitted b)


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


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config msg -> Config msg
withAdditionalContent =
    Input.withAdditionalContent >> mapInputConfig


{-| Render the Input Number.
-}
render : (Msg -> msg) -> ctx -> Model ctx -> Config msg -> Html msg
render tagger ctx (Model inputModel) (Config configuration) =
    Input.render (InputMsg >> tagger) ctx inputModel configuration


{-| The update function.
-}
update : Msg -> Model ctx -> Model ctx
update (InputMsg msg) (Model model) =
    Model (Input.update msg model)


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx -> Result String Int
validate ctx (Model inputModel) =
    Input.validate ctx inputModel


{-| Returns the current value of the Input Number.
-}
getValue : Model ctx -> Int
getValue (Model inputModel) =
    inputModel
        |> Input.getValue
        |> String.toInt
        |> Maybe.withDefault 0
