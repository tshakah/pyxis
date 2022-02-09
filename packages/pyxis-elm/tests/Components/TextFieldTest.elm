module Components.TextFieldTest exposing (suite)

import Commons.Properties.Placement as Placement
import Components.Field.Text as TextField
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes, tag)
import Test.Simulation as Simulation
import Validations


type Msg
    = Tagger TextField.Msg


suite : Test
suite =
    Test.describe "The TextField component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    textFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    textFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    textFieldModel
                        |> TextField.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                textFieldModel
                    |> TextField.withName name
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                textFieldModel
                    |> TextField.withPlaceholder p
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    textFieldModel
                        |> TextField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderModel
                        |> findInput
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
                    textFieldModel
                        |> TextField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> TextField.withClassList [ ( s3, True ) ]
                        |> renderModel
                        |> findInput
                        |> Expect.all
                            [ Query.hasNot
                                [ Selector.classes [ s1, s2 ]
                                ]
                            , Query.has
                                [ Selector.classes [ s3 ]
                                ]
                            ]
            , let
                textAddon =
                    "Currency"
              in
              Test.describe "Addon"
                [ Test.describe "Should render the right class"
                    [ Test.describe "Icon addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                textFieldModel
                                    |> TextField.withAddon Placement.append (TextField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                textFieldModel
                                    |> TextField.withAddon Placement.prepend (TextField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        ]
                    , Test.describe "Text addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                textFieldModel
                                    |> TextField.withAddon Placement.append (TextField.textAddon textAddon)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text textAddon
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                textFieldModel
                                    |> TextField.withAddon Placement.prepend (TextField.textAddon textAddon)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text textAddon
                                        ]
                        ]
                    ]
                ]
            ]
        , Test.describe "Validation"
            [ Test.test "should pass initially if no validation is applied" <|
                \() ->
                    textFieldModel
                        |> TextField.getValidatedValue ()
                        |> Expect.equal (Ok "")
            , Test.fuzz Fuzz.string "should pass for every input if no validation is applied" <|
                \str ->
                    simulationWithoutValidation
                        |> simulateEvents str
                        |> Simulation.expectModel (TextField.getValidatedValue () >> Expect.equal (Ok str))
                        |> Simulation.run
            , Test.test "should not pass initially with `notEmptyValidation` applied" <|
                \() ->
                    textFieldModel
                        |> TextField.withValidation (\_ -> Validations.notEmptyValidation)
                        |> TextField.getValidatedValue ()
                        |> Expect.equal (Err "Required field")
            , Test.test "should not pass if the input str is not compliant to validation func" <|
                \() ->
                    simulationWithValidation
                        |> simulateEvents "this is lower"
                        |> Simulation.expectModel (TextField.getValidatedValue () >> Expect.equal (Err "String must be uppercase"))
                        |> Simulation.expectHtml (Query.contains [ Html.text "String must be uppercase" ])
                        |> Simulation.run
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.string "input should update the model value" <|
                \str ->
                    simulationWithValidation
                        |> simulateEvents str
                        |> Simulation.expectModel (TextField.getValue >> Expect.equal str)
                        |> Simulation.run
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


textFieldModel : TextField.Model ctx Msg
textFieldModel =
    TextField.text Tagger "input-id"


renderModel : TextField.Model ctx msg -> Query.Single msg
renderModel model =
    model
        |> TextField.render
        |> Query.fromHtml


simulationWithoutValidation : Simulation.Simulation (TextField.Model () TextField.Msg) TextField.Msg
simulationWithoutValidation =
    Simulation.fromSandbox
        { init = TextField.text identity "input-id"
        , update = TextField.update ()
        , view = TextField.render
        }


simulationWithValidation : Simulation.Simulation (TextField.Model () TextField.Msg) TextField.Msg
simulationWithValidation =
    Simulation.fromSandbox
        { init =
            TextField.text identity "input-id"
                |> TextField.withValidation (\() -> Validations.isUppercaseValidation)
        , update = TextField.update ()
        , view = TextField.render
        }


simulateEvents : String -> Simulation.Simulation model msg -> Simulation.Simulation model msg
simulateEvents str simulation =
    simulation
        |> Simulation.simulate ( Event.focus, [ Selector.tag "input" ] )
        |> Simulation.simulate ( Event.input str, [ Selector.tag "input" ] )
        |> Simulation.simulate ( Event.blur, [ Selector.tag "input" ] )
