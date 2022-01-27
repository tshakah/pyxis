module Components.TextFieldTest exposing (suite)

import Components.Field.Text as TextField
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes, tag)


type Msg
    = Tagger TextField.Msg


suite : Test
suite =
    describe "The TextField component"
        [ describe "Default"
            [ test "has an id and a data-test-id" <|
                \_ ->
                    TextField.create Tagger "input-id"
                        |> TextField.render
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        , describe "Validation"
            [ test "has error" <|
                \_ ->
                    TextField.create Tagger "input-id"
                        |> TextField.render
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        ]
