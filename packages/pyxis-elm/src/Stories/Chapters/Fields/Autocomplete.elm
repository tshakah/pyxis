module Stories.Chapters.Fields.Autocomplete exposing (Model, docs, init)

import Components.Field.Autocomplete as Autocomplete
import Components.Field.Label as Label
import ElmBook
import ElmBook.Actions
import ElmBook.Chapter
import Html exposing (Html)
import PrimaFunction
import RemoteData


docs : ElmBook.Chapter.Chapter (SharedState x)
docs =
    "Autocomplete"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withStatefulComponentList componentsList
        |> ElmBook.Chapter.render """
Autocomplete is used to search data across both predefined and dynamic data source.
It allows you to handle your data via a generic _value_.

Data is provided by the user so autocomplete only handles its logic without executing a query o reading a datasource.

<component with-label="Autocomplete" />
```
{-| Provide your data type the way its best represented.
-}
type Job
    = Developer
    | Designer
    | ProductManager

{-| Provide your own filter function.
-}
jobMatches : String -> Job -> Bool
jobMatches searchTerm =
    jobToLabel >> String.toLower >> String.contains (String.toLower searchTerm)

{-| Provide a way to get a label from your value.
-}
jobToLabel : Job -> String
jobToLabel job =
    case job of
        Developer ->
            "Developer"
        Designer ->
            "Designer"
        ProductManager ->
            "ProductManager"


{-| Define your application message.
-}
type Msg
    = JobFetched (RemoteData Http.Error (List Job))
    | JobChanged (Autocomplete.Msg Job)

{-| Define your model.
-}
type alias Model = {
        job : Autocomplete.Model () Job
    }

initialModel : Model
initialModel =
    Data { job = Autocomplete.init Nothing (always (Result.fromMaybe "")) }


{-| The autocomplete receives suggestions from you representing them via a RemoteData wrapper.
Setting suggestions is up to you.
-}
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        JobFetched remoteData ->
            ({ model | job = Autocomplete.setSuggestion remoteData model.job }, Cmd.none)

        JobChanged subMsg ->
            ({ model | job = Autocomplete.update subMsg model.autocomplete })

{-| Render your autocomplete.
-}
view : Model -> Html Msg
view model =
    Autocomplete.config jobMatches jobToLabel "autocomplete-id"
        |> Autocomplete.withPlaceholder "Choose your job role"
        |> Autocomplete.render JobChanged () model.job

```
"""


type alias SharedState x =
    { x | autocomplete : Model }


type Job
    = Developer
    | Designer
    | ProductManager


type alias Model =
    Autocomplete.Model () Job


init : Model
init =
    Autocomplete.init Nothing (always (Result.fromMaybe ""))


jobToLabel : Job -> String
jobToLabel job =
    case job of
        Developer ->
            "Developer"

        Designer ->
            "Designer"

        ProductManager ->
            "Product manager"


componentsList : List ( String, SharedState x -> Html (ElmBook.Msg (SharedState x)) )
componentsList =
    [ ( "Autocomplete"
      , statefulComponent (Autocomplete.withLabel (Label.config "Label"))
      )
    ]


type alias ConfigMapper =
    Autocomplete.Config Job (Autocomplete.Msg Job) -> Autocomplete.Config Job (Autocomplete.Msg Job)


update : Autocomplete.Msg Job -> Model -> ( Model, Cmd (Autocomplete.Msg Job) )
update msg model =
    ( Autocomplete.update msg model
        |> PrimaFunction.ifThenMap (always (Autocomplete.isOnInput msg))
            (Autocomplete.setOptions (RemoteData.Success [ Designer, Developer, ProductManager ]))
    , Cmd.none
    )


statefulComponent :
    ConfigMapper
    -> SharedState x
    -> Html (ElmBook.Msg (SharedState x))
statefulComponent mapper sharedState =
    Autocomplete.config
        (\filter value -> String.contains (String.toLower filter) (String.toLower (jobToLabel value)))
        jobToLabel
        "autocomplete-config"
        |> mapper
        |> Autocomplete.render identity () sharedState.autocomplete
        |> Html.map
            (ElmBook.Actions.mapUpdateWithCmd
                { toState = \state model -> { state | autocomplete = model }
                , fromState = .autocomplete
                , update = update
                }
            )
