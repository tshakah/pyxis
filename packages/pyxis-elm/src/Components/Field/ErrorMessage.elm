module Components.Field.ErrorMessage exposing
    ( id
    , view
    )

import Commons.Attributes
import Html
import Html.Attributes as Attributes


{-| Returns the error id
-}
id : String -> String
id id_ =
    id_ ++ "-error"


{-| View the error message
-}
view : Maybe String -> String -> Html.Html msg
view maybeId errorMessage =
    Html.div
        [ Attributes.class "form-field__error-message"
        , Commons.Attributes.maybe (id >> Attributes.id) maybeId
        ]
        [ Html.text errorMessage ]
