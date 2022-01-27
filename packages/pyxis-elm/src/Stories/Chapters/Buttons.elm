module Stories.Chapters.Buttons exposing (docs)

import Commons.Properties.Size as Size
import Components.Button as Button
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


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
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Variant: Secondary
<component with-label="Secondary" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.secondary
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Variant: Tertiary
<component with-label="Tertiary" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.tertiary
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Variant: Brand
<component with-label="Brand" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.brand
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Variant: Ghost
<component with-label="Ghost" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.ghost
        |> Button.withType (Button.button OnClick)
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
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withType Button.submit
        |> Button.withText "Click me!"
        |> Button.render
```

### Type: Button.
<component with-label="Type Button" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Type: Reset.
<component with-label="Type Reset" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withType Button.reset
        |> Button.withText "Click me!"
        |> Button.render
```

### Type: Link.
<component with-label="Type Link" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withType (Button.link "https://www.prima.it")
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Size
Sizes set the occupied space of the button.

They can be useful when the actions need to be more prominent or when the space for the actions is little.

You can set your Button with a _size_ of huge, large, medium, small.

### Size: Huge.
<component with-label="Huge" />
```
import Components.Button as Button
import Commons.Properties.Size as Size

type Msg =
    OnClick

{-| Note that Huge size is only allowed on a Primary variant.
Check the documentation in order to be aware of what you can do and what's forbidden on your component.
-}
btn: Html Msg
btn =
    Button.primary
        |> Button.withSize Size.huge
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Large.
<component with-label="Large" />
```
import Components.Button as Button
import Commons.Properties.Size as Size

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withSize Size.large
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Medium.
<component with-label="Medium" />
```
import Components.Button as Button
import Commons.Properties.Size as Size

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withSize Size.medium
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Small.
<component with-label="Small" />
```
import Components.Button as Button
import Commons.Properties.Size as Size

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withSize Size.small
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Icon
Buttons can also accommodate an icon. The icon can be inserted in the append or prepend of the label.
The button can also contain only the icon, in this case it is advisable to add an _aria-label_ to the button to improve accessibility.

### Icon: Prepend
<component with-label="Prepend Icon" />
```
import Components.Button as Button
import Components.IconSet as IconSet

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withPrependIcon IconSet.Car
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Icon: Append
<component with-label="Append Icon" />
```
import Components.Button as Button
import Components.IconSet as IconSet

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withAppendIcon IconSet.Van
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```

### Icon: Only
<component with-label="Icon Only" />
```
import Components.Button as Button
import Components.IconSet as IconSet

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withIconOnly IconSet.Motorcycle
        |> Button.withType (Button.button OnClick)
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Loading
<component with-label="Loading" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withLoading True
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Id
<component with-label="Id" />
```
import Components.Button as Button

{-| Note that setting an id to the Button also implies setting a data-test-id
attribute with the same value of the id received.
-}
btn: Html Msg
btn =
    Button.primary
        |> Button.withId "jsButton"
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Disabled
<component with-label="Disabled" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withDisabled True
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Content Width
<component with-label="Content Width" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withContentWidth
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Shadow
<component with-label="Shadow" />
```
import Components.Button as Button

{-| Note that you can use a shadow only on a Primary/Brand variant.
-}
btn: Html Msg
btn =
    Button.primary
        |> Button.withShadow
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Accessibility
<component with-label="Accessible" />
```
import Components.Button as Button

btn: Html Msg
btn =
    Button.primary
        |> Button.withAriaLabel "Login"
        |> Button.withText "Login"
        |> Button.render
```
"""


withCommonOptions : Button.Model (ElmBook.Msg state) -> Button.Model (ElmBook.Msg state)
withCommonOptions =
    Button.withText "Click me!"
        >> Button.withType (Button.button (ElmBook.Actions.logAction "Button clicked"))


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Primary"
      , Button.primary
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Secondary"
      , Button.secondary
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Tertiary"
      , Button.tertiary
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Brand"
      , Button.brand
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Ghost"
      , Button.ghost
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Type Button"
      , Button.primary
            |> withCommonOptions
            |> Button.render
      )
    , ( "Type Submit"
      , Button.primary
            |> withCommonOptions
            |> Button.withType Button.submit
            |> Button.render
      )
    , ( "Type Reset"
      , Button.primary
            |> withCommonOptions
            |> Button.withType Button.reset
            |> Button.render
      )
    , ( "Type Link"
      , Button.primary
            |> withCommonOptions
            |> Button.withType (Button.link "https://www.prima.it")
            |> Button.render
      )
    , ( "Huge"
      , Button.primary
            |> withCommonOptions
            |> Button.withSize Size.huge
            |> Button.render
      )
    , ( "Large"
      , Button.primary
            |> withCommonOptions
            |> Button.withSize Size.large
            |> Button.render
      )
    , ( "Medium"
      , Button.primary
            |> withCommonOptions
            |> Button.withSize Size.medium
            |> Button.render
      )
    , ( "Small"
      , Button.primary
            |> withCommonOptions
            |> Button.withSize Size.small
            |> Button.render
      )
    , ( "Prepend Icon"
      , Button.primary
            |> withCommonOptions
            |> Button.withIconPrepend IconSet.Car
            |> Button.render
      )
    , ( "Append Icon"
      , Button.primary
            |> withCommonOptions
            |> Button.withIconAppend IconSet.Van
            |> Button.render
      )
    , ( "Icon Only"
      , Button.primary
            |> withCommonOptions
            |> Button.withIconOnly IconSet.Car
            |> Button.render
      )
    , ( "Loading"
      , Button.primary
            |> withCommonOptions
            |> Button.withLoading True
            |> Button.render
      )
    , ( "Id"
      , Button.primary
            |> withCommonOptions
            |> Button.withId "jsButton"
            |> Button.render
      )
    , ( "Disabled"
      , Button.primary
            |> withCommonOptions
            |> Button.withDisabled True
            |> Button.render
      )
    , ( "Content Width"
      , Button.primary
            |> withCommonOptions
            |> Button.withContentWidth
            |> Button.render
      )
    , ( "Shadow"
      , Button.primary
            |> withCommonOptions
            |> Button.withShadow
            |> Button.render
      )
    , ( "Accessible"
      , Button.primary
            |> withCommonOptions
            |> Button.withAriaLabel "Login"
            |> Button.render
      )
    ]
