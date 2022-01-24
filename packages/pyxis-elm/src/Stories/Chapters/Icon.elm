module Stories.Chapters.Icon exposing (docs)

import Commons.Properties.Size as Size
import Commons.Properties.Theme as Theme
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
      |> Icon.withStyleDefault
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
      |> Icon.withStyleBoxed
      |> Icon.render
```

## Theme
You can set your Icon with a default _theme_ or alternative.

### Theme: Default
<component with-label="Default Theme" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet


icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withThemeDefault
      |> Icon.render
```

### Theme: Alternative
<component with-label="Alternative Theme" />
```
import Components.Icon as Icon
import Components.IconSet as IconSet

{-| Note that you can only enable the Alternative theme on a Boxed icon.
-}
icon: Html msg
icon =
  IconSet.User
      |> Icon.create
      |> Icon.withStyleBoxed
      |> Icon.withThemeAlternative
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
            |> Icon.withSize Size.large
            |> Icon.render
      )
    , ( "Medium"
      , IconSet.User
            |> Icon.create
            |> Icon.withSize Size.medium
            |> Icon.render
      )
    , ( "Small"
      , IconSet.User
            |> Icon.create
            |> Icon.withSize Size.small
            |> Icon.render
      )
    , ( "Default Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.default
            |> Icon.render
      )
    , ( "Boxed Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.boxed
            |> Icon.render
      )
    , ( "Default Theme"
      , IconSet.User
            |> Icon.create
            |> Icon.withTheme Theme.default
            |> Icon.render
      )
    , ( "Alternative Theme"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.boxed
            |> Icon.withTheme Theme.alternative
            |> Icon.render
      )
    , ( "Accessible Description"
      , IconSet.User
            |> Icon.create
            |> Icon.withDescription "A screen-reader useful description"
            |> Icon.render
      )
    ]
