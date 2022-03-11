module Form.GridTest exposing (suite)

import Components.Form.Grid as Grid
import Components.Form.Grid.Col as Col
import Components.Form.Grid.Row as Row
import Fuzz
import Html
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (classes)


suite : Test
suite =
    Test.describe "The Form Grid component"
        [ Test.describe "Grid"
            [ Test.test "has valid markup" <|
                \_ ->
                    Grid.render [] []
                        |> Query.fromHtml
                        |> Query.has [ classes [ "form-grid" ] ]
            , Test.test "has a large gap" <|
                \_ ->
                    Grid.render [ Grid.largeGap ] []
                        |> Query.fromHtml
                        |> Query.has [ classes [ "form-grid", "form-grid--gap-large" ] ]
            ]
        , Test.describe "Row"
            [ Test.test "has valid markup" <|
                \_ ->
                    Grid.render []
                        [ Grid.row [] []
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row" ] []
                            ]
            , Test.test "has small size" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [ Row.smallSize ] []
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row form-grid__row--small" ] []
                            ]
            , Test.test "has large size" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [ Row.largeSize ] []
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row form-grid__row--large" ] []
                            ]
            ]
        , Test.describe "Col"
            [ Test.test "has valid markup" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [] [] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column" ] []
                            ]
            , Test.fuzz Fuzz.string "has content" <|
                \s ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [] [ Html.text s ] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column" ] [ Html.text s ]
                            ]
            , Test.test "spans by two" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [ Col.span2 ] [] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column form-grid__row__column--span-2" ] []
                            ]
            , Test.test "spans by three" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [ Col.span3 ] [] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column form-grid__row__column--span-3" ] []
                            ]
            , Test.test "spans by four" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [ Col.span4 ] [] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column form-grid__row__column--span-4" ] []
                            ]
            , Test.test "spans by five" <|
                \_ ->
                    Grid.render
                        []
                        [ Grid.row [] [ Grid.col [ Col.span5 ] [] ]
                        ]
                        |> Query.fromHtml
                        |> Query.contains
                            [ Html.div [ Html.Attributes.class "form-grid__row__column form-grid__row__column--span-5" ] []
                            ]
            ]
        ]
