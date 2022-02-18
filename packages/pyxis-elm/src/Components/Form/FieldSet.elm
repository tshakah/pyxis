module Components.Form.FieldSet exposing
    ( FieldSet
    , create
    , withRow
    , withRows
    , withTitle
    , withText
    , withIcon
    , render
    )

{-|


# FieldSet

@docs FieldSet
@docs create


## Rows

@docs withRow
@docs withRows


## Generics

@docs withTitle
@docs withText
@docs withIcon


## Rendering

@docs render

-}

import Commons.Properties.Size as Size
import Commons.Render
import Components.Form.Grid as Grid
import Components.Form.Grid.Column as Column
import Components.Form.Grid.Row as Row exposing (Row)
import Components.Icon as Icon
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a FieldSet and its contents.
-}
type FieldSet msg
    = FieldSet (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { title : String
    , text : Maybe String
    , icon : Maybe Icon.Model
    , rows : List (Row msg)
    }


{-| Creates a FieldSet with an empty legend.
-}
create : FieldSet msg
create =
    FieldSet
        { title = ""
        , text = Nothing
        , icon = Nothing
        , rows = []
        }


{-| Adds a title to the FieldSet.
-}
withTitle : String -> FieldSet msg -> FieldSet msg
withTitle a (FieldSet configuration) =
    FieldSet { configuration | title = a }


{-| Adds a text (not a title) to the FieldSet.
-}
withText : String -> FieldSet msg -> FieldSet msg
withText a (FieldSet configuration) =
    FieldSet { configuration | text = Just a }


{-| Adds a title to the FieldSet.
-}
withIcon : Icon.Model -> FieldSet msg -> FieldSet msg
withIcon a (FieldSet configuration) =
    FieldSet { configuration | icon = Just a }


{-| Adds a Row to the FieldSet.
-}
withRow : Row msg -> FieldSet msg -> FieldSet msg
withRow a (FieldSet configuration) =
    FieldSet { configuration | rows = configuration.rows ++ [ a ] }


{-| Adds a Row list to the FieldSet.
-}
withRows : List (Row msg) -> FieldSet msg -> FieldSet msg
withRows a (FieldSet configuration) =
    FieldSet { configuration | rows = configuration.rows ++ a }


{-| Renders the FieldSet.
-}
render : FieldSet msg -> Html msg
render (FieldSet configuration) =
    Html.fieldset
        []
        [ Grid.create
            |> Grid.withGap Grid.largeGap
            |> Grid.withContent
                [ renderRowWithColumn [ renderLegend configuration ]
                , renderRowWithColumn
                    [ Grid.create
                        |> Grid.withContent (List.map Row.render configuration.rows)
                        |> Grid.render
                    ]
                ]
            |> Grid.render
        ]


{-| Internal.
-}
renderRowWithColumn : List (Html msg) -> Html msg
renderRowWithColumn content =
    Row.create
        |> Row.withColumn (Column.withContent content Column.create)
        |> Row.render


{-| Internal.
-}
renderLegend : Configuration msg -> Html msg
renderLegend configuration =
    Html.legend
        [ Attributes.class "form-legend" ]
        [ configuration.icon
            |> Maybe.map renderIconAddon
            |> Commons.Render.renderMaybe
        , renderTitle configuration.title
        , configuration.text
            |> Maybe.map renderText
            |> Commons.Render.renderMaybe
        ]


{-| Internal.
-}
renderIconAddon : Icon.Model -> Html msg
renderIconAddon icon =
    Html.div
        [ Attributes.class "form-legend__addon" ]
        [ icon
            |> Icon.withSize Size.small
            |> Icon.render
        ]


{-| Internal.
-}
renderTitle : String -> Html msg
renderTitle str =
    Html.span
        [ Attributes.class "form-legend__title" ]
        [ Html.text str ]


{-| Internal.
-}
renderText : String -> Html msg
renderText str =
    Html.span
        [ Attributes.class "form-legend__text" ]
        [ Html.text str ]
