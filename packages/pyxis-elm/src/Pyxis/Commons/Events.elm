module Pyxis.Commons.Events exposing
    ( PointerEvent, PointerType(..)
    , onClickPreventDefault, alwaysStopPropagationOn
    )

{-|


## Events utilities

@docs PointerEvent, PointerType
@docs onClickPreventDefault, alwaysStopPropagationOn

-}

import Html
import Html.Events
import Json.Decode


{-| The PointerEvent data
The decoding is very permissive in order to prevent weird
bugs in older browsers and fallbacks to Nothing instead of failing
-}
type alias PointerEvent =
    { pointerType : Maybe PointerType
    }


{-| The event .pointerType field
-}
type PointerType
    = Mouse
    | Pen
    | Touch


{-| Internal
-}
pointerEventDecoder : Json.Decode.Decoder PointerEvent
pointerEventDecoder =
    Json.Decode.map PointerEvent
        (Json.Decode.maybe (Json.Decode.field "pointerType" pointerTypeDecoder))


{-| Internal
-}
pointerTypeDecoder : Json.Decode.Decoder PointerType
pointerTypeDecoder =
    Json.Decode.andThen
        (\str ->
            case str of
                "mouse" ->
                    Json.Decode.succeed Mouse

                "pen" ->
                    Json.Decode.succeed Pen

                "touch" ->
                    Json.Decode.succeed Touch

                _ ->
                    Json.Decode.fail ""
        )
        Json.Decode.string


{-| A version of onClick that decodes extra data about the PointerEvent.
-}
onClickPreventDefault : (PointerEvent -> value) -> Html.Attribute value
onClickPreventDefault tagger =
    Html.Events.on "click" (Json.Decode.map tagger pointerEventDecoder)


{-| Stops propagation of a provided event.
-}
alwaysStopPropagationOn : String -> msg -> Html.Attribute msg
alwaysStopPropagationOn evt msg =
    Html.Events.stopPropagationOn evt (Json.Decode.succeed ( msg, True ))
