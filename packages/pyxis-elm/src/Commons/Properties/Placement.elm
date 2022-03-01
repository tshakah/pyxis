module Commons.Properties.Placement exposing
    ( Placement
    , prepend, append
    , isPrepend, isAppend
    , toString
    )

{-| The available positions.

@docs Placement
@docs prepend, append
@docs isPrepend, isAppend

@docs toString

-}


{-| A type representing a placement
-}
type Placement
    = Prepend
    | Append


{-| Place in leading position
-}
prepend : Placement
prepend =
    Prepend


{-| Place in trailing position
-}
append : Placement
append =
    Append


{-| Returns True whether the placement is `prepend`
-}
isPrepend : Placement -> Bool
isPrepend placement =
    case placement of
        Prepend ->
            True

        _ ->
            False


{-| Returns True whether the placement is `append`
-}
isAppend : Placement -> Bool
isAppend placement =
    case placement of
        Append ->
            True

        _ ->
            False


{-| Return the placement string suffix.
-}
toString : Placement -> String
toString placement =
    case placement of
        Prepend ->
            "prepend"

        Append ->
            "append"
