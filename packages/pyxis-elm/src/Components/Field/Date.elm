module Components.Field.Date exposing
    ( Model
    , init
    , Config
    , config
    , withSize
    , withLabel
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


## Rendering

@docs render

-}

import Commons.Properties.Placement as Placement
import Commons.Properties.Size exposing (Size)
import Components.Field.Input as Input
import Components.Field.Label as Label
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


{-| The input date model.
-}
type Model ctx
    = Model
        { inputModel : Input.Model ctx Date
        }


{-| Inits the date model.
-}
init : (ctx -> Date -> Result String Date) -> Model ctx
init validation =
    Model
        { inputModel = Input.init parseDate validation
        }


{-| The view config.
-}
type Config msg
    = Config (Input.Config msg)


{-| Creates a <input type="date">.
-}
config : (Msg -> msg) -> String -> Config msg
config tagger id =
    Config
        (id
            |> Input.date
                { onInput = parseDate >> OnInput >> tagger
                , onFocus = tagger OnFocus
                , onBlur = tagger OnBlur
                }
            |> Input.withAddon Placement.prepend (Input.iconAddon IconSet.Calendar)
        )


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


parseDate : String -> Date
parseDate str =
    str
        |> Date.fromIsoString
        |> Result.map Parsed
        |> Result.withDefault (Raw str)


{-| Internal.
-}
mapInputModel : (Input.Model ctx Date -> Input.Model ctx Date) -> Model ctx -> Model ctx
mapInputModel builder (Model configuration) =
    Model { configuration | inputModel = builder configuration.inputModel }


{-| Internal.
-}
mapInputConfig : (Input.Config msg -> Input.Config msg) -> Config msg -> Config msg
mapInputConfig builder (Config configuration) =
    Config (builder configuration)


{-| Adds a Label to the Input.
-}
withLabel : Label.Model -> Config msg -> Config msg
withLabel label =
    mapInputConfig (Input.withLabel label)


{-| Sets a default value to the Input Date.
-}
withDefaultValue : Date.Date -> Model ctx -> Model ctx
withDefaultValue defaultValue =
    setValue (Parsed defaultValue)


{-| Sets a ClassList to the Input Date.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classes =
    mapInputConfig (Input.withClassList classes)


{-| Sets a Name to the Input Date.
-}
withName : String -> Config msg -> Config msg
withName name =
    mapInputConfig (Input.withName name)


{-| Sets a Placeholder to the Input Date.
-}
withPlaceholder : String -> Config msg -> Config msg
withPlaceholder placeholder =
    mapInputConfig (Input.withPlaceholder placeholder)


{-| Sets a Size to the Input Date.
-}
withSize : Size -> Config msg -> Config msg
withSize =
    Input.withSize >> mapInputConfig


{-| Sets the input as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled =
    Input.withDisabled >> mapInputConfig


{-| Render the Input Date.
-}
render : ctx -> Model ctx -> Config msg -> Html msg
render ctx (Model state) (Config configuration) =
    Input.render ctx state.inputModel configuration


{-| The update function.
-}
update : ctx -> Msg -> Model ctx -> Model ctx
update ctx msg model =
    case msg of
        OnBlur ->
            model

        OnFocus ->
            model

        OnInput value ->
            setValue value model


{-| Internal.
-}
inputDateToString : Date -> String
inputDateToString d =
    case d of
        Raw str ->
            str

        Parsed date ->
            Date.toIsoString date


{-| Internal.
-}
setValue : Date -> Model ctx -> Model ctx
setValue =
    inputDateToString >> Input.setValue >> mapInputModel


{-| Returns the validated value by running the function you gave to the init.
-}
validate : ctx -> Model ctx -> Result String Date
validate ctx (Model { inputModel }) =
    Input.validate ctx inputModel


{-| Returns the current value of the Input Date.
-}
getValue : Model ctx -> Date
getValue (Model { inputModel }) =
    parseDate (Input.getValue inputModel)
