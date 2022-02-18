module Components.Icon exposing
    ( Model
    , create
    , withTheme
    , withSize
    , Style
    , default
    , neutral
    , brand
    , success
    , alert
    , error
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
@docs neutral
@docs brand
@docs success
@docs alert
@docs error
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
    | Boxed Variant


{-| The available Icon variants.
-}
type Variant
    = Neutral
    | Brand
    | Success
    | Alert
    | Error


{-| Creates a Default style.
-}
default : Style
default =
    Default


{-| Creates a Neutral style.
-}
neutral : Style
neutral =
    Boxed Neutral


{-| Creates a Brand style.
-}
brand : Style
brand =
    Boxed Brand


{-| Creates a Success style.
-}
success : Style
success =
    Boxed Success


{-| Creates a Alert style.
-}
alert : Style
alert =
    Boxed Alert


{-| Sets a default style to the Icon.
-}
withStyle : Style -> Model -> Model
withStyle a (Model configuration) =
    Model { configuration | style = a }


{-| Represent a error style for the Icon.
-}
error : Style
error =
    Boxed Error


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


{-| Internal.
-}
isBoxed : Style -> Bool
isBoxed style =
    case style of
        Boxed _ ->
            True

        _ ->
            False


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
             , ( "icon--boxed", isBoxed configuration.style || Theme.isAlternative configuration.theme )
             , ( "icon--brand", configuration.style == brand )
             , ( "icon--success", configuration.style == success )
             , ( "icon--alert", configuration.style == alert )
             , ( "icon--error", configuration.style == error )
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
