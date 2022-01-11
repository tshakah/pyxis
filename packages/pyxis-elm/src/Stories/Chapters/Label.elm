module Stories.Chapters.Label exposing (docs)

import Components.Label as Label
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter ()
docs =
    "Label"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

Label component provides a label to be used within a form. It requires a _text_ and a proper _for_ value.
Note that _for_ attribute value is also passed to data-test-id.

<component with-label="Label" />
```
Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "Label" "input-id"
            |> Label.render
```
## Variations
Label can have an additional explanatory text or can be set with a smaller size.

### With an additional text
<component with-label="Additional text" />
```
Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "Main label" "input-id"
            |> Label.withSubText "This is an additional text"
            |> Label.render
```

### Size: small
<component with-label="Small" />
```
Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "Smaller label" "input-id"
            |> Label.withSizeSmall
            |> Label.render
```
---
## Accessibility
Remember that the _for_ attribute provided must be equal to the id attribute of the related input element to bind
them together.
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Label"
      , Label.create "Label" "input-id"
            |> Label.render
      )
    , ( "Additional text"
      , Label.create "Main label" "input-id"
            |> Label.withSubText "This is an additional text"
            |> Label.render
      )
    , ( "Small"
      , Label.create "Smaller label" "input-id"
            |> Label.withSizeSmall
            |> Label.render
      )
    ]
