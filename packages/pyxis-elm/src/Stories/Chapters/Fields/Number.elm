module Stories.Chapters.Fields.Number exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Label as Label
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
    = OnNumberFieldMsg Number.Msg


validation : formData -> Int -> Result String Int
validation _ value =
    if value < 18 then
        Err "You should be at least 18 years old"
    else
        Ok value


numberFieldModel : Number.Model formData
numberFieldModel =
    Number.init validation


numberField : formData -> Html Msg
numberField formData =
    Number.config "number-id"
        |> Number.render OnNumberFieldMsg formData numberFieldModel
```
## Addon

Number field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="Number withAddon prepend text" />

```
Number.config "number-id"
    |> Number.withAddon Placement.prepend (Number.textAddon "mq")
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

### Addon: Append Text
<component with-label="Number withAddon append text" />

```
Number.config "number-id"
    |> Number.withAddon Placement.append (Number.textAddon "€")
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

### Addon: Prepend Icon
<component with-label="Number withAddon prepend icon" />

```
Number.config "number-id"
    |> Number.withAddon Placement.prepend (Number.iconAddon IconSet.AccessKey)
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

### Addon: Append Icon
<component with-label="Number withAddon append icon" />

```
Number.config "number-id"
    |> Number.withAddon Placement.append (Number.iconAddon IconSet.Bell)
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Number withSize small" />

```
Number.config "number-id"
    |> Number.withSize Size.small
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

## Others

<component with-label="Number withPlaceholder" />
```
Number.config "number-id"
    |> Number.withPlaceholder "Custom placeholder"
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```

<component with-label="Number withDisabled" />
```
Number.config "number-id"
    |> Number.withDisabled True
    |> Number.render OnNumberFieldMsg formData numberFieldModel
```
"""


type alias SharedState x =
    { x | number : Model }


type alias Model =
    { base : Number.Model ()
    , withValidation : Number.Model ()
    }


validation : () -> Int -> Result String Int
validation _ value =
    if value < 18 then
        Err "You should be at least 18 years old"

    else
        Ok value


init : Model
init =
    { base = Number.init (always Ok)
    , withValidation = Number.init validation
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Number"
      , statefulComponent
            "number"
            (Number.withLabel (Label.config "Age"))
            .withValidation
            updateWithValidation
      )
    , ( "Number withAddon prepend text"
      , statelessComponent "with-addon-prepend-text"
            (Number.withAddon Placement.prepend (Number.textAddon "mq"))
      )
    , ( "Number withAddon append text"
      , statelessComponent "with-addon-append-text"
            (Number.withAddon Placement.append (Number.textAddon "€"))
      )
    , ( "Number withAddon prepend icon"
      , statelessComponent "with-addon-prepend-icon"
            (Number.withAddon Placement.prepend (Number.iconAddon IconSet.AccessKey))
      )
    , ( "Number withAddon append icon"
      , statelessComponent "with-addon-append-icon"
            (Number.withAddon Placement.append (Number.iconAddon IconSet.Bell))
      )
    , ( "Number withSize small"
      , statelessComponent "small" (Number.withSize Size.small)
      )
    , ( "Number withDisabled"
      , statelessComponent "disabled" (Number.withDisabled True)
      )
    , ( "Number withPlaceholder"
      , statelessComponent "placeholder" (Number.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : String -> (Number.Config -> Number.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent id modifier { number } =
    Number.config id
        |> modifier
        |> Number.render identity () number.base
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | number = model }
                , fromState = .number
                , update = \msg model -> { model | base = Number.update msg model.base }
                }
            )


statefulComponent :
    String
    -> (Number.Config -> Number.Config)
    -> (Model -> Number.Model ())
    -> (Number.Msg -> Model -> Model)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent id configModifier modelPicker update sharedState =
    Number.config id
        |> configModifier
        |> Number.render identity () (sharedState.number |> modelPicker)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | number = model }
                , fromState = .number
                , update = update
                }
            )


updateWithValidation : Number.Msg -> Model -> Model
updateWithValidation msg model =
    { model | withValidation = Number.update msg model.withValidation }
