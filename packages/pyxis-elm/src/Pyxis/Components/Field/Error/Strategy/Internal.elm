module Pyxis.Components.Field.Error.Strategy.Internal exposing
    ( Strategy(..)
    , getShownValidation
    )

{-|

@docs Strategy
@docs getShownValidation

-}

import Pyxis.Components.Field.Status as FieldStatus


{-| Internal representation of a Strategy, used in Field.Strategy
-}
type
    Strategy
    -- Returns whether to show the error
    = ShowError (FieldStatus.Status -> Bool)


{-| Helper used to determine whether the error should be shown in the UI or not
-}
getShownValidation : FieldStatus.Status -> Result error value -> Bool -> Strategy -> Result error ()
getShownValidation fieldStatus getValidationResult isSubmitted (ShowError showError) =
    if isSubmitted || showError fieldStatus then
        Result.map (always ()) getValidationResult

    else
        Ok ()
