module Stories.Chapters.DateField exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.Date as DateField
import Date
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "DateField"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
date Field are used to let the user enter a date. They include built-in validation to reject non-numerical entries.

<component with-label="DateField" />
```
numberField : (DateField.Msg -> msg) -> String -> Html msg
numberField tagger id =
    DateField.create tagger id
        |> DateField.render
```

## Size

Sizes set the occupied space of the date-field.
You can set your DateField with a _size_ of default or small.

### Size: Small
<component with-label="DateField withSize small" />

```
numberFieldWithSize : (DateField.Msg -> msg) -> String -> Html msg
numberFieldWithSize tagger id =
    DateField.create tagger id
        |> DateField.withSize Size.small
        |> DateField.render

```

## Others graphical API

<component with-label="DateField withPlaceholder" />
```
numberFieldWithPlaceholder : (DateField.Msg -> msg) -> String -> Html msg
numberFieldWithPlaceholder tagger id =
    DateField.create tagger id
        |> DateField.withPlaceholder "Custom placeholder"
        |> DateField.render

```

<component with-label="DateField withDefaultValue" />
```
numberFieldWithName : (DateField.Msg -> msg) -> String -> Html msg
numberFieldWithName tagger id =
    DateField.create tagger id
        |> DateField.withDefaultValue "Default Value"
        |> DateField.render

```

<component with-label="DateField withDisabled" />
```
numberFieldWithClassList : (DateField.Msg -> msg) -> String -> Html msg
numberFieldWithClassList tagger id =
    DateField.create tagger id
        |> DateField.withDisabled True
        |> DateField.render

```

## Non-graphical API

<component with-label="DateField withNonGraphicalApi" />
```
numberFieldWithNonGraphicalApi : (DateField.Msg -> msg) -> String -> Html msg
numberFieldWithNonGraphicalApi tagger id =
    DateField.create OnDateFieldMsg "withNonGraphicalApi"
        |> DateField.withClassList [ ( "class-on-date-field", True ), ( "class-not-on-date-field", False ) ]
        |> DateField.withName "date-field-name"
        |> DateField.withValidation requiredDateField
        |> DateField.render


requiredDateField : FormData -> DateField.Date -> Result String DateField.Date
requiredDateField _ value =
    case value of
        DateField.Parsed date ->
            if Date.year date < 1900 then
                Err "Date year must be >= 1900"

            else
                Ok value

        DateField.Raw _ ->
            Err "Insert a valid date"


```
"""


type alias SharedState x =
    { x
        | dateFieldModels : DateFieldModels
    }


type alias FormData =
    {}


type alias DateFieldModels =
    { base : DateField.Model FormData Msg
    , withNonGraphicalApi : DateField.Model FormData Msg
    }


type alias Model =
    DateFieldModels


type Msg
    = OnDateFieldMsg DateField.Msg


init : Model
init =
    { base = DateField.create OnDateFieldMsg "base"
    , withNonGraphicalApi =
        DateField.create OnDateFieldMsg "withNonGraphicalApi"
            |> DateField.withClassList [ ( "class-on-date-field", True ), ( "class-not-on-date-field", False ) ]
            |> DateField.withName "date-field-name"
            |> DateField.withValidation requiredDateField
    }


requiredDateField : FormData -> DateField.Date -> Result String DateField.Date
requiredDateField _ value =
    case value of
        DateField.Parsed date ->
            if Date.year date < 1900 then
                Err "Date year must be >= 1900"

            else
                Ok value

        DateField.Raw _ ->
            Err "Insert a valid date"


sizeComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
sizeComponents =
    [ ( "DateField withSize small"
      , statelessComponent "DateField small" (DateField.withSize Size.small)
      )
    ]


otherGraphicalApiComponents : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
otherGraphicalApiComponents =
    [ ( "DateField withDefaultValue"
      , statelessComponent "DateField withDefaultValue" (DateField.withDefaultValue (Date.fromRataDie 1000000))
      )
    , ( "DateField withDisabled"
      , statelessComponent "DateField withDisabled" (DateField.withDisabled True)
      )
    , ( "DateField withPlaceholder"
      , statelessComponent "DateField withPlaceholder" (DateField.withPlaceholder "Custom placeholder")
      )
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "DateField"
      , statelessComponent "DateField" identity
      )
    , ( "DateField withNonGraphicalApi"
      , statefulComponent
            "DateField with Functional Api"
            .withNonGraphicalApi
            (\state model -> mapDateFieldModels (setWithNonGraphicalApi model) state)
      )
    ]
        ++ sizeComponents
        ++ otherGraphicalApiComponents


mapDateFieldModels : (DateFieldModels -> DateFieldModels) -> SharedState x -> SharedState x
mapDateFieldModels updater state =
    { state | dateFieldModels = updater state.dateFieldModels }


setBase : DateField.Model FormData Msg -> DateFieldModels -> DateFieldModels
setBase newModel dateFieldModels =
    { dateFieldModels | base = newModel }


setWithNonGraphicalApi : DateField.Model FormData Msg -> DateFieldModels -> DateFieldModels
setWithNonGraphicalApi newModel dateFieldModels =
    { dateFieldModels | withNonGraphicalApi = newModel }


fromState : (DateFieldModels -> DateField.Model FormData Msg) -> SharedState x -> DateField.Model FormData Msg
fromState mapper =
    .dateFieldModels >> mapper


updateInternal : Msg -> DateField.Model FormData Msg -> DateField.Model FormData Msg
updateInternal (OnDateFieldMsg msg) model =
    DateField.update {} msg model


withErrorWrapper : Html msg -> Html msg
withErrorWrapper component =
    Html.div [ Html.Attributes.style "margin-bottom" "20px" ] [ component ]


statelessComponent : String -> (DateField.Model FormData Msg -> DateField.Model FormData Msg) -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statelessComponent placeholder modifier { dateFieldModels } =
    dateFieldModels.base
        |> DateField.withPlaceholder placeholder
        |> modifier
        |> DateField.render
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \state model -> mapDateFieldModels (setBase model) state
                , fromState = .dateFieldModels >> .base
                , update = \(OnDateFieldMsg msg) model -> DateField.update {} msg model
                }
            )


statefulComponent :
    String
    -> (DateFieldModels -> DateField.Model FormData Msg)
    -> (SharedState x -> DateField.Model FormData Msg -> SharedState x)
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent placeholder mapper toState sharedModel =
    sharedModel.dateFieldModels
        |> mapper
        |> DateField.withPlaceholder placeholder
        |> DateField.render
        |> withErrorWrapper
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = toState
                , fromState = fromState mapper
                , update = updateInternal
                }
            )
