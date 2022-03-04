module Components.Form.Grid.Row exposing
    ( Row
    , default
    , large
    , small
    , withColumns
    , render
    )

{-|


# Row

@docs Row
@docs create


## Sizes

@docs default
@docs large
@docs small


## Columns

@docs withColumns


## Rendering

@docs render

-}

import Commons.Properties.Size as Size exposing (Size)
import Components.Form.Grid.Column as Column exposing (Column)
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Row and its contents.
-}
type Row msg
    = Row (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { size : Size
    , columns : List (Column msg)
    }


{-| Creates an empty Row.
-}
init : Size -> Row msg
init size =
    Row
        { size = size
        , columns = []
        }


{-| Creates a Row with small size.
-}
small : Row msg
small =
    init Size.small


{-| Creates a Row with large size.
-}
large : Row msg
large =
    init Size.large


{-| Creates a Row with a default size size.
-}
default : Row msg
default =
    init Size.fullWidth


{-| Adds a List of Column inside it.
-}
withColumns : List (Column msg) -> Row msg -> Row msg
withColumns columns (Row configuration) =
    Row { configuration | columns = columns }


{-| Renders the Row.
-}
render : Row msg -> Html msg
render (Row configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-grid__row", True )
            , ( "form-grid__row--large", configuration.size == Size.large )
            , ( "form-grid__row--small", configuration.size == Size.small )
            ]
        ]
        (List.map Column.render configuration.columns)
