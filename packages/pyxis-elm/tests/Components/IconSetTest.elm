module Components.IconSetTest exposing (suite)

import Commons.Render as CR
import Components.IconSet as IconSet
import SvgParser
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag)


suite : Test
suite =
    describe "The IconSet component"
        [ describe "Renders an svg tag"
            (List.map iconTest IconSet.allIcons)
        ]


iconTest : IconSet.Icon -> Test
iconTest icon =
    test ("from icon " ++ IconSet.toLabel icon) <|
        \_ ->
            icon
                |> IconSet.toString
                |> SvgParser.parse
                |> Result.toMaybe
                |> CR.renderMaybe
                |> Query.fromHtml
                |> Query.has [ tag "svg" ]
