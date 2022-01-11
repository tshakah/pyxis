module Commons.Properties.Size exposing
    ( Size
    , huge
    , isHuge
    , isLarge
    , isMedium
    , isSmall
    , large
    , medium
    , small
    )


type Size
    = Huge
    | Large
    | Medium
    | Small


huge : Size
huge =
    Huge


large : Size
large =
    Large


medium : Size
medium =
    Medium


small : Size
small =
    Small


isHuge : Size -> Bool
isHuge =
    (==) Huge


isLarge : Size -> Bool
isLarge =
    (==) Large


isMedium : Size -> Bool
isMedium =
    (==) Medium


isSmall : Size -> Bool
isSmall =
    (==) Small
