module Components.Form.Grid.Column exposing
    ( Column
    , create
    , ColumnSpan
    , oneColumn
    , twoColumns
    , threeColumns
    , fourColumns
    , fiveColumns
    , withColumnSpan
    , withSize
    , withContent
    , render
    )

{-|


# Column

@docs Column
@docs create


## Span

@docs ColumnSpan
@docs oneColumn
@docs twoColumns
@docs threeColumns
@docs fourColumns
@docs fiveColumns
@docs withColumnSpan


## Generics

@docs withSize
@docs withContent


## Rendering

@docs render

-}

import Commons.Properties.Size as Size exposing (Size)
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Column and its contents.
-}
type Column msg
    = Column (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { size : Size
    , span : ColumnSpan
    , content : List (Html msg)
    }


{-| Creates an empty Column.
-}
create : Column msg
create =
    Column
        { size = Size.medium
        , span = oneColumn
        , content = []
        }


{-| Represents the available column span inside a Column.
-}
type ColumnSpan
    = OneColumn
    | TwoColumns
    | ThreeColumns
    | FourColumns
    | FiveColumns


{-| Creates a Column with no further column span inside it.
-}
oneColumn : ColumnSpan
oneColumn =
    OneColumn


{-| Creates a Column with a two-columns column span inside.
-}
twoColumns : ColumnSpan
twoColumns =
    TwoColumns


{-| Creates a Column with a three-columns column span inside it.
-}
threeColumns : ColumnSpan
threeColumns =
    ThreeColumns


{-| Creates a Column with a four-columns column span inside it.
-}
fourColumns : ColumnSpan
fourColumns =
    FourColumns


{-| Creates a Column with a five-columns column span inside it.
-}
fiveColumns : ColumnSpan
fiveColumns =
    FiveColumns


{-| Adds a ColumnSpan to the Column.
-}
withColumnSpan : ColumnSpan -> Column msg -> Column msg
withColumnSpan a (Column configuration) =
    Column { configuration | span = a }


{-| Adds a Size to the Column.
-}
withSize : Size -> Column msg -> Column msg
withSize a (Column configuration) =
    Column { configuration | size = a }


{-| Adds content to the Column.
-}
withContent : List (Html msg) -> Column msg -> Column msg
withContent a (Column configuration) =
    Column { configuration | content = a }


{-| Renders the Column.
-}
render : Column msg -> Html msg
render (Column configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-grid__row__column", True )
            , ( "form-grid__row__column--span-2", configuration.span == twoColumns )
            , ( "form-grid__row__column--span-3", configuration.span == threeColumns )
            , ( "form-grid__row__column--span-4", configuration.span == fourColumns )
            , ( "form-grid__row__column--span-5", configuration.span == fiveColumns )
            ]
        ]
        configuration.content
