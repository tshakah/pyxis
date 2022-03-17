module Components.Field.TextTest exposing (suite)

import Commons.Properties.Placement as Placement
import Components.Field.Label as LabelField
import Components.Field.Text as TextField
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes)


suite : Test
suite =
    Test.describe "The Text component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        , Test.describe "Label"
            [ Test.fuzz Fuzz.string "the input has label" <|
                \s ->
                    fieldConfig
                        |> TextField.withLabel (LabelField.config s)
                        |> fieldRender () fieldModel
                        |> findLabel
                        |> Query.has
                            [ Selector.text s
                            ]
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
                        |> TextField.withDisabled b
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                fieldConfig
                    |> TextField.withName name
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                fieldConfig
                    |> TextField.withPlaceholder p
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    fieldConfig
                        |> TextField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
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
                        |> TextField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> TextField.withClassList [ ( s3, True ) ]
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
            , Test.describe "Addon"
                [ Test.describe "Should render the right class"
                    [ Test.describe "Icon addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                fieldConfig
                                    |> TextField.withAddon Placement.append (TextField.iconAddon IconSet.ArrowDown)
                                    |> fieldRender () fieldModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                fieldConfig
                                    |> TextField.withAddon Placement.prepend (TextField.iconAddon IconSet.ArrowDown)
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
                                    |> TextField.withAddon Placement.append (TextField.textAddon s)
                                    |> fieldRender () fieldModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text s
                                        ]
                        , Test.fuzz Fuzz.string "prepend positioning should be rendered correctly" <|
                            \s ->
                                fieldConfig
                                    |> TextField.withAddon Placement.prepend (TextField.textAddon s)
                                    |> fieldRender () fieldModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text s
                                        ]
                        ]
                    ]
                ]
            ]
        , Test.describe "Validation"
            [ Test.test "should pass initially if no validation is applied" <|
                \() ->
                    fieldModel
                        |> TextField.getValue
                        |> Expect.equal ""
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


findLabel : Query.Single msg -> Query.Single msg
findLabel =
    Query.find [ Selector.tag "label", Selector.class "form-label" ]


fieldModel : TextField.Model ctx
fieldModel =
    TextField.init "" (always Ok)


fieldConfig : TextField.Config
fieldConfig =
    TextField.text "input-id"


fieldRender : ctx -> TextField.Model ctx -> TextField.Config -> Query.Single TextField.Msg
fieldRender ctx model =
    TextField.render identity ctx model >> Query.fromHtml
