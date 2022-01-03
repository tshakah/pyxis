module Commons.Attributes exposing (compose)

import Html


{-| Useful to compose mandatory attributes with maybe ones.
-}
compose : List (Html.Attribute msg) -> List (Maybe (Html.Attribute msg)) -> List (Html.Attribute msg)
compose attributes maybeAttributes =
    maybeAttributes
        |> List.filterMap identity
        |> List.append attributes
