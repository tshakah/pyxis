module Pyxis.Commons.Render exposing
    ( empty
    , renderIf
    , renderErrorOrHint
    , renderMaybe
    , renderUnless
    , renderListIf
    , renderListMaybe
    , renderListUnless
    )

{-| Do not expose this module.

@docs empty


## Render

@docs renderIf
@docs renderErrorOrHint
@docs renderMaybe
@docs renderUnless
@docs renderListIf
@docs renderListMaybe
@docs renderListUnless

-}

import Html exposing (Html)
import Maybe.Extra
import Pyxis.Components.Field.Error as Error
import Pyxis.Components.Field.Hint as Hint


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


{-| Renders a Maybe Html if its value is Just _something_.
-}
renderListMaybe : Maybe (List (Html msg)) -> List (Html msg)
renderListMaybe =
    Maybe.withDefault []


{-| -}
renderErrorOrHint : String -> Maybe Hint.Config -> Maybe Error.Config -> Html msg
renderErrorOrHint id hintConfig errorConfig =
    Maybe.Extra.or
        (Maybe.map (Error.withFieldId id >> Error.render) errorConfig)
        (Maybe.map (Hint.withFieldId id >> Hint.render) hintConfig)
        |> renderMaybe
