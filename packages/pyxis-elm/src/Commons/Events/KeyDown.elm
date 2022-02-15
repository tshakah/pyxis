module Commons.Events.KeyDown exposing
    ( Event
    , decoder
    , isSpace
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
    makePredicate 42


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
