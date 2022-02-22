module Stories.Chapters.RadioGroup exposing (Model, docs, init)

import Components.Field.RadioGroup as RadioGroup
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Stories.Helpers as SH


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Field/RadioGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
A radio group is used to combine and provide structure to group of radio buttons, placing element such as label and error message in a pleasant and clear way.
Radio group have a horizontal layout as default, but with more then two items a vertical layout is recommended.

<component with-label="RadioGroup" />
```
type
    Option
    -- Can be a String or Maybe String alias
    = M
    | F
    | Default -- Add a Default/None/NoSelection/... option to handle the possibility of no selection.


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : RadioGroup.Model ctx Option
radioGroupModel =
    RadioGroup.init validation Default


radioGroupView : ctx -> Html Msg
radioGroupView ctx =
    RadioGroup.config "radio-id"
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions
            [ RadioGroup.option { value = M, label = "Male" }
            , RadioGroup.option { value = F, label = "Female" }
            ]
        |> RadioGroup.render OnRadioFieldMsg ctx radioGroupModel


validation : ctx -> Option -> Result String Option
validation _ value =
    if value == Default then
        Err "Invalid selection"

    else
        Ok value
```

# Vertical Layout
<component with-label="RadioGroup vertical" />

```
radioGroupVerticalLayout : String -> (RadioGroup.Msg value -> msg) -> ctx -> RadioGroup.Model ctx value -> Html msg
radioGroupVerticalLayout id tagger ctx radioModel =
    RadioGroup.config id
        |> RadioGroup.withLayout RadioGroup.vertical
        |> RadioGroup.render tagger ctx radioModel
```


# Disabled
<component with-label="RadioGroup disabled" />
```
radioGroupDisabled : String -> (RadioGroup.Msg value -> msg) -> ctx -> RadioGroup.Model ctx value -> Html msg
radioGroupDisabled id tagger ctx radioModel =
    RadioGroup.config id
        |> RadioGroup.withDisabled True
        |> RadioGroup.render tagger ctx radioModel
```
"""


type alias SharedState x =
    { x
        | radio : RadioFieldModels
    }


type Option
    = M
    | F
    | Default


type alias RadioFieldModels =
    { base : RadioGroup.Model {} Option
    , vertical : RadioGroup.Model {} Option
    , disabled : RadioGroup.Model {} Option
    }


type alias Model =
    RadioFieldModels


type Msg
    = OnBaseRadioFieldMsg (RadioGroup.Msg Option)
    | OnVerticalRadioFieldMsg (RadioGroup.Msg Option)
    | OnDisabledRadioFieldMsg (RadioGroup.Msg Option)


update : Msg -> RadioGroup.Model ctx Option -> RadioGroup.Model ctx Option
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
        RadioGroup.init validation Default
    , vertical =
        RadioGroup.init validation Default
    , disabled =
        RadioGroup.init validation M
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
    -> (RadioFieldModels -> RadioGroup.Model {} Option)
    -> (RadioGroup.Config Option -> RadioGroup.Config Option)
    -> (RadioGroup.Model {} Option -> RadioFieldModels -> RadioFieldModels)
    -> { a | radio : RadioFieldModels }
    -> Html (ElmBook.Msg { b | radio : RadioFieldModels })
radioGroupComponent id name tagger modelMapper configModifier modelUpdater sharedState =
    SH.statefulComponent
        (.radio >> modelMapper)
        (config id name |> configModifier)
        (RadioGroup.render tagger {})
        (\state model -> mapRadioFieldModels (modelUpdater model) state)
        update
        (modelMapper sharedState.radio)


mapRadioFieldModels : (RadioFieldModels -> RadioFieldModels) -> SharedState x -> SharedState x
mapRadioFieldModels updater state =
    { state | radio = updater state.radio }


setBase : RadioGroup.Model {} Option -> RadioFieldModels -> RadioFieldModels
setBase newModel textFieldModels =
    { textFieldModels | base = newModel }


setVertical : RadioGroup.Model {} Option -> RadioFieldModels -> RadioFieldModels
setVertical newModel textFieldModels =
    { textFieldModels | vertical = newModel }
