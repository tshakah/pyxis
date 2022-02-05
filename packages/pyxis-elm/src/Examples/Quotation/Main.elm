module Examples.Quotation.Main exposing (main)

import Browser
import Date exposing (Date)
import Examples.Quotation.Step1 as Step1
import Html exposing (Html)
import Task
import Time


type Step
    = Initial
    | Step1 Step1.Model


type alias Model =
    { step : Step
    }


type Msg
    = GotToday Date
    | Step1Msg Step1.Msg


init : () -> ( Model, Cmd Msg )
init () =
    ( { step = Initial
      }
    , Task.perform GotToday getToday
    )


update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
    case ( model.step, msg ) of
        ( Initial, GotToday today ) ->
            ( { model | step = Step1 (Step1.init today) }
            , Cmd.none
            )

        ( Step1 subModel, Step1Msg subMsg ) ->
            let
                ( newModel, _ ) =
                    Step1.update subMsg subModel
            in
            ( { model | step = Step1 newModel }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )


getToday : Task.Task Never Date
getToday =
    Task.map2 Date.fromPosix Time.here Time.now


view : Model -> Html Msg
view model =
    case model.step of
        Initial ->
            Html.text ""

        Step1 subModel ->
            Html.map Step1Msg (Step1.view subModel)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
