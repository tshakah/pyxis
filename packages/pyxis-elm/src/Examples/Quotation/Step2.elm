module Examples.Quotation.Step2 exposing
    ( Model
    , Msg
    , ParsedData
    , init
    , update
    , view
    )

import Components.Button as Button
import Components.Input as Input
import Components.Select as Select
import Date exposing (Date)
import Email exposing (Email)
import Examples.Quotation.Common exposing (viewFormItem)
import Examples.Quotation.Entities.CivilStatus as CivilStatus exposing (CivilStatus)
import Examples.Quotation.Entities.Occupation as Occupation exposing (Occupation)
import Examples.Quotation.MockData as Mock
import Examples.Quotation.Step1 as Step1 exposing (AniaResponse)
import Examples.Quotation.Validations as Validations
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events exposing (onSubmit)
import PipeValidation
import Validation


emailFieldValidation : String -> Result String Email.Email
emailFieldValidation =
    Validations.requiredFieldValidation
        >> Result.andThen (Email.fromString "Inserire una email valida")


type alias ParsedData =
    { occupation : Occupation
    , civilStatus : CivilStatus
    , email : Email
    , phone : String
    }


parseForm : Model -> Maybe ParsedData
parseForm =
    PipeValidation.succeed ParsedData
        |> PipeValidation.maybe (.occupationSelect >> Maybe.andThen Occupation.fromString)
        |> PipeValidation.maybe (.civilStatusSelect >> Maybe.andThen CivilStatus.fromString)
        |> PipeValidation.input .emailInput
        |> PipeValidation.input .phoneInput


type alias Model =
    { occupationSelect : Maybe String
    , civilStatusSelect : Maybe String
    , emailInput : Input.Model Email
    , phoneInput : Input.Model String
    , licenceYear : Maybe String

    -- Other
    , aniaResponse : AniaResponse
    , parsedData : Step1.ParsedData
    , submitted : Bool
    }


init : { aniaResponse : Step1.AniaResponse, parsedData : Step1.ParsedData } -> Model
init { aniaResponse, parsedData } =
    { occupationSelect = Nothing
    , civilStatusSelect = Nothing
    , emailInput = Input.empty emailFieldValidation
    , phoneInput = Input.empty Validations.requiredFieldValidation
    , licenceYear = Nothing

    -- Other
    , aniaResponse = aniaResponse
    , parsedData = parsedData
    , submitted = False
    }


type Msg
    = SelectedJob String
    | SelectedCivilStatus String
    | SelectLicenceYear String
    | EmailInput Input.Msg
    | PhoneInput Input.Msg
    | Submit


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectedJob value ->
            ( { model | occupationSelect = Just value }, Cmd.none )

        SelectedCivilStatus value ->
            ( { model | civilStatusSelect = Just value }, Cmd.none )

        SelectLicenceYear value ->
            ( { model | licenceYear = Just value }, Cmd.none )

        EmailInput subMsg ->
            ( { model | emailInput = Input.update subMsg model.emailInput }, Cmd.none )

        PhoneInput subMsg ->
            ( { model | phoneInput = Input.update subMsg model.phoneInput }, Cmd.none )

        Submit ->
            case parseForm model of
                Nothing ->
                    ( { model | submitted = True }, Cmd.none )

                Just _ ->
                    -- TODO
                    ( model
                    , Cmd.none
                    )


licenceYears : Model -> List Int
licenceYears model =
    let
        birthYear =
            Date.year model.parsedData.birthDate

        currentYear =
            Date.year model.parsedData.today
    in
    List.range (birthYear + 18) currentYear


view : Model -> Html Msg
view model =
    Html.form [ class "space-y", onSubmit Submit ]
        [ viewFormItem "Professione"
            (Select.view
                { placeholder = "Seleziona lavoro"
                , onSelect = SelectedJob
                , options =
                    List.map (\occ -> Select.option { text = occ.label, value = Occupation.toString occ.id })
                        model.aniaResponse.occupations
                , currentValue = model.occupationSelect
                }
            )
        , viewFormItem "Stato civile"
            (Select.view
                { placeholder = "Stato civile"
                , onSelect = SelectedCivilStatus
                , options =
                    List.map (\occ -> Select.option { text = occ.label, value = CivilStatus.toString occ.id })
                        model.aniaResponse.civilsStatus
                , currentValue = model.civilStatusSelect
                }
            )
        , viewFormItem "Anno patente"
            (Select.view
                { placeholder = "Anno patente"
                , onSelect = SelectLicenceYear
                , options =
                    List.map (\year -> Select.option { text = String.fromInt year, value = String.fromInt year })
                        (licenceYears model)
                , currentValue = model.licenceYear
                }
            )
        , viewFormItem "Email"
            (Input.email
                |> Input.withPlaceholder "example@example.com"
                |> Input.render model.emailInput EmailInput
            )
        , viewFormItem "Numero cellulare"
            (Input.text
                |> Input.render model.phoneInput PhoneInput
            )
        , Button.primary
            |> Button.withType Button.submit
            |> Button.withText "Richiedi preventivo"
            |> Button.render
        ]
