module Examples.Quotation.Step1 exposing
    ( Model
    , Msg
    , ParsedData
    , init
    , update
    , view
    )

import Components.Button as Btn
import Components.Input as Input
import Date exposing (Date)
import Examples.Quotation.Month.Extra as Month
import Examples.Quotation.Plate as Plate exposing (Plate)
import Examples.Quotation.Validations as Validations
import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events
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


dayValidation : Validation String Int
dayValidation =
    Validations.requiredFieldValidation
        >> Result.andThen (Validation.String.toInt "Il giorno inserito non è valido")


monthValidation : String -> Result String Time.Month
monthValidation =
    let
        errorMessage =
            "Il mese inserito non è valido"
    in
    Validations.requiredFieldValidation
        >> Result.andThen (Validation.String.toInt errorMessage)
        >> Result.andThen (Validation.fromMaybe errorMessage Month.fromInt)


yearValidation : String -> Result String Int
yearValidation =
    let
        label =
            "L'anno inserito non è valido"
    in
    Validations.requiredFieldValidation
        >> Result.andThen (Validation.String.toInt label)
        -- TODO max
        >> Result.andThen (Validation.Int.min 1920 label)


type alias Model =
    { plate : Input.Model Plate
    , birthDay : Input.Model Int
    , birthMonth : Input.Model Time.Month
    , birthYear : Input.Model Int

    -- Other data
    , isSubmitted : Bool
    , today : Date
    }


type alias ParsedData =
    { plate : Plate
    , birthDate : Date
    }


validateBirthDate : Model -> Maybe Date
validateBirthDate =
    PipeValidation.succeed Date.fromCalendarDate
        |> PipeValidation.input .birthYear
        |> PipeValidation.input .birthMonth
        |> PipeValidation.input .birthDay


validateForm : Model -> Maybe ParsedData
validateForm =
    PipeValidation.succeed ParsedData
        |> PipeValidation.input .plate
        |> PipeValidation.maybe validateBirthDate


init : Date -> Model
init today =
    { plate = Input.empty plateFieldValidation
    , birthDay = Input.empty dayValidation
    , birthMonth = Input.empty monthValidation
    , birthYear = Input.empty yearValidation
    , isSubmitted = False
    , today = today
    }


type Msg
    = PlateInput Input.Msg
    | BirthDayInput Input.Msg
    | BirthMonthInput Input.Msg
    | BirthYearInput Input.Msg
    | Submit


{-| The final data structure we want to parse when submitting the form
-}
type alias FormData =
    { plate : Plate
    }


parseForm : Model -> Maybe FormData
parseForm =
    PipeValidation.succeed FormData
        |> PipeValidation.input .plate


updatePlate : Input.Msg -> Input.Model data -> Input.Model data
updatePlate =
    Input.update |> Input.enhanceUpdateWithMask (String.toUpper >> Just)


baseUpdate : Msg -> Model -> ( Model, Cmd Msg )
baseUpdate msg model =
    case msg of
        PlateInput subMsg ->
            ( { model | plate = updatePlate subMsg model.plate }, Cmd.none )

        BirthDayInput subMsg ->
            ( { model | birthDay = Input.update subMsg model.birthDay }, Cmd.none )

        BirthMonthInput subMsg ->
            ( { model | birthMonth = Input.update subMsg model.birthMonth }, Cmd.none )

        BirthYearInput subMsg ->
            ( { model | birthYear = Input.update subMsg model.birthYear }, Cmd.none )

        Submit ->
            ( { model | isSubmitted = True }
            , case parseForm model of
                Nothing ->
                    Cmd.none

                Just data ->
                    Cmd.none
            )


validDateMultiValidation : String -> Model -> Maybe (Result String ())
validDateMultiValidation self =
    PipeValidation.succeed
        (\today ->
            if True then
                Ok ()

            else
                Err "Passwords do not match"
        )
        |> PipeValidation.field .today


afterUpdate : (Model -> Model) -> (Msg -> Model -> ( Model, eff )) -> Msg -> Model -> ( Model, eff )
afterUpdate mapper update_ msg model =
    let
        ( newModel, cmd ) =
            update_ msg model
    in
    ( mapper newModel, cmd )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    baseUpdate
        |> afterUpdate (\m -> m)



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
        , Html.hr [] []
        , Input.number
            |> Input.withIsSubmitted model.isSubmitted
            |> Input.withPlaceholder "GG"
            |> Input.withMaxLength 2
            |> Input.withNumberMin 1
            |> Input.withNumberMax 31
            |> Input.render model.birthDay BirthDayInput
            |> viewFormItem "Giorno di nascita"
        , Input.number
            |> Input.withIsSubmitted model.isSubmitted
            |> Input.withPlaceholder "MM"
            |> Input.withMaxLength 2
            |> Input.withNumberMin 1
            |> Input.withNumberMax 31
            |> Input.render model.birthMonth BirthMonthInput
            |> viewFormItem "Mese di nascita"
        , Input.number
            |> Input.withIsSubmitted model.isSubmitted
            |> Input.withPlaceholder "YYYY"
            |> Input.withMaxLength 4
            |> Input.withNumberMin 1922
            |> Input.render model.birthYear BirthYearInput
            |> viewFormItem "Anno di nascita"
        , Btn.primary
            |> Btn.withText "Calcola"
            |> Btn.withType Btn.submit
            |> Btn.render
        ]


viewFormItem : String -> Html msg -> Html msg
viewFormItem str input =
    Html.div [ class "form-item" ]
        [ Html.label [ class "form-label" ] [ Html.text str ]
        , input
        ]


mockApiRequest : (() -> msg) -> Cmd msg
mockApiRequest msg =
    Task.perform msg (Process.sleep 1000)
