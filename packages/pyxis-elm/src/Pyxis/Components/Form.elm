module Pyxis.Components.Form exposing
    ( Config
    , config
    , withFieldSets
    , withOnSubmit
    , render
    )

{-|


# Form

@docs Config

@docs config


## General

@docs withFieldSets
@docs withOnSubmit


## Rendering

@docs render

-}

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Pyxis.Commons.Attributes as CommonsAttributes
import Pyxis.Components.Form.FieldSet as FieldSet


{-| Represents a Form and its contents.
-}
type Config msg
    = Config (ConfigData msg)


{-| Internal.
-}
type alias ConfigData msg =
    { fieldSets : List (FieldSet.Config msg)
    , onSubmit : Maybe msg
    }


{-| Creates a Form without contents.
-}
config : Config msg
config =
    Config
        { fieldSets = []
        , onSubmit = Nothing
        }


{-| Adds a FieldSet list to the Form.
-}
withFieldSets : List (FieldSet.Config msg) -> Config msg -> Config msg
withFieldSets fieldSets (Config configuration) =
    Config { configuration | fieldSets = fieldSets }


{-| Add a onSubmit event to the Form.
-}
withOnSubmit : msg -> Config msg -> Config msg
withOnSubmit onSubmit (Config configuration) =
    Config { configuration | onSubmit = Just onSubmit }


{-| Renders the Form.
-}
render : Config msg -> Html msg
render (Config { onSubmit, fieldSets }) =
    Html.form
        [ Html.Attributes.class "form"
        , CommonsAttributes.maybe Html.Events.onSubmit onSubmit
        ]
        (List.map FieldSet.render fieldSets)
