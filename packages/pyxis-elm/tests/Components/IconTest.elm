module Components.IconTest exposing (suite)

import Components.Icon as Icon
import Components.IconSet as IconSet
import Test exposing (Test, describe, test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (classes)


suite : Test
suite =
    describe "The Icon component"
        [ describe "Icon theme"
            [ test "is light by default" <|
                \_ ->
                    IconSet.Alarm
                        |> Icon.create
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon" ] ]
            , test "is dark" <|
                \_ ->
                    IconSet.Alarm
                        |> Icon.create
                        |> Icon.withTheme Icon.dark
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--alt" ] ]
            , test "when is dark it is also boxed" <|
                \_ ->
                    IconSet.Alarm
                        |> Icon.create
                        |> Icon.withTheme Icon.dark
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--boxed" ] ]
            ]
        , describe "Icon size"
            [ test "is large" <|
                \_ ->
                    IconSet.Facebook
                        |> Icon.create
                        |> Icon.withSize Icon.large
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-l" ] ]
            , test "is medium by default" <|
                \_ ->
                    IconSet.Book
                        |> Icon.create
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-m" ] ]
            , test "is small" <|
                \_ ->
                    IconSet.Van
                        |> Icon.create
                        |> Icon.withSize Icon.small
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--size-s" ] ]
            ]
        , describe "Icon style"
            [ test "is boxed" <|
                \_ ->
                    IconSet.Motorcycle
                        |> Icon.create
                        |> Icon.withStyle Icon.boxed
                        |> Icon.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "icon", "icon--boxed" ] ]
            ]
        ]
