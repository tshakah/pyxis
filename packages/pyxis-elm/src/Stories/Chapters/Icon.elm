module Stories.Chapters.Icon exposing (docs)

import Commons.Properties.Size as Size
import Commons.Properties.Theme as Theme
import Components.Icon as Icon
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Icons"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

Icons provide visual context and enhance usability, providing clarity and reducing cognitive load.
Customize them providing a proper size and variant to the component and remember that the colour
will be inherited from parent element.

## Size
You can set your Icon with a _size_ of large, medium or small.

### Size: Large
<component with-label="Large" />
```
icon: Html msg
icon =
  IconSet.User
    |> Icon.create
    |> Icon.withSize Size.large
    |> Icon.render
```

### Size: Medium
<component with-label="Medium" />
```
IconSet.User
    |> Icon.create
    |> Icon.withSize Size.medium
    |> Icon.render
```

### Size: Small
<component with-label="Small" />
```
IconSet.User
    |> Icon.create
    |> Icon.withSize Size.small
    |> Icon.render
```

## Style
You can set your Icon with a _style_ default or boxed.
A boxed icon can have neutral, brand, success, alert or error colors.

### Style: Default
<component with-label="Default Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.default
    |> Icon.render
```

### Style: Boxed Neutral
<component with-label="Boxed Neutral Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.neutral
    |> Icon.render
```

### Style: Boxed Brand
<component with-label="Boxed Brand Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.brand
    |> Icon.render
```

### Style: Boxed Success
<component with-label="Boxed Success Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.success
    |> Icon.render
```

### Style: Boxed Alert
<component with-label="Boxed Alert Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.alert
    |> Icon.render
```

### Style: Boxed Error
<component with-label="Boxed Error Style" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.error
    |> Icon.render
```

## Theme
You can set your Boxed Icon with a default _theme_ or alternative. Alt theme is mandatory in case of a dark background.

### Theme: Default
<component with-label="Default Theme" />
```
IconSet.User
    |> Icon.create
    |> Icon.withTheme Theme.default
    |> Icon.render
```

### Theme: Alternative

Note that you can only enable the Alternative theme on a Boxed icon.

<component with-label="Alternative Theme" with-background="#21283B" />
```
IconSet.User
    |> Icon.create
    |> Icon.withStyle Icon.default
    |> Icon.withTheme Theme.alternative
    |> Icon.render
```

## Accessibility
Non-decorative icons need to be read by screen reader, so if the icon to convey a message please remember to add
the prop "description" to component with a meaningful label for users relying on screen readers.

Moreover, please pay attention to icon colour as it should meet at least WCAG AA color contrast.

<component with-label="Accessible Description" />
```
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
    , ( "Boxed Neutral Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.neutral
            |> Icon.render
      )
    , ( "Boxed Brand Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.brand
            |> Icon.render
      )
    , ( "Boxed Success Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.success
            |> Icon.render
      )
    , ( "Boxed Alert Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.alert
            |> Icon.render
      )
    , ( "Boxed Error Style"
      , IconSet.User
            |> Icon.create
            |> Icon.withStyle Icon.error
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
