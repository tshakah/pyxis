module Components.Field.InputTest exposing (suite)

import Commons.Properties.Placement as Placement
import Commons.Properties.Size as Size
import Components.Field.Input as Input
import Components.Field.Label as LabelField
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


suite : Test
suite =
    Test.describe "The Input component"
        [ Test.test "renders the `form-field__text` class" <|
            \() ->
                fieldConfig
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has [ Selector.class "form-field__text" ]
        , Test.describe "Label"
            [ Test.fuzz Fuzz.string "should be rendered correctly" <|
                \s ->
                    fieldConfig
                        |> Input.withLabel (LabelField.config s)
                        |> fieldRender () fieldModel
                        |> findLabel
                        |> Query.has [ Selector.text s ]
            ]
        , Test.describe "Value attribute"
            [ Test.test "should be rendered correctly" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has [ Selector.attribute (Html.Attributes.value "") ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    fieldConfig
                        |> Input.withDisabled b
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "Name attribute should be rendered correctly" <|
            \name ->
                fieldConfig
                    |> Input.withName name
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                fieldConfig
                    |> Input.withPlaceholder p
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.test "id attribute should be rendered correctly" <|
            \() ->
                fieldConfig
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.id "input_field"
                        ]
        , Test.describe "classList"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    fieldConfig
                        |> Input.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> fieldRender () fieldModel
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
                    fieldConfig
                        |> Input.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> Input.withClassList [ ( s3, True ) ]
                        |> fieldRender () fieldModel
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
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> Query.has
                            [ Selector.disabled False
                            ]
            , Test.fuzz Fuzz.bool "should render the disabled property correctly" <|
                \b ->
                    fieldConfig
                        |> Input.withDisabled b
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has
                            [ Selector.disabled b
                            ]
            , Test.test "should render the disabled class when disabled" <|
                \() ->
                    fieldConfig
                        |> Input.withDisabled True
                        |> fieldRender () fieldModel
                        |> Query.has
                            [ Selector.class "form-field--disabled"
                            ]
            , Test.test "should not render the disabled class when not disabled" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> Query.hasNot
                            [ Selector.class "form-field--disabled"
                            ]
            ]
        , Test.describe "Addon"
            [ Test.describe "Should render the right class"
                [ Test.describe "Icon addon"
                    [ Test.test "append positioning should be rendered correctly" <|
                        \() ->
                            fieldConfig
                                |> Input.withAddon Placement.append (Input.iconAddon IconSet.ArrowDown)
                                |> fieldRender () fieldModel
                                |> Query.has
                                    [ Selector.class "form-field--with-append-icon"
                                    , Selector.class "form-field__addon"
                                    ]
                    , Test.test "prepend positioning should be rendered correctly" <|
                        \() ->
                            fieldConfig
                                |> Input.withAddon Placement.prepend (Input.iconAddon IconSet.ArrowDown)
                                |> fieldRender () fieldModel
                                |> Query.has
                                    [ Selector.class "form-field--with-prepend-icon"
                                    , Selector.class "form-field__addon"
                                    ]
                    ]
                , Test.describe "Text addon"
                    [ Test.fuzz Fuzz.string "append positioning should be rendered correctly" <|
                        \s ->
                            fieldConfig
                                |> Input.withAddon Placement.append (Input.textAddon s)
                                |> fieldRender () fieldModel
                                |> Query.has
                                    [ Selector.class "form-field--with-append-text"
                                    , Selector.class "form-field__addon"
                                    , Selector.text s
                                    ]
                    , Test.fuzz Fuzz.string "prepend positioning should be rendered correctly" <|
                        \s ->
                            fieldConfig
                                |> Input.withAddon Placement.prepend (Input.textAddon s)
                                |> fieldRender () fieldModel
                                |> Query.has
                                    [ Selector.class "form-field--with-prepend-text"
                                    , Selector.class "form-field__addon"
                                    , Selector.text s
                                    ]
                    ]
                ]
            ]
        , Test.describe "Size"
            [ Test.test "should render the correct size class" <|
                \() ->
                    fieldConfig
                        |> Input.withSize Size.small
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has
                            [ Selector.class "form-field__text--small"
                            ]
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.string "input event" <|
                \str ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Event.simulate (Event.input str)
                        |> Event.expect (Input str)
            , Test.test "blur event" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Event.simulate Event.blur
                        |> Event.expect Blur
            , Test.test "focus event" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Event.simulate Event.focus
                        |> Event.expect Focus
            ]
        ]


fieldModel : Input.Model ctx String
fieldModel =
    Input.init identity (always Ok)


fieldConfig : Input.Config Msg
fieldConfig =
    Input.text
        { onBlur = Blur
        , onFocus = Focus
        , onInput = Input
        }
        "input_field"


fieldRender : ctx -> Input.Model ctx value -> Input.Config msg -> Query.Single msg
fieldRender ctx model =
    Input.render ctx model >> Query.fromHtml


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


findLabel : Query.Single msg -> Query.Single msg
findLabel =
    Query.find [ Selector.tag "label", Selector.class "form-label" ]
