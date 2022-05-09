module Stories.Chapters.Fields.RadioGroup exposing (Model, docs, init)

import Components.Field.Label as Label
import Components.Field.RadioGroup as RadioGroup
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


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
    = Home
    | Motor


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


validation : formData -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just option ->
            Ok option


radioGroupModel : RadioGroup.Model formData Option Option
radioGroupModel =
    RadioGroup.init (Just Home) validation


radioGroupView : formData -> Html Msg
radioGroupView formData =
    RadioGroup.config "radio-name"
        |> RadioGroup.withName "insurance-type"
        |> RadioGroup.withLabel (Label.config "Choose the insurance type")
        |> RadioGroup.withOptions
            [ RadioGroup.option { value = Home, label = "Home" }
            , RadioGroup.option { value = Motor, label = "Motor" }
            ]
        |> RadioGroup.render OnRadioFieldMsg formData radioGroupModel
```

# Vertical Layout
A radio group is used to combine and provide structure to group of radio buttons, placing element such as label and error message in a pleasant and clear way. Also, it could display a hint message to help final user fill the group.

Radio group have a horizontal layout as default, but with more then two items a vertical layout is recommended.

<component with-label="RadioGroup vertical" />

```
RadioGroup.config name
    |> RadioGroup.withLayout RadioGroup.vertical
    |> RadioGroup.render
        OnRadioFieldMsg
        formData
        (radioGroupModel |> RadioGroup.setValue Motor)
```


# Disabled
<component with-label="RadioGroup disabled" />
```
RadioGroup.config name
    |> RadioGroup.withDisabled True
    |> RadioGroup.render
        OnRadioFieldMsg
        formData
        (radioGroupModel |> RadioGroup.setValue Home)
```
"""


type alias SharedState x =
    { x
        | radio : RadioFieldModels
    }


type Option
    = Home
    | Motor


type alias RadioFieldModels =
    { base : RadioGroup.Model () Option Option
    , vertical : RadioGroup.Model () Option Option
    , disabled : RadioGroup.Model () Option Option
    }


type alias Model =
    RadioFieldModels


init : Model
init =
    { base =
        RadioGroup.init Nothing (always (Result.fromMaybe "Invalid selection"))
    , vertical =
        RadioGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , disabled =
        RadioGroup.init (Just Home) (always (Result.fromMaybe "Invalid selection"))
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "RadioGroup"
      , statefulComponent
            { name = "radio-group"
            , configModifier = RadioGroup.withLabel (Label.config "Choose the insurance type")
            , modelPicker = .base
            , update = \msg models -> { models | base = RadioGroup.update msg models.base }
            }
      )
    , ( "RadioGroup vertical"
      , statefulComponent
            { name = "radio-group-vertical"
            , configModifier = RadioGroup.withLayout RadioGroup.vertical
            , modelPicker = .vertical
            , update = \msg models -> { models | vertical = RadioGroup.update msg models.vertical }
            }
      )
    , ( "RadioGroup disabled"
      , statefulComponent
            { name = "radio-group-disabled"
            , configModifier = RadioGroup.withDisabled True
            , modelPicker = .disabled
            , update = always identity
            }
      )
    ]


options : List (RadioGroup.Option Option)
options =
    [ RadioGroup.option { value = Home, label = "Home" }
    , RadioGroup.option { value = Motor, label = "Motor" }
    ]


type alias StatefulConfig =
    { name : String
    , configModifier : RadioGroup.Config Option -> RadioGroup.Config Option
    , modelPicker : Model -> RadioGroup.Model () Option Option
    , update : RadioGroup.Msg Option -> RadioFieldModels -> RadioFieldModels
    }


statefulComponent : StatefulConfig -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statefulComponent { name, configModifier, modelPicker, update } sharedState =
    RadioGroup.config name
        |> RadioGroup.withOptions options
        |> configModifier
        |> RadioGroup.render identity () (sharedState.radio |> modelPicker)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \sharedState_ models -> { sharedState_ | radio = models }
                , fromState = .radio
                , update = update
                }
            )
