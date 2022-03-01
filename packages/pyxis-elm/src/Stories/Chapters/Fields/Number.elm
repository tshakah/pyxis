module Stories.Chapters.Fields.Number exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Number as Number
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Fields/Number"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
All the properties described below concern the visual implementation of the component.

<component with-label="Number" />
```
type Msg
    = NumberFieldMsg Number.Msg

numberFieldModel : Date.Model ()

Number.config "numberfield-id"
    |> Number.render NumberFieldMsg () numberFieldModel
```
## Addon

Number field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="Number withAddon prepend text" />

```
Number.config "numberfield-id"
    |> Number.withAddon Placement.prepend (Number.textAddon "mq")
    |> Number.render NumberFieldMsg () numberFieldModel
```

### Addon: Append Text
<component with-label="Number withAddon append text" />

```
Number.config "numberfield-id"
    |> Number.withAddon Placement.append (Number.textAddon "€")
    |> Number.render NumberFieldMsg () numberFieldModel
```

### Addon: Prepend Icon
<component with-label="Number withAddon prepend icon" />

```
Number.config "numberfield-id"
    |> Number.withAddon Placement.prepend (Number.iconAddon IconSet.AccessKey)
    |> Number.render NumberFieldMsg () numberFieldModel
```

### Addon: Append Icon
<component with-label="Number withAddon append icon" />

```
Number.config "numberfield-id"
    |> Number.withAddon Placement.append (Number.iconAddon IconSet.Bell)
    |> Number.render NumberFieldMsg () numberFieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Number withSize small" />

```
Number.config "numberfield-id"
    |> Number.withSize Size.small
    |> Number.render NumberFieldMsg () numberFieldModel
```

## Others

<component with-label="Number withPlaceholder" />
```
Number.config "numberfield-id"
    |> Number.withPlaceholder "Custom placeholder"
    |> Number.render NumberFieldMsg () numberFieldModel
```

<component with-label="Number withDisabled" />
```
Number.config "numberfield-id"
    |> Number.withDisabled True
    |> Number.render NumberFieldMsg () numberFieldModel
```

---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x | number : Model }


type alias Model =
    { state : Number.Model ()
    }


init : Model
init =
    { state = Number.init (always Ok)
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Number"
      , statelessComponent identity
      )
    , ( "Number withAddon prepend text"
      , statelessComponent
            (Number.withAddon Placement.prepend (Number.textAddon "mq"))
      )
    , ( "Number withAddon append text"
      , statelessComponent
            (Number.withAddon Placement.append (Number.textAddon "€"))
      )
    , ( "Number withAddon prepend icon"
      , statelessComponent
            (Number.withAddon Placement.prepend (Number.iconAddon IconSet.AccessKey))
      )
    , ( "Number withAddon append icon"
      , statelessComponent
            (Number.withAddon Placement.append (Number.iconAddon IconSet.Bell))
      )
    , ( "Number withSize small"
      , statelessComponent (Number.withSize Size.small)
      )
    , ( "Number withDisabled"
      , statelessComponent (Number.withDisabled True)
      )
    , ( "Number withPlaceholder"
      , statelessComponent (Number.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : (Number.Config -> Number.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent modifier { number } =
    Number.config "base"
        |> modifier
        |> Number.render identity () number.state
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | number = model }
                , fromState = .number
                , update = \msg model -> { model | state = Number.update msg model.state }
                }
            )
