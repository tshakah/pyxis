module Components.InputTest exposing (suite)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Input as Input
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector


type Msg
    = Blur
    | Focus
    | Input String


events : Input.Events Msg
events =
    { onBlur = Blur
    , onFocus = Focus
    , onInput = Input
    }


suite : Test
suite =
    Test.describe "Input component"
        [ Test.test "renders the `form-field__text` class" <|
            \() ->
                Input.text events "test-id"
                    |> renderModel
                    |> findInput
                    |> Query.has [ Selector.class "form-field__text" ]
        , Test.describe "type"
            [ testHasType "text" Input.text
            , testHasType "email" Input.email
            , testHasType "date" Input.date
            , testHasType "number" Input.number
            , testHasType "password" Input.password
            ]
        , Test.describe "Value attribute"
            [ Test.fuzz Fuzz.string "should be rendered correctly" <|
                \s ->
                    Input.text events "test-id"
                        |> Input.withValue s
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.attribute (Html.Attributes.value s) ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    Input.text events "test-id"
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    Input.text events "test-id"
                        |> Input.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "Name attribute should be rendered correctly" <|
            \name ->
                Input.text events "test-id"
                    |> Input.withName name
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                Input.text events "test-id"
                    |> Input.withPlaceholder p
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.fuzz Fuzz.string "id attribute should be rendered correctly" <|
            \id ->
                Input.text events id
                    |> Input.withPlaceholder id
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.id id
                        ]
        , Test.describe "classList"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    Input.text events "test-id"
                        |> Input.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderModel
                        |> findInput
                        |> Expect.all
                            [ Query.has
                                [ Selector.classes [ s1, s3 ]
                                ]
                            , Query.hasNot
                                [ Selector.classes [ s2 ]
                                ]
                            ]
            , Test.fuzzDistinctClassNames3 "should only render the last pipe value" <|
                \s1 s2 s3 ->
                    Input.text events "test-id"
                        |> Input.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> Input.withClassList [ ( s3, True ) ]
                        |> renderModel
                        |> findInput
                        |> Expect.all
                            [ Query.hasNot
                                [ Selector.classes [ s1, s2 ]
                                ]
                            , Query.has
                                [ Selector.classes [ s3 ]
                                ]
                            ]
            ]
        , Test.describe "disabled attribute"
            [ Test.test "should be disabled by default" <|
                \() ->
                    Input.text events "test-id"
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ Selector.disabled False
                            ]
            , Test.fuzz Fuzz.bool "should render the disabled property correctly" <|
                \b ->
                    Input.text events "test-id"
                        |> Input.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ Selector.disabled b
                            ]
            , Test.test "should render the disabled class when disabled" <|
                \() ->
                    Input.text events "test-id"
                        |> Input.withDisabled True
                        |> renderModel
                        |> Query.has
                            [ Selector.class "form-field--disabled"
                            ]
            , Test.test "should not render the disabled class when not disabled" <|
                \() ->
                    Input.text events "test-id"
                        |> renderModel
                        |> Query.hasNot
                            [ Selector.class "form-field--disabled"
                            ]
            ]
        , let
            textAddon =
                "Currency"
          in
          Test.describe "Addon"
            [ Test.describe "Should render the right class"
                [ Test.describe "Icon addon"
                    [ Test.test "append positioning should be rendered correctly" <|
                        \() ->
                            Input.text events "test-id"
                                |> Input.withAddon Placement.append (Input.iconAddon IconSet.ArrowDown)
                                |> renderModel
                                |> Query.has
                                    [ Selector.class "form-field--with-append-icon"
                                    , Selector.class "form-field__addon"
                                    ]
                    , Test.test "prepend positioning should be rendered correctly" <|
                        \() ->
                            Input.text events "test-id"
                                |> Input.withAddon Placement.prepend (Input.iconAddon IconSet.ArrowDown)
                                |> renderModel
                                |> Query.has
                                    [ Selector.class "form-field--with-prepend-icon"
                                    , Selector.class "form-field__addon"
                                    ]
                    ]
                , Test.describe "Text addon"
                    [ Test.test "append positioning should be rendered correctly" <|
                        \() ->
                            Input.text events "test-id"
                                |> Input.withAddon Placement.append (Input.textAddon textAddon)
                                |> renderModel
                                |> Query.has
                                    [ Selector.class "form-field--with-append-text"
                                    , Selector.class "form-field__addon"
                                    , Selector.text textAddon
                                    ]
                    , Test.test "prepend positioning should be rendered correctly" <|
                        \() ->
                            Input.text events "test-id"
                                |> Input.withAddon Placement.prepend (Input.textAddon textAddon)
                                |> renderModel
                                |> Query.has
                                    [ Selector.class "form-field--with-prepend-text"
                                    , Selector.class "form-field__addon"
                                    , Selector.text textAddon
                                    ]
                    ]
                ]
            ]
        , let
            errorMsg =
                "Invalid value"
          in
          Test.describe "Error"
            [ Test.test "should be rendered correctly when error is present" <|
                \() ->
                    Input.text events "test-id"
                        |> Input.withErrorMessage (Just errorMsg)
                        |> renderModel
                        |> Query.has
                            [ Selector.class "form-field--error"
                            ]
            , Test.test "the message should be rendered correctly" <|
                \() ->
                    Input.text events "test-id"
                        |> Input.withErrorMessage (Just errorMsg)
                        |> renderModel
                        |> Query.find [ Selector.class "form-field__error-message" ]
                        |> Query.has
                            [ Selector.text errorMsg
                            ]
            ]
        , Test.describe "Size"
            [ Test.test "should render the correct size class" <|
                \() ->
                    Input.text events "test-id"
                        |> Input.withSize Size.small
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ Selector.class "form-field__text--small"
                            ]
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.string "input event" <|
                \str ->
                    Input.text events "test-id"
                        |> renderModel
                        |> findInput
                        |> Event.simulate (Event.input str)
                        |> Event.expect (Input str)
            , Test.test "blur event" <|
                \() ->
                    Input.text events "test-id"
                        |> renderModel
                        |> findInput
                        |> Event.simulate Event.blur
                        |> Event.expect Blur
            , Test.test "focus event" <|
                \() ->
                    Input.text events "test-id"
                        |> renderModel
                        |> findInput
                        |> Event.simulate Event.focus
                        |> Event.expect Focus
            ]
        ]


renderModel : Input.Model msg -> Query.Single msg
renderModel model =
    model
        |> Input.render
        |> Query.fromHtml


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


testHasType : String -> (Input.Events Msg -> String -> Input.Model Msg) -> Test
testHasType type_ factory =
    Test.test ("the input should have type " ++ type_) <|
        \() ->
            factory events "test-id"
                |> renderModel
                |> findInput
                |> Query.has [ Selector.attribute (Html.Attributes.type_ type_) ]
