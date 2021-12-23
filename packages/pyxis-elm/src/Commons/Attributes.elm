module Commons.Attributes exposing (empty)

{-| Do not expose this module.
-}

import Html
import Html.Attributes as Attributes


{-| Use this to write an empty attribute which will not be rendered.
Useful in order to prevent the need of a `Maybe Html.Attribute` in your component configuration.
-}
empty : Html.Attribute msg
empty =
    Attributes.attribute "" ""
