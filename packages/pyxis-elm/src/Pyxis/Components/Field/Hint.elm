module Pyxis.Components.Field.Hint exposing (Config, config, render, toId, withFieldId)

import Html exposing (Html)
import Html.Attributes
import Pyxis.Commons.Attributes as CommonsAttributes


{-| Represent a form field hint.
-}
type Config
    = Config
        { message : String
        , id : Maybe String
        }


{-| Creates an hint message.
-}
config : String -> Config
config message =
    Config { id = Nothing, message = message }


{-| Adds an id to the hint.
-}
withFieldId : String -> Config -> Config
withFieldId a (Config configuration) =
    Config { configuration | id = Just (toId a) }


{-| Given the field id returns an hintId.
-}
toId : String -> String
toId fieldId =
    fieldId ++ "-hint"


render : Config -> Html msg
render (Config { id, message }) =
    Html.div
        [ Html.Attributes.class "form-item__hint"
        , CommonsAttributes.maybe Html.Attributes.id id
        ]
        [ Html.text message
        ]
