module Stories.Chapters.Toggle exposing (Model, docs, init)

import Components.Toggle as Toggle
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Toggle"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """

Toggle allow users to choose between two mutually exclusive options, and they should provide immediate results.
<component with-label="Default" />
```
type Msg =
    OnToggle Bool

toggle : Bool -> Html Msg
toggle initialState =
    Toggle.config OnToggle
        |> Toggle.render initialState
```
## With Text
<component with-label="WithText" />
```
toggle : Bool -> Html Msg
toggle initialState =
    Toggle.config OnToggle
        |> Toggle.withText "Label"
        |> Toggle.render initialState
```
## With AriaLabel
<component with-label="WithAriaLabel" />
```
toggle : Bool -> Html Msg
toggle initialState =
    Toggle.config OnToggle
        |> Toggle.withAriaLabel "Label"
        |> Toggle.render initialState
```
## With Disabled
<component with-label="WithDisabled" />
```
toggle : Bool -> Html Msg
toggle initialState =
    Toggle.config OnToggle
        |> Toggle.withDisabled True
        |> Toggle.render initialState
```

## With Id
<component with-label="WithId" />
```
toggle : Bool -> Html Msg
toggle initialState =
    Toggle.config OnToggle
        |> Toggle.withId "toggle-id"
        |> Toggle.render initialState
```
"""


type alias SharedState x =
    { x | toggle : Model }


type alias Model =
    { base : Bool
    , disabled : Bool
    , label : Bool
    , ariaLabel : Bool
    , id : Bool
    }


init : Model
init =
    { base = True
    , disabled = False
    , label = False
    , ariaLabel = False
    , id = False
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Default"
      , statefulComponent identity .base setBase
      )
    , ( "WithDisabled"
      , statefulComponent (Toggle.withDisabled True) .disabled setDisabled
      )
    , ( "WithText"
      , statefulComponent (Toggle.withText "Label") .label setLabel
      )
    , ( "WithAriaLabel"
      , statefulComponent (Toggle.withAriaLabel "Label") .ariaLabel setAriaLabel
      )
    , ( "WithId"
      , statefulComponent (Toggle.withId "toggle-id") .id setId
      )
    ]


statefulComponent :
    (Toggle.Config (ElmBook.Msg (SharedState x)) -> Toggle.Config (ElmBook.Msg (SharedState x)))
    -> (Model -> Bool)
    -> (Bool -> Model -> Model)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent configModifier modelPicker updater sharedState =
    Toggle.config (ElmBook.Actions.updateStateWith (updater >> mapModel))
        |> configModifier
        |> Toggle.render (sharedState.toggle |> modelPicker)


mapModel : (Model -> Model) -> SharedState x -> SharedState x
mapModel updateModel sharedState =
    { sharedState | toggle = updateModel sharedState.toggle }


setBase : Bool -> Model -> Model
setBase value model =
    { model | base = value }


setDisabled : Bool -> Model -> Model
setDisabled value model =
    { model | disabled = value }


setLabel : Bool -> Model -> Model
setLabel value model =
    { model | label = value }


setId : Bool -> Model -> Model
setId value model =
    { model | id = value }


setAriaLabel : Bool -> Model -> Model
setAriaLabel value model =
    { model | ariaLabel = value }
