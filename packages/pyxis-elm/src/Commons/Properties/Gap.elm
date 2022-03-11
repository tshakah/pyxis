module Commons.Properties.Gap exposing
    ( Gap
    , small, medium, large
    , isSmall, isMedium, isLarge
    )

{-| Gap

@docs Gap
@docs small, medium, large
@docs isSmall, isMedium, isLarge

-}


{-| Represent a gap for a Grid.
-}
type Gap
    = Small
    | Medium
    | Large


{-| Creates a small Gap.
-}
small : Gap
small =
    Small


{-| Creates a medium Gap.
-}
medium : Gap
medium =
    Medium


{-| Creates a large Gap.
-}
large : Gap
large =
    Large


{-| Returns true if the given Gap is small.
-}
isSmall : Gap -> Bool
isSmall =
    (==) Small


{-| Returns true if the given Gap is medium.
-}
isMedium : Gap -> Bool
isMedium =
    (==) Medium


{-| Returns true if the given Gap is large.
-}
isLarge : Gap -> Bool
isLarge =
    (==) Large
