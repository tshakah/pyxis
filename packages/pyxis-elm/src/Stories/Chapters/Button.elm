module Stories.Chapters.Button exposing (docs)

import Components.Button as Button
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter ()
docs =
    "Buttons"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

## Variant
You can set your Button with a _variant_ of primary, secondary, tertiary, brand.

### Variant: Primary
<component with-label="Primary" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withButtonType OnClick
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
        |> Button.withButtonType OnClick
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
        |> Button.withButtonType OnClick
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
        |> Button.withButtonType OnClick
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
        |> Button.withButtonType OnClick
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
        |> Button.withSubmitType
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
        |> Button.withButtonType OnClick
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
        |> Button.withResetType
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
        |> Button.withLinkType "https://www.prima.it"
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Size
You can set your Button with a _size_ of huge, large, medium, small.

### Size: Huge.
<component with-label="Huge" />
```
import Components.Button as Button

type Msg =
    OnClick

{-| Note that Huge size is only allowed on a Primary variant.
Check the documentation in order to be aware of what you can do and what's forbidden on your component.
-}
btn: Html Msg
btn =
    Button.primary
        |> Button.withHugeSize
        |> Button.withButtonType OnClick
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Large.
<component with-label="Large" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withLargeSize
        |> Button.withButtonType OnClick
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Medium.
<component with-label="Medium" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withMediumSize
        |> Button.withButtonType OnClick
        |> Button.withText "Click me!"
        |> Button.render
```

### Size: Small.
<component with-label="Small" />
```
import Components.Button as Button

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withSmallSize
        |> Button.withButtonType OnClick
        |> Button.withText "Click me!"
        |> Button.render
```
---
## Icon
You can add an _icon_ to a Button. Icons can placed before or after the button _text_.
Or maybe you can choose to have only an Icon as the content of your button.

### Icon: Leading
<component with-label="Leading Icon" />
```
import Components.Button as Button
import Components.IconSet as IconSet

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withLeadingIcon IconSet.Car
        |> Button.withButtonType OnClick
        |> Button.withText "Click me!"
        |> Button.render
```

### Icon: Trailing
<component with-label="Trailing Icon" />
```
import Components.Button as Button
import Components.IconSet as IconSet

type Msg =
    OnClick

btn: Html Msg
btn =
    Button.primary
        |> Button.withTrailingIcon IconSet.Van
        |> Button.withButtonType OnClick
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
        |> Button.withButtonType OnClick
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


withCommonOptions : Button.Model a (ElmBook.Msg state) -> Button.Model a (ElmBook.Msg state)
withCommonOptions =
    Button.withText "Click me!"
        >> Button.withButtonType (ElmBook.Actions.logAction "Button clicked")


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Primary"
      , Button.primary
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Secondary"
      , Button.secondary
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Tertiary"
      , Button.tertiary
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Brand"
      , Button.brand
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Ghost"
      , Button.ghost
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Type Button"
      , Button.primary
            |> withCommonOptions
            |> Button.withButtonType (ElmBook.Actions.logAction "Clicked")
            |> Button.render
      )
    , ( "Type Submit"
      , Button.primary
            |> withCommonOptions
            |> Button.withSubmitType
            |> Button.render
      )
    , ( "Type Reset"
      , Button.primary
            |> withCommonOptions
            |> Button.withResetType
            |> Button.render
      )
    , ( "Type Link"
      , Button.primary
            |> withCommonOptions
            |> Button.withLinkType "https://www.prima.it"
            |> Button.render
      )
    , ( "Huge"
      , Button.primary
            |> withCommonOptions
            |> Button.withHugeSize
            |> Button.render
      )
    , ( "Large"
      , Button.primary
            |> withCommonOptions
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Medium"
      , Button.primary
            |> withCommonOptions
            |> Button.withMediumSize
            |> Button.render
      )
    , ( "Small"
      , Button.primary
            |> withCommonOptions
            |> Button.withSmallSize
            |> Button.render
      )
    , ( "Leading Icon"
      , Button.primary
            |> withCommonOptions
            |> Button.withLeadingIcon IconSet.Car
            |> Button.render
      )
    , ( "Trailing Icon"
      , Button.primary
            |> withCommonOptions
            |> Button.withTrailingIcon IconSet.Van
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
