module Components.Field.AutocompleteTest exposing (suite)

import Commons.Properties.Size as Size
import Components.Button as Button
import Components.Field.Autocomplete as Autocomplete
import Components.Field.Label as Label
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html
import Html.Attributes
import RemoteData
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute)
import Test.Simulation as Simulation exposing (Simulation)


type Job
    = Developer
    | Designer
    | ProductManager


filterJobs : String -> Job -> Bool
filterJobs filter =
    getJobName >> String.contains filter


getJobName : Job -> String
getJobName job =
    case job of
        Developer ->
            "DEVELOPER"

        Designer ->
            "DESIGNER"

        ProductManager ->
            "PRODUCT_MANAGER"


suite : Test
suite =
    Test.describe "The Autocomplete component"
        [ Test.fuzz Fuzz.string "should set an additional content" <|
            \s ->
                config "autocomplete-id"
                    |> Autocomplete.withAdditionalContent (Html.span [] [ Html.text s ])
                    |> render
                    |> Query.find [ Selector.tag "span" ]
                    |> Query.has [ Selector.text s ]
        , Test.fuzz Fuzz.string "should set a disabled attribute" <|
            \s ->
                config "autocomplete-id"
                    |> Autocomplete.withDisabled True
                    |> render
                    |> findInput
                    |> Query.has [ Selector.attribute (Html.Attributes.disabled True) ]
        , Test.fuzz Fuzz.string "should add a label" <|
            \s ->
                config "autocomplete-id"
                    |> Autocomplete.withLabel (Label.config s)
                    |> render
                    |> Query.find
                        [ Selector.tag "label"
                        , Selector.class "form-label"
                        ]
                    |> Query.has [ Selector.text s ]
        , Test.fuzz Fuzz.string "should set a name attribute" <|
            \s ->
                config "autocomplete-id"
                    |> Autocomplete.withName s
                    |> render
                    |> findInput
                    |> Query.has [ Selector.attribute (Html.Attributes.name s) ]
        , Test.fuzz Fuzz.string "should set a placeholder attribute" <|
            \s ->
                config "autocomplete-id"
                    |> Autocomplete.withPlaceholder s
                    |> render
                    |> findInput
                    |> Query.has [ Selector.attribute (Html.Attributes.placeholder s) ]
        , Test.test "should set a size" <|
            \() ->
                config "autocomplete-id"
                    |> Autocomplete.withSize Size.small
                    |> render
                    |> findInput
                    |> Query.has [ Selector.class "form-field__autocomplete--small" ]
        , Test.test "Show the custom message when no result is found" <|
            \() ->
                config "autocomplete-id"
                    |> Autocomplete.withNoResultsFoundMessage "Nothing was found."
                    |> simulation
                    |> Simulation.simulate ( Event.input "Qwerty", [ Selector.tag "input" ] )
                    |> Simulation.expectHtml
                        (findDropdown >> Query.has [ Selector.text "Nothing was found." ])
                    |> Simulation.run
        , Test.describe "Addon"
            [ Test.test "Show action under no result message" <|
                \() ->
                    config "autocomplete-id"
                        |> Autocomplete.withAddonAction
                            (Button.ghost
                                |> Button.withText "Visit the page"
                                |> Button.withType (Button.link "https://www.google.com")
                                |> Button.render
                            )
                        |> simulation
                        |> Simulation.simulate ( Event.input "Qwerty", [ Selector.tag "input" ] )
                        |> Simulation.expectHtml
                            (findDropdown
                                >> Query.find [ Selector.class "form-dropdown__no-results__action" ]
                                >> Query.has [ Selector.text "Visit the page", Selector.attribute (Html.Attributes.href "https://www.google.com") ]
                            )
                        |> Simulation.run
            , Test.test "Prepend an header to the option list" <|
                \() ->
                    config "autocomplete-id"
                        |> Autocomplete.withAddonHeader "Choose a role:"
                        |> simulation
                        |> Simulation.simulate ( Event.input "D", [ Selector.tag "input" ] )
                        |> Simulation.expectHtml
                            (findDropdown
                                >> Query.find [ Selector.class "form-dropdown__header" ]
                                >> Query.has [ Selector.text "Choose a role:" ]
                            )
                        |> Simulation.run
            , Test.test "On focus the suggestion should be visible" <|
                \() ->
                    config "autocomplete-id"
                        |> Autocomplete.withAddonSuggestion { title = "Suggestion", subtitle = Just "Subtitle", icon = IconSet.Search }
                        |> render
                        |> findDropdown
                        |> Query.find [ Selector.class "form-dropdown__suggestion" ]
                        |> Query.has [ Selector.text "Suggestion", Selector.text "Subtitle" ]
            ]
        , Test.describe "Update"
            [ Test.test "Inputting a given option should update the model" <|
                \() ->
                    config "autocomplete-id"
                        |> simulation
                        |> Simulation.simulate ( Event.input "DEVELOPER", [ Selector.tag "input" ] )
                        |> Simulation.simulate ( Event.click, [ Selector.class "form-dropdown__item" ] )
                        |> Simulation.expectModel
                            (Expect.all
                                [ Autocomplete.validate () >> Expect.equal (Ok Developer)
                                ]
                            )
                        |> Simulation.run
            ]
        ]


config : String -> Autocomplete.Config Job (Autocomplete.Msg Job)
config =
    Autocomplete.config filterJobs getJobName


init : Autocomplete.Model () Job
init =
    Autocomplete.init Nothing (always validation)


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


findDropdown : Query.Single msg -> Query.Single msg
findDropdown =
    Query.find [ Selector.class "form-dropdown" ]


render : Autocomplete.Config Job (Autocomplete.Msg Job) -> Query.Single (Autocomplete.Msg Job)
render =
    Autocomplete.render identity () init >> Query.fromHtml


validation : Maybe Job -> Result String Job
validation maybeJob =
    maybeJob
        |> Maybe.map Ok
        |> Maybe.withDefault (Err "Select a job.")


simulation : Autocomplete.Config Job (Autocomplete.Msg Job) -> Simulation (Autocomplete.Model () Job) (Autocomplete.Msg Job)
simulation config_ =
    Simulation.fromElement
        { init =
            ( Autocomplete.init Nothing (always validation)
                |> Autocomplete.setOptions (RemoteData.Success [ Developer, Designer, ProductManager ])
            , Cmd.none
            )
        , update = \msg model -> ( Autocomplete.update msg model, Cmd.none )
        , view = \model -> Autocomplete.render identity () model config_
        }
