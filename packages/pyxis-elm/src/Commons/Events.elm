module Commons.Events exposing
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
import Json.Decode as Dec


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
pointerEventDecoder : Dec.Decoder PointerEvent
pointerEventDecoder =
    Dec.map PointerEvent
        (Dec.maybe (Dec.field "pointerType" pointerTypeDecoder))


{-| Internal
-}
pointerTypeDecoder : Dec.Decoder PointerType
pointerTypeDecoder =
    Dec.andThen
        (\str ->
            case str of
                "mouse" ->
                    Dec.succeed Mouse

                "pen" ->
                    Dec.succeed Pen

                "touch" ->
                    Dec.succeed Touch

                _ ->
                    Dec.fail ""
        )
        Dec.string


{-| A version of onClick that decodes extra data about the PointerEvent.
-}
onClickPreventDefault : (PointerEvent -> value) -> Html.Attribute value
onClickPreventDefault tagger =
    Html.Events.on "click" (Dec.map tagger pointerEventDecoder)


{-| Stops propagation of a provided event.
-}
alwaysStopPropagationOn : String -> msg -> Html.Attribute msg
alwaysStopPropagationOn evt msg =
    Html.Events.stopPropagationOn evt (Dec.succeed ( msg, True ))
