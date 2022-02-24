module Commons.Render exposing
    ( empty
    , renderIf
    , renderErrorOrHint
    , renderUnless
    , renderListIf
    , renderListUnless
    , renderMaybe
    )

{-| Do not expose this module.

@docs empty


## Render

@docs renderIf
@docs renderErrorOrHint
@docs renderUnless
@docs renderListIf
@docs renderListUnless
@docs renderMaybe

-}

import Components.Field.Error as Error
import Components.Field.Hint as Hint
import Html exposing (Html)
import Maybe.Extra


{-| Renders an empty Html node.
-}
empty : Html msg
empty =
    Html.text ""


{-| Renders an Html based when condition is satisfied.
-}
renderIf : Bool -> Html msg -> Html msg
renderIf condition html =
    if condition then
        html

    else
        empty


{-| Renders an Html based when condition is not satisfied.
-}
renderUnless : Bool -> Html msg -> Html msg
renderUnless condition =
    renderIf (not condition)


{-| Renders an Html list based when condition is satisfied.
-}
renderListIf : Bool -> List (Html msg) -> List (Html msg)
renderListIf condition html =
    if condition then
        html

    else
        []


{-| Renders an Html list based when condition is not satisfied.
-}
renderListUnless : Bool -> List (Html msg) -> List (Html msg)
renderListUnless condition =
    renderListIf (not condition)


{-| Renders a Maybe Html if its value is Just _something_.
-}
renderMaybe : Maybe (Html msg) -> Html msg
renderMaybe =
    Maybe.withDefault empty


{-| -}
renderErrorOrHint : String -> Maybe Hint.Config -> Maybe Error.Config -> Html msg
renderErrorOrHint id hintConfig errorConfig =
    Maybe.Extra.or
        (Maybe.map (Error.withFieldId id >> Error.render) errorConfig)
        (Maybe.map (Hint.withFieldId id >> Hint.render) hintConfig)
        |> renderMaybe
