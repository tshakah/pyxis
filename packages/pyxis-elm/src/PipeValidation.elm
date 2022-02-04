module PipeValidation exposing
    ( Step
    , hardcoded
    , input
    , required
    , succeed
    )

import Components.Input as Input
import Validation exposing (Validation)


type alias Step model field data =
    (model -> Maybe (field -> data)) -> (model -> Maybe data)


succeed : value -> model -> Maybe value
succeed value _ =
    Just value


required : (model -> Maybe field) -> Step model field data
required getFieldData f model =
    Maybe.map2 (<|) (f model) (getFieldData model)


hardcoded : field -> Step model field data
hardcoded field =
    required (\_ -> Just field)


input : (model -> Input.Model field) -> Step model field data
input getter =
    required (Input.getData << getter)
