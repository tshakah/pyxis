module Components.Label exposing
    ( Model
    , create
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
import String.Extra as SE


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
    , for : String
    , size : Size
    , subText : Maybe String
    , text : String
    }


{-| Inits the Label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label" "input-id"
            |> Label.render

-}
create : String -> String -> Model
create text for =
    Model
        { classList = []
        , for = for
        , size = Medium
        , subText = Nothing
        , text = text
        }


{-| Add a list of conditional classes for label.

    Import Components.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label" "input-id"
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
        Label.create "My custom label" "input-id"
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
        Label.create "My custom label" "input-id"
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
    Html.small [ Html.Attributes.class "label__sub" ] [ Html.text subText ]


{-| Renders the Label.
-}
render : Model -> Html msg
render (Model { for, classList, size, text, subText }) =
    Html.label
        [ Html.Attributes.classList
            ([ ( "label", True )
             , ( "label--small", size == Small )
             ]
                ++ classList
            )
        , Html.Attributes.for for
        , (++) (SE.camelize for) "Label" |> CA.testId
        ]
        [ Html.text text
        , subText
            |> Maybe.map renderSubText
            |> CR.renderMaybe
        ]
