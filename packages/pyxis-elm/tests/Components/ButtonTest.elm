module Components.ButtonTest exposing (suite)

import Components.Button as Button
import Components.Icon as Icon
import Components.IconSet as IconSet
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (classes, disabled, text)


type Msg
    = OnClick


suite : Test
suite =
    describe "The Button component"
        [ describe "Button emphasis"
            [ test "is primary by default" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--primary" ] ]
            , test "is forced to primary when size is huge" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withEmphasis Button.secondary
                        |> Button.withSize Button.huge
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--primary", "button--huge" ] ]
            , test "is secondary" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withEmphasis Button.secondary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--secondary" ] ]
            , test "is tertiary" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withEmphasis Button.tertiary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--tertiary" ] ]
            , test "is brand" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withEmphasis Button.brand
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--brand" ] ]
            , test "is ghost" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withEmphasis Button.ghost
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--ghost" ] ]
            ]
        , describe "Button theme"
            [ test "is dark" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withTheme Button.dark
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--alt" ] ]
            ]
        , describe "Button size"
            [ test "is huge" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withSize Button.huge
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--huge" ] ]
            , test "is large" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withSize Button.large
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--large" ] ]
            , test "is medium by default" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--medium" ] ]
            , test "is small" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withSize Button.small
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--small" ] ]
            ]
        , describe "Button icon"
            [ test "is leading" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withLeadingIcon IconSet.Car
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--leading-icon" ] ]
            , test "is trailing" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withTrailingIcon IconSet.Motorcycle
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--trailing-icon" ] ]
            ]
        , describe "Button events"
            [ test "has onClick" <|
                \_ ->
                    OnClick
                        |> Button.button
                        |> Button.create
                        |> Button.render
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect OnClick
            ]
        , describe "Button generics"
            [ test "has textual content" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withText "Click me!"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ text "Click me!" ]
            , test "is disabled" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withDisabled True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ disabled True ]
            , test "is loading" <|
                \_ ->
                    Button.submit
                        |> Button.create
                        |> Button.withLoading True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--loading" ] ]
            ]
        ]
