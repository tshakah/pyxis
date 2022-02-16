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
                    radioGroupModel
                        |> renderModel
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled False ])
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    radioGroupModel
                        |> RadioGroup.withDisabled b
                        |> renderModel
                        |> findInputs
                        |> Query.each (Query.has [ Selector.disabled b ])
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                radioGroupModel
                    |> RadioGroup.withName name
                    |> renderModel
                    |> findInputs
                    |> Query.each
                        (Query.has
                            [ Selector.attribute (Html.Attributes.name name)
                            ]
                        )
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    radioGroupModel
                        |> RadioGroup.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderModel
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
                    radioGroupModel
                        |> RadioGroup.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> RadioGroup.withClassList [ ( s3, True ) ]
                        |> renderModel
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
                    radioGroupModel
                        |> RadioGroup.withVerticalLayout True
                        |> renderModel
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


radioGroupModel : RadioGroup.Model Option ctx Msg
radioGroupModel =
    RadioGroup.create "gender" Tagger Default
        |> RadioGroup.withOptions radioOptions


renderModel : RadioGroup.Model Option ctx Msg -> Query.Single Msg
renderModel model =
    model
        |> RadioGroup.withOptions radioOptions
        |> RadioGroup.render
        |> Query.fromHtml


simulationWithoutValidation : Simulation.Simulation (RadioGroup.Model Option {} (RadioGroup.Msg Option)) (RadioGroup.Msg Option)
simulationWithoutValidation =
    Simulation.fromSandbox
        { init = RadioGroup.create "gender" identity Default |> RadioGroup.withOptions radioOptions
        , update = RadioGroup.update {}
        , view = RadioGroup.render
        }


simulationWithValidation : Simulation.Simulation (RadioGroup.Model Option {} (RadioGroup.Msg Option)) (RadioGroup.Msg Option)
simulationWithValidation =
    Simulation.fromSandbox
        { init =
            RadioGroup.create "gender" identity Default
                |> RadioGroup.withOptions radioOptions
                |> RadioGroup.withValidation
                    (\_ value ->
                        if value == Default then
                            Err "Required"

                        else
                            Ok value
                    )
                |> RadioGroup.validate {}
        , update = RadioGroup.update {}
        , view = RadioGroup.render
        }


simulateEvents : String -> Simulation.Simulation model msg -> Simulation.Simulation model msg
simulateEvents testId simulation =
    simulation
        |> Simulation.simulate ( Event.check True, [ Selector.attribute (CA.testId testId) ] )
