module Pyxis.Components.Toggle exposing
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

import Html exposing (Html)
import Html.Attributes
import Html.Events
import Pyxis.Commons.Attributes as CommonsAttributes
import Pyxis.Commons.Render as CommonsRender
import Pyxis.Commons.String as CommonsString


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


{-| Inits the Toggle.

    type Msg
            = OnToggle Bool

        toggle : Bool -> Html Msg
        toggle initialState =
            Toggle.config OnToggle
                |> Toggle.render initialState

-}
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
        [ Html.Attributes.classList
            [ ( "toggle", True )
            , ( "toggle--disabled", disabled )
            ]
        , Html.Attributes.classList classList
        , CommonsAttributes.maybe Html.Attributes.id id
        , CommonsAttributes.maybe CommonsAttributes.testId id
        ]
        [ text
            |> Maybe.map Html.text
            |> CommonsRender.renderMaybe
        , Html.input
            [ Html.Attributes.type_ "checkbox"
            , Html.Attributes.class "toggle__input"
            , Html.Attributes.attribute "aria-checked" (CommonsString.fromBool value)
            , CommonsAttributes.role "switch"
            , Html.Attributes.disabled disabled
            , Html.Attributes.checked value
            , Html.Events.onCheck onCheck
            , CommonsAttributes.maybe CommonsAttributes.ariaLabel ariaLabel
            ]
            []
        ]
