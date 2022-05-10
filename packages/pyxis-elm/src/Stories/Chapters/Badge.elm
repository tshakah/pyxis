module Stories.Chapters.Badge exposing (docs)

import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Pyxis.Commons.Properties.Theme as Theme
import Pyxis.Components.Badge as Badge


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Badge"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

Badges are labels which hold small amounts of information. They are composed of text inside a `span` element.
<component with-label="Default" />

## Variants
Variants of badge consist on different combinations of colours and each of them conveys a different meaning to the user.

### Neutral Badge
<component with-label="Neutral" />
```
badge: Html msg
badge =
    Badge.neutral "Badge"
        |> Badge.render
```
### Brand Badge
<component with-label="Brand" />
```
Badge.brand "Badge"
    |> Badge.render
```
### Action Badge
<component with-label="Action" />
```
Badge.action "Badge"
    |> Badge.render
```
### Success Badge
<component with-label="Success" />
```
Badge.success "Badge"
    |> Badge.render
```
### Alert Badge
<component with-label="Alert" />
```
Badge.alert "Badge"
    |> Badge.render
```
### Error Badge
<component with-label="Error" />
```
Badge.error "Badge"
    |> Badge.render
```
### Neutral Badge With Gradient
<component with-label="NeutralGradient" />
```
Badge.neutralGradient "Badge"
    |> Badge.render
```
### Brand Badge With Gradient
<component with-label="BrandGradient" />
```
Badge.brandGradient "Badge"
    |> Badge.render
```
### Ghost
__Please note:__ ghost badge are available only with alternative theme.
<component with-label="Ghost"  with-background="#21283B" />
```
Badge.ghost "Badge"
    |> Badge.render
```
---
### Theme: Alternative
__Please note:__ `neutralGradient` and `brandGradient` could not be used with alternate theme.
<component with-label="AltTheme" with-background="#21283B" />
```
Badge.neutral "Badge"
    |> Badge.withTheme Theme.alternative
    |> Badge.render
```
---
## With id
Setting an id to Badge also implies setting a `data-test-id`
attribute with the same value of the id received.

<component with-label="WithId" />
```
Badge.ghost "Badge"
    |> Badge.withId "badge-id"
    |> Badge.render
```
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Default"
      , Badge.neutral "Badge"
            |> Badge.render
      )
    , ( "Neutral"
      , Badge.neutral "Badge"
            |> Badge.render
      )
    , ( "Brand"
      , Badge.brand "Badge"
            |> Badge.render
      )
    , ( "Action"
      , Badge.action "Badge"
            |> Badge.render
      )
    , ( "Success"
      , Badge.success "Badge"
            |> Badge.render
      )
    , ( "Alert"
      , Badge.alert "Badge"
            |> Badge.render
      )
    , ( "Error"
      , Badge.error "Badge"
            |> Badge.render
      )
    , ( "NeutralGradient"
      , Badge.neutralGradient "Badge"
            |> Badge.render
      )
    , ( "BrandGradient"
      , Badge.brandGradient "Badge"
            |> Badge.render
      )
    , ( "Ghost"
      , Badge.ghost "Badge"
            |> Badge.render
      )
    , ( "AltTheme"
      , Badge.neutral "Badge"
            |> Badge.withTheme Theme.alternative
            |> Badge.render
      )
    , ( "WithId"
      , Badge.neutral "Badge"
            |> Badge.withId "badge-id"
            |> Badge.render
      )
    ]
