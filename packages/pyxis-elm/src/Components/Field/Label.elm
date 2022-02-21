module Components.Field.Label exposing
    ( Config
    , config
    , withFor
    , withId
    , withSize
    , withSubText
    , withClassList
    , render
    )

{-|


# Label component


## Configuration

@docs Config
@docs config


## Types

@docs Model
@docs create


## Generics

@docs withFor
@docs withId
@docs withSize
@docs withSubText
@docs withClassList


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render as CR
import Html exposing (Html)
import Html.Attributes


{-| The Label model.
-}
type Config
    = Model Configuration


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

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.render

-}
config : String -> Config
config text =
    Model
        { classList = []
        , for = Nothing
        , id = Nothing
        , size = Size.medium
        , subText = Nothing
        , text = text
        }


{-| Add a `for` attribute to label.

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withFor "input-id"
            |> Label.render

-}
withFor : String -> Config -> Config
withFor for (Model configuration) =
    Model { configuration | for = Just for }


{-| Add `id` and `data-test-id` attributes to label.

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withId "label-id"
            |> Label.render

-}
withId : String -> Config -> Config
withId id (Model configuration) =
    Model { configuration | id = Just id }


{-| Add a list of conditional classes for label.

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withClassList [("my-label-class", True), ("another-class", True)]
            |> Label.render

-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classList (Model configuration) =
    Model { configuration | classList = classList }


{-| Set label to small size.

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withSize Size.small
            |> Label.render

-}
withSize : Size -> Config -> Config
withSize a (Model configuration) =
    Model { configuration | size = a }


{-| Set a sub-level text for label.

    Import Components.Field.Label as Label

    myLabel: Html msg
    myLabel =
        Label.create "My custom label"
            |> Label.withSubText "This is a sub-level text"
            |> Label.render

-}
withSubText : String -> Config -> Config
withSubText text (Model configuration) =
    Model { configuration | subText = Just text }


{-| Renders the Label.
-}
render : Config -> Html msg
render (Model { for, classList, id, size, text, subText }) =
    Html.label
        [ Html.Attributes.classList
            ([ ( "form-label", True )
             , ( "form-label--small", size == Size.small )
             ]
                ++ classList
            )
        , Commons.Attributes.maybe Html.Attributes.for for
        , Commons.Attributes.maybe Html.Attributes.id id
        , Commons.Attributes.maybe Commons.Attributes.testId id
        ]
        [ Html.text text
        , subText
            |> Maybe.map renderSubText
            |> CR.renderMaybe
        ]


{-| Internal.
-}
renderSubText : String -> Html msg
renderSubText subText =
    Html.small [ Html.Attributes.class "form-label__sub" ] [ Html.text subText ]
