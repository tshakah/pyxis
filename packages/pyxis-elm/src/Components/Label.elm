module Components.Label exposing
    ( Model
    , create
    , withFor
    , withId
    , withSizeSmall
    , withSubText
    , withClassList
    , render
    )

{-|


# Label Module


## Types

@docs Model
@docs create


## Generics

@docs withFor
@docs withId
@docs withSizeSmall
@docs withSubText
@docs withClassList


## Rendering

@docs render

-}

import Commons.Attributes as CA
import Commons.Render as CR
import Html exposing (Html)
import Html.Attributes


{-| The Label model.
-}
type Model
    = Model Configuration


{-| The available Label sizes.
-}
type Size
    = Medium
    | Small


{-| Internal. The internal Label configuration.
-}
type alias Configuration =
    { classList : List ( String, Bool )
    , for : Maybe String
    , id : Maybe String
    , size : Size
    , subText : Maybe String
    , text : String
    }


{-| Inits the Label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.render

-}
create : String -> Model
create text =
    Model
        { classList = []
        , for = Nothing
        , id = Nothing
        , size = Medium
        , subText = Nothing
        , text = text
        }


{-| Add a `for` attribute to label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withFor "input-id"
            |> Label.render

-}
withFor : String -> Model -> Model
withFor for (Model configuration) =
    Model { configuration | for = Just for }


{-| Add `id` and `data-test-id` attributes to label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withId "label-id"
            |> Label.render

-}
withId : String -> Model -> Model
withId id (Model configuration) =
    Model { configuration | id = Just id }


{-| Add a list of conditional classes for label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withClassList [("my-label-class", True), ("another-class", True)]
            |> Label.render

-}
withClassList : List ( String, Bool ) -> Model -> Model
withClassList classList (Model configuration) =
    Model { configuration | classList = classList }


{-| Set label to small size.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withSizeSmall
            |> Label.render

-}
withSizeSmall : Model -> Model
withSizeSmall (Model configuration) =
    Model { configuration | size = Small }


{-| Set a sub-level text for label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withSubText "This is a sub-level text"
            |> Label.render

-}
withSubText : String -> Model -> Model
withSubText text (Model configuration) =
    Model { configuration | subText = Just text }


{-| Internal.
-}
renderSubText : String -> Html msg
renderSubText subText =
    Html.small [ Html.Attributes.class "form-label__sub" ] [ Html.text subText ]


{-| Renders the Label.
-}
render : Model -> Html msg
render (Model { for, classList, id, size, text, subText }) =
    Html.label
        (CA.compose
            [ Html.Attributes.classList
                ([ ( "form-label", True )
                 , ( "form-label--small", size == Small )
                 ]
                    ++ classList
                )
            ]
            [ Maybe.map Html.Attributes.for for
            , Maybe.map Html.Attributes.id id
            , Maybe.map CA.testId id
            ]
        )
        [ Html.text text
        , subText
            |> Maybe.map renderSubText
            |> CR.renderMaybe
        ]
