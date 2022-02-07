module Components.Select exposing
    ( Args
    , option
    , view
    )

import Html exposing (Html)
import Html.Attributes exposing (class)
import Html.Events exposing (onInput)
import Utils


type Option
    = Option String String


option : { text : String, value : String } -> Option
option { text, value } =
    Option value text


type alias Args msg =
    { placeholder : String
    , options : List Option
    , onSelect : String -> msg
    , currentValue : Maybe String
    }


view : Args msg -> Html msg
view args =
    Html.div [ class "form-field" ]
        [ Utils.concatArgs
            (Html.select
                [ class "form-field__select"
                , onInput args.onSelect
                , Html.Attributes.value (Maybe.withDefault "" args.currentValue)
                ]
            )
            [ [ Html.option
                    [ Html.Attributes.disabled True
                    , Html.Attributes.value ""
                    , Html.Attributes.selected True
                    ]
                    [ Html.text args.placeholder ]
              ]
            , List.map
                (\(Option value text) ->
                    Html.option
                        [ Html.Attributes.value value
                        ]
                        [ Html.text text ]
                )
                args.options
            ]
        ]
