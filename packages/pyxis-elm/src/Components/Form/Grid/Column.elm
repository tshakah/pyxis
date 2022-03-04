module Components.Form.Grid.Column exposing
    ( Column
    , oneSpan
    , twoSpan
    , threeSpan
    , fourSpan
    , fiveSpan
    , withContent
    , render
    )

{-|


# Column

@docs Column
@docs create


## Span

@docs ColumnSpan
@docs oneSpan
@docs twoSpan
@docs threeSpan
@docs fourSpan
@docs fiveSpan


## Generics

@docs withContent


## Rendering

@docs render

-}

import Commons.Render
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Column and its contents.
-}
type Column msg
    = Column (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { span : ColumnSpan
    , content : Html msg
    }


{-| Creates an empty Column.
-}
init : ColumnSpan -> Column msg
init span =
    Column
        { span = span
        , content = Commons.Render.empty
        }


{-| Represents the available column span inside a Column.
-}
type ColumnSpan
    = OneSpan
    | TwoSpan
    | ThreeSpan
    | FourSpan
    | FiveSpan


{-| Creates a Column with no further column span inside it.
-}
oneSpan : Column msg
oneSpan =
    init OneSpan


{-| Creates a Column with a two-columns span inside.
-}
twoSpan : Column msg
twoSpan =
    init TwoSpan


{-| Creates a Column with a three-columns span inside.
-}
threeSpan : Column msg
threeSpan =
    init ThreeSpan


{-| Creates a Column with a four-columns span inside.
-}
fourSpan : Column msg
fourSpan =
    init FourSpan


{-| Creates a Column with a five-columns span inside.
-}
fiveSpan : Column msg
fiveSpan =
    init FiveSpan


{-| Add content to the Column
-}
withContent : Html msg -> Column msg -> Column msg
withContent content (Column configuration) =
    Column { configuration | content = content }


{-| Renders the Column.
-}
render : Column msg -> Html msg
render (Column configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-grid__row__column", True )
            , ( "form-grid__row__column--span-2", configuration.span == TwoSpan )
            , ( "form-grid__row__column--span-3", configuration.span == ThreeSpan )
            , ( "form-grid__row__column--span-4", configuration.span == FourSpan )
            , ( "form-grid__row__column--span-5", configuration.span == FiveSpan )
            ]
        ]
        [ configuration.content ]
