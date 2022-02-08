module Components.DateFieldTest exposing (suite)

import Components.Field.Date as DateField
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
    Test.describe "The TextField component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    dateFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__date" ]
                            ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    dateFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    dateFieldModel
                        |> DateField.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                dateFieldModel
                    |> DateField.withName name
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                dateFieldModel
                    |> DateField.withPlaceholder p
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    dateFieldModel
                        |> DateField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
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
                    dateFieldModel
                        |> DateField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> DateField.withClassList [ ( s3, True ) ]
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
        , Test.describe "Validation"
            [ Test.test "has error" <|
                \() ->
                    dateFieldModel
                        |> DateField.render
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__date" ]
                            ]
            , Test.test "should pass initially if no validation is applied" <|
                \() ->
                    dateFieldModel
                        |> DateField.getValidatedValue ()
                        |> Expect.equal (Ok (DateField.Raw ""))
            , Test.fuzz Fuzz.Extra.date "should pass for every input if no validation is applied" <|
                \date ->
                    dateFieldModel
                        |> renderModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (Date.toIsoString date))
                            (\(Tagger msg) ->
                                dateFieldModel
                                    |> DateField.update () msg
                                    |> DateField.getValidatedValue ()
                                    |> Expect.equal (Ok (DateField.Parsed date))
                            )
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.Extra.date "input should update the model value" <|
                \date ->
                    dateFieldModel
                        |> renderModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (Date.toIsoString date))
                            (\(Tagger msg) ->
                                dateFieldModel
                                    |> DateField.update () msg
                                    |> DateField.getValue
                                    |> Expect.equal (DateField.Parsed date)
                            )
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


dateFieldModel : DateField.Model ctx Msg
dateFieldModel =
    DateField.create Tagger "input-id"


renderModel : DateField.Model ctx msg -> Query.Single msg
renderModel model =
    model
        |> DateField.render
        |> Query.fromHtml
