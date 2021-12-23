module Custom.QualifiedImports exposing (details, makeErrorFromExposing, message, rule)

import Elm.Syntax.Exposing as Exposing
import Elm.Syntax.Import exposing (Import)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node(..))
import Review.Rule as Rule exposing (Error, Rule)


rule : Rule
rule =
    Rule.newModuleRuleSchema "QualifiedImports" ()
        |> Rule.withSimpleImportVisitor importVisitor
        |> Rule.fromModuleRuleSchema


message : String
message =
    "Invalid import"


details : List String
details =
    [ "The module imports should either be qualified, or export the module main type" ]


makeErrorFromExposing : ModuleName -> Node Exposing.TopLevelExpose -> Maybe (Error {})
makeErrorFromExposing moduleName (Node range exposing_) =
    case exposing_ of
        -- Infix expose are always legal
        Exposing.InfixExpose _ ->
            Nothing

        -- Function expose are never legal
        Exposing.FunctionExpose _ ->
            Just
                (Rule.error
                    { message = message
                    , details = details
                    }
                    range
                )

        -- Type alias have to be equal to moduleName
        Exposing.TypeOrAliasExpose name ->
            if Just name == listLast moduleName then
                Nothing

            else
                Just
                    (Rule.error
                        { message = message
                        , details = details
                        }
                        range
                    )

        -- Types have to be equal to moduleName
        Exposing.TypeExpose { name } ->
            if Just name == listLast moduleName then
                Nothing

            else
                Just
                    (Rule.error
                        { message = message
                        , details = details
                        }
                        range
                    )


importVisitor : Node Import -> List (Error {})
importVisitor (Node range { exposingList, moduleName }) =
    case exposingList of
        Just (Node _ (Exposing.All _)) ->
            [ Rule.error
                { message = message
                , details = details
                }
                range
            ]

        Just (Node _ (Exposing.Explicit exposings)) ->
            List.filterMap (makeErrorFromExposing (Node.value moduleName)) exposings

        _ ->
            []


listLast : List a -> Maybe a
listLast lst =
    case lst of
        [] ->
            Nothing

        [ x ] ->
            Just x

        _ :: tl ->
            listLast tl
