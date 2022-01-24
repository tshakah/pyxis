module Stories.Chapters.IconSet exposing (docs)

import Commons.Properties.Size as Size
import Components.Icon as Icon
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter ()
docs =
    "IconSet"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.renderComponentList componentsList


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    List.map toComponent IconSet.allIcons


toComponent : IconSet.Icon -> ( String, Html (ElmBook.Msg state) )
toComponent icon =
    ( IconSet.toLabel icon
    , icon
        |> Icon.create
        |> Icon.withSize Size.large
        |> Icon.render
    )
