module Examples.Form.Utils exposing
    ( rowLargeWithOneColumn
    , rowSmallWithOneColumn
    )

import Components.Form.Grid.Column as Column
import Components.Form.Grid.Row as Row
import Html exposing (Html)


rowSmallWithOneColumn : Html msg -> Row.Row msg
rowSmallWithOneColumn content =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent content
            ]


rowLargeWithOneColumn : Html msg -> Row.Row msg
rowLargeWithOneColumn content =
    Row.large
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent content
            ]
