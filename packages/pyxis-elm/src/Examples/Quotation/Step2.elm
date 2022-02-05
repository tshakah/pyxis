module Examples.Quotation.Step2 exposing
    ( Model
    , Msg
    , init
    , update
    , view
    )

import Components.Select as Select
import Examples.Quotation.Entities.Occupation as Occupation
import Examples.Quotation.MockData as Mock
import Examples.Quotation.Step1 as Step1
import Html exposing (Html)
import Html.Attributes exposing (class)


type alias Model =
    { jobSelect : Maybe String
    , occupations : List Mock.Occupation
    }


init : Step1.AniaResponse -> Step1.ParsedData -> Model
init { occupations } _ =
    { jobSelect = Nothing
    , occupations = occupations
    }


type Msg
    = SelectedJob String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectedJob value ->
            ( { model | jobSelect = Just value }, Cmd.none )


view : Model -> Html Msg
view model =
    Html.div [ class "form-field" ]
        [ Select.view
            { placeholder = "Seleziona lavoro"
            , onSelect = SelectedJob
            , options =
                List.map (\occ -> Select.option { text = occ.label, value = Occupation.toString occ.id })
                    model.occupations
            , currentValue = model.jobSelect
            }
        ]
