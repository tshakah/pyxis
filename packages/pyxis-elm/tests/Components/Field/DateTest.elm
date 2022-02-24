module Components.Field.DateTest exposing (suite)

import Components.Field.Date as DateField
import Components.Field.Label as LabelField
import Date
import Expect
import Fuzz
import Fuzz.Extra
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes, tag)


type Msg
    = Tagger DateField.Msg


suite : Test
suite =
    Test.describe "The Date component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__date" ]
                            ]
            ]
        , Test.describe "Label"
            [ Test.fuzz Fuzz.string "the input has label" <|
                \s ->
                    fieldConfig
                        |> DateField.withLabel (LabelField.config s)
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
                        |> DateField.withDisabled b
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                fieldConfig
                    |> DateField.withName name
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                fieldConfig
                    |> DateField.withPlaceholder p
                    |> fieldRender () fieldModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    fieldConfig
                        |> DateField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
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
                        |> DateField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> DateField.withClassList [ ( s3, True ) ]
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
        , Test.describe "Validation"
            [ Test.test "has error" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__date" ]
                            ]
            , Test.test "should pass initially if no validation is applied" <|
                \() ->
                    fieldModel
                        |> DateField.getValue
                        |> Expect.equal (DateField.Raw "")
            , Test.fuzz Fuzz.Extra.date "should pass for every input if no validation is applied" <|
                \date ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (Date.toIsoString date))
                            (\(Tagger msg) ->
                                fieldModel
                                    |> DateField.update msg
                                    |> DateField.getValue
                                    |> Expect.equal (DateField.Parsed date)
                            )
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.Extra.date "input should update the model value" <|
                \date ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (Date.toIsoString date))
                            (\(Tagger msg) ->
                                fieldModel
                                    |> DateField.update msg
                                    |> DateField.getValue
                                    |> Expect.equal (DateField.Parsed date)
                            )
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


findLabel : Query.Single msg -> Query.Single msg
findLabel =
    Query.find [ Selector.tag "label", Selector.class "form-label" ]


fieldModel : DateField.Model ctx
fieldModel =
    DateField.init (always Ok)


fieldConfig : DateField.Config Msg
fieldConfig =
    DateField.config Tagger "input-id"


fieldRender : ctx -> DateField.Model ctx -> DateField.Config msg -> Query.Single msg
fieldRender ctx model =
    DateField.render ctx model >> Query.fromHtml
