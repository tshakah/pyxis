module Components.Field.TextareaTest exposing (suite)

import Commons.Properties.Size as Size
import Components.Field.Textarea as Textarea
import Expect
import Fuzz
import Html
import Html.Attributes as Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes, tag)
import Test.Simulation as Simulation
import Validations


type Msg
    = OnTextareaMsg Textarea.Msg


suite : Test
suite =
    Test.describe "The Textarea component"
        [ Test.describe "Default"
            [ Test.test "the textarea has an id and a data-test-id" <|
                \() ->
                    textareaModel
                        |> renderModel
                        |> findTextarea
                        |> Query.has
                            [ attribute (Attributes.id "textarea-id")
                            , attribute (Attributes.attribute "data-test-id" "textarea-id")
                            , classes [ "form-field__textarea" ]
                            ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    textareaModel
                        |> renderModel
                        |> findTextarea
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    textareaModel
                        |> Textarea.withDisabled b
                        |> renderModel
                        |> findTextarea
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                textareaModel
                    |> Textarea.withName name
                    |> renderModel
                    |> findTextarea
                    |> Query.has
                        [ Selector.attribute (Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                textareaModel
                    |> Textarea.withPlaceholder p
                    |> renderModel
                    |> findTextarea
                    |> Query.has
                        [ Selector.attribute (Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    textareaModel
                        |> Textarea.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderModel
                        |> findTextarea
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
                    textareaModel
                        |> Textarea.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> Textarea.withClassList [ ( s3, True ) ]
                        |> renderModel
                        |> findTextarea
                        |> Expect.all
                            [ Query.hasNot
                                [ Selector.classes [ s1, s2 ]
                                ]
                            , Query.has
                                [ Selector.classes [ s3 ]
                                ]
                            ]
            ]
        , Test.describe "Size"
            [ Test.test "should render the correct size class" <|
                \() ->
                    textareaModel
                        |> Textarea.withSize Size.small
                        |> renderModel
                        |> findTextarea
                        |> Query.has
                            [ Selector.class "form-field__textarea--small"
                            ]
            ]
        , Test.describe "Validation"
            [ Test.test "should pass initially if no validation is applied" <|
                \() ->
                    textareaModel
                        |> Textarea.getValidatedValue ()
                        |> Expect.equal (Ok "")
            , Test.fuzz Fuzz.string "should pass for every input if no validation is applied" <|
                \str ->
                    simulationWithoutValidation
                        |> simulateEvents str
                        |> Simulation.expectModel (Textarea.getValidatedValue () >> Expect.equal (Ok str))
                        |> Simulation.run
            , Test.test "should not pass initially with `notEmptyValidation` applied" <|
                \() ->
                    textareaModel
                        |> Textarea.withValidation (\_ -> Validations.notEmptyValidation)
                        |> Textarea.getValidatedValue ()
                        |> Expect.equal (Err "Required field")
            , Test.test "should not pass if the input str is not compliant to validation func" <|
                \() ->
                    simulationWithValidation
                        |> simulateEvents "this is lower"
                        |> Simulation.expectModel (Textarea.getValidatedValue () >> Expect.equal (Err "String must be uppercase"))
                        |> Simulation.expectHtml (Query.contains [ Html.text "String must be uppercase" ])
                        |> Simulation.run
            ]
        ]


findTextarea : Query.Single msg -> Query.Single msg
findTextarea =
    Query.find [ tag "textarea" ]


textareaModel : Textarea.Model ctx Msg
textareaModel =
    Textarea.create OnTextareaMsg "textarea-id"


renderModel : Textarea.Model ctx msg -> Query.Single msg
renderModel model =
    model
        |> Textarea.render
        |> Query.fromHtml


simulationWithoutValidation : Simulation.Simulation (Textarea.Model () Textarea.Msg) Textarea.Msg
simulationWithoutValidation =
    Simulation.fromSandbox
        { init = Textarea.create identity "input-id"
        , update = Textarea.update ()
        , view = Textarea.render
        }


simulationWithValidation : Simulation.Simulation (Textarea.Model () Textarea.Msg) Textarea.Msg
simulationWithValidation =
    Simulation.fromSandbox
        { init =
            Textarea.create identity "input-id"
                |> Textarea.withValidation (\() -> Validations.isUppercaseValidation)
        , update = Textarea.update ()
        , view = Textarea.render
        }


simulateEvents : String -> Simulation.Simulation model msg -> Simulation.Simulation model msg
simulateEvents str simulation =
    simulation
        |> Simulation.simulate ( Event.focus, [ Selector.tag "textarea" ] )
        |> Simulation.simulate ( Event.input str, [ Selector.tag "textarea" ] )
        |> Simulation.simulate ( Event.blur, [ Selector.tag "textarea" ] )
