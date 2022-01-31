module Components.IconSetTest exposing (suite)

import Commons.Render as CR
import Components.IconSet as IconSet
import SvgParser
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (tag)


suite : Test
suite =
    Test.describe "The IconSet component"
        [ Test.describe "Renders an svg tag"
            (List.map iconTest IconSet.allIcons)
        ]


iconTest : IconSet.Icon -> Test
iconTest icon =
    Test.test ("from icon " ++ IconSet.toLabel icon) <|
        \() ->
            icon
                |> IconSet.toString
                |> SvgParser.parse
                |> Result.toMaybe
                |> CR.renderMaybe
                |> Query.fromHtml
                |> Query.has [ tag "svg" ]
