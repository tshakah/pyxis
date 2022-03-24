module Stories.Chapters.Fields.CheckboxCardGroup exposing (Model, docs, init)

import Commons.Properties.Size as Size
import Components.Field.CheckboxCardGroup as CheckboxCardGroup
import Components.Field.Label as Label
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "CheckboxCardGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Checkbox Card lets the user make zero or multiple selection from a list of options.
In comparison to a normal checkbox, it's more graphical and appealing, as it can display an image or an icon and also has a slot for a more descriptive label.
As normal checkbox, checkbox cards can be combined together in groups too, in order to have a clean user experience.

<component with-label="CheckboxCardGroup" />
```
type Option
    = Home
    | Motor


type Msg
    = OnCheckboxFieldMsg (CheckboxCardGroup.Msg Option)

validation : formData -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt

checkboxCardGroupModel : Model formData value parsed
checkboxCardGroupModel =
    CheckboxCardGroup.init [] validation


checkboxCardGroupView : formData -> Html Msg
checkboxCardGroupView formData =
    CheckboxCardGroup.config "checkboxCard-id"
        |> CheckboxCardGroup.withLabel (Label.config "Choose the area")
        |> CheckboxCardGroup.withName "area"
        |> CheckboxCardGroup.withOptions
            [ CheckboxCardGroup.option
                { value = M
                , title = Just "Motor"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            , CheckboxCardGroup.option
                { value = F
                , title = Just "Home"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            ]
        |> CheckboxCardGroup.render OnCheckboxFieldMsg formData checkboxCardGroupModel
```
## Vertical
<component with-label="CheckboxCardGroup vertical" />
```
CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxCardGroup.withLayout CheckboxCardGroup.vertical
    |> CheckboxCardGroup.render OnCheckboxFieldMsg formData checkboxCardModel
```
## Large Size
Please note that with large layout you need to configure an image addon.
<component with-label="CheckboxCardGroup large" />
```
optionsWithImage : List (CheckboxCardGroup.Option Option)
optionsWithImage =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]

CheckboxGroup.config "checkbox-id"
    |> CheckboxCardGroup.withSize Size.large
    |> CheckboxCardGroup.withOptions optionsWithImage
    |> CheckboxCardGroup.render OnCheckboxFieldMsg formData checkboxCardModel
```
## Icon addon
<component with-label="CheckboxCardGroup with icon" />
```
optionsWithIcon : List (CheckboxCardGroup.Option Option)
optionsWithIcon =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.iconAddon IconSet.Car
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.iconAddon IconSet.Home
        }
    ]

CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxCardGroup.withOptions optionsWithIcon
    |> CheckboxCardGroup.render OnCheckboxFieldMsg formData checkboxCardModel
```
## Text addon
<component with-label="CheckboxCardGroup with text" />
```
optionsWithTextAddon : List (CheckboxCardGroup.Option Option)
optionsWithTextAddon =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.textAddon "€ 800,00"
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.textAddon "€ 1.000,00"
        }
    ]

CheckboxGroup.config "checkboxgroup-id"
    |> CheckboxCardGroup.withOptions optionsWithTextAddon
    |> CheckboxCardGroup.render OnCheckboxFieldMsg formData checkboxCardModel
```
"""


type alias SharedState x =
    { x
        | checkboxCard : CheckboxCardFieldModels
    }


type alias Msg x =
    ElmBook.Msg (SharedState x)


type Option
    = M
    | F


type alias CheckboxCardFieldModels =
    { base : CheckboxCardGroup.Model () Option (NonemptyList Option)
    , vertical : CheckboxCardGroup.Model () Option (List Option)
    , disabled : CheckboxCardGroup.Model () Option (List Option)
    , large : CheckboxCardGroup.Model () Option (List Option)
    , icon : CheckboxCardGroup.Model () Option (List Option)
    , text : CheckboxCardGroup.Model () Option (List Option)
    }


type alias Model =
    CheckboxCardFieldModels


init : Model
init =
    { base =
        CheckboxCardGroup.init [] validationRequired
    , vertical =
        CheckboxCardGroup.init [] (always Ok)
    , disabled =
        CheckboxCardGroup.init [] (always Ok)
    , large =
        CheckboxCardGroup.init [] (always Ok)
    , icon =
        CheckboxCardGroup.init [] (always Ok)
    , text =
        CheckboxCardGroup.init [] (always Ok)
    }


type alias NonemptyList a =
    ( a, List a )


validationRequired : () -> List Option -> Result String (NonemptyList Option)
validationRequired () langs =
    case langs of
        [] ->
            Err "You must select at least one option"

        hd :: tl ->
            Ok ( hd, tl )


optionsWithImage : List (CheckboxCardGroup.Option Option)
optionsWithImage =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]


optionsWithIcon : List (CheckboxCardGroup.Option Option)
optionsWithIcon =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.iconAddon IconSet.Car
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.iconAddon IconSet.Home
        }
    ]


optionsWithTextAddon : List (CheckboxCardGroup.Option Option)
optionsWithTextAddon =
    [ CheckboxCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.textAddon "€ 800,00"
        }
    , CheckboxCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = CheckboxCardGroup.textAddon "€ 1.000,00"
        }
    ]


componentsList : List ( String, SharedState x -> Html (Msg x) )
componentsList =
    [ ( "CheckboxCardGroup"
      , statefulComponent
            { id = "base"
            , configModifier = CheckboxCardGroup.withLabel (Label.config "Choose the area")
            , modelPicker = .base
            , update = \msg models -> { models | base = CheckboxCardGroup.update msg models.base }
            }
      )
    , ( "CheckboxCardGroup vertical"
      , statefulComponent
            { id = "vertical"
            , configModifier = CheckboxCardGroup.withLayout CheckboxCardGroup.vertical
            , modelPicker = .vertical
            , update = \msg models -> { models | vertical = CheckboxCardGroup.update msg models.vertical }
            }
      )
    , ( "CheckboxCardGroup large"
      , statefulComponent
            { id = "large"
            , configModifier = CheckboxCardGroup.withSize Size.large >> CheckboxCardGroup.withOptions optionsWithImage
            , modelPicker = .large
            , update = \msg models -> { models | large = CheckboxCardGroup.update msg models.large }
            }
      )
    , ( "CheckboxCardGroup with icon"
      , statefulComponent
            { id = "icon"
            , configModifier = CheckboxCardGroup.withOptions optionsWithIcon
            , modelPicker = .icon
            , update = \msg models -> { models | icon = CheckboxCardGroup.update msg models.icon }
            }
      )
    , ( "CheckboxCardGroup with text"
      , statefulComponent
            { id = "with-text"
            , configModifier = CheckboxCardGroup.withOptions optionsWithTextAddon
            , modelPicker = .text
            , update = \msg models -> { models | text = CheckboxCardGroup.update msg models.text }
            }
      )
    ]


type alias StatefulConfig parsed =
    { id : String
    , configModifier : CheckboxCardGroup.Config Option -> CheckboxCardGroup.Config Option
    , modelPicker : Model -> CheckboxCardGroup.Model () Option parsed
    , update : CheckboxCardGroup.Msg Option -> CheckboxCardFieldModels -> CheckboxCardFieldModels
    }


statefulComponent : StatefulConfig parsed -> SharedState x -> Html (Msg x)
statefulComponent { id, configModifier, modelPicker, update } sharedState =
    CheckboxCardGroup.config id
        |> CheckboxCardGroup.withOptions
            [ CheckboxCardGroup.option
                { value = M
                , title = Just "Motor"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            , CheckboxCardGroup.option
                { value = F
                , title = Just "Home"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            ]
        |> CheckboxCardGroup.withName id
        |> configModifier
        |> CheckboxCardGroup.render identity () (sharedState.checkboxCard |> modelPicker)
        |> Html.map
            (ElmBook.Actions.mapUpdate
                { toState = \sharedState_ models -> { sharedState_ | checkboxCard = models }
                , fromState = .checkboxCard
                , update = update
                }
            )
