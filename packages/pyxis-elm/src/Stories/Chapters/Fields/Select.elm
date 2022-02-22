module Stories.Chapters.Fields.Select exposing (Model, docs, init)

import Commons.Lens as Lens exposing (Lens)
import Commons.Properties.Size as Size
import Components.Field.Label as Label
import Components.Field.Select as Select
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import PrimaFunction


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Fields/Select"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Select components enable the selection of one out of at least four options provided in a list.
They are typically used within a form to allow users to make their desired selection from the list of options.

The select component uses a custom wrapper on desktop:

<component with-label="Select (desktop)" />
```
Select.create False "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , Select.option { value = "DESIGNER", label = "Designer" }
          , Select.option { value = "PRODUCT_MANAGER", label = "Product Manager" }
          , Select.option { value = "CEO", label = "Chief executive officer" }
          , Select.option { value = "CTO", label = "Chief technology officer" }
          , Select.option { value = "CONSULTANT", label = "Consultant" }
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```

And the native `<select>` on mobile:

<component with-label="Select (mobile)" />
```
Select.create True "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , ...
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```

### Disabled

<component with-label="Select with disabled=True" />
```
Select.create False "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withDisabled True
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , ...
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```

### Size
Select can have two size: default or small.

<component with-label="Select with size=Small" />
```
Select.create False "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withDisabled True
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , ...
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```

### Label
Select can have two size: default or small.

<component with-label="Select with label" />
```
Select.create False "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withLabel (Label.config "Label")
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , ...
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```


### Validation
<component with-label="Select with error message" />
```
Select.create False "select-id"
    |> Select.withPlaceholder "Select your role..."
    |> Select.withOptions
          [ Select.option { value = "DEVELOPER", label = "Developer" }
          , ...
          ]
    |> Select.render ctx Tagger model.roleSelectModel
```
"""


type alias SharedState x =
    { x
        | select : Model
    }


type alias Model =
    { base : Select.Model () (Maybe Job)
    , withValidation : Select.Model () Job
    }


requiredFieldValidation : Maybe a -> Result String a
requiredFieldValidation m =
    case m of
        Nothing ->
            Err "Required field"

        Just str ->
            Ok str


optionalFieldValidation : (from -> Result String to) -> Maybe from -> Result String (Maybe to)
optionalFieldValidation validation m =
    case m of
        Nothing ->
            Ok Nothing

        Just x ->
            Result.map Just (validation x)


validateJob : String -> Result String Job
validateJob job =
    case job of
        "DEVELOPER" ->
            Ok Developer

        "DESIGNER" ->
            Ok Designer

        "PRODUCT_MANAGER" ->
            Ok ProductManager

        _ ->
            Err "Insert a valid option"


validateJobValue : Job -> Result String Job
validateJobValue j =
    case j of
        Developer ->
            Ok j

        _ ->
            Err "Select `Developer` to continue"


init : Model
init =
    { base = Select.init (\() -> optionalFieldValidation validateJob)
    , withValidation =
        Select.init
            (\() ->
                requiredFieldValidation
                    >> Result.andThen validateJob
                    >> Result.andThen validateJobValue
            )
    }


type Job
    = Developer
    | Designer
    | ProductManager


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ viewBaseSection "Select (desktop)"
        (Select.config False "desktop-select")
    , viewBaseSection "Select (mobile)"
        (Select.config True "mobile-select")
    , viewBaseSection "Select with disabled=True"
        (Select.config False "disabled-select"
            |> Select.withDisabled True
        )
    , viewBaseSection "Select with size=Small"
        (Select.config False "small-select"
            |> Select.withSize Size.small
        )
    , viewBaseSection "Select with label"
        (Select.config False "labelled-select"
            |> Select.withLabel (Label.config "Label")
        )
    , viewValidationSection "Select with error message"
        (Select.config False "validation-select")
    ]


viewSection :
    Lens Model (Select.Model () a)
    -> String
    -> Select.Config
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewSection lens title select =
    let
        composedLens : Lens { r | select : Model } (Select.Model () a)
        composedLens =
            selectLens |> Lens.andCompose lens
    in
    ( title
    , \sharedState ->
        select
            -- Common options
            |> Select.withPlaceholder "Select your role..."
            |> Select.withOptions
                [ Select.option { value = "DEVELOPER", label = "Developer" }
                , Select.option { value = "DESIGNER", label = "Designer" }
                , Select.option { value = "PRODUCT_MANAGER", label = "Product Manager" }
                , Select.option { value = "CEO", label = "Chief executive officer" }
                , Select.option { value = "CTO", label = "Chief technology officer" }
                , Select.option { value = "CONSULTANT", label = "Consultant" }
                ]
            -- Rendering
            |> Select.render () identity (composedLens.get sharedState)
            |> Html.map
                (ElmBook.Actions.mapUpdateWithCmd
                    { toState = PrimaFunction.flip composedLens.set
                    , fromState = composedLens.get
                    , update = Select.update
                    }
                )
    )


viewBaseSection :
    String
    -> Select.Config
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewBaseSection =
    viewSection (Lens .base (\x r -> { r | base = x }))


viewValidationSection :
    String
    -> Select.Config
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewValidationSection =
    viewSection (Lens .withValidation (\x r -> { r | withValidation = x }))


selectLens : Lens { a | select : b } b
selectLens =
    Lens .select (\x r -> { r | select = x })
