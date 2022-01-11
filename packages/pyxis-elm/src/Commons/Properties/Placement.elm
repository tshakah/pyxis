module Commons.Properties.Placement exposing
    ( Placement
    , isLeading
    , isTrailing
    , leading
    , trailing
    )

{-| The available positions.
-}


type Placement
    = Leading
    | Trailing


leading : Placement
leading =
    Leading


trailing : Placement
trailing =
    Trailing


isLeading : Placement -> Bool
isLeading placement =
    case placement of
        Leading ->
            True

        _ ->
            False


isTrailing : Placement -> Bool
isTrailing placement =
    case placement of
        Trailing ->
            True

        _ ->
            False
