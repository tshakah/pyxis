module Stories.Chapters.Form exposing (Model, docs, init)

import Components.Form as Form exposing (Form)
import Components.Form.FieldSet as FieldSet exposing (FieldSet)
import Components.Form.Grid.Column as Column exposing (Column)
import Components.Form.Grid.Row as Row exposing (Row)
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Form"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Lorem ipsum dolor sit amet.

<component with-label="Form" />
"""


type alias SharedState x =
    { x
        | form : Form {}
    }


type alias Model =
    Form {}


init : Model
init =
    Form.create


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Form"
      , statelessComponent
      )
    ]


mapModel : (Model -> Model) -> SharedState x -> SharedState x
mapModel updater state =
    { state | form = updater state.form }


statelessComponent : SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent { form } =
    let
        usernameColumn : Column {}
        usernameColumn =
            Column.create
                |> Column.withContent
                    []

        passwordColumn : Column {}
        passwordColumn =
            Column.create
                |> Column.withContent
                    []

        rows : List (Row {})
        rows =
            [ Row.create
                |> Row.withColumns
                    [ usernameColumn
                    , passwordColumn
                    ]
            ]

        fieldSets : List (FieldSet {})
        fieldSets =
            [ FieldSet.create
                |> FieldSet.withIcon IconSet.User
                |> FieldSet.withTitle "User data"
                |> FieldSet.withRows rows
            , FieldSet.create
                |> FieldSet.withTitle "Vehicle data"
                |> FieldSet.withText "Lorem ipsum dolor sit amet."
                |> FieldSet.withRows rows
            ]
    in
    form
        |> Form.withFieldSets fieldSets
        |> Form.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapModel identity state
                , fromState = .form
                , update = \_ model -> model
                }
            )
