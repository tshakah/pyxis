module Stories.Chapters.Fields.Date exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.Date as Date
import Components.Field.Label as Label
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Date"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
All the properties described below concern the visual implementation of the component.

<component with-label="Date" />
```
type Msg
    = OnDateFieldMsg Date.Msg


validation : formData -> Date.Date -> Result String Date.Date
validation _ value =
    case value of
        Date.Parsed _ ->
            Ok value

        Date.Raw _ ->
            Err "You should select a valid date"


dateFieldModel : Date.Model formData
dateFieldModel =
    Date.init validation


dateField : formData -> Html Msg
dateField formData =
    Date.config "date-id"
        |> Date.render OnDateFieldMsg formData dateFieldModel
```

## Size

Sizes set the occupied space of the text-field.
You can set your TextField with a _size_ of default or small.

### Size: Small
<component with-label="Date withSize small" />

```
Date.config "date-id"
    |> Date.withSize Size.small
    |> Date.render OnDateFieldMsg formData dateFieldModel
```

## Others

<component with-label="Date withPlaceholder" />
```
Date.config "date-id"
    |> Date.withPlaceholder "Custom placeholder"
    |> Date.render OnDateFieldMsg formData dateFieldModel
```

<component with-label="Date withDisabled" />
```
Date.config "date-id"
    |> Date.withDisabled True
    |> Date.render OnDateFieldMsg formData dateFieldModel
```

"""


type alias SharedState x =
    { x | date : Model }


type alias Model =
    { base : Date.Model ()
    , withValidation : Date.Model ()
    }


init : Model
init =
    { base = Date.init (always Ok)
    , withValidation = Date.init validation
    }


validation : () -> Date.Date -> Result String Date.Date
validation _ value =
    case value of
        Date.Parsed _ ->
            Ok value

        Date.Raw _ ->
            Err "You should select a valid date"


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Date"
      , statefulComponent
            "date-id"
            (Date.withLabel (Label.config "Date"))
            .withValidation
            updateWithValidation
      )
    , ( "Date withSize small"
      , statelessComponent "small" (Date.withSize Size.small)
      )
    , ( "Date withDisabled"
      , statelessComponent "disabled" (Date.withDisabled True)
      )
    , ( "Date withPlaceholder"
      , statelessComponent "placeholder" (Date.withPlaceholder "Custom placeholder")
      )
    ]


statelessComponent : String -> (Date.Config -> Date.Config) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent id modifier { date } =
    Date.config id
        |> modifier
        |> Date.render identity () date.base
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | date = model }
                , fromState = .date
                , update = \msg model -> { model | base = Date.update msg model.base }
                }
            )


statefulComponent :
    String
    -> (Date.Config -> Date.Config)
    -> (Model -> Date.Model ())
    -> (Date.Msg -> Model -> Model)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent id configModifier modelPicker update sharedState =
    Date.config id
        |> configModifier
        |> Date.render identity () (sharedState.date |> modelPicker)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> { state | date = model }
                , fromState = .date
                , update = update
                }
            )


updateWithValidation : Date.Msg -> Model -> Model
updateWithValidation msg model =
    { model | withValidation = Date.update msg model.withValidation }
