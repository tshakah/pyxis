module Pyxis.Components.Form.Grid.Row exposing
    ( Option
    , Size
    , large
    , medium
    , small
    , largeSize
    , mediumSize
    , smallSize
    , isLarge
    , isMedium
    , isSmall
    , buildConfiguration
    )

{-|


## Options

@docs Option


## Size options

@docs Size
@docs large
@docs medium
@docs small
@docs largeSize
@docs mediumSize
@docs smallSize
@docs isLarge
@docs isMedium
@docs isSmall


## Methods

@docs buildConfiguration

-}


{-| Row size
-}
type Size
    = Small
    | Medium
    | Large


{-| Row size small
-}
small : Size
small =
    Small


{-| Row size medium
-}
medium : Size
medium =
    Medium


{-| Row size large
-}
large : Size
large =
    Large


{-| Check if the size is small
-}
isSmall : Size -> Bool
isSmall =
    (==) Small


{-| Check if the size is medium
-}
isMedium : Size -> Bool
isMedium =
    (==) Medium


{-| Check if the size is large
-}
isLarge : Size -> Bool
isLarge =
    (==) Large


{-| Internal. Convenient type to work with a partial Grid.Row configuration.
-}
type alias ConfigData a =
    { a | size : Size }


{-| Represent the available Row options.
-}
type Option config
    = Option (ConfigData config -> ConfigData config)


{-| A utility to obtain a Configuration from a list of Option(s).
-}
buildConfiguration : List (Option config) -> ConfigData config -> ConfigData config
buildConfiguration options config =
    List.foldl (\(Option mapper) c -> mapper c) config options


{-| Creates a small size Row option.
-}
smallSize : Option config
smallSize =
    Option (\config -> { config | size = Small })


{-| Creates a medium size Row option.
-}
mediumSize : Option config
mediumSize =
    Option (\config -> { config | size = Medium })


{-| Creates a large size Row option.
-}
largeSize : Option config
largeSize =
    Option (\config -> { config | size = Large })
