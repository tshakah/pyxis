module Components.Field.State exposing
    ( State(..)
    , onBlur, onChange, onFocus, onInput
    )

{-| Internal field state representation

@docs State
@docs focus, blur, input, change

-}


{-| The internal representation of a field component

Untouched := Not focused yet
Touched := triggered `focus` at least once

-}
type State
    = Untouched -- Initial state
    | Touched
        { blurred : Bool
        , hasFocus : Bool -- currently focused
        , dirty : Bool -- edited text at least once
        }


{-| User focuses the field
-}
onFocus : State -> State
onFocus state =
    case state of
        Untouched ->
            Touched
                { blurred = False
                , hasFocus = True
                , dirty = False
                }

        Touched data ->
            Touched
                { data | hasFocus = True }


{-| User blurs the field
-}
onBlur : State -> State
onBlur state =
    case state of
        Touched data ->
            Touched
                { data | hasFocus = False, blurred = True }

        -- Should not happen
        _ ->
            state


{-| User inputs a value
-}
onInput : State -> State
onInput state =
    case state of
        Touched data ->
            Touched { data | dirty = True }

        -- Should not happen
        _ ->
            state


{-| Same a `input`
-}
onChange : State -> State
onChange =
    onInput
