module Pyxis.Commons.Attributes exposing
    ( ariaDescribedBy
    , ariaDescribedByErrorOrHint
    , ariaHidden
    , ariaLabel
    , ariaLabelledbyBy
    , role
    , target
    , testId
    , renderIf
    , maybe
    , none
    )

{-|


## A11Y Attributes

@docs ariaDescribedBy
@docs ariaDescribedByErrorOrHint
@docs ariaHidden
@docs ariaLabel
@docs ariaLabelledbyBy
@docs role


## Attributes

@docs LinkTarget
@docs target
@docs testId


## Utilities

@docs renderIf
@docs maybe
@docs none

-}

import Html
import Html.Attributes
import Json.Encode
import Maybe.Extra
import Pyxis.Commons.Attributes.LinkTarget as CommonsAttributesLinkTarget exposing (LinkTarget)


target : LinkTarget -> Html.Attribute msg
target =
    CommonsAttributesLinkTarget.toString
        >> Html.Attributes.target


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


{-| Creates an aria-describedby attribute based on Error or Hint
-}
ariaDescribedByErrorOrHint : Maybe String -> Maybe String -> Html.Attribute msg
ariaDescribedByErrorOrHint errorId hintId =
    Maybe.Extra.or errorId hintId
        |> Maybe.map ariaDescribedBy
        |> Maybe.withDefault none


{-| Creates an aria-labelledby attribute.
-}
ariaLabelledbyBy : String -> Html.Attribute msg
ariaLabelledbyBy =
    Html.Attributes.attribute "aria-labelledby"



-- Conditional utilities


{-| Renders a noop attribute, akin to Cmd.none or Sub.none

Copied from <https://github.com/NoRedInk/noredink-ui/blob/15.6.1/src/Nri/Ui/Html/Attributes/V2.elm#L34>

-}
none : Html.Attribute msg
none =
    Html.Attributes.property "none@primauk-elm" Json.Encode.null


{-| Renders the given attribute when the flag is True (else render Attribute.none)
-}
renderIf : Bool -> Html.Attribute msg -> Html.Attribute msg
renderIf bool attr =
    if bool then
        attr

    else
        none


{-| Renders the value wrapped in Maybe, when present (else renders Attribute.none)

    maybeId : Maybe String

    button
        [ Pyxis.Commons.Attributes.maybe Html.Attributes.id maybeId ]
        []

-}
maybe : (a -> Html.Attribute msg) -> Maybe a -> Html.Attribute msg
maybe f =
    Maybe.map f >> Maybe.withDefault none
