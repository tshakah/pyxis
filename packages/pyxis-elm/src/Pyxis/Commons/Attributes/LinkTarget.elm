module Pyxis.Commons.Attributes.LinkTarget exposing
    ( LinkTarget
    , blank
    , self
    , parent
    , top
    , frameName
    , toString
    )

{-|


## Link Target attributes

@docs LinkTarget
@docs blank
@docs self
@docs parent
@docs top
@docs frameName


## Utilities

@docs toString

-}


{-| The a tag `target` attribute options
-}
type LinkTarget
    = Blank
    | Self
    | Parent
    | Top
    | Framename


{-| The `blank` option for `target` attribute
-}
blank : LinkTarget
blank =
    Blank


{-| The `self` option for `target` attribute
-}
self : LinkTarget
self =
    Self


{-| The `parent` option for `target` attribute
-}
parent : LinkTarget
parent =
    Parent


{-| The `top` option for `target` attribute
-}
top : LinkTarget
top =
    Top


{-| The `frameName` option for `target` attribute
-}
frameName : LinkTarget
frameName =
    Framename


{-| Convert the LinkTarget type to string
-}
toString : LinkTarget -> String
toString linkTarget =
    case linkTarget of
        Blank ->
            "_blank"

        Self ->
            "_self"

        Parent ->
            "_parent"

        Top ->
            "_top"

        Framename ->
            "framename"
