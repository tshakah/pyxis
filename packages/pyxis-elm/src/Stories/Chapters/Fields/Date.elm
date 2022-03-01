module Stories.Chapters.Fields.Date exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.Date as Date
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Fields/Date"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
All the properties described below concern the visual implementation of the component.

<component with-label="Date" />
```
type Msg
    = DateFieldMsg Date.Msg

dateFieldModel : Date.Model ()

Date.config "datefield-id"
    |> Date.render DateFieldMsg () dateFieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Date withSize small" />

```
Date.config "datefield-id"
    |> Date.withSize Size.small
    |> Date.render DateFieldMsg () dateFieldModel
```

## Others

<component with-label="Date withPlaceholder" />
```
Date.config "datefield-id"
    |> Date.withPlaceholder "Custom placeholder"
    |> Date.render DateFieldMsg () dateFieldModel
```

<component with-label="Date withDisabled" />
```
Date.config "datefield-id"
    |> Date.withDisabled True
    |> Date.render DateFieldMsg () dateFieldModel
```

---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x | date : Model }


type alias Model =
    { state : Date.Model ()
    , config : Date.Config
    }


init : Model
init =
    { state = Date.init (always Ok)
    , config = Date.config "base"
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Date"
      , statelessComponent identity
      )
    , ( "Date withSize small"
      , statelessComponent (Date.withSize Size.small)
      )
    , ( "Date withDisabled"
      , statelessComponent (Date.withDisabled True)
      )
    , ( "Date withPlaceholder"
      , statelessComponent (Date.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : (Date.Config -> Date.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent modifier { date } =
    date.config
        |> modifier
        |> Date.render identity () date.state
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | date = model }
                , fromState = .date
                , update = \msg model -> { model | state = Date.update msg model.state }
                }
            )
