module Components.Form.Grid.Row exposing
    ( Option
    , largeSize
    , mediumSize
    , smallSize
    , buildConfiguration
    )

{-|


## Options

@docs Option


## Size options

@docs largeSize
@docs mediumSize
@docs smallSize


## Methods

@docs buildConfiguration

-}

import Commons.Properties.Size as Size exposing (Size)


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
    Option (\config -> { config | size = Size.small })


{-| Creates a medium size Row option.
-}
mediumSize : Option config
mediumSize =
    Option (\config -> { config | size = Size.medium })


{-| Creates a large size Row option.
-}
largeSize : Option config
largeSize =
    Option (\config -> { config | size = Size.large })
