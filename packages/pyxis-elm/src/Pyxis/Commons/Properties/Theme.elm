module Pyxis.Commons.Properties.Theme exposing
    ( Theme
    , default, alternative
    , isDefault, isAlternative
    )

{-|


# The available themes.

@docs Theme
@docs default, alternative
@docs isDefault, isAlternative

-}


{-| A type representing the theme
-}
type Theme
    = Default
    | Alternative


{-| default placement
-}
default : Theme
default =
    Default


{-| alternative placement
-}
alternative : Theme
alternative =
    Alternative


{-| Returns True whether the theme is `default`
-}
isDefault : Theme -> Bool
isDefault =
    (==) Default


{-| Returns True whether the theme is `alternative`
-}
isAlternative : Theme -> Bool
isAlternative =
    (==) Alternative
