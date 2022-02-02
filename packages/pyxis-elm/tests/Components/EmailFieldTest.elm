module Components.EmailFieldTest exposing (suite)

import Commons.Properties.Placement as Placement
import Components.Field.Email as EmailField
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
    = Tagger EmailField.Msg


suite : Test
suite =
    Test.describe "The Email Input component"
        [ Test.describe "Default"
            [ Test.test "the input has an id and a data-test-id" <|
                \() ->
                    emailFieldModel
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
                    emailFieldModel
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    emailFieldModel
                        |> EmailField.withDisabled b
                        |> renderModel
                        |> findInput
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly" <|
            \name ->
                emailFieldModel
                    |> EmailField.withName name
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.name name)
                        ]
        , Test.fuzz Fuzz.string "placeholder attribute should be rendered correctly" <|
            \p ->
                emailFieldModel
                    |> EmailField.withPlaceholder p
                    |> renderModel
                    |> findInput
                    |> Query.has
                        [ Selector.attribute (Html.Attributes.placeholder p)
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    emailFieldModel
                        |> EmailField.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
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
                    emailFieldModel
                        |> EmailField.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> EmailField.withClassList [ ( s3, True ) ]
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
                                emailFieldModel
                                    |> EmailField.withAddon Placement.append (EmailField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                emailFieldModel
                                    |> EmailField.withAddon Placement.prepend (EmailField.iconAddon IconSet.ArrowDown)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-prepend-icon"
                                        , Selector.class "form-field__addon"
                                        ]
                        ]
                    , Test.describe "Text addon"
                        [ Test.test "append positioning should be rendered correctly" <|
                            \() ->
                                emailFieldModel
                                    |> EmailField.withAddon Placement.append (EmailField.textAddon textAddon)
                                    |> renderModel
                                    |> Query.has
                                        [ Selector.class "form-field--with-append-text"
                                        , Selector.class "form-field__addon"
                                        , Selector.text textAddon
                                        ]
                        , Test.test "prepend positioning should be rendered correctly" <|
                            \() ->
                                emailFieldModel
                                    |> EmailField.withAddon Placement.prepend (EmailField.textAddon textAddon)
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
                    emailFieldModel
                        |> EmailField.render
                        |> Query.fromHtml
                        |> Query.find [ tag "input" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id "input-id")
                            , attribute (Html.Attributes.attribute "data-test-id" "input-id")
                            , classes [ "form-field__text" ]
                            ]
            ]
        , Test.describe "Events"
            [ Test.fuzz Fuzz.string "input should update the model value" <|
                \str ->
                    emailFieldModel
                        |> renderModel
                        |> findInput
                        |> Test.triggerMsg (Event.input str)
                            (\(Tagger msg) ->
                                EmailField.update msg emailFieldModel
                                    |> Tuple.first
                                    |> EmailField.getValue
                                    |> Expect.equal (Just str)
                            )
            ]
        ]


findInput : Query.Single msg -> Query.Single msg
findInput =
    Query.find [ Selector.tag "input" ]


emailFieldModel : EmailField.Model Msg
emailFieldModel =
    EmailField.create Tagger "input-id"


renderModel : EmailField.Model msg -> Query.Single msg
renderModel model =
    model
        |> EmailField.render
        |> Query.fromHtml
