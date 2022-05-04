module Components.TextSwitchTest exposing (suite)

import Commons.Attributes
import Commons.Properties.Theme as Theme
import Components.TextSwitch as TextSwitch
import Expect
import Html.Attributes
import Test exposing (Test)
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, checked, class, classes, id, tag, text)


type Option
    = M
    | F


type Msg
    = OnChange Option


suite : Test
suite =
    Test.describe "TextSwitch component"
        [ Test.test "has correct class and role" <|
            \() ->
                textSwitchConfig
                    |> renderConfig
                    |> Expect.all
                        [ Query.has [ class "text-switch-wrapper" ]
                        , Query.find [ class "text-switch" ]
                            >> Query.has [ attribute (Html.Attributes.attribute "role" "radiogroup") ]
                        ]
        , Test.describe "its options"
            [ Test.test "can have equal width" <|
                \() ->
                    textSwitchConfig
                        |> TextSwitch.withOptionsWidth TextSwitch.equalWidth
                        |> renderConfig
                        |> Query.has [ class "text-switch--equal-option-width" ]
            , Test.test "have correct classes and id" <|
                \() ->
                    textSwitchConfig
                        |> renderConfig
                        |> Query.findAll [ class "text-switch__option" ]
                        |> Expect.all
                            [ Query.each (Query.has [ class "text-switch__option-input" ])
                            , Query.first
                                >> Query.has
                                    [ id "id-name-option-0"
                                    , attribute (Html.Attributes.attribute "data-test-id" "id-name-option-0")
                                    ]
                            ]
            , Test.describe "with label"
                [ Test.test "renders the label" <|
                    \() ->
                        textSwitchConfig
                            |> TextSwitch.withLabel "Label"
                            |> renderConfig
                            |> Expect.all
                                [ Query.find [ class "text-switch__label" ]
                                    >> Query.has
                                        [ id "id-name-label"
                                        , text "Label"
                                        ]
                                , Query.has [ attribute (Commons.Attributes.ariaLabelledbyBy "id-name-label") ]
                                ]
                , Test.test "renders the label on top-left position" <|
                    \() ->
                        textSwitchConfig
                            |> TextSwitch.withLabel "Label"
                            |> TextSwitch.withLabelPosition TextSwitch.topLeft
                            |> renderConfig
                            |> Query.has [ class "text-switch-wrapper--top-left-label" ]
                , Test.test "renders the label on the left" <|
                    \() ->
                        textSwitchConfig
                            |> TextSwitch.withLabel "Label"
                            |> TextSwitch.withLabelPosition TextSwitch.left
                            |> renderConfig
                            |> Query.has [ class "text-switch-wrapper--left-label" ]
                ]
            , Test.test "can have an aria-label" <|
                \() ->
                    textSwitchConfig
                        |> TextSwitch.withAriaLabel "aria-label"
                        |> renderConfig
                        |> Query.has [ attribute (Commons.Attributes.ariaLabel "aria-label") ]
            , Test.test "can have the alternative theme" <|
                \() ->
                    textSwitchConfig
                        |> TextSwitch.withTheme Theme.alternative
                        |> renderConfig
                        |> Query.has [ class "text-switch-wrapper--alt" ]
            , Test.test "have the correct id" <|
                \() ->
                    textSwitchConfig
                        |> renderConfig
                        |> Query.has
                            [ id "id-name"
                            , attribute (Html.Attributes.attribute "data-test-id" "id-name")
                            ]
            , Test.test "can have an personalized id" <|
                \() ->
                    textSwitchConfig
                        |> TextSwitch.withId "custom-id"
                        |> TextSwitch.withLabel "label"
                        |> renderConfig
                        |> Expect.all
                            [ Query.has
                                [ id "custom-id"
                                , attribute (Html.Attributes.attribute "data-test-id" "custom-id")
                                ]
                            , Query.find [ class "text-switch__label" ]
                                >> Query.has [ id "custom-id-label" ]
                            ]
            , Test.test "can have a classlist" <|
                \() ->
                    textSwitchConfig
                        |> TextSwitch.withClassList
                            [ ( "my-class", True )
                            , ( "my-other-class", True )
                            ]
                        |> renderConfig
                        |> Query.has [ classes [ "my-class", "my-other-class" ] ]
            ]
        ]


options =
    [ TextSwitch.option { value = M, label = "Male" }
    , TextSwitch.option { value = F, label = "Female" }
    ]


textSwitchConfig : TextSwitch.Config Option Msg
textSwitchConfig =
    TextSwitch.config "name" OnChange |> TextSwitch.withOptions options


renderConfig : TextSwitch.Config Option Msg -> Query.Single Msg
renderConfig =
    TextSwitch.render M >> Query.fromHtml
