module Components.Field.CheckboxCardGroupTest exposing (suite)

import Components.Field.CheckboxCardGroup as CheckboxCardGroup
import Expect
import Fuzz
import Fuzz.Extra
import Html.Attributes
import Json.Encode exposing (Value)
import Test exposing (Test)
import Test.Extra as Test
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (attribute)
import Test.Simulation as Simulation exposing (Simulation)


type Lang
    = Elm
    | Typescript
    | Rust
    | Elixir


langsConfig : CheckboxCardGroup.Config Lang
langsConfig =
    CheckboxCardGroup.config "checkbox-id"
        |> CheckboxCardGroup.withOptions
            [ CheckboxCardGroup.option { value = Elm, title = Just "Elm", text = Nothing, addon = Nothing }
            , CheckboxCardGroup.option { value = Typescript, title = Just "Typescript", text = Nothing, addon = Nothing }
            , CheckboxCardGroup.option { value = Rust, title = Just "Rust", text = Nothing, addon = Nothing }
            , CheckboxCardGroup.option { value = Elixir, title = Just "Elixir", text = Nothing, addon = Nothing }
            ]


suite : Test
suite =
    Test.describe "The CheckboxGroup component"
        [ Test.describe "Id"
            [ Test.fuzz Fuzz.Extra.nonEmptyString "the CheckboxGroup has an id and a data-test-id" <|
                \id ->
                    CheckboxCardGroup.config id
                        |> renderCheckboxGroup
                        |> Query.find [ Selector.class "form-card-group" ]
                        |> Query.has
                            [ attribute (Html.Attributes.id id)
                            , attribute (Html.Attributes.attribute "data-test-id" id)
                            ]
            ]
        , Test.describe "Disabled attribute"
            [ Test.test "should be False by default" <|
                \() ->
                    langsConfig
                        |> renderCheckboxGroup
                        |> findInput "Elixir"
                        |> Query.has [ Selector.disabled False ]
            , Test.fuzz Fuzz.bool "should be rendered correctly" <|
                \b ->
                    CheckboxCardGroup.config "checkbox-id"
                        |> CheckboxCardGroup.withOptions
                            [ CheckboxCardGroup.option { value = Elm, title = Just "Elm", text = Nothing, addon = Nothing }
                            , CheckboxCardGroup.option { value = Typescript, title = Just "Typescript", text = Nothing, addon = Nothing }
                            , CheckboxCardGroup.option { value = Rust, title = Just "Rust", text = Nothing, addon = Nothing }
                            , CheckboxCardGroup.option { value = Elixir, title = Just "Elixir", text = Nothing, addon = Nothing }
                                |> CheckboxCardGroup.withDisabledOption b
                            ]
                        |> renderCheckboxGroup
                        |> findInput "Elixir"
                        |> Query.has [ Selector.disabled b ]
            ]
        , Test.fuzz Fuzz.string "name attribute should be rendered correctly on every input" <|
            \name ->
                let
                    hasName : Query.Single msg -> Expect.Expectation
                    hasName =
                        Query.has
                            [ Selector.attribute (Html.Attributes.name name)
                            ]
                in
                langsConfig
                    |> CheckboxCardGroup.withName name
                    |> renderCheckboxGroup
                    |> Expect.all
                        [ findInput "Elm" >> hasName
                        , findInput "Typescript" >> hasName
                        , findInput "Rust" >> hasName
                        , findInput "Elixir" >> hasName
                        ]
        , Test.describe "ClassList attribute"
            [ Test.fuzzDistinctClassNames3 "should render correctly the given classes" <|
                \s1 s2 s3 ->
                    CheckboxCardGroup.config "checkbox-id"
                        |> CheckboxCardGroup.withClassList [ ( s1, True ), ( s2, False ), ( s3, True ) ]
                        |> renderCheckboxGroup
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
                    CheckboxCardGroup.config "checkbox-id"
                        |> CheckboxCardGroup.withClassList [ ( s1, True ), ( s2, True ) ]
                        |> CheckboxCardGroup.withClassList [ ( s3, True ) ]
                        |> renderCheckboxGroup
                        |> Expect.all
                            [ Query.hasNot
                                [ Selector.classes [ s1, s2 ]
                                ]
                            , Query.has
                                [ Selector.classes [ s3 ]
                                ]
                            ]
            ]
        , Test.describe "Update"
            [ Test.test "selecting options" <|
                \() ->
                    simulation
                        |> Simulation.simulate (check "Typescript" True)
                        |> Simulation.expectModel
                            (CheckboxCardGroup.getValue
                                >> List.member Typescript
                                >> Expect.true "`Typescript` option should be selected"
                            )
                        |> Simulation.run
            , Test.test "unselecting options" <|
                \() ->
                    simulation
                        |> Simulation.simulate (check "Typescript" True)
                        |> Simulation.simulate (check "Typescript" False)
                        |> Simulation.expectModel
                            (CheckboxCardGroup.getValue
                                >> List.member Typescript
                                >> Expect.false "`Typescript` option should not be selected"
                            )
                        |> Simulation.run
            ]
        , Test.describe "Validation"
            [ Test.test "should be applied initially" <|
                \() ->
                    CheckboxCardGroup.init [] nonEmptyLangValidation
                        |> CheckboxCardGroup.validate ()
                        |> Expect.err
            , Test.test "should update when selecting items" <|
                \() ->
                    simulation
                        |> Simulation.simulate (check "Typescript" True)
                        |> Simulation.simulate (check "Elixir" True)
                        |> Simulation.simulate (check "Elixir" False)
                        |> Simulation.expectModel
                            (\model ->
                                model
                                    |> CheckboxCardGroup.validate ()
                                    |> whenOk
                                        (\( hd, tl ) ->
                                            Expect.all
                                                [ List.member Typescript >> Expect.true "`Typescript` option should  be selected"
                                                , List.member Elixir >> Expect.false "`Elixir` option should not be selected"
                                                , List.member Rust >> Expect.false "`Rust` option should not be selected"
                                                ]
                                                (hd :: tl)
                                        )
                            )
                        |> Simulation.run
            , Test.test "should update when selecting items (1)" <|
                \() ->
                    simulation
                        |> Simulation.simulate (check "Typescript" True)
                        |> Simulation.simulate (check "Elixir" True)
                        |> Simulation.simulate (check "Elixir" False)
                        |> Simulation.simulate (check "Typescript" False)
                        |> Simulation.expectModel
                            (\model ->
                                model
                                    |> CheckboxCardGroup.validate ()
                                    |> Expect.err
                            )
                        |> Simulation.run
            ]
        ]


whenOk : (value -> Expect.Expectation) -> Result String value -> Expect.Expectation
whenOk expectation result =
    case result of
        Err err ->
            Expect.fail err

        Ok x ->
            expectation x


check : String -> Bool -> ( ( String, Value ), List Selector.Selector )
check label b =
    ( Event.check b
    , inputSelectors label
    )


inputSelectors : String -> List Selector.Selector
inputSelectors label =
    [ Selector.all
        [ Selector.tag "label"
        , Selector.containing [ Selector.text label ]
        ]
    , Selector.tag "input"
    ]


findInput : String -> Query.Single msg -> Query.Single msg
findInput label =
    Query.find (inputSelectors label)


renderCheckboxGroup : CheckboxCardGroup.Config value -> Query.Single (CheckboxCardGroup.Msg value)
renderCheckboxGroup =
    CheckboxCardGroup.render identity () (CheckboxCardGroup.init [] (always Ok)) >> Query.fromHtml


type alias NonemptyList a =
    ( a, List a )


nonEmptyLangValidation : () -> List Lang -> Result String (NonemptyList Lang)
nonEmptyLangValidation () langs =
    case langs of
        [] ->
            Err "You must select at least one option"

        hd :: tl ->
            Ok ( hd, tl )


simulation :
    Simulation
        (CheckboxCardGroup.Model () Lang (NonemptyList Lang))
        (CheckboxCardGroup.Msg Lang)
simulation =
    Simulation.fromSandbox
        { init = CheckboxCardGroup.init [] nonEmptyLangValidation
        , update = CheckboxCardGroup.update
        , view = \model -> CheckboxCardGroup.render identity () model langsConfig
        }
