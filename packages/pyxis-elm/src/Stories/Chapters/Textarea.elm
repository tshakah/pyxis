module Stories.Chapters.Textarea exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.Textarea as Textarea
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Textarea"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """

Textarea is used when the user may insert longer form content, typically spanning across multiple lines.
It can hold any amount of text and in doing so it grows in height.
Unlike text fields, textarea doesn't support addons.

<component with-label="Textarea" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.render
```
## State
Textarea has default (with placeholder), hover, focus, filled, error and disable states.

### Default with placeholder
<component with-label="Textarea withPlaceholder" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.render
```

### Disabled
<component with-label="Textarea withDisabled" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.withDisabled True
        |> Textarea.render
```
---
## Validation
Add a list of validation function to the modifier. In the example, please try to blur with empty text and
you'll see the error.
<component with-label="Textarea withValidation" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.withValidation []
        |> Textarea.render
```
---
## Size: small
<component with-label="Textarea withSize small" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.withSize Size.small
        |> Textarea.render
```
---
## With default value
<component with-label="Textarea withDefaultValue" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.withDefaultValue "This is a default text."
        |> Textarea.render
```
---
## With name
<component with-label="Textarea withName" />
```
import Components.Field.Textarea as Textarea

textarea: (Textarea.Msg -> msg) -> String -> Html msg
textarea tagger id =
    Textarea.create tagger id
        |> Textarea.withPlaceholder "Textarea"
        |> Textarea.withName "textarea-name"
        |> Textarea.render
```
---
## Accessibility
Whenever possible, please use the label element to associate text with form elements explicitly, with the
`for` attribute of the label that exactly match the id of the form input.
"""


type alias SharedState x =
    { x
        | textareaModels : TextareaModels
    }


type alias FormData =
    {}


type alias TextareaModels =
    { base : Textarea.Model FormData Msg
    , withNonGraphicalApi : Textarea.Model FormData Msg
    }


type alias Model =
    TextareaModels


type Msg
    = OnTextareaMsg Textarea.Msg


init : Model
init =
    { base = Textarea.create OnTextareaMsg "base"
    , withNonGraphicalApi =
        Textarea.create OnTextareaMsg "withNonGraphicalApi"
            |> Textarea.withValidation requiredTextarea
    }


requiredTextarea : FormData -> String -> Result String String
requiredTextarea _ value =
    if value |> String.trim |> String.isEmpty then
        Err "Field can not be empty"

    else
        Ok value


sizeComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
sizeComponents =
    [ ( "Textarea withSize small"
      , statelessComponent "Textarea small" (Textarea.withSize Size.small)
      )
    ]


otherGraphicalApiComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
otherGraphicalApiComponents =
    [ ( "Textarea withDefaultValue"
      , statelessComponent "Textarea withDefaultValue" (Textarea.withDefaultValue "Default Value")
      )
    , ( "Textarea withDisabled"
      , statelessComponent "Textarea withDisabled" (Textarea.withDisabled True)
      )
    , ( "Textarea withPlaceholder"
      , statelessComponent "Textarea withPlaceholder" (Textarea.withPlaceholder "Custom placeholder")
      )
    , ( "Textarea withName"
      , statelessComponent "Textarea withName" (Textarea.withName "Textarea name")
      )
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Textarea"
      , statelessComponent "Textarea" identity
      )
    , ( "Textarea withValidation"
      , statefulComponent
            "Textarea with Validation"
            .withNonGraphicalApi
            (\state model -> mapTextareaModels (setWithNonGraphicalApi model) state)
      )
    ]
        ++ sizeComponents
        ++ otherGraphicalApiComponents


mapTextareaModels : (TextareaModels -> TextareaModels) -> SharedState x -> SharedState x
mapTextareaModels updater state =
    { state | textareaModels = updater state.textareaModels }


setBase : Textarea.Model FormData Msg -> TextareaModels -> TextareaModels
setBase newModel textareaModels =
    { textareaModels | base = newModel }


setWithNonGraphicalApi : Textarea.Model FormData Msg -> TextareaModels -> TextareaModels
setWithNonGraphicalApi newModel textareaModels =
    { textareaModels | withNonGraphicalApi = newModel }


fromState : (TextareaModels -> Textarea.Model FormData Msg) -> SharedState x -> Textarea.Model FormData Msg
fromState mapper =
    .textareaModels
        >> mapper


updateInternal : Msg -> Textarea.Model FormData Msg -> Textarea.Model FormData Msg
updateInternal (OnTextareaMsg msg) model =
    Textarea.update {} msg model


withErrorWrapper : Html msg -> Html msg
withErrorWrapper component =
    Html.div [ Html.Attributes.style "margin-bottom" "20px" ] [ component ]


statelessComponent : String -> (Textarea.Model FormData Msg -> Textarea.Model FormData Msg) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent placeholder modifier { textareaModels } =
    textareaModels.base
        |> Textarea.withPlaceholder placeholder
        |> modifier
        |> Textarea.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapTextareaModels (setBase model) state
                , fromState = .textareaModels >> .base
                , update = \(OnTextareaMsg msg) model -> Textarea.update {} msg model
                }
            )


statefulComponent :
    String
    -> (TextareaModels -> Textarea.Model FormData Msg)
    -> (SharedState x -> Textarea.Model FormData Msg -> SharedState x)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent placeholder mapper toState sharedModel =
    sharedModel.textareaModels
        |> mapper
        |> Textarea.withPlaceholder placeholder
        |> Textarea.render
        |> withErrorWrapper
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = fromState mapper
                , update = updateInternal
                }
            )
