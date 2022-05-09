module Components.Field.LabelTest exposing (suite)

import Components.Field.Label as Label
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes, tag, text)


suite : Test
suite =
    Test.describe "The Label component"
        [ Test.describe "Default"
            [ Test.test "has a textual content" <|
                \() ->
                    Label.config "My label"
                        |> Label.render
                        |> Query.fromHtml
                        |> Query.has
                            [ tag "label"
                            , text "My label"
                            , classes [ "form-label" ]
                            ]
            , Test.describe "Size"
                [ Test.test "is small" <|
                    \() ->
                        Label.config "My label"
                            |> Label.withSize Label.small
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "form-label", "form-label--small" ] ]
                ]
            , Test.describe "With a sub-text"
                [ Test.test "creates a 'small' tag" <|
                    \() ->
                        Label.config "My label"
                            |> Label.withSubText "Sub-level text"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.find [ tag "small" ]
                            |> Query.has
                                [ classes [ "form-label__sub" ]
                                , text "Sub-level text"
                                ]
                ]
            , Test.describe "Generics"
                [ Test.test "has a for attribute" <|
                    \() ->
                        Label.config "My label"
                            |> Label.withFor "input-id"
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ attribute (Html.Attributes.for "input-id") ]
                , Test.test "has a class list" <|
                    \() ->
                        Label.config "My label"
                            |> Label.withClassList
                                [ ( "my-class", True )
                                , ( "my-other-class", True )
                                ]
                            |> Label.render
                            |> Query.fromHtml
                            |> Query.has [ classes [ "my-class", "my-other-class" ] ]
                , Test.test "has an id" <|
                    \() ->
                        Label.config "My label"
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
