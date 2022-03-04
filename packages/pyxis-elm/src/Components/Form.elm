module Components.Form exposing
    ( Form
    , create
    , withFieldSets
    , render
    )

{-|


# Form

@docs Form
@docs create


## FieldSets

@docs withFieldSet
@docs withFieldSets


## Rendering

@docs render

-}

import Components.Form.FieldSet as FieldSet exposing (FieldSet)
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Represents a Form and its contents.
-}
type Form msg
    = Form (Configuration msg)


{-| Internal.
-}
type alias Configuration msg =
    { fieldsets : List (FieldSet msg)
    }


{-| Creates a Form without contents.
-}
create : Form msg
create =
    Form { fieldsets = [] }


{-| Adds a FieldSet list to the Form.
-}
withFieldSets : List (FieldSet msg) -> Form msg -> Form msg
withFieldSets fieldsets (Form configuration) =
    Form { configuration | fieldsets = fieldsets }


{-| Renders the Form.
-}
render : Form msg -> Html msg
render (Form configuration) =
    Html.form
        [ Attributes.class "form" ]
        (List.map FieldSet.render configuration.fieldsets)
