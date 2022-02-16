module Stories.Chapters.Form exposing (Model, docs, init)

import Components.Field.Label as Label
import Components.Field.Text as TextField
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
        | formModel : Form Msg
    }


type alias Model =
    Form Msg


type Msg
    = TextFieldNoOp TextField.Msg


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
    { state | formModel = updater state.formModel }


statelessComponent : SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent { formModel } =
    let
        usernameColumn : Column Msg
        usernameColumn =
            Column.create
                |> Column.withContent
                    [ "Username"
                        |> Label.create
                        |> Label.render
                    , "username"
                        |> TextField.email TextFieldNoOp
                        |> TextField.render
                    ]

        passwordColumn : Column Msg
        passwordColumn =
            Column.create
                |> Column.withContent
                    [ "Password"
                        |> Label.create
                        |> Label.render
                    , "password"
                        |> TextField.password TextFieldNoOp
                        |> TextField.render
                    ]

        rows : List (Row Msg)
        rows =
            [ Row.create
                |> Row.withColumns
                    [ usernameColumn
                    , passwordColumn
                    ]
            ]

        fieldSets : List (FieldSet Msg)
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
    formModel
        |> Form.withFieldSets fieldSets
        |> Form.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapModel identity state
                , fromState = .formModel
                , update = \_ model -> model
                }
            )
