module Components.RadioGroupTest exposing (suite)

import Commons.Attributes as CA
import Components.Field.RadioGroup as RadioGroup
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
    = M
    | F
    | Default


type Msg
    = Tagger (RadioGroup.Msg Option)


suite : Test
suite =
    Test.describe "The RadioGroup component"
        [ Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    radioGroupConfig
                        |> renderRadioGroup
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled False ])
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    radioGroupConfig
                        |> RadioGroup.withDisabled b
                        |> renderRadioGroup
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled b ])
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                radioGroupConfig
                    |> RadioGroup.withName name
                    |> renderRadioGroup
                    |> findInputs
                    |> Query.each
                        (Query.has
                            [ Selector.attribute (Html.Attributes.name name)
                            ]
                        )
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    radioGroupConfig
                        |> RadioGroup.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderRadioGroup
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
                    radioGroupConfig
                        |> RadioGroup.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> RadioGroup.withClassList [ ( s3, True ) ]
                        |> renderRadioGroup
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
                    radioGroupConfig
                        |> RadioGroup.withVerticalLayout True
                        |> renderRadioGroup
                        |> Query.has
                            [ Selector.classes [ "form-control-group--column" ]
                            ]
            ]
        , Test.describe "Validation"
            [ Test.test "should pass initially if no validation is applied" <|
                \() ->
                    radioGroupModel
                        |> RadioGroup.getValidatedValue {}
                        |> Expect.equal (Ok Default)
            , Test.test "should pass for every input if no validation is applied" <|
                \() ->
                    simulationWithoutValidation
                        |> simulateEvents "gender-male-option"
                        |> Simulation.expectModel (RadioGroup.getValidatedValue {} >> Expect.equal (Ok M))
                        |> Simulation.run
            , Test.test "should not pass if the input is not compliant with the validation function" <|
                \() ->
                    simulationWithValidation
                        |> Simulation.expectModel (RadioGroup.getValidatedValue {} >> Expect.equal (Err "Required"))
                        |> Simulation.expectHtml (Query.find [ Selector.id "gender-error" ] >> Query.contains [ Html.text "Required" ])
                        |> Simulation.run
            ]
        , Test.describe "Events"
            [ Test.test "input should update the model value" <|
                \() ->
                    simulationWithValidation
                        |> simulateEvents "gender-male-option"
                        |> Simulation.expectModel (RadioGroup.getValue >> Expect.equal M)
                        |> Simulation.run
            ]
        ]


findInputs : Query.Single msg -> Query.Multiple msg
findInputs =
    Query.findAll [ Selector.tag "input" ]


radioOptions : List (RadioGroup.Option Option)
radioOptions =
    [ RadioGroup.option { value = M, label = "Male" }
    , RadioGroup.option { value = F, label = "Female" }
    ]


radioGroupModel : RadioGroup.Model Option ctx
radioGroupModel =
    RadioGroup.init Default


radioGroupConfig : RadioGroup.Configuration Option
radioGroupConfig =
    RadioGroup.config "gender"
        |> RadioGroup.withOptions radioOptions


renderRadioGroup : RadioGroup.Configuration Option -> Query.Single Msg
renderRadioGroup =
    RadioGroup.render Tagger radioGroupModel
        >> Query.fromHtml


simulationWithoutValidation : Simulation.Simulation (RadioGroup.Model Option {}) (RadioGroup.Msg Option)
simulationWithoutValidation =
    Simulation.fromSandbox
        { init = RadioGroup.init Default
        , update = RadioGroup.update {}
        , view = \model -> RadioGroup.render identity model radioGroupConfig
        }


simulationWithValidation : Simulation.Simulation (RadioGroup.Model Option {}) (RadioGroup.Msg Option)
simulationWithValidation =
    Simulation.fromSandbox
        { init =
            radioGroupModel
                |> RadioGroup.withValidation
                    (\_ value ->
                        if value == Default then
                            Err "Required"

                        else
                            Ok value
                    )
                |> RadioGroup.validate {}
        , update = RadioGroup.update {}
        , view = \model -> RadioGroup.render identity model radioGroupConfig
        }


simulateEvents : String -> Simulation.Simulation model msg -> Simulation.Simulation model msg
simulateEvents testId simulation =
    simulation
        |> Simulation.simulate ( Event.check True, [ Selector.attribute (CA.testId testId) ] )
