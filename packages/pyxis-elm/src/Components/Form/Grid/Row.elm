module Components.Form.Grid.Row exposing
    ( Row
    , create
    , withColumn
    , withColumns
    , withSize
    , render
    )

{-|


# Row

@docs Row
@docs create


## Columns

@docs withColumn
@docs withColumns


## Generics

@docs withSize


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
create : Row msg
create =
    Row
        { size = Size.medium
        , columns = []
        }


{-| Adds a Size to the Row.
-}
withSize : Size -> Row msg -> Row msg
withSize a (Row configuration) =
    Row { configuration | size = a }


{-| Adds a Column to the Row.
-}
withColumn : Column msg -> Row msg -> Row msg
withColumn a (Row configuration) =
    Row { configuration | columns = configuration.columns ++ [ a ] }


{-| Adds a Column list to the Row.
-}
withColumns : List (Column msg) -> Row msg -> Row msg
withColumns a (Row configuration) =
    Row { configuration | columns = configuration.columns ++ a }


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
