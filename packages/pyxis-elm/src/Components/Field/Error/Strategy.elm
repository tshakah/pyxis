module Components.Field.Error.Strategy exposing
    ( Strategy
    , onBlur, onInput, onSubmit
    )

{-| Strategy

@docs Strategy
@docs onBlur, onInput, onSubmit

-}

import Components.Field.Error.Strategy.Internal as StrategyInternal
import Components.Field.Status as FieldStatus


{-| A type representing the approached used to show the error (if present)
-}
type alias Strategy =
    StrategyInternal.Strategy


{-| Show the error on user input
-}
onInput : Strategy
onInput =
    StrategyInternal.ShowError inputStrategy


{-| Internal
-}
inputStrategy : FieldStatus.Status -> Bool
inputStrategy fieldStatus =
    case fieldStatus of
        FieldStatus.Touched { dirty, blurred } ->
            dirty || blurred

        FieldStatus.Untouched ->
            False


{-| Show the error starting from user blur
-}
onBlur : Strategy
onBlur =
    StrategyInternal.ShowError blurStrategy


{-| Internal
-}
blurStrategy : FieldStatus.Status -> Bool
blurStrategy fieldStatus =
    case fieldStatus of
        FieldStatus.Touched { blurred } ->
            blurred

        FieldStatus.Untouched ->
            False


{-| Show the error only when the form is submitted
-}
onSubmit : Strategy
onSubmit =
    StrategyInternal.ShowError submitStrategy


{-| Internal
-}
submitStrategy : a -> Bool
submitStrategy _ =
    False
