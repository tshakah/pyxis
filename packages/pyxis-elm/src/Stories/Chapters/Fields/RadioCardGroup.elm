module Stories.Chapters.Fields.RadioCardGroup exposing (Model, docs, init)

import Commons.Lens as Lens exposing (Lens)
import Commons.Properties.Size as Size
import Components.Field.Label as Label
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.IconSet as IconSet
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import PrimaFunction


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Field/RadioCardGroup"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
<component with-label="RadioCardGroup" />
```
type
    Option -- Can be a String or Maybe String alias
    = Home
    | Motor


type Msg
    = OnRadioFieldMsg (RadioCardGroup.Msg Option)


radioCardGroupModel : (ctx -> Maybe value -> Result String parsed) -> Model ctx value parsed
radioCardGroupModel =
    RadioCardGroup.init validation


radioCardGroupView : ctx -> Html Msg
radioCardGroupView ctx =
    RadioCardGroup.config "radioCard-id"
        |> RadioCardGroup.withLabel (Label.config "Choose the area")
        |> RadioCardGroup.withName "area"
        |> RadioCardGroup.withOptions
            [ RadioCardGroup.option
                { value = M
                , title = Just "Motor"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            , RadioCardGroup.option
                { value = F
                , title = Just "Home"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            ]
        |> RadioCardGroup.render OnRadioFieldMsg ctx radioCardGroupModel


validation : ctx -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt
```
## Vertical
<component with-label="RadioCardGroup vertical" />
```
radioCardGroupModel : (ctx -> Maybe value -> Result String parsed) -> RadioCardGroup.Model ctx value parsed
radioCardGroupModel =
    RadioCardGroup.init validation
        |> RadioCardGroup.setValue Motor


radioCardGroupVerticalLayout :
    String
    -> (RadioCardGroup.Msg value -> msg)
    -> ctx -> RadioCardGroup.Model ctx value parsed
    -> Html msg
radioCardGroupVerticalLayout id tagger ctx radioCardModel =
    RadioGroup.config id
        |> RadioCardGroup.withLayout RadioCardGroup.vertical
        |> RadioCardGroup.render tagger ctx radioCardModel
```
## Large Size
Please note that with large layout you need to configure an image addon.
<component with-label="RadioCardGroup large" />
```
optionsWithImage : List (RadioCardGroup.Option Option)
optionsWithImage =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]


radioCardGroupLargeSize :
    String
    -> (RadioCardGroup.Msg value -> msg)
    -> ctx -> RadioCardGroup.Model ctx value parsed
    -> Html msg
radioCardGroupLargeSize id tagger ctx radioCardModel =
    RadioGroup.config id
        |> RadioCardGroup.withSize Size.large
        |> RadioCardGroup.withOptions optionsWithImage
        |> RadioCardGroup.render tagger ctx radioCardModel
```
## Icon addon
<component with-label="RadioCardGroup with icon" />
```
optionsWithIcon : List (RadioCardGroup.Option Option)
optionsWithIcon =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Home
        }
    ]


radioCardGroupWithIcon :
    String
    -> (RadioCardGroup.Msg value -> msg)
    -> ctx -> RadioCardGroup.Model ctx value parsed
    -> Html msg
radioCardGroupWithIcon id ctx radioCardModel =
    RadioGroup.config id
        |> RadioCardGroup.withOptions optionsWithIcon
        |> RadioCardGroup.render tagger ctx radioCardModel
```
## Text addon
<component with-label="RadioCardGroup with text" />
```
optionsWithTextAddon : List (RadioCardGroup.Option Option)
optionsWithTextAddon =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 800,00"
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 1.000,00"
        }
    ]


radioCardGroupWithTextAddon :
    String
    -> (RadioCardGroup.Msg value -> msg)
    -> ctx -> RadioCardGroup.Model ctx value parsed
    -> Html msg
radioCardGroupWithTextAddon id tagger ctx radioCardModel =
    RadioGroup.config id
        |> RadioCardGroup.withOptions optionsWithTextAddon
        |> RadioCardGroup.render tagger ctx radioCardModel
```
"""


type alias SharedState x =
    { x
        | radioCard : RadioCardFieldModels
    }


type Option
    = M
    | F


type alias RadioCardFieldModels =
    { base : RadioCardGroup.Model () Option Option
    , vertical : RadioCardGroup.Model () Option (Maybe Option)
    , disabled : RadioCardGroup.Model () Option (Maybe Option)
    , large : RadioCardGroup.Model () Option (Maybe Option)
    , icon : RadioCardGroup.Model () Option (Maybe Option)
    , text : RadioCardGroup.Model () Option (Maybe Option)
    }


type alias Model =
    RadioCardFieldModels


init : Model
init =
    { base =
        RadioCardGroup.init validationRequired
    , vertical =
        RadioCardGroup.init (always Ok)
            |> RadioCardGroup.setValue M
    , disabled =
        RadioCardGroup.init (always Ok)
            |> RadioCardGroup.setValue M
    , large =
        RadioCardGroup.init (always Ok)
            |> RadioCardGroup.setValue M
    , icon =
        RadioCardGroup.init (always Ok)
            |> RadioCardGroup.setValue M
    , text =
        RadioCardGroup.init (always Ok)
            |> RadioCardGroup.setValue M
    }


validationRequired : ctx -> Maybe Option -> Result String Option
validationRequired _ value =
    case value of
        Nothing ->
            Err "Invalid selection"

        Just opt ->
            Ok opt


config : String -> RadioCardGroup.Config Option
config id =
    RadioCardGroup.config id
        |> RadioCardGroup.withOptions
            [ RadioCardGroup.option
                { value = M
                , title = Just "Motor"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            , RadioCardGroup.option
                { value = F
                , title = Just "Home"
                , text = Just "Lorem ipsum dolor"
                , addon = Nothing
                }
            ]
        |> RadioCardGroup.withName id


optionsWithImage : List (RadioCardGroup.Option Option)
optionsWithImage =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.imgAddon "../assets/placeholder.svg"
        }
    ]


optionsWithIcon : List (RadioCardGroup.Option Option)
optionsWithIcon =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.iconAddon IconSet.Home
        }
    ]


optionsWithTextAddon : List (RadioCardGroup.Option Option)
optionsWithTextAddon =
    [ RadioCardGroup.option
        { value = M
        , title = Just "Motor"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 800,00"
        }
    , RadioCardGroup.option
        { value = F
        , title = Just "Home"
        , text = Just "Lorem ipsum dolor"
        , addon = RadioCardGroup.textAddon "€ 1.000,00"
        }
    ]


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ viewSection "RadioCardGroup"
        baseLens
        (config "base"
            |> RadioCardGroup.withLabel (Label.config "Choose the area")
        )
    , viewSection "RadioCardGroup vertical"
        verticalLens
        (config "vertical"
            |> RadioCardGroup.withLayout RadioCardGroup.vertical
        )
    , viewSection "RadioCardGroup disabled"
        verticalLens
        (config "disabled"
            |> RadioCardGroup.withDisabled True
        )
    , viewSection "RadioCardGroup large"
        largeLens
        (config "large"
            |> RadioCardGroup.withSize Size.large
            |> RadioCardGroup.withOptions optionsWithImage
        )
    , viewSection "RadioCardGroup with icon"
        iconLens
        (config "with-icon"
            |> RadioCardGroup.withOptions optionsWithIcon
        )
    , viewSection "RadioCardGroup with text"
        textLens
        (config "with-text"
            |> RadioCardGroup.withOptions optionsWithTextAddon
        )
    ]


viewSection :
    String
    -> Lens Model (RadioCardGroup.Model () Option parsed)
    -> RadioCardGroup.Config Option
    -> ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
viewSection title lens card =
    let
        composedLens : Lens { a | radioCard : Model } (RadioCardGroup.Model () Option parsed)
        composedLens =
            radioCardLens |> Lens.andCompose lens
    in
    ( title
    , \sharedState ->
        card
            |> RadioCardGroup.render identity () (composedLens.get sharedState)
            |> Html.map
                (ElmBook.Actions.mapUpdate
                    { fromState = composedLens.get
                    , toState = PrimaFunction.flip composedLens.set
                    , update = RadioCardGroup.update
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


largeLens : Lens { a | large : b } b
largeLens =
    Lens .large (\x r -> { r | large = x })


iconLens : Lens { a | icon : b } b
iconLens =
    Lens .icon (\x r -> { r | icon = x })


textLens : Lens { a | text : b } b
textLens =
    Lens .text (\x r -> { r | text = x })


radioCardLens : Lens { a | radioCard : b } b
radioCardLens =
    Lens .radioCard (\x r -> { r | radioCard = x })
