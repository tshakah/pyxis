module Stories.Chapters.Fields.RadioCardGroup exposing (Model, docs, init)

import Components.Field.Label as Label
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "RadioCardGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
<component with-label="RadioCardGroup" />
```
type Option
    = Home
    | Motor


type Msg
    = OnRadioCardFieldMsg (RadioCardGroup.Msg Option)

validation : formData -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt

radioCardGroupModel : RadioCardGroup.Model formData Option Option
radioCardGroupModel =
    RadioCardGroup.init (Just Motor) validation


radioCardGroupView : formData -> Html Msg
radioCardGroupView formData =
    RadioCardGroup.config "radioCard-name"
        |> RadioCardGroup.withLabel (Label.config "Choose the insurance type")
        |> RadioCardGroup.withName "insurance-type"
        |> RadioCardGroup.withOptions
            [ RadioCardGroup.option
                { value = Motor
                , title = Just "Motor"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            , RadioCardGroup.option
                { value = Home
                , title = Just "Home"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            ]
        |> RadioCardGroup.render OnRadioCardFieldMsg formData radioCardGroupModel

```
## Vertical Layout
<component with-label="RadioCardGroup vertical" />
```
RadioCardGroup.config name
    |> RadioCardGroup.withLayout RadioCardGroup.vertical
    |> RadioCardGroup.render
        OnRadioCardFieldMsg
        formData
        (radioCardModel )
```
## Large Size
Please note that with large layout you need to configure an image addon.
<component with-label="RadioCardGroup large" />
```
optionsWithImage : List (RadioCardGroup.Option Option)
optionsWithImage =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]

RadioCardGroup.config name
    |> RadioCardGroup.withSize RadioCardGroup.large
    |> RadioCardGroup.withOptions optionsWithImage
    |> RadioCardGroup.render
        OnRadioCardFieldMsg
        formData
        (radioCardModel )
```
## Icon addon
<component with-label="RadioCardGroup with icon" />
```
optionsWithIcon : List (RadioCardGroup.Option Option)
optionsWithIcon =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Home
        }
    ]


RadioCardGroup.config name
    |> RadioCardGroup.withOptions optionsWithIcon
    |> RadioCardGroup.render
        OnRadioCardFieldMsg
        formData
        (radioCardModel )
```
## Text addon
<component with-label="RadioCardGroup with text" />
```
optionsWithTextAddon : List (RadioCardGroup.Option Option)
optionsWithTextAddon =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 800,00"
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 1.000,00"
        }
    ]


RadioCardGroup.config name
    |> RadioCardGroup.withOptions optionsWithTextAddon
    |> RadioCardGroup.render
        OnRadioCardFieldMsg
        formData
        (radioCardModel )
```
"""


type alias SharedState x =
    { x
        | radioCard : RadioCardFieldModels
    }


type Option
    = Home
    | Motor


type alias RadioCardFieldModels =
    { base : RadioCardGroup.Model () Option Option
    , vertical : RadioCardGroup.Model () Option Option
    , disabled : RadioCardGroup.Model () Option Option
    , large : RadioCardGroup.Model () Option Option
    , icon : RadioCardGroup.Model () Option Option
    , text : RadioCardGroup.Model () Option Option
    }


type alias Model =
    RadioCardFieldModels


init : Model
init =
    { base =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , vertical =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , disabled =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , large =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , icon =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    , text =
        RadioCardGroup.init (Just Motor) (always (Result.fromMaybe "Invalid selection"))
    }


options : List (RadioCardGroup.Option Option)
options =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = Nothing
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = Nothing
        }
    ]


optionsWithImage : List (RadioCardGroup.Option Option)
optionsWithImage =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]


optionsWithIcon : List (RadioCardGroup.Option Option)
optionsWithIcon =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Home
        }
    ]


optionsWithTextAddon : List (RadioCardGroup.Option Option)
optionsWithTextAddon =
    [ RadioCardGroup.option
        { value = Motor
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 800,00"
        }
    , RadioCardGroup.option
        { value = Home
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 1.000,00"
        }
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "RadioCardGroup"
      , statefulComponent
            { name = "radio-group"
            , configModifier = RadioCardGroup.withLabel (Label.config "Choose the insurance type")
            , modelPicker = .base
            , update = \msg models -> { models | base = RadioCardGroup.update msg models.base }
            }
      )
    , ( "RadioCardGroup vertical"
      , statefulComponent
            { name = "radio-group-vertical"
            , configModifier = RadioCardGroup.withLayout RadioCardGroup.vertical
            , modelPicker = .vertical
            , update = \msg models -> { models | vertical = RadioCardGroup.update msg models.vertical }
            }
      )
    , ( "RadioCardGroup disabled"
      , statefulComponent
            { name = "radio-group-disabled"
            , configModifier = RadioCardGroup.withDisabled True
            , modelPicker = .disabled
            , update = \msg models -> { models | disabled = RadioCardGroup.update msg models.disabled }
            }
      )
    , ( "RadioCardGroup large"
      , statefulComponent
            { name = "radio-group-large"
            , configModifier = RadioCardGroup.withSize RadioCardGroup.large >> RadioCardGroup.withOptions optionsWithImage
            , modelPicker = .large
            , update = \msg models -> { models | large = RadioCardGroup.update msg models.large }
            }
      )
    , ( "RadioCardGroup with icon"
      , statefulComponent
            { name = "radio-group-icon"
            , configModifier = RadioCardGroup.withOptions optionsWithIcon
            , modelPicker = .icon
            , update = \msg models -> { models | icon = RadioCardGroup.update msg models.icon }
            }
      )
    , ( "RadioCardGroup with text"
      , statefulComponent
            { name = "radio-group-text"
            , configModifier = RadioCardGroup.withOptions optionsWithTextAddon
            , modelPicker = .text
            , update = \msg models -> { models | text = RadioCardGroup.update msg models.text }
            }
      )
    ]


type alias StatefulConfig =
    { name : String
    , configModifier : RadioCardGroup.Config Option -> RadioCardGroup.Config Option
    , modelPicker : Model -> RadioCardGroup.Model () Option Option
    , update : RadioCardGroup.Msg Option -> RadioCardFieldModels -> RadioCardFieldModels
    }


statefulComponent : StatefulConfig -> SharedState x -> Html (ElmBook.Msg (SharedState x))
statefulComponent { name, configModifier, modelPicker, update } sharedState =
    RadioCardGroup.config name
        |> RadioCardGroup.withOptions options
        |> configModifier
        |> RadioCardGroup.render identity () (sharedState.radioCard |> modelPicker)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \sharedState_ models -> { sharedState_ | radioCard = models }
                , fromState = .radioCard
                , update = update
                }
            )
