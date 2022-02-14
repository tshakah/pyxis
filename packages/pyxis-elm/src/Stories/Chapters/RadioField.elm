module Stories.Chapters.RadioField exposing (Model, docs, init)

import Components.Field.RadioGroup as RadioGroup
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Stories.Helpers as SH


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "RadioGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
A radio group is used to combine and provide structure to group of radio buttons, placing element such as label and error message in a pleasant and clear way.
Radio group have a horizontal layout as default, but with more then two items a vertical layout is recommended.

<component with-label="RadioGroup" />
```
type Option
    = M
    | F
    | Default


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger Default
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == Default then
        Err "Invalid selection"

    else
        Ok value


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = M, label = "Male" }
    , RadioGroup.option { value = F, label = "Female" }
    ]
```
"""


type alias SharedState x =
    { x
        | radioFieldModels : RadioFieldModels
    }


type Option
    = M
    | F
    | Default


type alias RadioFieldModels =
    { base : RadioGroup.Model Option {} Msg
    }


type alias Model =
    RadioFieldModels


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


init : Model
init =
    { base =
        RadioGroup.create "radio-gender-id" OnRadioFieldMsg Default
            |> RadioGroup.withOptions
                [ RadioGroup.option { value = M, label = "Male" }
                , RadioGroup.option { value = F, label = "Female" }
                ]
            |> RadioGroup.withName "gender"
            |> RadioGroup.withValidation validation
    }


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == Default then
        Err "Invalid selection"

    else
        Ok value


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "RadioGroup"
      , statefulComponent .base identity setBase
      )
    ]


statefulComponent :
    (RadioFieldModels -> RadioGroup.Model Option {} Msg)
    -> (RadioGroup.Model Option {} Msg -> RadioGroup.Model Option {} Msg)
    -> (RadioGroup.Model Option {} Msg -> RadioFieldModels -> RadioFieldModels)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent mapper modifier setInternalValue =
    SH.statefulComponent
        (.radioFieldModels >> mapper)
        (modifier >> RadioGroup.render)
        (\state model -> mapRadioFieldModels (setInternalValue model) state)
        (\(OnRadioFieldMsg msg) -> RadioGroup.update {} msg)


mapRadioFieldModels : (RadioFieldModels -> RadioFieldModels) -> SharedState x -> SharedState x
mapRadioFieldModels updater state =
    { state | radioFieldModels = updater state.radioFieldModels }


setBase : RadioGroup.Model Option {} Msg -> RadioFieldModels -> RadioFieldModels
setBase newModel textFieldModels =
    { textFieldModels | base = newModel }
