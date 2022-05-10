module Stories.Chapters.Message exposing (docs)

import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes
import Pyxis.Components.IconSet as IconSet
import Pyxis.Components.Message as Message


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Message"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

Message highlights feedback or information to the user about the process that he's following or the content that he's consuming.
<component with-label="Default" />

## Variants
Messages can have one of the following variants: neutral, brand, success, alert, error or ghost. Some of them
are available only with a default background, others can be both with a neutral background and a colored one.

### Neutral Message
Neutral messages are available only with the default neutral background.
<component with-label="Neutral" />
```
message: Html msg
message =
    Message.neutral
        |> Message.withContent [ Html.text "Message Text" ]
        |> Message.withTitle "Message Title"
        |> Message.render
```
### Brand Message
Brand messages could have both a neutral background and a colored one.
<component with-label="Brand DefaultBackground" />
```
Message.brand Message.defaultBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
<component with-label="Brand ColoredBackground" />
```
Message.brand Message.coloredBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
### Success Message
Success messages could have both a neutral background and a colored one.
<component with-label="Success DefaultBackground" />
```
Message.success Message.defaultBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
<component with-label="Success ColoredBackground" />
```
Message.success Message.coloredBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
### Alert Message
Alert message is available only with the colored background, set by default.
<component with-label="Alert" />
```
Message.alert
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
### Error Message
Error messages could have both a neutral background and a colored one.
<component with-label="Error DefaultBackground" />
```
Message.error Message.defaultBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
<component with-label="Error ColoredBackground" />
```
Message.error Message.coloredBackground
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withTitle "Message Title"
    |> Message.render
```
### Ghost
Ghost message is not available with colored background.

__Please note:__ a message with this variant shouldn't have a title.
<component with-label="Ghost" />
```
Message.ghost
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.render
```
---
## Dismissible
Message can have a closing icon and be dismissible.

__Please note:__ `withOnDismiss` function requires a String that is the `aria-label` attribute passed to
button with closing icon.
<component with-label="Dismissible" />
```
type Msg
    = OnClick


message : Html Msg
message =
    Message.neutral
        |> Message.withContent [ Html.text "Message Text" ]
        |> Message.withOnDismiss OnClick "Close message"
        |> Message.render
```
---
## Custom Icon
Message Icon by default is based on the style of the Message itself but you can customize it
following the example below.
<component with-label="With Icon" />
```
Message.neutral
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withIcon IconSet.PrimaLogo
    |> Message.render
```
---
## With id
Setting an id to Message also implies setting a `data-test-id`
attribute with the same value of the id received.

<component with-label="With Id" />
```
Message.neutral
    |> Message.withContent [ Html.text "Message Text" ]
    |> Message.withId "message-id"
    |> Message.render
```
---
## Accessibility
Messages have a role attribute set to `alert` when variant is "error", and set to `status`
in all other cases. Also, a proper description to for closing button is required if the message is dismissible.
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Default"
      , Message.neutral
            |> Message.withContent
                [ Html.text "Se il veicolo non è assicurato con Prima, invia una mail a "
                , Html.a
                    [ Html.Attributes.href "#"
                    , Html.Attributes.class "c-action-base text-s-bold"
                    ]
                    [ Html.text "prima@prima.it" ]
                ]
            |> Message.render
      )
    , ( "Neutral"
      , Message.neutral
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Brand DefaultBackground"
      , Message.brand Message.defaultBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Success DefaultBackground"
      , Message.success Message.defaultBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Error DefaultBackground"
      , Message.error Message.defaultBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Brand ColoredBackground"
      , Message.brand Message.coloredBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Success ColoredBackground"
      , Message.success Message.coloredBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Alert"
      , Message.alert
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Error ColoredBackground"
      , Message.error Message.coloredBackground
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withTitle "Message Title"
            |> Message.render
      )
    , ( "Ghost"
      , Message.ghost
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.render
      )
    , ( "Dismissible"
      , Message.neutral
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withOnDismiss (ElmBook.Actions.logAction "Close clicked") "Close message"
            |> Message.render
      )
    , ( "With Icon"
      , Message.neutral
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withIcon IconSet.PrimaLogo
            |> Message.render
      )
    , ( "With Id"
      , Message.neutral
            |> Message.withContent
                [ Html.text "Message Text" ]
            |> Message.withId "message-id"
            |> Message.render
      )
    ]
