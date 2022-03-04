module Components.Form.Grid exposing
    ( Grid
    , create
    , Gap
    , defaultGap
    , largeGap
    , withGap
    , ContentType
    , withContent
    , rows
    , subgrid
    , render
    )

{-|


# Grid

@docs Grid
@docs create


## Gap

@docs Gap
@docs defaultGap
@docs largeGap
@docs withGap


## Content

@docs ContentType
@docs withContent
@docs rows
@docs subgrid


## Rendering

@docs render

-}

import Components.Form.Grid.Row as Row exposing (Row)
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a form Grid and its contents.
-}
type Grid msg
    = Grid (Configuration msg)


type ContentType msg
    = Rows (List (Row msg))
    | SubGrid (Grid msg)


rows : List (Row msg) -> ContentType msg
rows =
    Rows


subgrid : Grid msg -> ContentType msg
subgrid =
    SubGrid


{-| Internal.
-}
type alias Configuration msg =
    { content : List (ContentType msg)
    , gap : Gap
    }


{-| Creates an empty Grid.
-}
create : Grid msg
create =
    Grid
        { content = []
        , gap = defaultGap
        }


{-| Adds a content to the Grid.
-}
withContent : List (ContentType msg) -> Grid msg -> Grid msg
withContent content_ (Grid configuration) =
    Grid { configuration | content = content_ }


{-| Represent a gap for the Grid Row(s).
-}
type Gap
    = Default
    | Large


{-| Creates a default Gap.
-}
defaultGap : Gap
defaultGap =
    Default


{-| Creates a large Gap.
-}
largeGap : Gap
largeGap =
    Large


{-| Adds a gap to the Grid.
-}
withGap : Gap -> Grid msg -> Grid msg
withGap a (Grid configuration) =
    Grid { configuration | gap = a }


{-| Renders the Grid.
-}
render : Grid msg -> Html msg
render (Grid configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-grid", True )
            , ( "form-grid--gap-large", configuration.gap == Large )
            ]
        ]
        (configuration.content
            |> List.map renderContentByType
            |> List.concat
        )


{-| Internal.
-}
renderContentByType : ContentType msg -> List (Html msg)
renderContentByType type_ =
    case type_ of
        Rows rows_ ->
            List.map Row.render rows_

        SubGrid grid ->
            [ render grid ]
