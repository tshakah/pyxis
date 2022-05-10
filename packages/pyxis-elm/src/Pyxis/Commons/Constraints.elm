module Pyxis.Commons.Constraints exposing
    ( Allowed
    , Denied
    )

{-| Defines some types which are useful in order to express api constraints by using phantom types.

@docs Allowed
@docs Denied

-}


{-| A type to enforce api consistency with phantom types technique.
-}
type alias Allowed =
    ()


{-| A type to enforce api consistency with phantom types technique.
-}
type alias Denied =
    {}
