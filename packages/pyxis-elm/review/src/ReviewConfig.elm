module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import Custom.NoBoolPatternMatching
import Custom.NoPipeRecordGetterRule
import Custom.QualifiedImports
import Custom.SignatureInScopedLet
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Variables
import Review.Rule exposing (Rule)


config : List Rule
config =
    [ NoExposingEverything.rule
    , NoImportingEverything.rule
        [ "Html"
        , "Html.Attributes"
        , "Html.Events"
        ]
    , NoMissingTypeAnnotation.rule
        |> Review.Rule.ignoreErrorsForDirectories [ "src/Stories" ]
    , NoUnused.CustomTypeConstructors.rule []
        |> Review.Rule.ignoreErrorsForFiles [ "src/Commons/ApiConstraint.elm" ]
    , NoUnused.Dependencies.rule
    , NoUnused.Exports.rule
        |> Review.Rule.ignoreErrorsForDirectories [ "src" ]
    , NoUnused.Modules.rule
        |> Review.Rule.ignoreErrorsForDirectories [ "src/Stories", "src/Examples" ]
    , NoUnused.Variables.rule
    , Custom.SignatureInScopedLet.rule
    , Custom.NoBoolPatternMatching.rule
    , Custom.NoPipeRecordGetterRule.rule
    , Custom.QualifiedImports.rule
    ]
