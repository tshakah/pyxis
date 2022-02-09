module Stories.Chapters.TextField exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Text as TextField
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "TextField"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Text fields are used when the user should include short form content, including text, numbers, e-mail addresses, or passwords.
All the properties described below concern the visual implementation of the component.

<component with-label="TextField" />
```
textField : (TextField.Msg -> msg) -> String -> Html msg
textField tagger id =
    TextField.create tagger id
        |> TextField.render
```
## Addon

Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="TextField withAddon prepend text" />

```
textFieldWithAddon : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    TextField.create tagger id
        |> TextField.withAddon Placement.prepend (TextField.textAddon "mq")
        |> TextField.render
```

### Addon: Append Text
<component with-label="TextField withAddon append text" />

```
textFieldWithAddon : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    TextField.create tagger id
        |> TextField.withAddon Placement.append (TextField.textAddon "€")
        |> TextField.render
```

### Addon: Prepend Icon
<component with-label="TextField withAddon prepend icon" />

```
textFieldWithAddon : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    TextField.create tagger id
        |> TextField.withAddon Placement.prepend (TextField.iconAddon IconSet.AccessKey)
        |> TextField.render
```

### Addon: Append Icon
<component with-label="TextField withAddon append icon" />

```
textFieldWithAddon : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    TextField.create tagger id
        |> TextField.withAddon Placement.append (TextField.iconAddon IconSet.Bell)
        |> TextField.render
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="TextField withSize small" />

```
textFieldWithSize : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithSize tagger id =
    TextField.create tagger id
        |> TextField.withSize Size.small
        |> TextField.render

```

## Others graphical API

<component with-label="TextField withPlaceholder" />
```
textFieldWithPlaceholder : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithPlaceholder tagger id =
    TextField.create tagger id
        |> TextField.withPlaceholder "Custom placeholder"
        |> TextField.render

```

<component with-label="TextField withDefaultValue" />
```
textFieldWithName : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithName tagger id =
    TextField.create tagger id
        |> TextField.withDefaultValue "Default Value"
        |> TextField.render

```

<component with-label="TextField withDisabled" />
```
textFieldWithClassList : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithClassList tagger id =
    TextField.create tagger id
        |> TextField.withDisabled True
        |> TextField.render

```

## Non-graphical API

<component with-label="TextField withNonGraphicalApi" />
```
textFieldWithNonGraphicalApi : (TextField.Msg -> msg) -> String -> Html msg
textFieldWithNonGraphicalApi tagger id =
    TextField.create OnTextFieldMsg "withNonGraphicalApi"
        |> TextField.withClassList [ ( "class-on-text-field", True ), ( "class-not-on-text-field", False ) ]
        |> TextField.withName "text-field-name"
        |> TextField.withValidation requiredTextField
        |> TextField.render

requiredTextField : FormData -> String -> Result String String
requiredTextField _ value =
    if value |> String.trim |> String.isEmpty then
        Err "Field can not be empty"

    else
        Ok value

```
---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x
        | textFieldModels : TextFieldModels
    }


type alias FormData =
    {}


type alias TextFieldModels =
    { base : TextField.Model FormData Msg
    , withNonGraphicalApi : TextField.Model FormData Msg
    }


type alias Model =
    TextFieldModels


type Msg
    = OnTextFieldMsg TextField.Msg


init : Model
init =
    { base = TextField.text OnTextFieldMsg "base"
    , withNonGraphicalApi =
        TextField.text OnTextFieldMsg "withNonGraphicalApi"
            |> TextField.withClassList [ ( "class-on-text-field", True ), ( "class-not-on-text-field", False ) ]
            |> TextField.withName "text-field-name"
            |> TextField.withValidation requiredTextField
    }


requiredTextField : FormData -> String -> Result String String
requiredTextField _ value =
    if value |> String.trim |> String.isEmpty then
        Err "Field can not be empty"

    else
        Ok value


addonComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
addonComponents =
    [ ( "TextField withAddon prepend text"
      , statelessComponent
            "TextField withAddon prepend text"
            (TextField.withAddon Placement.prepend (TextField.textAddon "mq"))
      )
    , ( "TextField withAddon append text"
      , statelessComponent
            "TextField withAddon append text"
            (TextField.withAddon Placement.append (TextField.textAddon "€"))
      )
    , ( "TextField withAddon prepend icon"
      , statelessComponent
            "TextField withAddon prepend icon"
            (TextField.withAddon Placement.prepend (TextField.iconAddon IconSet.AccessKey))
      )
    , ( "TextField withAddon append icon"
      , statelessComponent
            "TextField withAddon append icon"
            (TextField.withAddon Placement.append (TextField.iconAddon IconSet.Bell))
      )
    ]


sizeComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
sizeComponents =
    [ ( "TextField withSize small"
      , statelessComponent "TextField small" (TextField.withSize Size.small)
      )
    ]


otherGraphicalApiComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
otherGraphicalApiComponents =
    [ ( "TextField withDefaultValue"
      , statelessComponent "TextField withDefaultValue" (TextField.withDefaultValue "Default Value")
      )
    , ( "TextField withDisabled"
      , statelessComponent "TextField withDisabled" (TextField.withDisabled True)
      )
    , ( "TextField withPlaceholder"
      , statelessComponent "TextField withPlaceholder" (TextField.withPlaceholder "Custom placeholder")
      )
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "TextField"
      , statelessComponent "TextField" identity
      )
    , ( "TextField withNonGraphicalApi"
      , statefulComponent
            "TextField with Functional Api"
            .withNonGraphicalApi
            (\state model -> mapTextFieldModels (setWithNonGraphicalApi model) state)
      )
    ]
        ++ addonComponents
        ++ sizeComponents
        ++ otherGraphicalApiComponents


mapTextFieldModels : (TextFieldModels -> TextFieldModels) -> SharedState x -> SharedState x
mapTextFieldModels updater state =
    { state | textFieldModels = updater state.textFieldModels }


setBase : TextField.Model FormData Msg -> TextFieldModels -> TextFieldModels
setBase newModel textFieldModels =
    { textFieldModels | base = newModel }


setWithNonGraphicalApi : TextField.Model FormData Msg -> TextFieldModels -> TextFieldModels
setWithNonGraphicalApi newModel textFieldModels =
    { textFieldModels | withNonGraphicalApi = newModel }


fromState : (TextFieldModels -> TextField.Model FormData Msg) -> SharedState x -> TextField.Model FormData Msg
fromState mapper =
    .textFieldModels
        >> mapper


updateInternal : Msg -> TextField.Model FormData Msg -> TextField.Model FormData Msg
updateInternal (OnTextFieldMsg msg) model =
    TextField.update {} msg model


withErrorWrapper : Html msg -> Html msg
withErrorWrapper component =
    Html.div [ Html.Attributes.style "margin-bottom" "20px" ] [ component ]


statelessComponent : String -> (TextField.Model FormData Msg -> TextField.Model FormData Msg) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent placeholder modifier { textFieldModels } =
    textFieldModels.base
        |> TextField.withPlaceholder placeholder
        |> modifier
        |> TextField.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapTextFieldModels (setBase model) state
                , fromState = .textFieldModels >> .base
                , update = \(OnTextFieldMsg msg) model -> TextField.update {} msg model
                }
            )


statefulComponent :
    String
    -> (TextFieldModels -> TextField.Model FormData Msg)
    -> (SharedState x -> TextField.Model FormData Msg -> SharedState x)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent placeholder mapper toState sharedModel =
    sharedModel.textFieldModels
        |> mapper
        |> TextField.withPlaceholder placeholder
        |> TextField.render
        |> withErrorWrapper
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = fromState mapper
                , update = updateInternal
                }
            )
