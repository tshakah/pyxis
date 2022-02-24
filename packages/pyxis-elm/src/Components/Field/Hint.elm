module Components.Field.Hint exposing (Config, config, render, toId, withFieldId)

import Commons.Attributes
import Html exposing (Html)
import Html.Attributes as Attributes


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
        [ Attributes.class "form-item__hint"
        , Commons.Attributes.maybe Attributes.id id
        ]
        [ Html.text message
        ]
