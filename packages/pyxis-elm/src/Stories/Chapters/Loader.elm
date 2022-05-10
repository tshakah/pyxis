module Stories.Chapters.Loader exposing (docs)

import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Pyxis.Commons.Properties.Theme as Theme
import Pyxis.Components.Loaders.Loader as Loader


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Loader"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

## Spinner
<component with-label="Spinner" />
```
spinner: Html msg
spinner =
    Loader.spinner
        |> Loader.render
```
### With Text
<component with-label="Spinner With Text" />
```
spinner: Html msg
spinner =
    Loader.spinner
        |> Loader.withText "Loading message..."
        |> Loader.render
```
### With Theme Alternative
<component with-label="Spinner Alt" with-background="#21283b" />
```
spinner: Html msg
spinner =
    Loader.spinner
        |> Loader.withTheme Theme.alternative
        |> Loader.withText "Loading message..."
        |> Loader.render
```
## SpinnerSmall
<component with-label="Spinner Small" />
```
spinner: Html msg
spinner =
    Loader.spinnerSmall
        |> Loader.withText "Loading message..."
        |> Loader.render
```
---
## Car
<component with-label="Car" />
```
car: Html msg
car =
    Loader.car
        |> Loader.render
```
### With Text
<component with-label="Car With Text" />
```
car: Html msg
car =
    Loader.car
        |> Loader.withText "Loading message..."
        |> Loader.render
```
### With Theme Alternative
<component with-label="Car Alt" with-background="#21283b" />
```
car: Html msg
car =
    Loader.car
        |> Loader.withTheme Theme.alternative
        |> Loader.withText "Loading message..."
        |> Loader.render
```

## Accessibility
Loaders have a `status` role with a default label `Loading...`
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Spinner"
      , Loader.spinner
            |> Loader.render
      )
    , ( "Spinner With Text"
      , Loader.spinner
            |> Loader.withText "Loading message..."
            |> Loader.render
      )
    , ( "Spinner Small"
      , Loader.spinnerSmall
            |> Loader.withText "Loading message..."
            |> Loader.render
      )
    , ( "Spinner Alt"
      , Loader.spinner
            |> Loader.withText "Loading message..."
            |> Loader.withTheme Theme.alternative
            |> Loader.render
      )
    , ( "Car"
      , Loader.car
            |> Loader.render
      )
    , ( "Car With Text"
      , Loader.car
            |> Loader.withText "Loading message..."
            |> Loader.render
      )
    , ( "Car Alt"
      , Loader.car
            |> Loader.withText "Loading message..."
            |> Loader.withTheme Theme.alternative
            |> Loader.render
      )
    ]
