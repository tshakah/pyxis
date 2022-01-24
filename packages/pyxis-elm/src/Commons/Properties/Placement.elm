module Commons.Properties.Placement exposing
    ( Placement
    , append
    , isAppend
    , isPrepend
    , prepend
    )

{-| The available positions.
-}


type Placement
    = Prepend
    | Append


prepend : Placement
prepend =
    Prepend


append : Placement
append =
    Append


isPrepend : Placement -> Bool
isPrepend placement =
    case placement of
        Prepend ->
            True

        _ ->
            False


isAppend : Placement -> Bool
isAppend placement =
    case placement of
        Append ->
            True

        _ ->
            False
