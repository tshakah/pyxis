module PipeValidation exposing
    ( hardcoded
    , input
    , required
    , succeed
    )

import Components.Input as Input
import Validation exposing (Validation)


succeed : value -> Validation model value
succeed value _ =
    Ok value


required : Validation model field -> Validation model (field -> data) -> Validation model data
required getFieldData f model =
    Result.map2 (<|) (f model) (getFieldData model)


hardcoded : field -> Validation model (field -> data) -> Validation model data
hardcoded field =
    required (\_ -> Ok field)


input : (model -> Input.Model field) -> Validation model (field -> data) -> Validation model data
input getter =
    required (Input.validate << getter)
