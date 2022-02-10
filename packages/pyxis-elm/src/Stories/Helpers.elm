module Stories.Helpers exposing (statefulComponent)

import ElmBook
import ElmBook.Actions
import Html exposing (Html)
import Html.Attributes


statefulComponent :
    (sharedModel -> model)
    -> (model -> Html msg)
    -> (sharedModel -> model -> sharedModel)
    -> (msg -> model -> model)
    -> sharedModel
    -> Html (ElmBook.Msg sharedModel)
statefulComponent mapper renderer toState update sharedModel =
    sharedModel
        |> mapper
        |> renderer
        |> withErrorWrapper
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = mapper
                , update = update
                }
            )


withErrorWrapper : Html msg -> Html msg
withErrorWrapper component =
    Html.div [ Html.Attributes.style "margin-bottom" "20px" ] [ component ]
