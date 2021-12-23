module Components.Icon exposing
    ( Icon
    , accessKey
    , alarm
    , render
    )

{-|


# Icon component


## Icon

@docs Icon
@docs accessKey
@docs alarm


## Rendering

@docs render

-}

import Html exposing (Html)


{-| Available icons from Pyxis iconset.
-}
type Icon
    = AccessKey
    | Alarm


{-| The access-key icon from Pyxis iconset.
-}
accessKey : Icon
accessKey =
    AccessKey


{-| The alarm icon from Pyxis iconset.
-}
alarm : Icon
alarm =
    Alarm


{-| Renders an Icon.
-}
render : Icon -> Html msg
render icon =
    Html.i [] [ Html.text "Here's the icon " ]
