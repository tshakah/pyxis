module Components.Field.AutocompleteTest exposing (suite)

import Commons.Properties.Size as Size
import Components.Field.Autocomplete as Autocomplete
import Components.Field.Label as Label
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
        , Test.describe "Update"
            [ Test.test "Inputting a given option should update the model" <|
                \() ->
                    simulation
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


render : Autocomplete.Config Job (Autocomplete.Msg Job) -> Query.Single (Autocomplete.Msg Job)
render =
    Autocomplete.render identity () init >> Query.fromHtml


validation : Maybe Job -> Result String Job
validation maybeJob =
    maybeJob
        |> Maybe.map Ok
        |> Maybe.withDefault (Err "Select a job.")


simulation : Simulation (Autocomplete.Model () Job) (Autocomplete.Msg Job)
simulation =
    Simulation.fromElement
        { init =
            ( Autocomplete.init Nothing (always validation)
                |> Autocomplete.setOptions (RemoteData.Success [ Developer, Designer, ProductManager ])
            , Cmd.none
            )
        , update = \msg model -> ( Autocomplete.update msg model, Cmd.none )
        , view = \model -> Autocomplete.render identity () model (config "autocomplete-id")
        }
