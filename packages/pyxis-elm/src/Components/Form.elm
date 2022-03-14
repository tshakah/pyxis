module Components.Form exposing
    ( Config
    , config
    , withFieldSets
    , render
    )

{-|


# Form

@docs Config

@docs config


## FieldSets

@docs withFieldSets


## Rendering

@docs render

-}

import Components.Form.FieldSet as FieldSet
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Form and its contents.
-}
type Config msg
    = Config (ConfigData msg)


{-| Internal.
-}
type alias ConfigData msg =
    { fieldSets : List (FieldSet.Config msg)
    }


{-| Creates a Form without contents.
-}
config : Config msg
config =
    Config { fieldSets = [] }


{-| Adds a FieldSet list to the Form.
-}
withFieldSets : List (FieldSet.Config msg) -> Config msg -> Config msg
withFieldSets fieldSets (Config configuration) =
    Config { configuration | fieldSets = fieldSets }


{-| Renders the Form.
-}
render : Config msg -> Html msg
render (Config configuration) =
    Html.form
        [ Attributes.class "form" ]
        (List.map FieldSet.render configuration.fieldSets)
