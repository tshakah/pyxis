module Stories.Chapters.Buttons exposing (docs)

import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes
import Pyxis.Commons.Attributes.LinkTarget as CommonsAttributesLinkTarget
import Pyxis.Commons.Properties.Theme as Theme
import Pyxis.Components.Button as Button
import Pyxis.Components.IconSet as IconSet


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Buttons"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

## Variant
Variants set the visual style of the button, each button should have a visual hierarchy in the page.

Variants help the user to understand this hierarchy.

You can set your Button with a _variant_ of primary, secondary, tertiary, brand, ghost.

### Variant: Primary
<component with-label="Primary" />
```
type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withText "Click me!"
        |> Button.withType Button.button
        |> Button.withOnClick OnClick
        |> Button.render
```

### Variant: Secondary
<component with-label="Secondary" />
```
Button.secondary
    |> Button.withText "Click me!"
    |> Button.render
```

### Variant: Tertiary
<component with-label="Tertiary" />
```
Button.tertiary
    |> Button.withText "Click me!"
    |> Button.render
```

### Variant: Brand
<component with-label="Brand" />
```
Button.brand
    |> Button.withText "Click me!"
    |> Button.render
```

### Variant: Ghost
<component with-label="Ghost" />
```
Button.ghost
    |> Button.withText "Click me!"
    |> Button.render
```
---
## Type
By default each button has a type="submit" attribute. You can also choose between _button_ and _reset_.
Otherwise you can always create an _anchor_ with the appearance of a _button_ in case you need to link an url to your button.

### Type: Submit.
<component with-label="Type Submit" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType Button.submit
    |> Button.render
```

### Type: Button.
<component with-label="Type Button" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType Button.button
    |> Button.withOnClick OnClick
    |> Button.render
```

### Type: Reset.
<component with-label="Type Reset" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType Button.reset
    |> Button.render
```

### Type: Link.
<component with-label="Type Link" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType (Button.link "https://www.prima.it")
    |> Button.render
```

<component with-label="Type Link with target" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType (Button.linkWithTarget "https://www.prima.it" LinkTarget.blank)
    |> Button.render
```

---
## Size
Sizes set the occupied space of the button.

They can be useful when the actions need to be more prominent or when the space for the actions is little.

You can set your Button with a _size_ of huge, large, medium, small.

### Size: Huge.

Note that Huge size is only allowed on a Primary variant.
Check the documentation in order to be aware of what you can do and what's forbidden on your component.

<component with-label="Huge" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withSize Button.huge
    |> Button.render
```

### Size: Large.
<component with-label="Large" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withSize Button.large
    |> Button.render
```

### Size: Medium.
<component with-label="Medium" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withSize Button.medium
    |> Button.render
```

### Size: Small.
<component with-label="Small" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withSize Button.small
    |> Button.render
```
---
## Icon
Buttons can also accommodate an icon. The icon can be inserted in the append or prepend of the label.
The button can also contain only the icon, in this case it is advisable to add an _aria-label_ to the button to improve accessibility.

### Icon: Prepend
<component with-label="Prepend Icon" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withPrependIcon IconSet.Car
    |> Button.render
```

### Icon: Append
<component with-label="Append Icon" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withAppendIcon IconSet.Van
    |> Button.render
```

### Icon: Only
<component with-label="Icon Only" />
```
Button.primary
    |> Button.withAriaLabel "Login"
    |> Button.withIconOnly IconSet.Motorcycle
    |> Button.render
```
---
## Loading
<component with-label="Loading" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withLoading True
    |> Button.render
```
---
## Id

Note that setting an id to the Button also implies setting a data-test-id
attribute with the same value of the id received.

<component with-label="Id" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withId "jsButton"
    |> Button.render
```
---
## Disabled
<component with-label="Disabled" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withDisabled True
    |> Button.render
```
---
## Content Width
<component with-label="Content Width" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withContentWidth
    |> Button.render
```
---
## Shadow

Note that you can use a shadow only on a Primary/Brand variant.

<component with-label="Shadow" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withShadow
    |> Button.render
```
---
## Alternative

Use on dark background.

<component with-label="Alternative" />
```
Button.primary
    |> Button.withText "Click me!"
    |> Button.withTheme Theme.alternative
    |> Button.render
```
---
## Accessibility

When you use the iconPlacement `only` options remember to add the prop aria-label to component with a meaningful label for users relying on screen readers.

<component with-label="Accessible" />
```
Button.primary
    |> Button.withAriaLabel "Login"
    |> Button.withIconOnly IconSet.User
    |> Button.render
```
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Primary"
      , Button.primary
            |> Button.withType Button.button
            |> Button.withOnClick (ElmBook.Actions.logAction "Button clicked")
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Secondary"
      , Button.secondary
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Tertiary"
      , Button.tertiary
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Brand"
      , Button.brand
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Ghost"
      , Button.ghost
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Type Button"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Type Submit"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withType Button.submit
            |> Button.render
      )
    , ( "Type Reset"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withType Button.reset
            |> Button.render
      )
    , ( "Type Link"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withType (Button.link "https://www.prima.it")
            |> Button.render
      )
    , ( "Type Link with target"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withType (Button.linkWithTarget "https://www.prima.it" CommonsAttributesLinkTarget.blank)
            |> Button.render
      )
    , ( "Huge"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withSize Button.huge
            |> Button.render
      )
    , ( "Large"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.render
      )
    , ( "Medium"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withSize Button.medium
            |> Button.render
      )
    , ( "Small"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withSize Button.small
            |> Button.render
      )
    , ( "Prepend Icon"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withIconPrepend IconSet.Car
            |> Button.render
      )
    , ( "Append Icon"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withIconAppend IconSet.Van
            |> Button.render
      )
    , ( "Icon Only"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withIconOnly IconSet.Car
            |> Button.render
      )
    , ( "Loading"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withLoading True
            |> Button.render
      )
    , ( "Id"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withId "jsButton"
            |> Button.render
      )
    , ( "Disabled"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withDisabled True
            |> Button.render
      )
    , ( "Content Width"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withContentWidth
            |> Button.render
      )
    , ( "Shadow"
      , Button.primary
            |> Button.withText "Click me!"
            |> Button.withShadow
            |> Button.render
      )
    , ( "Alternative"
      , Html.div [ Html.Attributes.class "bg-neutral-base padding-s" ]
            [ Button.primary
                |> Button.withText "Click me!"
                |> Button.withTheme Theme.alternative
                |> Button.render
            ]
      )
    , ( "Accessible"
      , Button.primary
            |> Button.withIconOnly IconSet.User
            |> Button.withAriaLabel "Login"
            |> Button.render
      )
    ]
