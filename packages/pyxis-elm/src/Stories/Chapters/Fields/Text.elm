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
    "Text"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
All the properties described below concern the visual implementation of the component.

<component with-label="Text" />
```
textField : (Text.Msg -> msg) -> String -> Html msg
textField tagger id =
    Text.create tagger id
        |> Text.render
```
## Addon

Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="Text withAddon prepend text" />

```
textFieldWithAddon : (Text.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    Text.create tagger id
        |> Text.withAddon Placement.prepend (Text.textAddon "mq")
        |> Text.render
```

### Addon: Append Text
<component with-label="Text withAddon append text" />

```
textFieldWithAddon : (Text.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    Text.create tagger id
        |> Text.withAddon Placement.append (Text.textAddon "€")
        |> Text.render
```

### Addon: Prepend Icon
<component with-label="Text withAddon prepend icon" />

```
textFieldWithAddon : (Text.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    Text.create tagger id
        |> Text.withAddon Placement.prepend (Text.iconAddon IconSet.AccessKey)
        |> Text.render
```

### Addon: Append Icon
<component with-label="Text withAddon append icon" />

```
textFieldWithAddon : (Text.Msg -> msg) -> String -> Html msg
textFieldWithAddon tagger id =
    Text.create tagger id
        |> Text.withAddon Placement.append (Text.iconAddon IconSet.Bell)
        |> Text.render
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Text withSize small" />

```
textFieldWithSize : (Text.Msg -> msg) -> String -> Html msg
textFieldWithSize tagger id =
    Text.create tagger id
        |> Text.withSize Size.small
        |> Text.render

```

## Others

<component with-label="Text withPlaceholder" />
```
textFieldWithPlaceholder : (Text.Msg -> msg) -> String -> Html msg
textFieldWithPlaceholder tagger id =
    Text.create tagger id
        |> Text.withPlaceholder "Custom placeholder"
        |> Text.render

```

<component with-label="Text withDisabled" />
```
textFieldWithClassList : (Text.Msg -> msg) -> String -> Html msg
textFieldWithClassList tagger id =
    Text.create tagger id
        |> Text.withDisabled True
        |> Text.render

```

---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x | text : Model }


type alias Model =
    { state : Text.Model {}
    , config : Text.Config Msg
    }


type Msg
    = OnTextFieldMsg Text.Msg


init : Model
init =
    { state = Text.init (always Ok)
    , config = Text.text OnTextFieldMsg "base"
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


statelessComponent : (Text.Config Msg -> Text.Config Msg) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent modifier { text } =
    text.config
        |> modifier
        |> Text.render {} text.state
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | text = model }
                , fromState = .text
                , update = \(OnTextFieldMsg msg) model -> { model | state = Text.update {} msg model.state }
                }
            )
