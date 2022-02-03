module FieldState exposing
    ( FieldState(..)
    , blur
    , focus
    , input
    )

{-| -}


{-| Untouched := Not focused yet
Touched := trigghered `focus` at least once
-}
type FieldState
    = Untouched -- Initial state
    | Touched
        { blurredAtLeastOnce : Bool
        , focused : Bool -- currently focused
        , dirty : Bool -- edited text at least once
        }


focus : FieldState -> FieldState
focus state =
    case state of
        Untouched ->
            Touched
                { blurredAtLeastOnce = False
                , focused = True
                , dirty = False
                }

        Touched data ->
            Touched
                { data | focused = True }


blur : FieldState -> FieldState
blur state =
    case state of
        Touched data ->
            Touched
                { data | focused = False, blurredAtLeastOnce = True }

        -- Should not happen
        _ ->
            state


input : FieldState -> FieldState
input state =
    case state of
        Touched data ->
            Touched { data | dirty = True }

        -- Should not happen
        _ ->
            state
