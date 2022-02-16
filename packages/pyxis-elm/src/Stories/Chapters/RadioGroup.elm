module Stories.Chapters.RadioGroup exposing (Model, docs, init)

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

### Implementation with only valid options

```
type Option
    = M
    | F


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger M


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = M, label = "Male" }
    , RadioGroup.option { value = F, label = "Female" }
    ]
```

### Implementation with Maybe String (Error prone)

```
type alias Option =
    Maybe String


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger Nothing
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    case value of
        Just "" ->
            Err "Required"

        Nothing ->
            Err "Required"

        _ ->
            Ok value


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = Just "male", label = "Male" }
    , RadioGroup.option { value = Just "female", label = "Female" }
    ]
```

### Implementation with String (Error prone)

```
type alias Option =
    String


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger ""
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == "female" || value == "male" then
        Ok value

    else
        Err "Required"


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = "male", label = "Male" }
    , RadioGroup.option { value = "female", label = "Female" }
    ]
````

# Vertical Layout
<component with-label="RadioGroup vertical" />

```
radioGroupVerticalLayout : String -> (RadioGroup.Msg value -> msg) -> value -> Html msg
radioGroupVerticalLayout id tagger defaultValue =
    RadioGroup.create id tagger defaultValue
        |> RadioGroup.withVerticalLayout True
        |> RadioGroup.render
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
    , ( "RadioGroup vertical"
      , statefulComponent .base (RadioGroup.withVerticalLayout True) setBase
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
