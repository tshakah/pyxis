module Components.Field.RadioCardGroupTest exposing (suite)

import Commons.Attributes as CommonsAttributes
import Commons.Properties.Size as Size
import Components.Field.RadioCardGroup as RadioCardGroup
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Test.Simulation as Simulation


type Option
    = Home
    | Motor


suite : Test
suite =
    Test.describe "The RadioCardGroup component"
        [ Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    radioCardGroupConfig noAddonOptions
                        |> renderRadioCardGroup
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled False ])
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withDisabled b
                        |> renderRadioCardGroup
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled b ])
            , Test.test "if disabled, each card has the proper class" <|
                \() ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withDisabled True
                        |> renderRadioCardGroup
                        |> findCards
                        |> Query.each (Query.has [ Selector.class "form-card--disabled" ])
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                radioCardGroupConfig noAddonOptions
                    |> RadioCardGroup.withName name
                    |> renderRadioCardGroup
                    |> findInputs
                    |> Query.each
                        (Query.has
                            [ Selector.attribute (Html.Attributes.name name)
                            ]
                        )
        , Test.test "checked card should have the correct class" <|
            \() ->
                radioCardGroupConfig noAddonOptions
                    |> RadioCardGroup.render identity
                        ()
                        (RadioCardGroup.init validation
                            |> RadioCardGroup.setValue Home
                        )
                    |> Query.fromHtml
                    |> Query.find [ Selector.containing [ Selector.id "area-home---title-option" ] ]
                    |> Query.has [ Selector.class "form-card--checked" ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderRadioCardGroup
                        |> Expect.all
                            [ Query.has
                                [ Selector.classes [ s1, s3 ]
                                ]
                            , Query.hasNot
                                [ Selector.classes [ s2 ]
                                ]
                            ]
            , Test.fuzzDistinctClassNames3 "should only render the last pipe value" <|
                \s1 s2 s3 ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> RadioCardGroup.withClassList [ ( s3, True ) ]
                        |> renderRadioCardGroup
                        |> Expect.all
                            [ Query.has
                                [ Selector.classes [ s3 ]
                                ]
                            , Query.hasNot
                                [ Selector.classes [ s1, s2 ]
                                ]
                            ]
            ]
        , Test.describe "Vertical layout"
            [ Test.test "should have the class for the vertical layout" <|
                \() ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withLayout RadioCardGroup.vertical
                        |> renderRadioCardGroup
                        |> Query.has
                            [ Selector.classes [ "form-card-group--column" ]
                            ]
            ]
        , Test.describe "Large Size"
            [ Test.test "should have the class for the large" <|
                \() ->
                    radioCardGroupConfig noAddonOptions
                        |> RadioCardGroup.withSize Size.large
                        |> renderRadioCardGroup
                        |> findCards
                        |> Query.each (Query.has [ Selector.classes [ "form-card--large" ] ])
            ]
        , Test.describe "Addon"
            [ Test.test "with image addon should render an image with proper class" <|
                \() ->
                    radioCardGroupConfig withImgAddonOptions
                        |> renderRadioCardGroup
                        |> findCards
                        |> Query.each
                            (Query.has [ Selector.tag "img", Selector.class "form-card__addon" ])
            , Test.test "with text addon should render the text passed with proper class" <|
                \() ->
                    radioCardGroupConfig withTextAddonOptions
                        |> RadioCardGroup.withSize Size.large
                        |> renderRadioCardGroup
                        |> findCards
                        |> Query.each
                            (Query.has [ Selector.text "1.000,00", Selector.class "form-card__addon" ])
            , Test.test "with icon addon should render an Icon with proper class" <|
                \() ->
                    radioCardGroupConfig withIconAddonOptions
                        |> RadioCardGroup.withSize Size.large
                        |> renderRadioCardGroup
                        |> findCards
                        |> Query.each
                            (Query.has
                                [ Selector.attribute (CommonsAttributes.testId (IconSet.toLabel IconSet.Car))
                                , Selector.classes [ "form-card__addon", "form-card__addon--with-icon" ]
                                ]
                            )
            ]
        , Test.describe "Validation"
            [ Test.test "should not pass if the input is not compliant with the validation function" <|
                \() ->
                    simulationWithValidation
                        |> Simulation.expectModel
                            (RadioCardGroup.getValue
                                >> validation {}
                                >> Expect.equal (Err "Required")
                            )
                        |> Simulation.expectHtml (Query.find [ Selector.id "area-error" ] >> Query.contains [ Html.text "Required" ])
                        |> Simulation.run
            ]
        , Test.describe "Events"
            [ Test.test "input should update the model value" <|
                \() ->
                    simulationWithValidation
                        |> simulateEvents "area-home---title-option"
                        |> Simulation.expectModel (RadioCardGroup.getValue >> Expect.equal (Just Home))
                        |> Simulation.run
            ]
        ]


findInputs : Query.Single msg -> Query.Multiple msg
findInputs =
    Query.findAll [ Selector.tag "input" ]


findCards : Query.Single msg -> Query.Multiple msg
findCards =
    Query.findAll [ Selector.class "form-card" ]


noAddonOptions : List (RadioCardGroup.Option Option)
noAddonOptions =
    [ RadioCardGroup.option
        { value = Home
        , text = Just "Home - description"
        , title = Just "Home - title"
        , addon = Nothing
        }
    , RadioCardGroup.option
        { value = Motor
        , text = Just "Motor - description"
        , title = Just "Motor - title"
        , addon = Nothing
        }
    ]


withImgAddonOptions : List (RadioCardGroup.Option Option)
withImgAddonOptions =
    [ RadioCardGroup.option
        { value = Home
        , text = Just "Home - description"
        , title = Just "Home - title"
        , addon = RadioCardGroup.imgAddon "/home.svg"
        }
    , RadioCardGroup.option
        { value = Motor
        , text = Just "Motor - description"
        , title = Just "Motor - title"
        , addon = RadioCardGroup.imgAddon "/car.svg"
        }
    ]


withIconAddonOptions : List (RadioCardGroup.Option Option)
withIconAddonOptions =
    [ RadioCardGroup.option
        { value = Home
        , text = Just "Home - description"
        , title = Just "Home - title"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    , RadioCardGroup.option
        { value = Motor
        , text = Just "Motor - description"
        , title = Just "Motor - title"
        , addon = RadioCardGroup.iconAddon IconSet.Car
        }
    ]


withTextAddonOptions : List (RadioCardGroup.Option Option)
withTextAddonOptions =
    [ RadioCardGroup.option
        { value = Home
        , text = Just "Home - description"
        , title = Just "Home - title"
        , addon = RadioCardGroup.textAddon "1.000,00"
        }
    , RadioCardGroup.option
        { value = Motor
        , text = Just "Motor - description"
        , title = Just "Motor - title"
        , addon = RadioCardGroup.textAddon "1.000,00"
        }
    ]


radioCardGroupConfig : List (RadioCardGroup.Option Option) -> RadioCardGroup.Config Option
radioCardGroupConfig options =
    RadioCardGroup.config "area"
        |> RadioCardGroup.withOptions options


renderRadioCardGroup : RadioCardGroup.Config Option -> Query.Single (RadioCardGroup.Msg Option)
renderRadioCardGroup =
    RadioCardGroup.render identity () (RadioCardGroup.init validation)
        >> Query.fromHtml


simulationWithValidation : Simulation.Simulation (RadioCardGroup.Model () Option Option) (RadioCardGroup.Msg Option)
simulationWithValidation =
    Simulation.fromSandbox
        { init = RadioCardGroup.init validation
        , update = \subMsg model -> RadioCardGroup.update subMsg model
        , view = \model -> RadioCardGroup.render identity () model (radioCardGroupConfig noAddonOptions)
        }


validation : ctx -> Maybe Option -> Result String Option
validation _ value =
    case value of
        Nothing ->
            Err "Required"

        Just x ->
            Ok x


simulateEvents :
    String
    -> Simulation.Simulation (RadioCardGroup.Model () Option Option) (RadioCardGroup.Msg Option)
    -> Simulation.Simulation (RadioCardGroup.Model () Option Option) (RadioCardGroup.Msg Option)
simulateEvents testId simulation =
    simulation
        |> Simulation.simulate ( Event.check True, [ Selector.attribute (CommonsAttributes.testId testId) ] )
