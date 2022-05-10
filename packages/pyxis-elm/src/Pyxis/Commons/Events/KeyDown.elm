module Pyxis.Commons.Events.KeyDown exposing
    ( Event
    , decoder
    , isArrowDown
    , isArrowUp
    , isEnter
    , isEsc
    , isSpace
    , isTab
    , onKeyDown
    , onKeyDownPreventDefaultOn
    )

{-| Utilities for the keydown event
-}

import Html
import Html.Events
import Json.Decode


{-| An opaque type representing the keydown event data
-}
type Event
    = Event Int


{-| Returns True whether the keydown event was triggered by the " " char
-}
isSpace : Event -> Bool
isSpace =
    makePredicate 32


isTab : Event -> Bool
isTab =
    makePredicate 9


isEnter : Event -> Bool
isEnter =
    makePredicate 13


isArrowDown : Event -> Bool
isArrowDown =
    makePredicate 40


isArrowUp : Event -> Bool
isArrowUp =
    makePredicate 38


isEsc : Event -> Bool
isEsc =
    makePredicate 27


{-| Internal
-}
makePredicate : Int -> Event -> Bool
makePredicate match (Event code) =
    code == match


{-| Decodes a KeyDown.Event
-}
decoder : (Event -> msg) -> Json.Decode.Decoder msg
decoder tagger =
    Json.Decode.map (Event >> tagger) Html.Events.keyCode


{-| Keydown event attribute
-}
onKeyDown : (Event -> msg) -> Html.Attribute msg
onKeyDown tagger =
    Html.Events.on "keydown" (decoder tagger)


{-| Like [KeyDown.onKeyDown](#onKeyDown), but prevents default when the given flag is True
-}
onKeyDownPreventDefaultOn : (Event -> ( msg, Bool )) -> Html.Attribute msg
onKeyDownPreventDefaultOn tagger =
    Html.Events.preventDefaultOn "keydown" (decoder tagger)
