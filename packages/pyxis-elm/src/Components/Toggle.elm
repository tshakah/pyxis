module Components.Toggle exposing
    ( Config
    , config
    , withClassList
    , withId
    , withAriaLabel
    , withDisabled
    , withText
    , render
    )

{-|


# Toggle Component

@docs Config
@docs config


## Generics

@docs withClassList
@docs withId
@docs withAriaLabel
@docs withDisabled
@docs withText


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Render
import Commons.String
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events


{-| Internal. The internal Toggle configuration.
-}
type alias ConfigData msg =
    { ariaLabel : Maybe String
    , classList : List ( String, Bool )
    , disabled : Bool
    , id : Maybe String
    , text : Maybe String
    , onCheck : Bool -> msg
    }


{-| The Toggle configuration.
-}
type Config msg
    = Config (ConfigData msg)


config : (Bool -> msg) -> Config msg
config onCheck =
    Config
        { ariaLabel = Nothing
        , classList = []
        , disabled = False
        , id = Nothing
        , text = Nothing
        , onCheck = onCheck
        }


{-| Sets whether the Toggle should be disabled or not.
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled disabled (Config configuration) =
    Config { configuration | disabled = disabled }


{-| Sets an aria-label to the Toggle.
-}
withAriaLabel : String -> Config msg -> Config msg
withAriaLabel ariaLabel (Config configuration) =
    Config { configuration | ariaLabel = Just ariaLabel }


{-| Sets an id to the Toggle.
-}
withId : String -> Config msg -> Config msg
withId id (Config configuration) =
    Config { configuration | id = Just id }


{-| Adds a textual content to the Toggle.
-}
withText : String -> Config msg -> Config msg
withText text (Config configuration) =
    Config { configuration | text = Just text }


{-| Adds a classList to the Toggle.
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Renders the toggle.
-}
render : Bool -> Config msg -> Html msg
render value (Config { ariaLabel, classList, disabled, text, onCheck, id }) =
    Html.label
        [ Attributes.classList
            [ ( "toggle", True )
            , ( "toggle--disabled", disabled )
            ]
        , Attributes.classList classList
        , Commons.Attributes.maybe Attributes.id id
        , Commons.Attributes.maybe Commons.Attributes.testId id
        ]
        [ text
            |> Maybe.map Html.text
            |> Commons.Render.renderMaybe
        , Html.input
            [ Attributes.type_ "checkbox"
            , Attributes.class "toggle__input"
            , Attributes.attribute "aria-checked" (Commons.String.fromBool value)
            , Commons.Attributes.role "switch"
            , Attributes.disabled disabled
            , Attributes.checked value
            , Events.onCheck onCheck
            , Commons.Attributes.maybe Commons.Attributes.ariaLabel ariaLabel
            ]
            []
        ]
