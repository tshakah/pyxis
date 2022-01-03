module Components.ButtonTest exposing (suite)

import Components.Button as Button
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
            [ test "is primary" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withPrimaryVariant
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--primary" ] ]
            , test "is secondary" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withSecondaryVariant
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--secondary" ] ]
            , test "is tertiary" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withTertiaryVariant
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--tertiary" ] ]
            , test "is brand" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withBrandVariant
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--brand" ] ]
            , test "is ghost" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withGhostVariant
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--ghost" ] ]
            ]
        , describe "Button theme"
            [ test "is dark" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withDarkTheme
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--alt" ] ]
            ]
        , describe "Button size"
            [ test "is huge" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withPrimaryVariant
                        |> Button.withHugeSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--huge" ] ]
            , test "is large" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withLargeSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--large" ] ]
            , test "is medium" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withMediumSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--medium" ] ]
            , test "is small" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withSecondaryVariant
                        |> Button.withSmallSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--small" ] ]
            ]
        , describe "Button icon"
            [ test "is leading" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withLeadingIcon IconSet.Car
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--leading-icon" ] ]
            , test "is trailing" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withTrailingIcon IconSet.Motorcycle
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--trailing-icon" ] ]
            , test "is icon only" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withSecondaryVariant
                        |> Button.withLargeSize
                        |> Button.withIconOnly IconSet.Van
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--icon-only" ] ]
            ]
        , describe "Button events"
            [ test "has onClick" <|
                \_ ->
                    Button.create
                        |> Button.withButtonType OnClick
                        |> Button.render
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect OnClick
            ]
        , describe "Button generics"
            [ test "has textual content" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withText "Click me!"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ text "Click me!" ]
            , test "is disabled" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withDisabled True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ disabled True ]
            , test "is loading" <|
                \_ ->
                    Button.create
                        |> Button.withSubmitType
                        |> Button.withLoading True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--loading" ] ]
            ]
        ]
