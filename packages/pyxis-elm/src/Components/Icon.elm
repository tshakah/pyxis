module Components.Icon exposing
    ( Model
    , create
    , Theme
    , light, dark
    , withTheme
    , Size
    , large, medium, small
    , withSize
    , Style
    , default, boxed
    , withStyle
    , render
    )

{-|


# Icon component

@docs Model
@docs create


## Theme

@docs Theme
@docs light, dark
@docs withTheme


## Size

@docs Size
@docs large, medium, small
@docs withSize


## Style

@docs Style
@docs default, boxed
@docs withStyle


## Rendering

@docs render

-}

import Commons.Render as CR
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import SvgParser


{-| The Icon model.
-}
type Model
    = Model Configuration


{-| Internal. The internal Icon configuration.
-}
type alias Configuration =
    { icon : IconSet.Icon
    , size : Size
    , style : Style
    , theme : Theme
    }


{-| Inits the Icon.
-}
create : IconSet.Icon -> Model
create icon =
    Model
        { icon = icon
        , size = Medium
        , style = Default
        , theme = Light
        }


{-| The available Icon themes.
-}
type Theme
    = Light
    | Dark


{-| A light Icon Theme.
-}
light : Theme
light =
    Light


{-| A dark Icon Theme.
-}
dark : Theme
dark =
    Dark


{-| Sets a size to the Icon.
-}
withTheme : Theme -> Model -> Model
withTheme a (Model configuration) =
    Model
        { configuration
            | theme = a
            , style =
                if a == dark then
                    boxed

                else
                    configuration.style
        }


{-| The available Icon sizes.
-}
type Size
    = Large
    | Medium
    | Small


{-| A large Icon Size.
-}
large : Size
large =
    Large


{-| A medium Icon Size.
-}
medium : Size
medium =
    Medium


{-| A small Icon Size.
-}
small : Size
small =
    Small


{-| Sets a size to the Icon.
-}
withSize : Size -> Model -> Model
withSize a (Model configuration) =
    Model { configuration | size = a }


{-| The available Icon sizes.
-}
type Style
    = Default
    | Boxed


{-| A default Icon Style.
-}
default : Style
default =
    Default


{-| A boxed Icon Style.
-}
boxed : Style
boxed =
    Boxed


{-| Sets a size to the Icon.
-}
withStyle : Style -> Model -> Model
withStyle a (Model configuration) =
    Model { configuration | style = a }


{-| Renders the Icon.
-}
render : Model -> Html msg
render (Model configuration) =
    Html.div
        [ Attributes.classList
            [ ( "icon", True )
            , ( "icon--size-l", configuration.size == large )
            , ( "icon--size-m", configuration.size == medium )
            , ( "icon--size-s", configuration.size == small )
            , ( "icon--boxed", configuration.style == boxed )
            , ( "icon--alt", configuration.theme == dark && configuration.style == boxed )
            ]
        ]
        [ configuration.icon
            |> IconSet.toString
            |> SvgParser.parse
            |> Result.toMaybe
            |> CR.renderMaybe
        ]
