module Components.FormGridTest exposing (..)

import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as Column
import Components.Form.Grid.Row as Row
import Expect
import Html
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (class, classes)


suite : Test
suite =
    Test.describe "Form Grid component"
        [ Test.test "render correct markup" <|
            \() ->
                Form.create
                    |> renderFormConfig
                    |> Query.contains
                        [ Html.form
                            [ Html.Attributes.class "form" ]
                            []
                        ]
        , Test.describe "with fieldset"
            [ Test.test "render markup with grid" <|
                \() ->
                    Form.create
                        |> Form.withFieldSets
                            [ FieldSet.create
                            ]
                        |> renderFormConfig
                        |> Query.contains
                            [ Html.fieldset
                                [ Html.Attributes.class "form-fieldset" ]
                                [ Html.div
                                    [ Html.Attributes.classList
                                        [ ( "form-grid", True )
                                        , ( "form-grid--gap-large", True )
                                        ]
                                    ]
                                    []
                                ]
                            ]
            , Test.test "has header row" <|
                \() ->
                    FieldSet.create
                        |> FieldSet.withHeader
                            [ Row.default ]
                        |> renderFieldsetConfig
                        |> Query.children [ class "form-grid__row" ]
                        |> Query.count (Expect.equal 1)
            , Test.test "has content row with subgrid" <|
                \() ->
                    FieldSet.create
                        |> FieldSet.withContent
                            [ Row.default ]
                        |> renderFieldsetConfig
                        |> Query.contains
                            [ Html.div
                                [ Html.Attributes.class "form-grid" ]
                                [ Html.div
                                    [ Html.Attributes.class "form-grid__row" ]
                                    []
                                ]
                            ]
            , Test.test "has footer row" <|
                \() ->
                    FieldSet.create
                        |> FieldSet.withFooter
                            [ Row.default ]
                        |> renderFieldsetConfig
                        |> Query.children [ class "form-grid__row" ]
                        |> Query.count (Expect.equal 1)
            ]
        , Test.describe "with row"
            [ Test.test "has default size" <|
                \() ->
                    Row.default
                        |> renderRowConfig
                        |> Query.has [ class "form-grid__row" ]
            , Test.test "has large size" <|
                \() ->
                    Row.large
                        |> renderRowConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row"
                                , "form-grid__row--large"
                                ]
                            ]
            , Test.test "has small size" <|
                \() ->
                    Row.small
                        |> renderRowConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row"
                                , "form-grid__row--small"
                                ]
                            ]
            , Test.test "has default size and single column" <|
                \() ->
                    Row.default
                        |> Row.withColumns
                            [ Column.oneSpan
                            ]
                        |> renderRowConfig
                        |> Query.children [ class "form-grid__row__column" ]
                        |> Query.count (Expect.equal 1)
            , Test.test "has default size and two columns" <|
                \() ->
                    Row.default
                        |> Row.withColumns
                            [ Column.oneSpan
                            , Column.oneSpan
                            ]
                        |> renderRowConfig
                        |> Query.children [ class "form-grid__row__column" ]
                        |> Query.count (Expect.equal 2)
            ]
        , Test.describe "with column"
            [ Test.test "has one span" <|
                \() ->
                    Column.oneSpan
                        |> renderColumnConfig
                        |> Query.has [ class "form-grid__row__column" ]
            , Test.test "has two span" <|
                \() ->
                    Column.twoSpan
                        |> renderColumnConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row__column"
                                , "form-grid__row__column--span-2"
                                ]
                            ]
            , Test.test "has three span" <|
                \() ->
                    Column.threeSpan
                        |> renderColumnConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row__column"
                                , "form-grid__row__column--span-3"
                                ]
                            ]
            , Test.test "has four span" <|
                \() ->
                    Column.fourSpan
                        |> renderColumnConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row__column"
                                , "form-grid__row__column--span-4"
                                ]
                            ]
            , Test.test "has five span" <|
                \() ->
                    Column.fiveSpan
                        |> renderColumnConfig
                        |> Query.has
                            [ classes
                                [ "form-grid__row__column"
                                , "form-grid__row__column--span-5"
                                ]
                            ]
            , Test.test "has content" <|
                \() ->
                    Column.oneSpan
                        |> Column.withContent
                            (Html.div
                                [ Html.Attributes.class "test-class" ]
                                []
                            )
                        |> renderColumnConfig
                        |> Query.children [ class "test-class" ]
                        |> Query.count (Expect.equal 1)
            ]
        ]


renderFormConfig : Form.Form msg -> Query.Single msg
renderFormConfig =
    Form.render >> Query.fromHtml


renderFieldsetConfig : FieldSet.FieldSet msg -> Query.Single msg
renderFieldsetConfig =
    FieldSet.render >> Query.fromHtml


renderRowConfig : Row.Row msg -> Query.Single msg
renderRowConfig =
    Row.render >> Query.fromHtml


renderColumnConfig : Column.Column msg -> Query.Single msg
renderColumnConfig =
    Column.render >> Query.fromHtml
