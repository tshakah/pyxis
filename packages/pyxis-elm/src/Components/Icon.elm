module Components.Icon exposing
    ( Model
    , create
    , withTheme
    , withSize
    , Style
    , default
    , boxed
    , withStyle
    , withDescription
    , withClassList
    , render
    )

{-|


# Icon component

@docs Model
@docs create


## Theme

@docs withTheme


## Size

@docs withSize


## Style

@docs Style
@docs default
@docs boxed
@docs withStyle


## Generics

@docs withDescription
@docs withClassList


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Size as Size exposing (Size)
import Commons.Properties.Theme as Theme exposing (Theme)
import Commons.Render as CR
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Maybe.Extra
import SvgParser


{-| The Icon model.
-}
type Model
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


{-| Inits the Icon.
-}
create : IconSet.Icon -> Model
create icon =
    Model
        { classList = []
        , description = Nothing
        , icon = icon
        , size = Size.medium
        , style = Default
        , theme = Theme.default
        }


{-| Sets a theme to the Icon.
-}
withTheme : Theme -> Model -> Model
withTheme a (Model configuration) =
    Model { configuration | theme = a }


{-| Sets a large size to the Icon.
-}
withSize : Size -> Model -> Model
withSize a (Model configuration) =
    Model { configuration | size = a }


{-| The available Icon styles.
-}
type Style
    = Default
    | Boxed


{-| Represent a default style for the Icon.
-}
default : Style
default =
    Default


{-| Represent a boxed style for the Icon.
-}
boxed : Style
boxed =
    Boxed


{-| Sets a default style to the Icon.
-}
withStyle : Style -> Model -> Model
withStyle a (Model configuration) =
    Model { configuration | style = a }


{-| Adds an accessible text to the Icon.
-}
withDescription : String -> Model -> Model
withDescription a (Model configuration) =
    Model { configuration | description = Just a }


{-| Adds a classList to the Icon.
-}
withClassList : List ( String, Bool ) -> Model -> Model
withClassList a (Model configuration) =
    Model { configuration | classList = a }


{-| Renders the Icon.
-}
render : Model -> Html msg
render (Model configuration) =
    Html.div
        [ Attributes.classList
            ([ ( "icon", True )
             , ( "icon--size-l", Size.isLarge configuration.size )
             , ( "icon--size-m", Size.isMedium configuration.size )
             , ( "icon--size-s", Size.isSmall configuration.size )
             , ( "icon--boxed", configuration.style == Boxed )
             , ( "icon--alt", Theme.isAlternative configuration.theme )
             ]
                ++ configuration.classList
            )
        , Commons.Attributes.ariaHidden (configuration.description == Nothing)
        , Commons.Attributes.maybe Commons.Attributes.ariaLabel configuration.description
        , Commons.Attributes.renderIf (Maybe.Extra.isJust configuration.description) (Commons.Attributes.role "img")
        ]
        [ configuration.icon
            |> IconSet.toString
            |> SvgParser.parse
            |> Result.toMaybe
            |> CR.renderMaybe
        ]
