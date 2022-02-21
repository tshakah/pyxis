module Components.Field.TextareaTest exposing (suite)

import Commons.Properties.Placement as Placement
import Components.Field.Label as LabelField
import Components.Field.Textarea as TextareaField
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes, tag)
import Test.Simulation as Simulation


type Msg
    = Tagger TextareaField.Msg


suite : Test
suite =
    Test.describe "The Textarea component"
        [ Test.describe "Default"
            [ Test.test "the textarea has an id and a data-test-id" <|
                \() ->
                    fieldConfig
                        |> fieldRender () fieldModel
                        |> findTextarea
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__textarea" ]
                            ]
            ]
        , Test.describe "Label"
            [ Test.fuzz Fuzz.string "the input has label" <|
                \s ->
                    fieldConfig
                        |> TextareaField.withLabel (LabelField.config s)
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
                        |> findTextarea
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    fieldConfig
                        |> TextareaField.withDisabled b
                        |> fieldRender () fieldModel
                        |> findTextarea
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                fieldConfig
                    |> TextareaField.withName name
                    |> fieldRender () fieldModel
                    |> findTextarea
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                fieldConfig
                    |> TextareaField.withPlaceholder p
                    |> fieldRender () fieldModel
                    |> findTextarea
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    fieldConfig
                        |> TextareaField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> fieldRender () fieldModel
                        |> findTextarea
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
                        |> TextareaField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> TextareaField.withClassList [ ( s3, True ) ]
                        |> fieldRender () fieldModel
                        |> findTextarea
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
            [ Test.test "should pass initially if no validation is applied" <|
                \() ->
                    fieldModel
                        |> TextareaField.getValue
                        |> Expect.equal ""
            ]
        ]


findTextarea : Query.Single msg -> Query.Single msg
findTextarea =
    Query.find [ Selector.tag "textarea" ]


findLabel : Query.Single msg -> Query.Single msg
findLabel =
    Query.find [ Selector.tag "label", Selector.class "form-label" ]


fieldModel : TextareaField.Model ctx
fieldModel =
    TextareaField.init (always Ok)


fieldConfig : TextareaField.Config Msg
fieldConfig =
    TextareaField.config Tagger "input-id"


fieldRender : ctx -> TextareaField.Model ctx -> TextareaField.Config msg -> Query.Single msg
fieldRender ctx model =
    TextareaField.render ctx model >> Query.fromHtml
