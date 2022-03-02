module Components.Loaders.Loader exposing
    ( Config
    , car
    , spinner
    , spinnerSmall
    , withClassList
    , withId
    , withText
    , withTheme
    , render
    )

{-|


# Loader Component

@docs Config
@docs car
@docs spinner
@docs spinnerSmall


## Generics

@docs withClassList
@docs withId
@docs withText
@docs withTheme


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Theme as Theme exposing (Theme)
import Commons.Render
import Components.Loaders.LoaderCar as LoaderCar
import Html
import Html.Attributes as Attributes


{-| Internal. The internal Message configuration
-}
type alias ConfigData =
    { classList : List ( String, Bool )
    , id : Maybe String
    , text : Maybe String
    , theme : Theme
    , variant : Variant
    }


{-| The Loader configuration
-}
type Config
    = Config ConfigData


{-| The Loader internal configuration
-}
config : Variant -> Config
config variant =
    Config
        { classList = []
        , id = Nothing
        , text = Nothing
        , theme = Theme.default
        , variant = variant
        }


type Variant
    = SpinnerMedium
    | SpinnerSmall
    | Car


{-| Creates a Spinner
-}
spinner : Config
spinner =
    config SpinnerMedium


{-| Creates a Spinner small
-}
spinnerSmall : Config
spinnerSmall =
    config SpinnerSmall


{-| Creates a Car loader
-}
car : Config
car =
    config Car


{-| Internal.
-}
isCar : Variant -> Bool
isCar variant =
    case variant of
        Car ->
            True

        _ ->
            False


{-| Internal.
-}
isSmall : Variant -> Bool
isSmall variant =
    case variant of
        SpinnerSmall ->
            True

        _ ->
            False


{-| Internal.
-}
getVariantClass : Variant -> String
getVariantClass variant =
    case variant of
        Car ->
            "loader__car"

        _ ->
            "loader__spinner"


{-| Sets a theme to the Loader.
-}
withTheme : Theme -> Config -> Config
withTheme theme (Config configuration) =
    Config { configuration | theme = theme }


{-| Sets a description to the Loader.
-}
withText : String -> Config -> Config
withText text (Config configuration) =
    Config { configuration | text = Just text }


{-| Add a ClassList to Loader
-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classList (Config configuration) =
    Config { configuration | classList = classList }


{-| Add `id` and `data-test-id` to Loader.
-}
withId : String -> Config -> Config
withId id (Config configuration) =
    Config { configuration | id = Just id }


{-| Renders the Loader.
-}
render : Config -> Html.Html msg
render (Config { classList, id, theme, text, variant }) =
    Html.div
        [ Attributes.classList
            [ ( "loader", True )
            , ( "loader--with-car", isCar variant )
            , ( "loader--alt", Theme.isAlternative theme )
            , ( "loader--small", isSmall variant )
            ]
        , Attributes.classList classList
        , Commons.Attributes.maybe Attributes.id id
        , Commons.Attributes.maybe Commons.Attributes.testId id
        , Commons.Attributes.role "status"
        , Commons.Attributes.ariaLabel "Loading..."
        ]
        [ Html.div
            [ Attributes.class (getVariantClass variant) ]
            [ Commons.Render.renderIf (isCar variant) LoaderCar.renderSvg ]
        , text
            |> Maybe.map renderText
            |> Commons.Render.renderMaybe
        ]


{-| Internal.
-}
renderText : String -> Html.Html msg
renderText text =
    Html.div
        [ Attributes.class "loader__text" ]
        [ Html.text text ]
