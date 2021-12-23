module Custom.SignatureInScopedLet exposing (details, message, rule)

import Elm.Syntax.Expression as Expr exposing (Expression)
import Elm.Syntax.Node as Node exposing (Node(..))
import Review.Rule as Rule exposing (Error, Rule)


rule : Rule
rule =
    Rule.newModuleRuleSchema "SignatureInScopedLet" ()
        |> Rule.withSimpleExpressionVisitor expressionVisitor
        |> Rule.fromModuleRuleSchema


message : String
message =
    "Local let without type signature"


details : List String
details =
    [ "This local let declaration lack an accompanying type signature" ]


extractError : Node Expr.LetDeclaration -> Maybe (Error {})
extractError (Node range letDeclaration) =
    case letDeclaration of
        -- Cannot write signature of a destructuring expression
        -- E.g.
        -- let { url, fragment } = url in ...
        Expr.LetDestructuring _ _ ->
            Nothing

        Expr.LetFunction { signature } ->
            signature
                |> Maybe.map (always Nothing)
                |> Maybe.withDefault
                    (Just
                        (Rule.error
                            { message = message
                            , details = details
                            }
                            range
                        )
                    )


expressionVisitor : Node Expression -> List (Error {})
expressionVisitor (Node _ expr) =
    case expr of
        Expr.LetExpression { declarations } ->
            List.filterMap extractError declarations

        _ ->
            []
