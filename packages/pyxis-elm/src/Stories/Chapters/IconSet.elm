module Stories.Chapters.IconSet exposing (docs)

import ElmBook
import ElmBook.Chapter
import Html
import Html.Attributes
import Pyxis.Components.Form.Grid as Grid
import Pyxis.Components.Icon as Icon
import Pyxis.Components.IconSet as IconSet


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "IconSet"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.renderComponent
            (IconSet.allIcons
                |> group 3
                |> List.map toComponent
                |> Grid.render []
            )


toComponent : List IconSet.Icon -> Grid.Row (ElmBook.Msg state)
toComponent icons =
    icons
        |> List.map
            (\icon ->
                Grid.col
                    []
                    [ Html.div
                        [ Html.Attributes.style "align-items" "center"
                        , Html.Attributes.style "display" "flex"
                        , Html.Attributes.style "flex-direction" "column"
                        , Html.Attributes.classList
                            [ ( "bg-neutral-95", True )
                            , ( "padding-s", True )
                            , ( "radius-s", True )
                            , ( "text-s-book", True )
                            ]
                        ]
                        [ Html.text (IconSet.toLabel icon)
                        , Html.br [] []
                        , Html.br [] []
                        , icon
                            |> Icon.config
                            |> Icon.withSize Icon.large
                            |> Icon.render
                        ]
                    ]
            )
        |> Grid.row []


group : Int -> List IconSet.Icon -> List (List IconSet.Icon)
group i icons =
    case List.take i icons of
        [] ->
            []

        head ->
            head :: group i (List.drop i icons)
