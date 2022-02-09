module Stories.Book exposing (main)

import ElmBook
import ElmBook.StatefulOptions
import ElmBook.ThemeOptions
import Html
import Html.Attributes
import Stories.Chapters.Buttons as ButtonChapter
import Stories.Chapters.Icon as IconChapter
import Stories.Chapters.IconSet as IconSetChapter
import Stories.Chapters.Label as LabelChapter
import Stories.Chapters.NumberField as NumberFieldChapter
import Stories.Chapters.TextField as TextFieldChapter


type alias SharedState =
    { textFieldModels : TextFieldChapter.Model
    , numberFieldModels : NumberFieldChapter.Model
    }


initialState : SharedState
initialState =
    { textFieldModels = TextFieldChapter.init
    , numberFieldModels = NumberFieldChapter.init
    }


main : ElmBook.Book SharedState
main =
    ElmBook.book "Book"
        |> ElmBook.withStatefulOptions
            [ ElmBook.StatefulOptions.initialState initialState
            ]
        |> ElmBook.withThemeOptions
            [ ElmBook.ThemeOptions.globals
                [ Html.node "link" [ Html.Attributes.href "pyxis.css", Html.Attributes.rel "stylesheet" ] []
                ]
            , ElmBook.ThemeOptions.backgroundGradient "#8334c2" "#f2eaf8"
            , ElmBook.ThemeOptions.navBackground "#5b2488"
            , ElmBook.ThemeOptions.navAccent "#ffffff"
            , ElmBook.ThemeOptions.navAccentHighlight "#ffffff"
            , ElmBook.ThemeOptions.header (Html.h1 [] [ Html.text "Pyxis" ])
            ]
        |> ElmBook.withChapters
            [ ButtonChapter.docs
            , IconChapter.docs
            , IconSetChapter.docs
            , LabelChapter.docs
            , TextFieldChapter.docs
            , NumberFieldChapter.docs
            ]
