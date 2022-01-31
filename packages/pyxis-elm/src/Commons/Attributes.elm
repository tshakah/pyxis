module Commons.Attributes exposing
    ( ariaHidden
    , ariaLabel
    , role
    , testId
    , compose
    , ariaDescribedBy
    )

{-|


## A11Y Attributes

@docs ariaDescribedBy
@docs ariaHidden
@docs ariaLabel
@docs role


## Attributes

@docs testId


## Utilities

@docs compose

-}

import Html
import Html.Attributes


{-| Useful to compose mandatory attributes with maybe ones.
-}
compose : List (Html.Attribute msg) -> List (Maybe (Html.Attribute msg)) -> List (Html.Attribute msg)
compose attributes maybeAttributes =
    maybeAttributes
        |> List.filterMap identity
        |> List.append attributes


{-| Creates an aria-label attribute.
-}
ariaLabel : String -> Html.Attribute msg
ariaLabel =
    Html.Attributes.attribute "aria-label"


{-| Creates an aria-hidden attribute.
-}
ariaHidden : Bool -> Html.Attribute msg
ariaHidden a =
    Html.Attributes.attribute "aria-hidden"
        (if a then
            "true"

         else
            "false"
        )


{-| Creates a role attribute.
-}
role : String -> Html.Attribute msg
role =
    Html.Attributes.attribute "role"


{-| Creates an data-test-id attribute.
-}
testId : String -> Html.Attribute msg
testId =
    Html.Attributes.attribute "data-test-id"


{-| Creates an aria-describedby attribute.
-}
ariaDescribedBy : String -> Html.Attribute msg
ariaDescribedBy =
    Html.Attributes.attribute "aria-describedby"
