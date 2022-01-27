module Stories.Chapters.TextField exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.Text as TextField
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "TextField"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
<component with-label="TextField" />

```
textField =
    TextField.create Tagger "id"
            |> TextField.withSize Size.medium
            |> TextField.render
    
```
"""


type alias SharedState x =
    { x | textFieldModel : TextField.Model Msg }


type alias Model =
    TextField.Model Msg


type Msg
    = Tagger TextField.Msg


init : Model
init =
    TextField.create Tagger "id"
        |> TextField.withSize Size.medium


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "TextField"
      , \{ textFieldModel } ->
            textFieldModel
                |> TextField.render
                |> Html.map
                    (ElmBook.Actions.mapUpdateWithCmd
                        { toState = toState
                        , fromState = fromState
                        , update = updateInternal
                        }
                    )
      )
    ]


toState : SharedState x -> TextField.Model Msg -> SharedState x
toState state textFieldModel_ =
    { state | textFieldModel = textFieldModel_ }


fromState : SharedState x -> TextField.Model Msg
fromState =
    .textFieldModel


updateInternal : Msg -> TextField.Model Msg -> ( TextField.Model Msg, Cmd Msg )
updateInternal (Tagger msg) model =
    TextField.update msg model
