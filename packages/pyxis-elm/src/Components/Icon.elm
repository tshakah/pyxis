module Components.Icon exposing
    ( Model
    , create
    , Theme
    , withLightTheme
    , withDarkTheme
    , Size
    , withLargeSize
    , withMediumSize
    , withSmallSize
    , Style
    , withDefaultStyle
    , withBoxedStyle
    , withDescription
    , withClassList
    , render
    )

{-|


# Icon component

@docs Model
@docs create


## Theme

@docs Theme
@docs withLightTheme
@docs withDarkTheme


## Size

@docs Size
@docs withLargeSize
@docs withMediumSize
@docs withSmallSize


## Style

@docs Style
@docs withDefaultStyle
@docs withBoxedStyle


## Generics

@docs withDescription
@docs withClassList


## Rendering

@docs render

-}

import Commons.ApiConstraint as Api
import Commons.Attributes as CA
import Commons.Render as CR
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import SvgParser


{-| The Icon model.
-}
type Model a
    = Model Configuration


{-| Internal. The internal Icon configuration.
-}
type alias Configuration =
    { classList : List ( String, Bool )
    , description : Maybe String
    , icon : IconSet.Icon
    , size : Size
    , style : Style
    , theme : Theme
    }


{-| Internal. The default configuration which enforces api constraints.
Those keys represent which methods are use-restricted.
You can use the Commons/ApiConstraint.elm module to allow/disallow methods call.
-}
type alias DefaultConfiguration a =
    { a | dark : () }


{-| Inits the Icon.
-}
create : IconSet.Icon -> Model (DefaultConfiguration a)
create icon =
    Model
        { classList = []
        , description = Nothing
        , icon = icon
        , size = Medium
        , style = Default
        , theme = Light
        }


{-| The available Icon themes.
-}
type Theme
    = Light
    | Dark


{-| Sets a light theme to the Icon.
-}
withLightTheme : Model a -> Model { a | dark : Api.NotSupported }
withLightTheme (Model configuration) =
    Model { configuration | theme = Light }


{-| Sets a dark theme to the Icon.
-}
withDarkTheme : Model { a | dark : Api.Supported } -> Model a
withDarkTheme (Model configuration) =
    Model { configuration | theme = Dark }


{-| The available Icon sizes.
-}
type Size
    = Large
    | Medium
    | Small


{-| Sets a large size to the Icon.
-}
withLargeSize : Model a -> Model a
withLargeSize (Model configuration) =
    Model { configuration | size = Large }


{-| Sets a medium size to the Icon.
-}
withMediumSize : Model a -> Model a
withMediumSize (Model configuration) =
    Model { configuration | size = Medium }


{-| Sets a small size to the Icon.
-}
withSmallSize : Model a -> Model a
withSmallSize (Model configuration) =
    Model { configuration | size = Small }


{-| The available Icon styles.
-}
type Style
    = Default
    | Boxed


{-| Sets a default style to the Icon.
-}
withDefaultStyle : Model a -> Model { a | dark : Api.Supported }
withDefaultStyle (Model configuration) =
    Model { configuration | style = Default }


{-| Sets a boxed style to the Icon.
-}
withBoxedStyle : Model a -> Model { a | dark : Api.Supported }
withBoxedStyle (Model configuration) =
    Model { configuration | style = Boxed }


{-| Adds an accessible text to the Icon.
-}
withDescription : String -> Model a -> Model a
withDescription a (Model configuration) =
    Model { configuration | description = Just a }


{-| Adds a classList to the Icon.
-}
withClassList : List ( String, Bool ) -> Model a -> Model a
withClassList a (Model configuration) =
    Model { configuration | classList = a }


{-| Renders the Icon.
-}
render : Model a -> Html msg
render (Model configuration) =
    Html.div
        (CA.compose
            [ Attributes.classList
                ([ ( "icon", True )
                 , ( "icon--size-l", configuration.size == Large )
                 , ( "icon--size-m", configuration.size == Medium )
                 , ( "icon--size-s", configuration.size == Small )
                 , ( "icon--boxed", configuration.style == Boxed )
                 , ( "icon--alt", configuration.theme == Dark )
                 ]
                    ++ configuration.classList
                )
            , CA.ariaHidden (configuration.description == Nothing)
            ]
            [ Maybe.map CA.ariaLabel configuration.description
            , Maybe.map (always (CA.role "img")) configuration.description
            ]
        )
        [ configuration.icon
            |> IconSet.toString
            |> SvgParser.parse
            |> Result.toMaybe
            |> CR.renderMaybe
        ]
