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

A button with a variant _Primary_.
<component with-label="Primary" />

A button with a variant _Secondary_.
<component with-label="Secondary" />

A button with a variant _Tertiary_.
<component with-label="Tertiary" />

A button with a variant _Brand_.
<component with-label="Brand" />

A button with a variant _Ghost_.
<component with-label="Ghost" />

## Size
You can set your Button with a _size_ of huge, large, medium, small.

A button with size _Huge_.
<component with-label="Huge" />

A button with size _Large_.
<component with-label="Large" />

A button with size _Medium_.
<component with-label="Medium" />

A button with size _Small_.
<component with-label="Small" />

## Icon
You can add an _icon_ to a Button. Icons can placed before or after the button _text_.
Or maybe you can choose to have only an Icon as the content of your button.

A button with a _Leading Icon_.
<component with-label="Leading Icon" />

A button with a _Trailing Icon_.
<component with-label="Trailing Icon" />

A button with an _Icon Only_.
<component with-label="Icon Only" />
"""


defaultButton =
    Button.create
        |> Button.withButtonType (ElmBook.Actions.logAction "Button clicked")
        |> Button.withText "Click me!"


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Primary"
      , defaultButton
            |> Button.withPrimaryVariant
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Secondary"
      , defaultButton
            |> Button.withSecondaryVariant
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Tertiary"
      , defaultButton
            |> Button.withTertiaryVariant
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Brand"
      , defaultButton
            |> Button.withBrandVariant
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Ghost"
      , defaultButton
            |> Button.withGhostVariant
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Huge"
      , defaultButton
            |> Button.withPrimaryVariant
            |> Button.withHugeSize
            |> Button.render
      )
    , ( "Large"
      , defaultButton
            |> Button.withLargeSize
            |> Button.render
      )
    , ( "Medium"
      , defaultButton
            |> Button.withMediumSize
            |> Button.render
      )
    , ( "Small"
      , defaultButton
            |> Button.withPrimaryVariant
            |> Button.withSmallSize
            |> Button.render
      )
    , ( "Leading Icon"
      , defaultButton
            |> Button.withLeadingIcon IconSet.Car
            |> Button.render
      )
    , ( "Trailing Icon"
      , defaultButton
            |> Button.withTrailingIcon IconSet.Van
            |> Button.render
      )
    , ( "Icon Only"
      , defaultButton
            |> Button.withPrimaryVariant
            |> Button.withIconOnly IconSet.Car
            |> Button.render
      )
    ]
