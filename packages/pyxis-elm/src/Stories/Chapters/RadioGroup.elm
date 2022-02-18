module Stories.Chapters.RadioGroup exposing (Model, docs, init)

import Components.Field.RadioGroup as RadioGroup
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Stories.Helpers as SH


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "RadioGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
A radio group is used to combine and provide structure to group of radio buttons, placing element such as label and error message in a pleasant and clear way.
Radio group have a horizontal layout as default, but with more then two items a vertical layout is recommended.

<component with-label="RadioGroup" />
```
type Option
    = M
    | F
    | Default


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger Default
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == Default then
        Err "Invalid selection"

    else
        Ok value


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = M, label = "Male" }
    , RadioGroup.option { value = F, label = "Female" }
    ]
```

### Implementation with only valid options

```
type Option
    = M
    | F


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger M


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = M, label = "Male" }
    , RadioGroup.option { value = F, label = "Female" }
    ]
```

### Implementation with Maybe String (Error prone)

```
type alias Option =
    Maybe String


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger Nothing
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    case value of
        Just "" ->
            Err "Required"

        Nothing ->
            Err "Required"

        _ ->
            Ok value


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = Just "male", label = "Male" }
    , RadioGroup.option { value = Just "female", label = "Female" }
    ]
```

### Implementation with String (Error prone)

```
type alias Option =
    String


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : (RadioGroup.Msg Option -> msg) -> RadioGroup.Model Option ctx msg
radioGroupModel tagger =
    RadioGroup.create "radio-gender-id" tagger ""
        |> RadioGroup.withValidation validation


radioGroupView : Html Msg
radioGroupView =
    radioGroupModel OnRadioFieldMsg
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == "female" || value == "male" then
        Ok value

    else
        Err "Required"


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = "male", label = "Male" }
    , RadioGroup.option { value = "female", label = "Female" }
    ]
````

# Vertical Layout
<component with-label="RadioGroup vertical" />

```
radioGroupVerticalLayout : String -> (RadioGroup.Msg value -> msg) -> value -> Html msg
radioGroupVerticalLayout id tagger defaultValue =
    RadioGroup.create id tagger defaultValue
        |> RadioGroup.withVerticalLayout True
        |> RadioGroup.render
```


# Disabled
<component with-label="RadioGroup disabled" />
```
radioGroupDisabled : String -> (RadioGroup.Msg value -> msg) -> value -> Html msg
radioGroupDisabled id tagger defaultValue =
    RadioGroup.create id tagger defaultValue
        |> RadioGroup.withDisabled True
        |> RadioGroup.render
```
"""


type alias SharedState x =
    { x
        | radioFieldModels : RadioFieldModels
    }


type Option
    = M
    | F
    | Default


type alias RadioFieldModels =
    { base : RadioGroup.Model Option {}
    , vertical : RadioGroup.Model Option {}
    , disabled : RadioGroup.Model Option {}
    }


type alias Model =
    RadioFieldModels


type Msg
    = OnBaseRadioFieldMsg (RadioGroup.Msg Option)
    | OnVerticalRadioFieldMsg (RadioGroup.Msg Option)
    | OnDisabledRadioFieldMsg (RadioGroup.Msg Option)


update : Msg -> RadioGroup.Model Option ctx -> RadioGroup.Model Option ctx
update msg =
    case msg |> Debug.log "msg" of
        OnVerticalRadioFieldMsg subMsg ->
            RadioGroup.update subMsg

        OnBaseRadioFieldMsg subMsg ->
            RadioGroup.update subMsg

        OnDisabledRadioFieldMsg subMsg ->
            RadioGroup.update subMsg


init : Model
init =
    { base =
        RadioGroup.init Default
            |> RadioGroup.setValidation validation
    , vertical =
        RadioGroup.init Default
            |> RadioGroup.setValidation validation
    , disabled =
        RadioGroup.init M
            |> RadioGroup.setValidation validation
    }


config : String -> String -> RadioGroup.Config Option
config id name =
    RadioGroup.config id
        |> RadioGroup.withOptions
            [ RadioGroup.option { value = M, label = "Male" }
            , RadioGroup.option { value = F, label = "Female" }
            ]
        |> RadioGroup.withName name


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == Default then
        Err "Invalid selection"

    else
        Ok value


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "RadioGroup"
      , radioGroupComponent "base" "gender1" OnBaseRadioFieldMsg .base identity setBase
      )
    , ( "RadioGroup vertical"
      , radioGroupComponent "vertical" "gender2" OnVerticalRadioFieldMsg .vertical (RadioGroup.withLayout RadioGroup.vertical) setVertical
      )
    , ( "RadioGroup disabled"
      , radioGroupComponent "disabled" "gender3" OnDisabledRadioFieldMsg .disabled (RadioGroup.withDisabled True) (always identity)
      )
    ]


radioGroupComponent :
    String
    -> String
    -> (RadioGroup.Msg Option -> Msg)
    -> (RadioFieldModels -> RadioGroup.Model Option {})
    -> (RadioGroup.Config Option -> RadioGroup.Config Option)
    -> (RadioGroup.Model Option {} -> RadioFieldModels -> RadioFieldModels)
    -> { a | radioFieldModels : RadioFieldModels }
    -> Html (ElmBook.Msg { b | radioFieldModels : RadioFieldModels })
radioGroupComponent id name tagger modelMapper configModifier modelUpdater sharedState =
    SH.statefulComponent
        (.radioFieldModels >> modelMapper)
        (config id name |> configModifier)
        (RadioGroup.render tagger {})
        (\state model -> mapRadioFieldModels (modelUpdater model) state)
        update
        (modelMapper sharedState.radioFieldModels)


mapRadioFieldModels : (RadioFieldModels -> RadioFieldModels) -> SharedState x -> SharedState x
mapRadioFieldModels updater state =
    { state | radioFieldModels = updater state.radioFieldModels }


setBase : RadioGroup.Model Option {} -> RadioFieldModels -> RadioFieldModels
setBase newModel textFieldModels =
    { textFieldModels | base = newModel }


setVertical : RadioGroup.Model Option {} -> RadioFieldModels -> RadioFieldModels
setVertical newModel textFieldModels =
    { textFieldModels | vertical = newModel }
