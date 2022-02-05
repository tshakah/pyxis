module Examples.Quotation.Step1 exposing
    ( AniaResponse
    , Model
    , Msg
    , ParsedData
    , init
    , update
    , view
    )

import Components.Button as Btn
import Components.Input as Input exposing (Input)
import Date exposing (Date)
import Examples.Quotation.Month.Extra as Month
import Examples.Quotation.Plate as Plate exposing (Plate)
import Examples.Quotation.Validations as Validations
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
import Http
import PipeValidation
import Process
import Task
import Time
import Validation exposing (Validation)
import Validation.Int
import Validation.String



-- Fields validations


plateFieldValidation : Validation String Plate
plateFieldValidation =
    Validations.requiredFieldValidation
        >> Result.andThen (Validation.fromMaybe "La targa inserita non sembra essere valida." Plate.fromString)


type alias Model =
    { plate : Input.Model Plate
    , birthDate : Input.Model Date

    -- Other data
    , isSubmitted : Bool
    , waitingResponse : Bool
    , today : Date
    }


type alias ParsedData =
    { plate : Plate
    , birthDate : Date
    }


dateValidation : String -> Result String Date
dateValidation =
    Date.fromIsoString >> Result.mapError (\_ -> "La data inserita non è valida")


dateFieldValidation : Date -> Validation String Date
dateFieldValidation today =
    let
        check25YearsOld date =
            (Date.year today - Date.year date) >= 25

        checkDateIsNotFuture date =
            Date.year today >= Date.year date

        checkMinYear date =
            Date.year date >= 1920
    in
    Validations.requiredFieldValidation
        >> Result.andThen dateValidation
        >> Result.andThen (Validation.fromPredicate checkDateIsNotFuture "Hai inserito una data futura")
        >> Result.andThen (Validation.fromPredicate check25YearsOld "Devi avere almeno 25 anni")
        >> Result.andThen (Validation.fromPredicate checkMinYear "L'anno inserito non è valido")


init : Date -> Model
init today =
    { plate = Input.empty plateFieldValidation
    , birthDate = Input.empty (dateFieldValidation today)
    , isSubmitted = False
    , waitingResponse = False
    , today = today
    }


type Msg
    = PlateInput Input.Msg
    | BirthDateInput Input.Msg
    | Submit
    | GotResponse ParsedData (Result Http.Error AniaResponse)


plateInputMask : String -> Maybe String
plateInputMask =
    String.toUpper >> Just


validateForm : Model -> Maybe ParsedData
validateForm =
    PipeValidation.succeed ParsedData
        |> PipeValidation.input .plate
        |> PipeValidation.input .birthDate


update : Msg -> Model -> ( Model, Cmd Msg, Maybe ( ParsedData, AniaResponse ) )
update msg model =
    case msg of
        PlateInput subMsg ->
            ( { model | plate = Input.enhanceUpdateWithMask plateInputMask Input.update subMsg model.plate }, Cmd.none, Nothing )

        BirthDateInput subMsg ->
            ( { model | birthDate = Input.update subMsg model.birthDate }, Cmd.none, Nothing )

        GotResponse _ (Err _) ->
            -- TODO show error in ui
            ( model, Cmd.none, Nothing )

        GotResponse formData (Ok aniaResponse) ->
            ( model, Cmd.none, Just ( formData, aniaResponse ) )

        Submit ->
            case validateForm model of
                Nothing ->
                    ( { model | isSubmitted = True }, Cmd.none, Nothing )

                Just formData ->
                    ( { model | waitingResponse = True }
                    , sendToServer (GotResponse formData) formData
                    , Nothing
                    )



-- View


view : Model -> Html Msg
view model =
    Html.form [ class "space-y", Html.Events.onSubmit Submit ]
        [ Input.text
            |> Input.withIsSubmitted model.isSubmitted
            |> Input.withPlaceholder "AB123CD"
            |> Input.withMaxLength 7
            |> Input.render model.plate PlateInput
            |> viewFormItem "Targa"
        , Input.date
            |> Input.withIsSubmitted model.isSubmitted
            |> Input.render model.birthDate BirthDateInput
            |> viewFormItem "Data di nascita"
        , Btn.primary
            |> Btn.withText "Calcola"
            |> Btn.withType Btn.submit
            |> Btn.withDisabled model.waitingResponse
            |> Btn.render
        ]


viewFormItem : String -> Html msg -> Html msg
viewFormItem str input =
    Html.div [ class "form-item" ]
        [ Html.label [ class "form-label" ] [ Html.text str ]
        , input
        ]


type alias AniaResponse =
    { id : Int
    }


sendToServer : (Result Http.Error AniaResponse -> msg) -> ParsedData -> Cmd msg
sendToServer toMsg _ =
    let
        exampleResponse =
            { id = 0
            }
    in
    Task.perform (\_ -> toMsg (Ok exampleResponse)) (Process.sleep 400)
