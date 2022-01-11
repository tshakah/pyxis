module Components.LabelTest exposing (suite)

import Components.Label as Label
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes, tag, text)


suite : Test
suite =
    describe "The Label component"
        [ describe "Default"
            [ test "has a textual content and a for attribute" <|
                \_ ->
                    Label.create "My label" "input-id"
                        |> Label.render
                        |> Query.fromHtml
                        |> Query.has
                            [ text "My label"
                            , attribute (Html.Attributes.for "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "inputIdLabel")
                            , classes [ "label" ]
                            ]
            , describe "Size"
                [ test "is small" <|
                    \_ ->
                        Label.create "My label" "input-id"
                            |> Label.withSizeSmall
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "label", "label--small" ] ]
                ]
            , describe "With a sub-text"
                [ test "creates a 'small' tag" <|
                    \_ ->
                        Label.create "My label" "input-id"
                            |> Label.withSubText "Sub-level text"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.find [ tag "small" ]
                            |> Query.has
                                [ classes [ "label__sub" ]
                                , text "Sub-level text"
                                ]
                ]
            , describe "Generics"
                [ test "has a class list" <|
                    \_ ->
                        Label.create "My label" "input-id"
                            |> Label.withClassList
                                [ ( "my-class", True )
                                , ( "my-other-class", True )
                                ]
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "my-class", "my-other-class" ] ]
                ]
            ]
        ]
