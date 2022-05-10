module Stories.Chapters.TextSwitch exposing (Model, docs, init)

import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Pyxis.Commons.Properties.Theme as Theme
import Pyxis.Components.TextSwitch as TextSwitch


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "TextSwitch"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
A text switch allows users to select only one option between a set of options,
exactly how a radio button does but has a different visual design.
<component with-label="TextSwitch" />
```
type Option
    = Home
    | Motor


 type Msg =
     OnChange Option


options : List (TextSwitch.Option Option)
options =
    [ TextSwitch.option { value = Home, label = "Casa e famiglia" }
    , TextSwitch.option { value = Motor, label = "Moto" }
    ]


textSwitchView : String -> Html Msg
textSwitchView name =
    TextSwitch.config name OnChange
        |> TextSwitch.withOptions options
        |> TextSwitch.render Home

```

## Option Width
By default the width of the options is based on their content (`contentWidth`) but it could also
be set to be equal for all the options (`equalWidth`).
<component with-label="EqualWidth" />
```
TextSwitch.config name OnChange
    |> TextSwitch.withOptionWidth TextSwitch.equalWidth
    |> TextSwitch.withOptions options
    |> TextSwitch.render Home
```

## With Label
<component with-label="WithLabel" />
```
TextSwitch.config name OnChange
    |> TextSwitch.withLabel "Label"
    |> TextSwitch.withOptions options
    |> TextSwitch.render Home
```

## With Aria-label
Please provide an aria-label to the component if a label is not available.
<component with-label="WithAriaLabel" />
```
TextSwitch.config name OnChange
    |> TextSwitch.withAriaLabel "Label"
    |> TextSwitch.withOptions options
    |> TextSwitch.render Home
```

## With Label Position
By default the position of the label is `topCenter` but it could be also `topLeft` or `left`.
<component with-label="WithLabelPosition" />
```
TextSwitch.config name OnChange
    |> TextSwitch.withLabel "Label"
    |> TextSwitch.withLabelPosition TextSwitch.left
    |> TextSwitch.withOptions options
    |> TextSwitch.render Home
```

## With Theme
<component with-label="WithTheme" with-background="#21283B" />
```
TextSwitch.config name OnChange
    |> TextSwitch.withTheme Theme.alternative
    |> TextSwitch.withOptions options
    |> TextSwitch.render Home
```
"""


type alias SharedState x =
    { x
        | textSwitch : TextSwitchModels
    }


type Option
    = Home
    | Motor


type alias TextSwitchModels =
    { default : Option
    , equalWidth : Option
    , arialabel : Option
    , label : Option
    , labelPosition : Option
    , theme : Option
    }


type alias Model =
    TextSwitchModels


init : Model
init =
    { default = Home
    , equalWidth = Home
    , arialabel = Home
    , label = Home
    , labelPosition = Home
    , theme = Home
    }


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "TextSwitch"
      , statefulComponent
            { name = "default"
            , configModifier = identity
            , modelPicker = .default
            , update = \value model -> { model | default = value }
            }
      )
    , ( "EqualWidth"
      , statefulComponent
            { name = "equal-width"
            , configModifier = TextSwitch.withOptionsWidth TextSwitch.equalWidth
            , modelPicker = .equalWidth
            , update = \value model -> { model | equalWidth = value }
            }
      )
    , ( "WithLabel"
      , statefulComponent
            { name = "label"
            , configModifier = TextSwitch.withLabel "Label"
            , modelPicker = .label
            , update = \value model -> { model | label = value }
            }
      )
    , ( "WithAriaLabel"
      , statefulComponent
            { name = "arialabel"
            , configModifier = TextSwitch.withAriaLabel "Label"
            , modelPicker = .arialabel
            , update = \value model -> { model | arialabel = value }
            }
      )
    , ( "WithLabelPosition"
      , statefulComponent
            { name = "label-position"
            , configModifier = TextSwitch.withLabel "Label" >> TextSwitch.withLabelPosition TextSwitch.left
            , modelPicker = .labelPosition
            , update = \value model -> { model | labelPosition = value }
            }
      )
    , ( "WithTheme"
      , statefulComponent
            { name = "alt-theme"
            , configModifier = TextSwitch.withTheme Theme.alternative
            , modelPicker = .theme
            , update = \value model -> { model | theme = value }
            }
      )
    ]


options : List (TextSwitch.Option Option)
options =
    [ TextSwitch.option { value = Home, label = "Casa e famiglia" }
    , TextSwitch.option { value = Motor, label = "Moto" }
    ]


type alias StatefulConfig sharedState =
    { name : String
    , configModifier : TextSwitch.Config Option (ElmBook.Msg sharedState) -> TextSwitch.Config Option (ElmBook.Msg sharedState)
    , modelPicker : Model -> Option
    , update : Option -> Model -> Model
    }


statefulComponent : StatefulConfig (SharedState x) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statefulComponent { name, configModifier, modelPicker, update } sharedState =
    TextSwitch.config name (ElmBook.Actions.updateStateWith (update >> mapModel))
        |> TextSwitch.withOptions options
        |> configModifier
        |> TextSwitch.render (sharedState.textSwitch |> modelPicker)


mapModel : (Model -> Model) -> SharedState x -> SharedState x
mapModel updateModel sharedState =
    { sharedState | textSwitch = updateModel sharedState.textSwitch }
