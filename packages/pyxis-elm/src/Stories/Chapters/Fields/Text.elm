module Stories.Chapters.Fields.Text exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Text as Text
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Fields/Text"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
All the properties described below concern the visual implementation of the component.

<component with-label="Text" />
```
type Msg
    = TextFieldMsg Text.Msg

textFieldModel : Text.Model ()

Text.text "textfield-id"
    |> Text.render TextFieldMsg () textfieldModel
```
## Addon

Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="Text withAddon prepend text" />

```
Text.text "textfield-id"
    |> Text.withAddon Placement.prepend (Text.textAddon "mq")
    |> Text.render TextFieldMsg () textfieldModel
```

### Addon: Append Text
<component with-label="Text withAddon append text" />

```
Text.text "textfield-id"
    |> Text.withAddon Placement.append (Text.textAddon "€")
    |> Text.render TextFieldMsg () textfieldModel
```

### Addon: Prepend Icon
<component with-label="Text withAddon prepend icon" />

```
Text.text "textfield-id"
    |> Text.withAddon Placement.prepend (Text.iconAddon IconSet.AccessKey)
    |> Text.render TextFieldMsg () textfieldModel
```

### Addon: Append Icon
<component with-label="Text withAddon append icon" />

```
Text.text "textfield-id"
    |> Text.withAddon Placement.append (Text.iconAddon IconSet.Bell)
    |> Text.render TextFieldMsg () textfieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Text withSize small" />

```
Text.text "textfield-id"
    |> Text.withSize Size.small
    |> Text.render TextFieldMsg () textfieldModel
```

## Others

<component with-label="Text withPlaceholder" />
```
Text.text "textfield-id"
    |> Text.withPlaceholder "Custom placeholder"
    |> Text.render TextFieldMsg () textfieldModel
```

<component with-label="Text withDisabled" />
```
Text.text "textfield-id"
    |> Text.withDisabled True
    |> Text.render TextFieldMsg () textfieldModel
```

---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x | text : Model }


type alias Model =
    { state : Text.Model ()
    , config : Text.Config
    }


init : Model
init =
    { state = Text.init (always Ok)
    , config = Text.text "base"
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Text"
      , statelessComponent identity
      )
    , ( "Text withAddon prepend text"
      , statelessComponent
            (Text.withAddon Placement.prepend (Text.textAddon "mq"))
      )
    , ( "Text withAddon append text"
      , statelessComponent
            (Text.withAddon Placement.append (Text.textAddon "€"))
      )
    , ( "Text withAddon prepend icon"
      , statelessComponent
            (Text.withAddon Placement.prepend (Text.iconAddon IconSet.AccessKey))
      )
    , ( "Text withAddon append icon"
      , statelessComponent
            (Text.withAddon Placement.append (Text.iconAddon IconSet.Bell))
      )
    , ( "Text withSize small"
      , statelessComponent (Text.withSize Size.small)
      )
    , ( "Text withDisabled"
      , statelessComponent (Text.withDisabled True)
      )
    , ( "Text withPlaceholder"
      , statelessComponent (Text.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : (Text.Config -> Text.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent modifier { text } =
    text.config
        |> modifier
        |> Text.render identity () text.state
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | text = model }
                , fromState = .text
                , update = \msg model -> { model | state = Text.update msg model.state }
                }
            )
