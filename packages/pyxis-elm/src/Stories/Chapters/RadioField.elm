module Stories.Chapters.RadioField exposing (Model, docs, init)

import Components.Field.Radio as RadioField
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Stories.Helpers as SH


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "RadioField"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Text fields are used when the user should include short form content, including text, numbers, e-mail addresses, or passwords.
All the properties described below concern the visual implementation of the component.

<component with-label="RadioField" />
```
textField : (RadioField.Msg -> msg) -> String -> Html msg
textField tagger id =
    RadioField.create tagger id
        |> RadioField.render
```
## Addon

Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="RadioField withAddon prepend text" />

```
textFieldWithAddon : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    RadioField.create tagger id
        |> RadioField.withAddon Placement.prepend (RadioField.textAddon "mq")
        |> RadioField.render
```

### Addon: Append Text
<component with-label="RadioField withAddon append text" />

```
textFieldWithAddon : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    RadioField.create tagger id
        |> RadioField.withAddon Placement.append (RadioField.textAddon "€")
        |> RadioField.render
```

### Addon: Prepend Icon
<component with-label="RadioField withAddon prepend icon" />

```
textFieldWithAddon : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    RadioField.create tagger id
        |> RadioField.withAddon Placement.prepend (RadioField.iconAddon IconSet.AccessKey)
        |> RadioField.render
```

### Addon: Append Icon
<component with-label="RadioField withAddon append icon" />

```
textFieldWithAddon : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    RadioField.create tagger id
        |> RadioField.withAddon Placement.append (RadioField.iconAddon IconSet.Bell)
        |> RadioField.render
```

## Size

Sizes set the occupied space of the text-field.
You can set your RadioField with a _size_ of default or small.

### Size: Small
<component with-label="RadioField withSize small" />

```
textFieldWithSize : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithSize tagger id =
    RadioField.create tagger id
        |> RadioField.withSize Size.small
        |> RadioField.render

```

## Others graphical API

<component with-label="RadioField withPlaceholder" />
```
textFieldWithPlaceholder : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithPlaceholder tagger id =
    RadioField.create tagger id
        |> RadioField.withPlaceholder "Custom placeholder"
        |> RadioField.render

```

<component with-label="RadioField withDefaultValue" />
```
textFieldWithName : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithName tagger id =
    RadioField.create tagger id
        |> RadioField.withDefaultValue "Default Value"
        |> RadioField.render

```

<component with-label="RadioField withDisabled" />
```
textFieldWithClassList : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithClassList tagger id =
    RadioField.create tagger id
        |> RadioField.withDisabled True
        |> RadioField.render

```

## Non-graphical API

<component with-label="RadioField withNonGraphicalApi" />
```
textFieldWithNonGraphicalApi : (RadioField.Msg -> msg) -> String -> Html msg
textFieldWithNonGraphicalApi tagger id =
    RadioField.create OnRadioFieldMsg "withNonGraphicalApi"
        |> RadioField.withClassList [ ( "class-on-text-field", True ), ( "class-not-on-text-field", False ) ]
        |> RadioField.withName "text-field-name"
        |> RadioField.withValidation requiredRadioField
        |> RadioField.render

requiredRadioField : FormData -> String -> Result String String
requiredRadioField _ value =
    if value |> String.trim |> String.isEmpty then
        Err "Field can not be empty"

    else
        Ok value

```
"""


type alias SharedState x =
    { x
        | radioFieldModels : RadioFieldModels
    }


type Option
    = M
    | F
    | N


type alias RadioFieldModels =
    { base : RadioField.Model Option {} Msg
    }


type alias Model =
    RadioFieldModels


type Msg
    = OnRadioFieldMsg (RadioField.Msg Option)


init : Model
init =
    { base =
        RadioField.create
            "radio"
            OnRadioFieldMsg
            N
            [ RadioField.option { value = M, label = "Male" }
            , RadioField.option { value = F, label = "Female" }
            ]
            |> RadioField.withLabel { text = "Radio common label", id = "radio id" }
            |> RadioField.withName "gender"
            |> RadioField.withValidation validation
            |> RadioField.validate {}
    }


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == N then
        Err "Invalid selection"

    else
        Ok value


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "RadioField"
      , statefulComponent .base identity setBase
      )
    ]


statefulComponent :
    (RadioFieldModels -> RadioField.Model Option {} Msg)
    -> (RadioField.Model Option {} Msg -> RadioField.Model Option {} Msg)
    -> (RadioField.Model Option {} Msg -> RadioFieldModels -> RadioFieldModels)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent mapper modifier setInternalValue =
    SH.statefulComponent
        (.radioFieldModels >> mapper)
        (modifier >> RadioField.render)
        (\state model -> mapRadioFieldModels (setInternalValue model) state)
        (\(OnRadioFieldMsg msg) -> RadioField.update {} msg)


mapRadioFieldModels : (RadioFieldModels -> RadioFieldModels) -> SharedState x -> SharedState x
mapRadioFieldModels updater state =
    { state | radioFieldModels = updater state.radioFieldModels }


setBase : RadioField.Model Option {} Msg -> RadioFieldModels -> RadioFieldModels
setBase newModel textFieldModels =
    { textFieldModels | base = newModel }
