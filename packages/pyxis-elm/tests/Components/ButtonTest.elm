module Components.ButtonTest exposing (suite)

import Components.Button as Button
import Components.IconSet as IconSet
import Html.Attributes
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes, disabled, tag, text)


type Msg
    = OnClick


suite : Test
suite =
    describe "The Button component"
        [ describe "Button tag"
            [ test "is <button>" <|
                \_ ->
                    Button.primary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ tag "button" ]
            , test "is <a>" <|
                \_ ->
                    Button.primary
                        |> Button.withLinkType "https://www.prima.it"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has
                            [ tag "a"
                            , attribute (Html.Attributes.href "https://www.prima.it")
                            ]
            ]
        , describe "Button emphasis"
            [ test "is primary" <|
                \_ ->
                    Button.primary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--primary" ] ]
            , test "is secondary" <|
                \_ ->
                    Button.secondary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--secondary" ] ]
            , test "is tertiary" <|
                \_ ->
                    Button.tertiary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--tertiary" ] ]
            , test "is brand" <|
                \_ ->
                    Button.brand
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--brand" ] ]
            , test "is ghost" <|
                \_ ->
                    Button.ghost
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--ghost" ] ]
            ]
        , describe "Button theme"
            [ test "is light" <|
                \_ ->
                    Button.primary
                        |> Button.withLightTheme
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.hasNot [ classes [ "button--alt" ] ]
            , test "is dark" <|
                \_ ->
                    Button.primary
                        |> Button.withDarkTheme
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--alt" ] ]
            ]
        , describe "Button size"
            [ test "is huge" <|
                \_ ->
                    Button.primary
                        |> Button.withHugeSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--huge" ] ]
            , test "is large" <|
                \_ ->
                    Button.primary
                        |> Button.withLargeSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--large" ] ]
            , test "is medium" <|
                \_ ->
                    Button.primary
                        |> Button.withMediumSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--medium" ] ]
            , test "is small" <|
                \_ ->
                    Button.secondary
                        |> Button.withSmallSize
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--small" ] ]
            ]
        , describe "Button type"
            [ test "is submit by default" <|
                \_ ->
                    Button.primary
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (Html.Attributes.type_ "submit") ]
            , test "is button" <|
                \_ ->
                    Button.primary
                        |> Button.withButtonType OnClick
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (Html.Attributes.type_ "button") ]
            , test "is reset" <|
                \_ ->
                    Button.primary
                        |> Button.withResetType
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (Html.Attributes.type_ "reset") ]
            , test "has no type when tag is <a>" <|
                \_ ->
                    Button.primary
                        |> Button.withResetType
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.hasNot
                            [ attribute (Html.Attributes.type_ "submit")
                            , attribute (Html.Attributes.type_ "button")
                            , attribute (Html.Attributes.type_ "reset")
                            ]
            , test "is <a>" <|
                \_ ->
                    Button.primary
                        |> Button.withLinkType "https://www.prima.it"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has
                            [ tag "a"
                            , attribute (Html.Attributes.href "https://www.prima.it")
                            ]
            ]
        , describe "Button icon"
            [ test "is leading" <|
                \_ ->
                    Button.primary
                        |> Button.withLeadingIcon IconSet.Car
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--leading-icon" ] ]
            , test "is trailing" <|
                \_ ->
                    Button.primary
                        |> Button.withTrailingIcon IconSet.Motorcycle
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--trailing-icon" ] ]
            , test "is icon only" <|
                \_ ->
                    Button.primary
                        |> Button.withLargeSize
                        |> Button.withIconOnly IconSet.Van
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--icon-only" ] ]
            ]
        , describe "Button events"
            [ test "has onClick" <|
                \_ ->
                    Button.primary
                        |> Button.withButtonType OnClick
                        |> Button.render
                        |> Query.fromHtml
                        |> Event.simulate Event.click
                        |> Event.expect OnClick
            ]
        , describe "Button generics"
            [ test "has textual content" <|
                \_ ->
                    Button.primary
                        |> Button.withText "Click me!"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ text "Click me!" ]
            , test "has an id" <|
                \_ ->
                    Button.primary
                        |> Button.withId "jsButton"
                        |> Button.withText "Click me!"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has
                            [ attribute (Html.Attributes.attribute "id" "jsButton")
                            , attribute (Html.Attributes.attribute "data-test-id" "jsButton")
                            ]
            , test "has a classList" <|
                \_ ->
                    Button.primary
                        |> Button.withClassList
                            [ ( "my-class", True )
                            , ( "my-other-class", True )
                            ]
                        |> Button.withText "Click me!"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "my-class", "my-other-class" ] ]
            , test "is disabled" <|
                \_ ->
                    Button.primary
                        |> Button.withDisabled True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ disabled True ]
            , test "has shadow" <|
                \_ ->
                    Button.brand
                        |> Button.withShadow
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--shadow" ] ]
            , test "has limited content width" <|
                \_ ->
                    Button.tertiary
                        |> Button.withContentWidth
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--content-width" ] ]
            , test "is loading" <|
                \_ ->
                    Button.brand
                        |> Button.withLoading True
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ classes [ "button", "button--loading" ] ]
            , test "has an accessible label" <|
                \_ ->
                    Button.primary
                        |> Button.withAriaLabel "Login button"
                        |> Button.withText "Login"
                        |> Button.render
                        |> Query.fromHtml
                        |> Query.has [ attribute (Html.Attributes.attribute "aria-label" "Login button") ]
            ]
        ]
