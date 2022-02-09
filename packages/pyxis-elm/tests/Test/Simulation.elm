module Test.Simulation exposing
    ( Simulation
    , expectHtml
    , expectModel
    , fromSandbox
    , run
    , simulate
    , simulateBy
    , triggerMsg
    )

{-| Experimental testing utility

    A simple wrapper over an elm { init, update, view } record useful to perform the following steps::

    1. render the view from the current model
    2. trigger a message from a vdom event
    3. run the message over the update function and generate a new model
    4. (repeat)

-}

import Expect
import Html exposing (Html)
import Json.Encode exposing (Value)
import Test.Html.Event as Event exposing (Event)
import Test.Html.Query as Query
import Test.Html.Selector exposing (Selector)


type alias App model msg =
    { update : msg -> model -> model
    , view : model -> Html msg
    }


type alias State_ model msg =
    { modelResult : Result String model
    , expectations : List (() -> Expect.Expectation)
    , app : App model msg
    }


type Simulation model msg
    = Simulation (State_ model msg)


fromSandbox :
    { init : model
    , update : msg -> model -> model
    , view : model -> Html msg
    }
    -> Simulation model msg
fromSandbox flags =
    Simulation
        { modelResult = Ok flags.init
        , expectations = []
        , app =
            { update = flags.update
            , view = flags.view
            }
        }



-- Actions


run : Simulation model msg -> Expect.Expectation
run (Simulation state) =
    case state.modelResult of
        Err err ->
            () |> Expect.all (state.expectations ++ [ \() -> Expect.fail err ])

        Ok _ ->
            Expect.all state.expectations ()


{-| Internal, DO NOT expose
-}
whenOk : (model -> State_ model msg -> State_ model msg) -> Simulation model msg -> Simulation model msg
whenOk f (Simulation state) =
    case state.modelResult of
        Err _ ->
            Simulation state

        Ok model ->
            Simulation (f model state)


expectModel :
    (model -> Expect.Expectation)
    -> Simulation model msg
    -> Simulation model msg
expectModel expect =
    whenOk <|
        \model state ->
            let
                expectation () =
                    expect model
            in
            { state | expectations = state.expectations ++ [ expectation ] }


expectHtml :
    (Query.Single msg -> Expect.Expectation)
    -> Simulation model msg
    -> Simulation model msg
expectHtml expect =
    whenOk <|
        \model state ->
            let
                expectation () =
                    state.app.view model
                        |> Query.fromHtml
                        |> expect
            in
            { state | expectations = state.expectations ++ [ expectation ] }


triggerMsg : msg -> Simulation model msg -> Simulation model msg
triggerMsg msg =
    whenOk <|
        \model state ->
            { state | modelResult = Ok (state.app.update msg model) }


simulateBy :
    (msg -> Result String msg)
    -> ( ( String, Value ), List Selector )
    -> Simulation model msg
    -> Simulation model msg
simulateBy extractMsg ( event, selectors ) =
    whenOk <|
        \model state ->
            { state
                | modelResult =
                    state.app.view model
                        |> Query.fromHtml
                        |> Query.find selectors
                        |> Event.simulate event
                        |> Event.toResult
                        |> Result.andThen (\msg -> extractMsg msg |> Result.map (\newMsg -> ( msg, newMsg )))
                        |> Result.map
                            (\( msg, newMsg ) ->
                                model
                                    |> state.app.update msg
                                    |> state.app.update newMsg
                            )
            }


simulate : ( ( String, Value ), List Selector ) -> Simulation model msg -> Simulation model msg
simulate ( event, selectors ) =
    whenOk <|
        \model state ->
            { state
                | modelResult =
                    state.app.view model
                        |> Query.fromHtml
                        |> Query.find selectors
                        |> Event.simulate event
                        |> Event.toResult
                        |> Result.map (\msg -> state.app.update msg model)
            }
