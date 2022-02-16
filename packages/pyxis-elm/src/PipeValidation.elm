module PipeValidation exposing
    ( Step
    , field
    , hardcoded
    , input
    , inputWithCtx
    , maybe
    , succeed
    )

import Components.Input as Input


type alias Step model field data =
    (model -> Maybe (field -> data)) -> (model -> Maybe data)


succeed : value -> model -> Maybe value
succeed value _ =
    Just value


field : (model -> field) -> Step model field data
field getField f model =
    hardcoded (getField model) f model


hardcoded : value -> Step model value data
hardcoded field_ f model =
    Maybe.map (\f1 -> f1 field_) (f model)


maybe : (model -> Maybe field) -> Step model field data
maybe getMaybeField f model =
    Maybe.map2 (<|) (f model) (getMaybeField model)


input : (model -> Input.Model field) -> Step model field data
input =
    inputWithCtx (always ())


inputWithCtx : (model -> ctx) -> (model -> Input.ModelWithCtx ctx field) -> Step model field data
inputWithCtx wrapper getter =
    maybe (\model -> Input.getValueFromCtx (wrapper model) (getter model))
