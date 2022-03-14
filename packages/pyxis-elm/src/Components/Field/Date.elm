module Components.Field.Date exposing
    ( Model
    , init
    , Config
    , config
    , withSize
    , withLabel
    , withClassList
    , withDisabled
    , withHint
    , withName
    , withPlaceholder
    , withStrategy
    , withIsSubmitted
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
    , validate
    , Date(..)
    , isParsed
    , isRaw
    , getValue
    , render
    )

{-|


# Input Date component

@docs Model
@docs init


## Config

@docs Config
@docs config


## Size

@docs withSize


## Generics

@docs withLabel
@docs withClassList
@docs withDisabled
@docs withHint
@docs withName
@docs withPlaceholder
@docs withStrategy
@docs withIsSubmitted


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


## Rendering

@docs render

-}

import Commons.Properties.Size exposing (Size)
import Components.Field.Error.Strategy exposing (Strategy)
import Components.Field.Input as Input
import Components.Field.Label as Label
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


{-| The input date model.
-}
type Model ctx
    = Model (Input.Model ctx Date)


wrapValidation : (ctx -> Date -> Result String Date) -> (ctx -> String -> Result String Date)
wrapValidation validation ctx =
    parseDate >> validation ctx


{-| Inits the date model.
-}
init : (ctx -> Date -> Result String Date) -> Model ctx
init validation =
    Model (Input.init (wrapValidation validation))


{-| The view config.
-}
type Config
    = Config Input.Config


{-| Creates a <input type="date">.
-}
config : String -> Config
config =
    Input.date >> Config


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


parseDate : String -> Date
parseDate str =
    str
        |> Date.fromIsoString
        |> Result.map Parsed
        |> Result.withDefault (Raw str)


{-| Internal.
-}
mapInputConfig : (Input.Config -> Input.Config) -> Config -> Config
mapInputConfig builder (Config configuration) =
    Config (builder configuration)


{-| Adds a Label to the Input.
-}
withLabel : Label.Config -> Config -> Config
withLabel =
    Input.withLabel >> mapInputConfig


{-| Sets a ClassList to the Input Date.
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList =
    Input.withClassList >> mapInputConfig


{-| Adds the hint to the Input.
-}
withHint : String -> Config -> Config
withHint =
    Input.withHint >> mapInputConfig


{-| Sets a Name to the Input Date.
-}
withName : String -> Config -> Config
withName =
    Input.withName >> mapInputConfig


{-| Sets a Placeholder to the Input Date.
-}
withPlaceholder : String -> Config -> Config
withPlaceholder =
    Input.withPlaceholder >> mapInputConfig


{-| Sets a Size to the Input Date.
-}
withSize : Size -> Config -> Config
withSize =
    Input.withSize >> mapInputConfig


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


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config -> Config
withDisabled =
    Input.withDisabled >> mapInputConfig


{-| Render the Input Date.
-}
render : (Msg -> msg) -> ctx -> Model ctx -> Config -> Html msg
render tagger ctx (Model inputModel) (Config inputConfig) =
    Input.render (InputMsg >> tagger) ctx inputModel inputConfig


{-| The update function.
-}
update : Msg -> Model ctx -> Model ctx
update (InputMsg msg) (Model model) =
    Model (Input.update msg model)


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx -> Result String Date
validate ctx (Model inputModel) =
    Input.validate ctx inputModel


{-| Returns the current value of the Input Date.
-}
getValue : Model ctx -> Date
getValue (Model inputModel) =
    parseDate (Input.getValue inputModel)
