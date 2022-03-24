module Components.Field.Date exposing
    ( Model
    , init
    , Config
    , config
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
    , Date(..)
    , isParsed
    , isRaw
    , getValue
    , getParsedDateValue
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

@docs Date
@docs isParsed
@docs isRaw
@docs getValue
@docs getParsedDateValue


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


{-| Inits the date model.
If you wish to set an initial date for the Date component you should provide one in ISO format.

    initialParsedDateComponent : Date.Model ()
    initialParsedDateComponent =
        -- This will result in a Date.Parsed
        Date.init "2020-05-28" (always Ok)

    initialUnparsedDateComponent : Date.Model ()
    initialUnparsedDateComponent =
        -- This will result in a Date.Raw "28-05-2020"
        Date.init "28-05-2020" (always Ok)
            -- Also these date formats will fail parsing
            - "05-28-2020"
            - "28/05/2020"
            - "05/28/2020"

-}
init : String -> (ctx -> Date -> Result String Date) -> Model ctx
init initialValue validation =
    Model (Input.init initialValue (mapValidation validation))


{-| Internal.
-}
mapValidation : (ctx -> Date -> Result String Date) -> (ctx -> String -> Result String Date)
mapValidation validation ctx =
    parseDate >> validation ctx


{-| The view config.
-}
type Config msg
    = Config (Input.Config msg)


{-| Creates a <input type="date">.
-}
config : String -> Config msg
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
mapInputConfig : (Input.Config msg -> Input.Config msg) -> Config msg -> Config msg
mapInputConfig builder (Config configuration) =
    Config (builder configuration)


{-| Adds a Label to the Input.
-}
withLabel : Label.Config -> Config msg -> Config msg
withLabel =
    Input.withLabel >> mapInputConfig


{-| Sets a ClassList to the Input Date.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList =
    Input.withClassList >> mapInputConfig


{-| Adds the hint to the Input.
-}
withHint : String -> Config msg -> Config msg
withHint =
    Input.withHint >> mapInputConfig


{-| Sets a Name to the Input Date.
-}
withName : String -> Config msg -> Config msg
withName =
    Input.withName >> mapInputConfig


{-| Sets a Placeholder to the Input Date.
-}
withPlaceholder : String -> Config msg -> Config msg
withPlaceholder =
    Input.withPlaceholder >> mapInputConfig


{-| Sets a Size to the Input Date.
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
withIsSubmitted isSubmitted =
    mapInputConfig (Input.withIsSubmitted isSubmitted)


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled =
    Input.withDisabled >> mapInputConfig


{-| Append an additional custom html.
-}
withAdditionalContent : Html Never -> Config msg -> Config msg
withAdditionalContent =
    Input.withAdditionalContent >> mapInputConfig


{-| Render the Input Date.
-}
render : (Msg -> msg) -> ctx -> Model ctx -> Config msg -> Html msg
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


{-| Returns a parsed Date from the input[type="date"] value if possible.
-}
getParsedDateValue : Model ctx -> Maybe Date.Date
getParsedDateValue model =
    case getValue model of
        Parsed date ->
            Just date

        Raw _ ->
            Nothing
