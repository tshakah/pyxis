module Stories.Helpers exposing (statefulComponent)

import ElmBook
import ElmBook.Actions
import Html exposing (Html)
import Html.Attributes



--statefulComponent :
--    (sharedModel -> model)
--    -> config
--    -> (model -> config -> Html msg)
--    -> (sharedModel -> model -> sharedModel)
--    -> (msg -> model -> model)
--    -> sharedModel
--    -> Html (ElmBook.Msg sharedModel)


statefulComponent :
    (sharedState -> model)
    -> config
    -> (model -> config -> Html msg)
    -> (sharedState -> model -> sharedState)
    -> (msg -> model -> model)
    -> model
    -> Html (ElmBook.Msg sharedState)
statefulComponent mapper config render toState update model =
    render model config
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
