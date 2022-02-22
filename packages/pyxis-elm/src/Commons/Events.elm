module Commons.Events exposing (PointerEvent, PointerType(..), onClick)

import Html
import Html.Events
import Json.Decode as Dec


{-| The PointerEvent data
The decoding is very permissive in order to prevent weird
bugs in older browsers and fallbacks to Nothing instead of failing
-}
type alias PointerEvent =
    { pointerType : Maybe PointerType
    }


{-| Internal
-}
type PointerType
    = Mouse
    | Pen
    | Touch


{-| Internal
-}
pointerEventDecoder : Dec.Decoder PointerEvent
pointerEventDecoder =
    Dec.map PointerEvent
        (Dec.field "pointerType" pointerTypeFieldDecoder)


{-| Internal
-}
pointerTypeFieldDecoder : Dec.Decoder (Maybe PointerType)
pointerTypeFieldDecoder =
    Dec.map
        (Maybe.andThen pointerTypeFromString)
        (Dec.nullable Dec.string)


{-| Internal
-}
pointerTypeFromString : String -> Maybe PointerType
pointerTypeFromString str =
    case str of
        "mouse" ->
            Just Mouse

        "pen" ->
            Just Pen

        "touch" ->
            Just Touch

        _ ->
            Nothing


{-| A version of onClick that decodes extra data about the PointerEvent
-}
onClick : (PointerEvent -> value) -> Html.Attribute value
onClick tagger =
    Html.Events.on "click" (Dec.map tagger pointerEventDecoder)
