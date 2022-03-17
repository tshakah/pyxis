module Components.Field.Text exposing
    ( Model
    , init
    , Config
    , email
    , password
    , text
    , iconAddon
    , textAddon
    , withAddon
    , withSize
    , withClassList
    , withDisabled
    , withHint
    , withIsSubmitted
    , withLabel
    , withName
    , withPlaceholder
    , withStrategy
    , withValueMapper
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


# Text component

@docs Model
@docs init


## Config

@docs Config
@docs email
@docs password
@docs text


## Addon

@docs iconAddon
@docs textAddon
@docs withAddon


## Size

@docs withSize


## Generics

@docs withClassList
@docs withDisabled
@docs withHint
@docs withIsSubmitted
@docs withLabel
@docs withName
@docs withPlaceholder
@docs withStrategy
@docs withValueMapper


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


{-| The Text Model. This should be stored on your model.
-}
type Model ctx
    = Model (Input.Model ctx String)


{-| Internal.
-}
init : String -> (ctx -> String -> Result String String) -> Model ctx
init initialValue validation =
    Model (Input.init initialValue validation)


{-| The view configuration.
-}
type Config
    = Config Input.Config


{-| Creates a <input type="text">.
-}
text : String -> Config
text =
    Input.text >> Config


{-| Creates a <input type="email">.
-}
email : String -> Config
email =
    Input.email >> Config


{-| Creates a <input type="password">.
-}
password : String -> Config
password =
    Input.password >> Config


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


{-| Sets an Addon to the Input Text
-}
withAddon : Placement -> Input.AddonType -> Config -> Config
withAddon placement addon =
    addon
        |> Input.withAddon placement
        |> mapInputConfig


{-| Maps the inputted string before the update

    Text.config "id"
        |> Text.withValueMapper String.toUppercase
        |> Text.render Tagger formData model.textModel

In this example, if the user inputs "abc", the actual inputted text is "ABC".
This applies to both the user UI and the `getValue`/`validate` functions

-}
withValueMapper : (String -> String) -> Config -> Config
withValueMapper mapper =
    mapInputConfig (Input.withValueMapper mapper)


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


{-| Sets a ClassList to the Input Text.
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classes =
    mapInputConfig (Input.withClassList classes)


{-| Sets a Name to the Input Text.
-}
withName : String -> Config -> Config
withName name =
    mapInputConfig (Input.withName name)


{-| Sets a Placeholder to the Input Text.
-}
withPlaceholder : String -> Config -> Config
withPlaceholder placeholder =
    mapInputConfig (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Text.
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


{-| Sets the validation strategy (when to show the error, if present)
-}
withStrategy : Strategy -> Config -> Config
withStrategy strategy =
    mapInputConfig (Input.withStrategy strategy)


{-| Sets whether the form was submitted
-}
withIsSubmitted : Bool -> Config -> Config
withIsSubmitted b =
    mapInputConfig (Input.withIsSubmitted b)


{-| Render the Input Text.
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
validate : ctx -> Model ctx -> Result String String
validate ctx (Model inputModel) =
    Input.validate ctx inputModel


{-| Returns the current value of the Input Text.
-}
getValue : Model ctx -> String
getValue (Model inputModel) =
    Input.getValue inputModel
