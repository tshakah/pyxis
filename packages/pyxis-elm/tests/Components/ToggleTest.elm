module Components.ToggleTest exposing (suite)

import Expect
import Html.Attributes
import Pyxis.Components.Toggle as Toggle
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, class, classes, id, tag, text)


type Msg
    = OnToggle Bool


suite : Test
suite =
    Test.describe "Toggle component"
        [ Test.test "has correct class and role" <|
            \() ->
                renderConfig True identity
                    |> Expect.all
                        [ Query.has
                            [ class "toggle"
                            , tag "label"
                            ]
                        , Query.find [ tag "input" ]
                            >> Query.has
                                [ class "toggle__input"
                                , attribute (Html.Attributes.attribute "role" "switch")
                                , attribute (Html.Attributes.attribute "type" "checkbox")
                                ]
                        ]
        , Test.test "if a text is passed, it is rendered" <|
            \() ->
                renderConfig True (Toggle.withText "Label")
                    |> Query.has [ text "Label" ]
        , Test.test "if an aria-label is passed, it is rendered" <|
            \() ->
                renderConfig True (Toggle.withAriaLabel "Label")
                    |> Query.find [ tag "input" ]
                    |> Query.has [ attribute (Html.Attributes.attribute "aria-label" "Label") ]
        , Test.test "if checked, has `aria-checked` set to true" <|
            \() ->
                renderConfig True identity
                    |> Query.find [ tag "input" ]
                    |> Query.has [ attribute (Html.Attributes.attribute "aria-checked" "true") ]
        , Test.test "if not checked, has `aria-checked` set to false" <|
            \() ->
                renderConfig False identity
                    |> Query.find [ tag "input" ]
                    |> Query.has [ attribute (Html.Attributes.attribute "aria-checked" "false") ]
        , Test.test "if disabled, has correct class and attribute" <|
            \() ->
                renderConfig False (Toggle.withDisabled True)
                    |> Expect.all
                        [ Query.has [ class "toggle--disabled" ]
                        , Query.find [ tag "input" ]
                            >> Query.has [ attribute (Html.Attributes.disabled True) ]
                        ]
        , Test.test "has `id` and `data-test-id` if one is set" <|
            \() ->
                renderConfig False (Toggle.withId "toggle-id")
                    |> Query.has
                        [ id "toggle-id"
                        , attribute (Html.Attributes.id "toggle-id")
                        , attribute (Html.Attributes.attribute "data-test-id" "toggle-id")
                        ]
        , Test.test "has the correct list of class" <|
            \() ->
                renderConfig False
                    (Toggle.withClassList
                        [ ( "my-class", True )
                        , ( "my-other-class", True )
                        ]
                    )
                    |> Query.has [ classes [ "my-class", "my-other-class" ] ]
        ]


renderConfig : Bool -> (Toggle.Config Msg -> Toggle.Config Msg) -> Query.Single Msg
renderConfig initialState modifiers =
    Toggle.config OnToggle
        |> modifiers
        |> Toggle.render initialState
        |> Query.fromHtml
