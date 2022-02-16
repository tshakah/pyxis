module Components.Form.Grid exposing
    ( Grid
    , create
    , Gap
    , defaultGap
    , largeGap
    , withGap
    , withContent
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

@docs withContent


## Rendering

@docs render

-}

import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a form Grid and its contents.
-}
type Grid msg
    = Grid (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { content : List (Html msg)
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
withContent : List (Html msg) -> Grid msg -> Grid msg
withContent a (Grid configuration) =
    Grid { configuration | content = a }


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
            , ( "form-grid--gap-large", configuration.gap == largeGap )
            ]
        ]
        configuration.content
