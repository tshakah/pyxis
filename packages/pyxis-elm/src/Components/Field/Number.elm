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
    = Model (Input.Model ctx Int)


wrapValidation : (ctx -> Int -> Result String Int) -> (ctx -> String -> Result String Int)
wrapValidation validation ctx =
    String.toInt >> Maybe.withDefault 0 >> validation ctx


{-| Inits the model.
-}
init : (ctx -> Int -> Result String Int) -> Model ctx
init validation =
    Model (Input.init (wrapValidation validation))


{-| The view configuration.
-}
type Config
    = Config Input.Config


{-| Creates the Model of an Input of type="number"
-}
config : String -> Config
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
mapInputConfig : (Input.Config -> Input.Config) -> Config -> Config
mapInputConfig builder (Config configuration) =
    Config (builder configuration)


{-| Sets an Addon to the Input Number
-}
withAddon : Placement -> Input.AddonType -> Config -> Config
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
withLabel : Label.Config -> Config -> Config
withLabel label =
    mapInputConfig (Input.withLabel label)


{-| Sets a ClassList to the Input Number.
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classes =
    mapInputConfig (Input.withClassList classes)


{-| Sets a Name to the Input Number.
-}
withName : String -> Config -> Config
withName name =
    mapInputConfig (Input.withName name)


{-| Sets a Placeholder to the Input Number.
-}
withPlaceholder : String -> Config -> Config
withPlaceholder placeholder =
    mapInputConfig (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Number.
-}
withSize : Size -> Config -> Config
withSize =
    Input.withSize >> mapInputConfig


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config -> Config
withDisabled =
    Input.withDisabled >> mapInputConfig


{-| Adds the hint to the Input.
-}
withHint : String -> Config -> Config
withHint hint =
    mapInputConfig (Input.withHint hint)


{-| Render the Input Number.
-}
render : (Msg -> msg) -> ctx -> Model ctx -> Config -> Html msg
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
