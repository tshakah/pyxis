module Components.Form.FieldSet exposing
    ( FieldSet
    , create
    , withHeader
    , withContent
    , withFooter
    , render
    )

{-|


# FieldSet

@docs FieldSet
@docs create


## General

@docs withHeader
@docs withContent
@docs withFooter


## Rendering

@docs render

-}

import Components.Form.Grid as Grid
import Components.Form.Grid.Row exposing (Row)
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a FieldSet and its contents.
-}
type FieldSet msg
    = FieldSet (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { header : List (Row msg)
    , content : List (Row msg)
    , footer : List (Row msg)
    }


{-| Creates a FieldSet.
-}
create : FieldSet msg
create =
    FieldSet
        { header = []
        , content = []
        , footer = []
        }


{-| Adds a Header Row to the Fieldset.
-}
withHeader : List (Row msg) -> FieldSet msg -> FieldSet msg
withHeader headerRows (FieldSet configuration) =
    FieldSet { configuration | header = headerRows }


{-| Adds a Content Row to the Fieldset.
-}
withContent : List (Row msg) -> FieldSet msg -> FieldSet msg
withContent contentRows (FieldSet configuration) =
    FieldSet { configuration | content = contentRows }


{-| Adds a Footer Row to the Fieldset.
-}
withFooter : List (Row msg) -> FieldSet msg -> FieldSet msg
withFooter footerRows (FieldSet configuration) =
    FieldSet { configuration | footer = footerRows }


{-| Renders the FieldSet.
-}
render : FieldSet msg -> Html msg
render (FieldSet configuration) =
    Html.fieldset
        [ Attributes.class "form-fieldset" ]
        [ Grid.create
            |> Grid.withGap Grid.largeGap
            |> Grid.withContent
                [ Grid.rows configuration.header
                , renderContent configuration.content
                , Grid.rows configuration.footer
                ]
            |> Grid.render
        ]


{-| Internal.
-}
renderContent : List (Row msg) -> Grid.ContentType msg
renderContent content =
    if List.isEmpty content then
        Grid.rows []

    else
        Grid.create
            |> Grid.withContent [ Grid.rows content ]
            |> Grid.subgrid
