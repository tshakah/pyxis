module Stories.Chapters.Icon exposing (docs)

import Components.Icon as Icon
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter ()
docs =
    "Icons"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

## Size
You can set your Icon with a _size_ of large, medium or small.

### Size: Large
<component with-label="Large" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withLargeSize
      |> Icon.render
```

### Size: Medium
<component with-label="Medium" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withMediumSize
      |> Icon.render
```

### Size: Small
<component with-label="Small" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withSmallSize
      |> Icon.render
```

## Style
You can set your Icon with a _style_ default or boxed.

### Style: Default
<component with-label="Default Style" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withDefaultStyle
      |> Icon.render
```

### Style: Boxed
<component with-label="Boxed Style" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withBoxedStyle
      |> Icon.render
```

## Theme
You can set your Icon with a _theme_ light or dark.

### Theme: Light
<component with-label="Light Theme" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withLightTheme
      |> Icon.render
```

### Theme: Dark
<component with-label="Dark Theme" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet

{-| Note that you can only enable the Dark theme on a Boxed icon.
-}
icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withBoxedStyle
      |> Icon.withDarkTheme
      |> Icon.render
```

## Accessibility

<component with-label="Accessible Description" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withDescription "A screen-reader useful description"
      |> Icon.render
```

"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Large"
      , IconSet.User
            |> Icon.create
            |> Icon.withSizeLarge
            |> Icon.render
      )
    , ( "Medium"
      , IconSet.User
            |> Icon.create
            |> Icon.withSizeMedium
            |> Icon.render
      )
    , ( "Small"
      , IconSet.User
            |> Icon.create
            |> Icon.withSizeSmall
            |> Icon.render
      )
    , ( "Default Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyleDefault
            |> Icon.render
      )
    , ( "Boxed Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyleBoxed
            |> Icon.render
      )
    , ( "Light Theme"
      , IconSet.User
            |> Icon.create
            |> Icon.withThemeLight
            |> Icon.render
      )
    , ( "Dark Theme"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyleBoxed
            |> Icon.withThemeDark
            |> Icon.render
      )
    , ( "Accessible Description"
      , IconSet.User
            |> Icon.create
            |> Icon.withDescription "A screen-reader useful description"
            |> Icon.render
      )
    ]
