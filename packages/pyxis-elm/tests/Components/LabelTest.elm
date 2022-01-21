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
            [ test "has a textual content" <|
                \_ ->
                    Label.create "My label"
                        |> Label.render
                        |> Query.fromHtml
                        |> Query.has
                            [ tag "label"
                            , text "My label"
                            , classes [ "form-label" ]
                            ]
            , describe "Size"
                [ test "is small" <|
                    \_ ->
                        Label.create "My label"
                            |> Label.withSizeSmall
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "form-label", "form-label--small" ] ]
                ]
            , describe "With a sub-text"
                [ test "creates a 'small' tag" <|
                    \_ ->
                        Label.create "My label"
                            |> Label.withSubText "Sub-level text"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.find [ tag "small" ]
                            |> Query.has
                                [ classes [ "form-label__sub" ]
                                , text "Sub-level text"
                                ]
                ]
            , describe "Generics"
                [ test "has a for attribute" <|
                    \_ ->
                        Label.create "My label"
                            |> Label.withFor "input-id"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ attribute (Html.Attributes.for "input-id") ]
                , test "has a class list" <|
                    \_ ->
                        Label.create "My label"
                            |> Label.withClassList
                                [ ( "my-class", True )
                                , ( "my-other-class", True )
                                ]
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "my-class", "my-other-class" ] ]
                , test "has an id" <|
                    \_ ->
                        Label.create "My label"
                            |> Label.withId "label-id"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has
                                [ attribute (Html.Attributes.id "label-id")
                                , attribute (Html.Attributes.attribute "data-test-id" "label-id")
                                ]
                ]
            ]
        ]
