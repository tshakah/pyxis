module Commons.ApiConstraint exposing
    ( NotSupported
    , Supported
    )

{-| Defines some types which are useful in order to express api constraints by using phantom types.
-}


{-| A type to enforce api consistency with phantom types technique.
-}
type Supported
    = Supported


{-| A type to enforce api consistency with phantom types technique.
-}
type NotSupported
    = NotSupported
