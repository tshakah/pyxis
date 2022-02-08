module Components.NumberFieldTest exposing (suite)

import Commons.Properties.Placement as Placement
import Components.Field.Number as NumberField
import Components.IconSet as IconSet
import Expect
import Fuzz
import Html.Attributes
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute, classes, tag)


type Msg
    = Tagger NumberField.Msg


suite : Test
suite =
    Test.describe "The TextField component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    numberFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    numberFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    numberFieldModel
                        |> NumberField.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                numberFieldModel
                    |> NumberField.withName name
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                numberFieldModel
                    |> NumberField.withPlaceholder p
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    numberFieldModel
                        |> NumberField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
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
                    numberFieldModel
                        |> NumberField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> NumberField.withClassList [ ( s3, True ) ]
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
            , let
                textAddon =
                    "Currency"
              in
              Test.describe "Addon"
                [ Test.describe "Should render the right class"
                    [ Test.describe "Icon addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                numberFieldModel
                                    |> NumberField.withAddon Placement.append (NumberField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                numberFieldModel
                                    |> NumberField.withAddon Placement.prepend (NumberField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        ]
                    , Test.describe "Text addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                numberFieldModel
                                    |> NumberField.withAddon Placement.append (NumberField.textAddon textAddon)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text textAddon
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                numberFieldModel
                                    |> NumberField.withAddon Placement.prepend (NumberField.textAddon textAddon)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text textAddon
                                        ]
                        ]
                    ]
                ]
            ]
        , Test.describe "Validation"
            [ Test.test "has error" <|
                \() ->
                    numberFieldModel
                        |> NumberField.render
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            , Test.test "should pass initially if no validation is applied" <|
                \() ->
                    numberFieldModel
                        |> NumberField.getValidatedValue ()
                        |> Expect.equal (Ok 0)
            , Test.fuzz Fuzz.int "should pass for every input if no validation is applied" <|
                \n ->
                    numberFieldModel
                        |> renderModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (String.fromInt n))
                            (\(Tagger msg) ->
                                numberFieldModel
                                    |> NumberField.update () msg
                                    |> NumberField.getValidatedValue ()
                                    |> Expect.equal (Ok n)
                            )
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.int "input should update the model value" <|
                \n ->
                    numberFieldModel
                        |> renderModel
                        |> findInput
                        |> Test.triggerMsg (Event.input (String.fromInt n))
                            (\(Tagger msg) ->
                                numberFieldModel
                                    |> NumberField.update () msg
                                    |> NumberField.getValue
                                    |> Expect.equal n
                            )
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


numberFieldModel : NumberField.Model ctx Msg
numberFieldModel =
    NumberField.create Tagger "input-id"


renderModel : NumberField.Model ctx msg -> Query.Single msg
renderModel model =
    model
        |> NumberField.render
        |> Query.fromHtml
