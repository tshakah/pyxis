module Stories.Helpers exposing (statefulComponent)

import ElmBook
import ElmBook.Actions
import Html exposing (Html)


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
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = mapper
                , update = update
                }
            )
