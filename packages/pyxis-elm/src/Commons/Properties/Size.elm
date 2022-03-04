module Commons.Properties.Size exposing
    ( Size
    , fullWidth, huge, large, medium, small
    , isFullWidth, isHuge, isLarge, isMedium, isSmall
    )

{-|

@docs Size
@docs fullWidth, huge, large, medium, small
@docs isFullWidth, isHuge, isLarge, isMedium, isSmall

-}


{-| A type representing a component size
-}
type Size
    = FullWidth
    | Huge
    | Large
    | Medium
    | Small


{-| A fullWidth size
-}
fullWidth : Size
fullWidth =
    FullWidth


{-| A huge size
-}
huge : Size
huge =
    Huge


{-| A large size
-}
large : Size
large =
    Large


{-| A medium size
-}
medium : Size
medium =
    Medium


{-| A small size
-}
small : Size
small =
    Small


{-| Returns True whether the size is fullWidth
-}
isFullWidth : Size -> Bool
isFullWidth =
    (==) FullWidth


{-| Returns True whether the size is huge
-}
isHuge : Size -> Bool
isHuge =
    (==) Huge


{-| Returns True whether the size is large
-}
isLarge : Size -> Bool
isLarge =
    (==) Large


{-| Returns True whether the size is medium
-}
isMedium : Size -> Bool
isMedium =
    (==) Medium


{-| Returns True whether the size is small
-}
isSmall : Size -> Bool
isSmall =
    (==) Small
