module Components.Field.Error.Strategy.Internal exposing
    ( Strategy(..)
    , getShownValidation
    )

{-|

@docs Strategy
@docs getShownValidation

-}

import Components.Field.State as FieldState


{-| Internal representation of a Strategy, used in Field.Strategy
-}
type
    Strategy
    -- Returns whether to show the error
    = ShowError (FieldState.State -> Bool)


{-| Helper used to determine whether the error should be shown in the UI or not
-}
getShownValidation : FieldState.State -> (() -> Result error value) -> Bool -> Strategy -> Result error ()
getShownValidation fieldState getValidationResult isSubmitted (ShowError showError) =
    if isSubmitted || showError fieldState then
        Result.map (always ()) (getValidationResult ())

    else
        Ok ()
