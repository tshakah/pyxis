module Stories.Chapters.NumberField exposing (Model, docs, init)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Number as NumberField
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "NumberField"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Number Field are used to let the user enter a number. They include built-in validation to reject non-numerical entries.

<component with-label="NumberField" />
```
numberField : (NumberField.Msg -> msg) -> String -> Html msg
numberField tagger id =
    NumberField.create tagger id
        |> NumberField.render
```
## Addon

Number field can have several addons, such as icons or texts. They are used to make the user understand the purpose of the field better.
**Please Note**: use these addons one at a time.

### Addon: Prepend Text
<component with-label="NumberField withAddon prepend text" />

```
numberFieldWithAddon : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithAddon tagger id =
    NumberField.create tagger id
        |> NumberField.withAddon Placement.prepend (NumberField.textAddon "mq")
        |> NumberField.render
```

### Addon: Append Text
<component with-label="NumberField withAddon append text" />

```
numberFieldWithAddon : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithAddon tagger id =
    NumberField.create tagger id
        |> NumberField.withAddon Placement.append (NumberField.textAddon "€")
        |> NumberField.render
```

### Addon: Prepend Icon
<component with-label="NumberField withAddon prepend icon" />

```
numberFieldWithAddon : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithAddon tagger id =
    NumberField.create tagger id
        |> NumberField.withAddon Placement.prepend (NumberField.iconAddon IconSet.AccessKey)
        |> NumberField.render
```

### Addon: Append Icon
<component with-label="NumberField withAddon append icon" />

```
numberFieldWithAddon : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithAddon tagger id =
    NumberField.create tagger id
        |> NumberField.withAddon Placement.append (NumberField.iconAddon IconSet.Bell)
        |> NumberField.render
```

## Size

Sizes set the occupied space of the text-field.
You can set your NumberField with a _size_ of default or small.

### Size: Small
<component with-label="NumberField withSize small" />

```
numberFieldWithSize : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithSize tagger id =
    NumberField.create tagger id
        |> NumberField.withSize Size.small
        |> NumberField.render

```

## Others graphical API

<component with-label="NumberField withPlaceholder" />
```
numberFieldWithPlaceholder : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithPlaceholder tagger id =
    NumberField.create tagger id
        |> NumberField.withPlaceholder "Custom placeholder"
        |> NumberField.render

```

<component with-label="NumberField withDefaultValue" />
```
numberFieldWithName : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithName tagger id =
    NumberField.create tagger id
        |> NumberField.withDefaultValue "Default Value"
        |> NumberField.render

```

<component with-label="NumberField withDisabled" />
```
numberFieldWithClassList : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithClassList tagger id =
    NumberField.create tagger id
        |> NumberField.withDisabled True
        |> NumberField.render

```

## Non-graphical API

<component with-label="NumberField withNonGraphicalApi" />
```
numberFieldWithNonGraphicalApi : (NumberField.Msg -> msg) -> String -> Html msg
numberFieldWithNonGraphicalApi tagger id =
    NumberField.create OnNumberFieldMsg "withNonGraphicalApi"
        |> NumberField.withClassList [ ( "class-on-text-field", True ), ( "class-not-on-text-field", False ) ]
        |> NumberField.withName "text-field-name"
        |> NumberField.withValidation requiredNumberField
        |> NumberField.render

requiredNumberField : FormData -> Int -> Result String Int
requiredNumberField _ value =
    if value > 100 then
        Err "Insert a number <= 100"

    else
        Ok value

```
"""


type alias SharedState x =
    { x
        | numberFieldModels : NumberFieldModels
    }


type alias FormData =
    {}


type alias NumberFieldModels =
    { base : NumberField.Model FormData Msg
    , withNonGraphicalApi : NumberField.Model FormData Msg
    }


type alias Model =
    NumberFieldModels


type Msg
    = OnNumberFieldMsg NumberField.Msg


init : Model
init =
    { base = NumberField.create OnNumberFieldMsg "base"
    , withNonGraphicalApi =
        NumberField.create OnNumberFieldMsg "withNonGraphicalApi"
            |> NumberField.withClassList [ ( "class-on-text-field", True ), ( "class-not-on-text-field", False ) ]
            |> NumberField.withName "text-field-name"
            |> NumberField.withValidation requiredNumberField
    }


requiredNumberField : FormData -> Int -> Result String Int
requiredNumberField _ value =
    if value > 100 then
        Err "Insert a number <= 100"

    else
        Ok value


addonComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
addonComponents =
    [ ( "NumberField withAddon prepend text"
      , statelessComponent
            "NumberField withAddon prepend text"
            (NumberField.withAddon Placement.prepend (NumberField.textAddon "mq"))
      )
    , ( "NumberField withAddon append text"
      , statelessComponent
            "NumberField withAddon append text"
            (NumberField.withAddon Placement.append (NumberField.textAddon "€"))
      )
    , ( "NumberField withAddon prepend icon"
      , statelessComponent
            "NumberField withAddon prepend icon"
            (NumberField.withAddon Placement.prepend (NumberField.iconAddon IconSet.AccessKey))
      )
    , ( "NumberField withAddon append icon"
      , statelessComponent
            "NumberField withAddon append icon"
            (NumberField.withAddon Placement.append (NumberField.iconAddon IconSet.Bell))
      )
    ]


sizeComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
sizeComponents =
    [ ( "NumberField withSize small"
      , statelessComponent "NumberField small" (NumberField.withSize Size.small)
      )
    ]


otherGraphicalApiComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
otherGraphicalApiComponents =
    [ ( "NumberField withDefaultValue"
      , statelessComponent "NumberField withDefaultValue" (NumberField.withDefaultValue 42)
      )
    , ( "NumberField withDisabled"
      , statelessComponent "NumberField withDisabled" (NumberField.withDisabled True)
      )
    , ( "NumberField withPlaceholder"
      , statelessComponent "NumberField withPlaceholder" (NumberField.withPlaceholder "Custom placeholder")
      )
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "NumberField"
      , statelessComponent "NumberField" identity
      )
    , ( "NumberField withNonGraphicalApi"
      , statefulComponent
            "NumberField with Functional Api"
            .withNonGraphicalApi
            (\state model -> mapNumberFieldModels (setWithNonGraphicalApi model) state)
      )
    ]
        ++ addonComponents
        ++ sizeComponents
        ++ otherGraphicalApiComponents


mapNumberFieldModels : (NumberFieldModels -> NumberFieldModels) -> SharedState x -> SharedState x
mapNumberFieldModels updater state =
    { state | numberFieldModels = updater state.numberFieldModels }


setBase : NumberField.Model FormData Msg -> NumberFieldModels -> NumberFieldModels
setBase newModel numberFieldModels =
    { numberFieldModels | base = newModel }


setWithNonGraphicalApi : NumberField.Model FormData Msg -> NumberFieldModels -> NumberFieldModels
setWithNonGraphicalApi newModel numberFieldModels =
    { numberFieldModels | withNonGraphicalApi = newModel }


fromState : (NumberFieldModels -> NumberField.Model FormData Msg) -> SharedState x -> NumberField.Model FormData Msg
fromState mapper =
    .numberFieldModels
        >> mapper


updateInternal : Msg -> NumberField.Model FormData Msg -> NumberField.Model FormData Msg
updateInternal (OnNumberFieldMsg msg) model =
    NumberField.update {} msg model


withErrorWrapper : Html msg -> Html msg
withErrorWrapper component =
    Html.div [ Html.Attributes.style "margin-bottom" "20px" ] [ component ]


statelessComponent : String -> (NumberField.Model FormData Msg -> NumberField.Model FormData Msg) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent placeholder modifier { numberFieldModels } =
    numberFieldModels.base
        |> NumberField.withPlaceholder placeholder
        |> modifier
        |> NumberField.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapNumberFieldModels (setBase model) state
                , fromState = .numberFieldModels >> .base
                , update = \(OnNumberFieldMsg msg) model -> NumberField.update {} msg model
                }
            )


statefulComponent :
    String
    -> (NumberFieldModels -> NumberField.Model FormData Msg)
    -> (SharedState x -> NumberField.Model FormData Msg -> SharedState x)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent placeholder mapper toState sharedModel =
    sharedModel.numberFieldModels
        |> mapper
        |> NumberField.withPlaceholder placeholder
        |> NumberField.render
        |> withErrorWrapper
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = fromState mapper
                , update = updateInternal
                }
            )
