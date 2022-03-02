module Stories.Chapters.Fields.RadioGroup exposing (Model, docs, init)

import Commons.Lens as Lens exposing (Lens)
import Components.Field.RadioGroup as RadioGroup
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import PrimaFunction


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
    Option -- Can be a String or Maybe String alias
    = M
    | F


type Msg
    = OnRadioFieldMsg (RadioGroup.Msg Option)


radioGroupModel : RadioGroup.Model ctx Option
radioGroupModel =
    RadioGroup.init validation


radioGroupView : ctx -> Html Msg
radioGroupView ctx =
    RadioGroup.config "radio-id"
        |> RadioGroup.withName "gender"
        |> RadioGroup.withOptions
            [ RadioGroup.option { value = M, label = "Male" }
            , RadioGroup.option { value = F, label = "Female" }
            ]
        |> RadioGroup.render OnRadioFieldMsg ctx radioGroupModel


validation : ctx -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt
```

# Vertical Layout
A radio group is used to combine and provide structure to group of radio buttons, placing element such as label and error message in a pleasant and clear way. Also, it could display a hint message to help final user fill the group.

Radio group have a horizontal layout as default, but with more then two items a vertical layout is recommended.

<component with-label="RadioGroup vertical" />

```
radioGroupVerticalLayout : String -> (RadioGroup.Msg value -> msg) -> ctx -> RadioGroup.Model ctx value parsed -> Html msg
radioGroupVerticalLayout id tagger ctx radioModel =
    RadioGroup.config id
        |> RadioGroup.withLayout RadioGroup.vertical
        |> RadioGroup.render tagger ctx radioModel
```


# Disabled
<component with-label="RadioGroup disabled" />
```
radioGroupDisabled : String -> (RadioGroup.Msg value -> msg) -> ctx -> RadioGroup.Model ctx value parsed -> Html msg
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


type alias RadioFieldModels =
    { base : RadioGroup.Model () Option (Maybe Option)
    , vertical : RadioGroup.Model () Option Option
    , disabled : RadioGroup.Model () Option (Maybe Option)
    }


type alias Model =
    RadioFieldModels


init : Model
init =
    { base =
        RadioGroup.init (always Ok)
    , vertical =
        RadioGroup.init validationRequired
    , disabled =
        RadioGroup.init (always Ok)
            |> RadioGroup.setValue M
    }


validationRequired : ctx -> Maybe Option -> Result String Option
validationRequired _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ viewSection "RadioGroup"
        baseLens
        (RadioGroup.config "base"
            |> RadioGroup.withName "gender1"
        )
    , viewSection "RadioGroup vertical"
        verticalLens
        (RadioGroup.config "base"
            |> RadioGroup.withName "vertical"
            |> RadioGroup.withLayout RadioGroup.vertical
        )
    , viewSection "RadioGroup disabled"
        disabledLens
        (RadioGroup.config "disabled"
            |> RadioGroup.withName "gender3"
            |> RadioGroup.withDisabled True
        )
    ]


viewSection :
    String
    -> Lens Model (RadioGroup.Model () Option parsed)
    -> RadioGroup.Config Option
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewSection title lens checkbox =
    let
        composedLens : Lens { a | radio : Model } (RadioGroup.Model () Option parsed)
        composedLens =
            radioLens |> Lens.andCompose lens
    in
    ( title
    , \sharedState ->
        checkbox
            |> RadioGroup.withOptions
                [ RadioGroup.option { value = M, label = "Male" }
                , RadioGroup.option { value = F, label = "Female" }
                ]
            |> RadioGroup.render identity () (composedLens.get sharedState)
            |> Html.map
                (ElmBook.Actions.mapUpdate
                    { toState = PrimaFunction.flip composedLens.set
                    , fromState = composedLens.get
                    , update = RadioGroup.update
                    }
                )
    )



-- Lenses


baseLens : Lens { a | base : b } b
baseLens =
    Lens .base (\x r -> { r | base = x })


verticalLens : Lens { a | vertical : b } b
verticalLens =
    Lens .vertical (\x r -> { r | vertical = x })


disabledLens : Lens { a | disabled : b } b
disabledLens =
    Lens .disabled (\x r -> { r | disabled = x })


radioLens : Lens { a | radio : b } b
radioLens =
    Lens .radio (\x r -> { r | radio = x })
