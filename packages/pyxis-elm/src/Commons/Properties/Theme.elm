module Commons.Properties.Theme exposing (Theme, alternative, default, isAlternative, isDefault)

{-| The available themes.
-}


type Theme
    = Default
    | Alternative


default : Theme
default =
    Default


alternative : Theme
alternative =
    Alternative


isDefault : Theme -> Bool
isDefault =
    (==) Default


isAlternative : Theme -> Bool
isAlternative =
    (==) Alternative
