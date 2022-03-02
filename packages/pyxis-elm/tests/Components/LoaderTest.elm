module Components.LoaderTest exposing (suite)

import Commons.Properties.Theme as Theme
import Components.Loaders.Loader as Loader
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, class, classes, tag, text)


suite : Test
suite =
    Test.describe "Loader component"
        [ Test.test "renders correct classes when spinner" <|
            \() ->
                Loader.spinner
                    |> renderConfig
                    |> Query.has
                        [ class "loader"
                        , tag "div"
                        , class "loader__spinner"
                        ]
        , Test.test "renders correct classes when spinner small" <|
            \() ->
                Loader.spinnerSmall
                    |> renderConfig
                    |> Query.has
                        [ classes [ "loader", "loader--small" ]
                        , tag "div"
                        , class "loader__spinner"
                        ]
        , Test.test "renders correct classes when car" <|
            \() ->
                Loader.car
                    |> renderConfig
                    |> Query.has
                        [ class "loader"
                        , tag "div"
                        , class "loader__car"
                        , tag "svg"
                        ]
        , Test.test "has a description if a text is set" <|
            \() ->
                Loader.spinner
                    |> Loader.withText "Loading description"
                    |> renderConfig
                    |> Query.has
                        [ class "loader__text"
                        , text "Loading description"
                        ]
        , Test.test "has a the proper class if theme is alternative" <|
            \() ->
                Loader.spinner
                    |> Loader.withTheme Theme.alternative
                    |> renderConfig
                    |> Query.has [ class "loader--alt" ]
        , Test.test "has `id` and `data-test-id` if one is set" <|
            \() ->
                Loader.spinner
                    |> Loader.withId "message-id"
                    |> renderConfig
                    |> Query.has
                        [ attribute (Html.Attributes.attribute "id" "message-id")
                        , attribute (Html.Attributes.attribute "data-test-id" "message-id")
                        ]
        , Test.test "has the correct list of class" <|
            \() ->
                Loader.spinner
                    |> Loader.withClassList
                        [ ( "my-class", True )
                        , ( "my-other-class", True )
                        ]
                    |> renderConfig
                    |> Query.has [ classes [ "my-class", "my-other-class" ] ]
        ]


renderConfig : Loader.Config -> Query.Single msg
renderConfig =
    Loader.render >> Query.fromHtml
