module Pyxis.Components.Form.Grid.Col exposing
    ( Option
    , span1
    , span2
    , span3
    , span4
    , span5
    , buildConfiguration
    )

{-|


## Options

@docs Option
@docs span1
@docs span2
@docs span3
@docs span4
@docs span5


## Methods

@docs buildConfiguration

-}


{-| Internal. Convenient type to work with a partial Grid.Col configuration.
-}
type alias ConfigData a =
    { a | span : Int }


{-| Represent the available Col options.
-}
type Option config
    = Option (ConfigData config -> ConfigData config)


{-| A utility to obtain a Configuration from a list of Option(s).
-}
buildConfiguration : List (Option config) -> ConfigData config -> ConfigData config
buildConfiguration options config =
    List.foldl (\(Option mapper) c -> mapper c) config options


{-| Creates a one-span Col(umn) option. (Default).
-}
span1 : Option config
span1 =
    Option (\config -> { config | span = 1 })


{-| Creates a two-span Col(umn) option.
-}
span2 : Option config
span2 =
    Option (\config -> { config | span = 2 })


{-| Creates a three-span Col(umn) option.
-}
span3 : Option config
span3 =
    Option (\config -> { config | span = 3 })


{-| Creates a four-span Col(umn) option.
-}
span4 : Option config
span4 =
    Option (\config -> { config | span = 4 })


{-| Creates a five-span Col(umn) option.
-}
span5 : Option config
span5 =
    Option (\config -> { config | span = 5 })
