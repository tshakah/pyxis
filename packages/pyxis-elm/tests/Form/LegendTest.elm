module Form.LegendTest exposing (suite)

import Components.Form.Legend as Legend
import Components.Icon as Icon
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, classes, text)


suite : Test
suite =
    Test.describe "The Form Legend component"
        [ Test.test "is empty by default" <|
            \_ ->
                Legend.config "Legend"
                    |> Legend.render
                    |> Query.fromHtml
                    |> Expect.all
                        [ Query.has [ class "form-legend" ]
                        , Query.find [ class "form-legend__title" ] >> Query.has [ text "Legend" ]
                        ]
        , Test.test "has left aligned content" <|
            \_ ->
                Legend.config "Legend"
                    |> Legend.withAlignmentLeft
                    |> Legend.render
                    |> Query.fromHtml
                    |> Query.has [ classes [ "form-legend", "form-legend--align-left" ] ]
        , Test.fuzz Fuzz.string "contains description" <|
            \s ->
                Legend.config "Legend"
                    |> Legend.withDescription s
                    |> Legend.render
                    |> Query.fromHtml
                    |> Query.contains
                        [ Html.span
                            [ Html.Attributes.class "form-legend__text" ]
                            [ Html.text s ]
                        ]
        , Test.fuzz Fuzz.string "contains image addon" <|
            \s ->
                Legend.config "Legend"
                    |> Legend.withAddon (Legend.imageAddon s)
                    |> Legend.render
                    |> Query.fromHtml
                    |> Query.contains
                        [ Html.span
                            [ Html.Attributes.class "form-legend__addon" ]
                            [ Html.img
                                [ Html.Attributes.src s
                                , Html.Attributes.height 80
                                ]
                                []
                            ]
                        ]
        , Test.test "contains icon addon" <|
            \_ ->
                Legend.config "Legend"
                    |> Legend.withAddon (Legend.iconAddon IconSet.User)
                    |> Legend.render
                    |> Query.fromHtml
                    |> Query.contains
                        [ IconSet.User
                            |> Icon.config
                            |> Icon.withStyle Icon.brand
                            |> Icon.render
                        ]
        ]
