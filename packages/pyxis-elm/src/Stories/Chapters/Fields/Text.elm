module Stories.Chapters.Fields.Text exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Label as Label
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
type Msg
    = OnTextFieldMsg Text.Msg


type alias FormData =
    { name : String
    , surname : String
    }


validation : FormData -> String -> Result String String
validation _ value =
    if String.isEmpty value then
        Err "Required field"

    else
        Ok value


textFieldModel : Text.Model FormData
textFieldModel =
    Text.init validation


textField : FormData -> Html Msg
textField formData =
    Text.text "text-id"
        |> Text.withLabel (Label.config "Name")
        |> Text.render OnTextFieldMsg formData textFieldModel
```
## Addon

Text field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="Text withAddon prepend text" />

```
Text.text "text-id"
    |> Text.withAddon Placement.prepend (Text.textAddon "mq")
    |> Text.render OnTextFieldMsg formData textFieldModel
```

### Addon: Append Text
<component with-label="Text withAddon append text" />

```
Text.text "text-id"
    |> Text.withAddon Placement.append (Text.textAddon "€")
    |> Text.render OnTextFieldMsg formData textFieldModel
```

### Addon: Prepend Icon
<component with-label="Text withAddon prepend icon" />

```
Text.text "text-id"
    |> Text.withAddon Placement.prepend (Text.iconAddon IconSet.AccessKey)
    |> Text.render OnTextFieldMsg formData textFieldModel
```

### Addon: Append Icon
<component with-label="Text withAddon append icon" />

```
Text.text "text-id"
    |> Text.withAddon Placement.append (Text.iconAddon IconSet.Bell)
    |> Text.render OnTextFieldMsg formData textFieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Text withSize small" />

```
Text.text "text-id"
    |> Text.withSize Size.small
    |> Text.render OnTextFieldMsg formData textFieldModel
```

## Others

<component with-label="Text withPlaceholder" />
```
Text.text "text-id"
    |> Text.withPlaceholder "Custom placeholder"
    |> Text.render OnTextFieldMsg formData textFieldModel
```

<component with-label="Text withDisabled" />
```
Text.text "text-id"
    |> Text.withDisabled True
    |> Text.render OnTextFieldMsg formData textFieldModel
```
"""


type alias SharedState x =
    { x | text : Model }


type alias Model =
    { base : Text.Model ()
    , withValidation : Text.Model ()
    }


init : Model
init =
    { base = Text.init (always Ok)
    , withValidation = Text.init validation
    }


validation : () -> String -> Result String String
validation _ value =
    if String.isEmpty value then
        Err "Required field"

    else
        Ok value


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Text"
      , statefulComponent "text" (Text.withLabel (Label.config "Name")) identity .withValidation updateWithValidation
      )
    , ( "Text withAddon prepend text"
      , statelessComponent "with-addon-prepend-text"
            (Text.withAddon Placement.prepend (Text.textAddon "mq"))
      )
    , ( "Text withAddon append text"
      , statelessComponent "with-addon-append-text"
            (Text.withAddon Placement.append (Text.textAddon "€"))
      )
    , ( "Text withAddon prepend icon"
      , statelessComponent "with-addon-prepend-icon"
            (Text.withAddon Placement.prepend (Text.iconAddon IconSet.AccessKey))
      )
    , ( "Text withAddon append icon"
      , statelessComponent "with-addon-append-icon"
            (Text.withAddon Placement.append (Text.iconAddon IconSet.Bell))
      )
    , ( "Text withSize small"
      , statelessComponent "small" (Text.withSize Size.small)
      )
    , ( "Text withDisabled"
      , statelessComponent "disabled" (Text.withDisabled True)
      )
    , ( "Text withPlaceholder"
      , statelessComponent "placeholder" (Text.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : String -> (Text.Config -> Text.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent id modifier { text } =
    Text.text id
        |> modifier
        |> Text.render identity () text.base
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | text = model }
                , fromState = .text
                , update = \msg model -> { model | base = Text.update msg model.base }
                }
            )


statefulComponent :
    String
    -> (Text.Config -> Text.Config)
    -> (Text.Model () -> Text.Model ())
    -> (Model -> Text.Model ())
    -> (Text.Msg -> Model -> Model)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent id configModifier modelModifier modelPicker update sharedState =
    Text.text id
        |> configModifier
        |> Text.render identity () (sharedState.text |> modelPicker |> modelModifier)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | text = model }
                , fromState = .text
                , update = update
                }
            )


updateWithValidation : Text.Msg -> Model -> Model
updateWithValidation msg model =
    { model | withValidation = Text.update msg model.withValidation }
