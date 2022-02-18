module Components.Field.Error exposing
    ( Config
    , create
    , withId
    , render
    , toId
    , fromResult
    )

{-|


# Error

@docs Config
@docs create


## Generics

@docs withId


## Rendering

@docs render


## Utils

@docs toId
@docs fromResult

-}

import Commons.Attributes
import Html
import Html.Attributes as Attributes


{-| Represent a form field error.
-}
type Config
    = Config
        { message : String
        , id : Maybe String
        }


{-| Creates an error message.
-}
create : String -> Config
create message =
    Config { id = Nothing, message = message }


{-| Adds an id to the error.
-}
withId : String -> Config -> Config
withId a (Config configuration) =
    Config { configuration | id = Just (toId a) }


{-| Given the field id returns an errorId.
-}
toId : String -> String
toId fieldId =
    fieldId ++ "-error"


{-| Tries to create an error from a Result.Err.
-}
fromResult : Result String value -> Maybe Config
fromResult result =
    case result of
        Ok _ ->
            Nothing

        Err errorMessage ->
            Just (create errorMessage)


{-| View the error message
-}
render : Config -> Html.Html msg
render (Config { id, message }) =
    Html.div
        [ Attributes.class "form-field__error-message"
        , Commons.Attributes.maybe Attributes.id id
        ]
        [ Html.text message ]
