module Examples.Quotation.Step2 exposing
    ( Model
    , Msg
    , init
    , view
    )

import Examples.Quotation.Step1 as Step1
import Html exposing (Html)


type alias Model =
    {}


init : Step1.AniaResponse -> Step1.ParsedData -> Model
init _ _ =
    {}


type Msg
    = X


view : Model -> Html Msg
view _ =
    Html.text "TODO"
