module Stories.Chapters.Fields.CheckboxGroup exposing (Model, docs, init)

import Commons.Lens as Lens exposing (Lens)
import Components.Field.CheckboxGroup as CheckboxGroup
import Components.Field.Label as Label
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import PrimaFunction


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Fields/CheckboxGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Checkbox lets the user make zero or multiple selection from a list of options.

<component with-label="CheckboxGroup" />
```
type Msg
    = CheckboxGroupMsg (CheckboxGroup.Msg Lang)

CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxGroup.withOptions
        [ CheckboxGroup.option { value = Elm, label = "Elm" }
        , CheckboxGroup.option { value = Typescript, label = "Typescript" }
        , CheckboxGroup.option { value = Rust, label = "Rust" }
        , CheckboxGroup.option { value = Elixir, label = "Elixir" }
        ]
    |> CheckboxGroup.render ctx CheckboxGroupMsg model.langsModel
```

<component with-label="CheckboxGroup with validation" />
```
validation : () -> List Lang -> Result String (Lang, List Lang)
validation () checkedOptions =
    case checkedOptions of
        [] ->
            Err "You must select at least one option"

        hd :: tl ->
            Ok (hd, tl)

init : Model
init =
    { CheckboxGroup.init validation
    }

CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxGroup.withOptions
        [ CheckboxGroup.option { value = Elm, label = "Elm" }
        , ...
        ]
    |> CheckboxGroup.render ctx CheckboxGroupMsg model.langsModel
```

<component with-label="CheckboxGroup with single Checkbox" />
```
CheckboxGroup.single "Accept the policy" "checkbox-id"
|> CheckboxGroup.render ctx CheckboxGroupMsg model.cookieCheckboxModel
```

<component with-label="CheckboxGroup with disabled options" />
```
CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxGroup.withOptions
        [ CheckboxGroup.option { value = Elm, label = "Elm" }
        , CheckboxGroup.option { value = Typescript, label = "Typescript" }
        , CheckboxGroup.option { value = Rust, label = "Rust" }
        , CheckboxGroup.option { value = Elixir, label = "Elixir" }
            |> CheckboxGroup.withDisabledOption True
        ]
    |> CheckboxGroup.render ctx CheckboxGroupMsg model.langsModel
```

<component with-label="CheckboxGroup with vertical layout" />
```
CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxGroup.withOptions
        [ CheckboxGroup.option { value = Elm, label = "Elm" }
        , ...
        ]
    |> CheckboxGroup.withLayout CheckboxGroup.vertical
    |> CheckboxGroup.render ctx CheckboxGroupMsg model.langsModel
```

"""


type alias SharedState x =
    { x
        | checkbox : Model
    }


type Lang
    = Elm
    | Typescript
    | Rust
    | Elixir


type alias Model =
    { base : CheckboxGroup.Model () Lang (List Lang)
    , validated : CheckboxGroup.Model () Lang (NonemptyList Lang)
    , single : CheckboxGroup.Model () () Bool
    }


type alias NonemptyList a =
    ( a, List a )


validation : () -> List Lang -> Result String (NonemptyList Lang)
validation () langs =
    case langs of
        [] ->
            Err "You must select at least one option"

        hd :: tl ->
            Ok ( hd, tl )


singleOptionValidation : () -> List () -> Result error Bool
singleOptionValidation () =
    List.member () >> Ok


init : Model
init =
    { base = CheckboxGroup.init (always Ok)
    , validated = CheckboxGroup.init validation
    , single = CheckboxGroup.init singleOptionValidation
    }


langsConfig : CheckboxGroup.Config Lang
langsConfig =
    CheckboxGroup.config "checkboxgroup-id"
        |> CheckboxGroup.withOptions
            [ CheckboxGroup.option { value = Elm, label = "Elm" }
            , CheckboxGroup.option { value = Typescript, label = "Typescript" }
            , CheckboxGroup.option { value = Rust, label = "Rust" }
            , CheckboxGroup.option { value = Elixir, label = "Elixir" }
            ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ viewSection "CheckboxGroup" baseLens langsConfig
    , viewSection "CheckboxGroup with single Checkbox"
        singleLens
        (CheckboxGroup.single "Accept the policy" "checkbox-id")
    , viewSection "CheckboxGroup with validation" validatedLens langsConfig
    , viewSection "CheckboxGroup with disabled options"
        baseLens
        (CheckboxGroup.config "checkboxgroup-id"
            |> CheckboxGroup.withOptions
                [ CheckboxGroup.option { value = Elm, label = "Elm" }
                , CheckboxGroup.option { value = Typescript, label = "Typescript" }
                , CheckboxGroup.option { value = Rust, label = "Rust" }
                , CheckboxGroup.option { value = Elixir, label = "Elixir" }
                    |> CheckboxGroup.withDisabledOption True
                ]
        )
    , viewSection "CheckboxGroup with vertical layout"
        baseLens
        (langsConfig
            |> CheckboxGroup.withLayout CheckboxGroup.vertical
        )
    ]


viewSection :
    String
    -> Lens Model (CheckboxGroup.Model () value parsed)
    -> CheckboxGroup.Config value
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewSection title lens checkbox =
    let
        composedLens : Lens { a | checkbox : Model } (CheckboxGroup.Model () value parsed)
        composedLens =
            checkboxLens |> Lens.andCompose lens
    in
    ( title
    , \sharedState ->
        checkbox
            |> CheckboxGroup.withLabel (Label.config "Label")
            |> CheckboxGroup.render () identity (composedLens.get sharedState)
            |> Html.map
                (ElmBook.Actions.mapUpdate
                    { toState = PrimaFunction.flip composedLens.set
                    , fromState = composedLens.get
                    , update = CheckboxGroup.update
                    }
                )
    )



-- Lenses


baseLens : Lens { a | base : b } b
baseLens =
    Lens .base (\x r -> { r | base = x })


validatedLens : Lens { a | validated : b } b
validatedLens =
    Lens .validated (\x r -> { r | validated = x })


singleLens : Lens { a | single : b } b
singleLens =
    Lens .single (\x r -> { r | single = x })


checkboxLens : Lens { a | checkbox : b } b
checkboxLens =
    Lens .checkbox (\x r -> { r | checkbox = x })
