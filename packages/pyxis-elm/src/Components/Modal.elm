module Components.Modal exposing
    ( Config
    , config
    , Size
    , small
    , medium
    , large
    , withSize
    , withHeader
    , withContent
    , withFooter
    , withClassList
    , withCloseMsg
    , withAriaDescribedBy
    , render
    )

{-|


# Modal component

@docs Config
@docs config


## Size

@docs Size
@docs small
@docs medium
@docs large
@docs withSize


## Content

@docs withHeader
@docs withContent
@docs withFooter


## Generics

@docs withClassList
@docs withCloseMsg
@docs withAriaDescribedBy


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Render
import Components.Modal.Footer as Footer
import Components.Modal.Header as Header
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events as Events
import Maybe.Extra


{-| Internal. The internal Modal configuration.
-}
type alias ConfigData msg =
    { classList : List ( String, Bool )
    , content : List (Html msg)
    , id : String
    , footer : Maybe (Footer.Config msg)
    , header : Maybe (Header.Config msg)
    , size : Size
    , onCloseMsg : Maybe (Header.OnCloseData msg)
    , ariaDescribedBy : Maybe String
    }


{-| The Modal configuration.
-}
type Config msg
    = Config (ConfigData msg)


{-| Inits the Modal.

    import Components.Modal as Modal
    import Components.Modal.Footer as ModalFooter
    import Components.Modal.Header as ModalHeader

    showModal : Bool
    showModal =
        True

    modal : Html msg
    modal =
        Modal.config "test-modal"
            |> Modal.withHeader modalHeader
            |> Modal.withContent modalContent
            |> Modal.withFooter modalFooter
            |> Modal.render showModal

    modalHeader : ModalHeader.Config msg
    modalHeader =
        ModalHeader.config
            |> ModalHeader.withIsSticky
            |> ModalHeader.withTitle "Title Modal"

    modalContent : List (Html msg)
    modalContent =
        [ Html.text "Modal content" ]

    modalFooter : ModalFooter.Config msg
    modalFooter =
        ModalFooter.config
            |> ModalFooter.withIsSticky
            |> ModalFooter.withText "Text Footer"

-}
config : String -> Config msg
config id =
    Config
        { classList = []
        , content = []
        , footer = Nothing
        , id = id
        , header = Nothing
        , size = Medium
        , onCloseMsg = Nothing
        , ariaDescribedBy = Nothing
        }


type Size
    = Small
    | Medium
    | Large


{-| Small size
-}
small : Size
small =
    Small


{-| Medium size
-}
medium : Size
medium =
    Medium


{-| Large size
-}
large : Size
large =
    Large


{-| Sets the size to the Modal.
-}
withSize : Size -> Config msg -> Config msg
withSize size (Config configData) =
    Config { configData | size = size }


{-| Sets the Header to the Modal.
-}
withHeader : Header.Config msg -> Config msg -> Config msg
withHeader header (Config configData) =
    Config { configData | header = Just header }


{-| Sets the Content to the Modal.
-}
withContent : List (Html msg) -> Config msg -> Config msg
withContent content (Config configData) =
    Config { configData | content = content }


{-| Sets the Footer to the Modal.
-}
withFooter : Footer.Config msg -> Config msg -> Config msg
withFooter footer (Config configData) =
    Config { configData | footer = Just footer }


{-| Adds a ClassList to Modal
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classList (Config configData) =
    Config { configData | classList = classList }


{-| Sets the Modal visibility.
-}
withCloseMsg : msg -> String -> Config msg -> Config msg
withCloseMsg msg ariaLabel (Config configData) =
    Config { configData | onCloseMsg = Just { msg = msg, ariaLabel = ariaLabel } }


{-| Sets the Modal visibility.
-}
withAriaDescribedBy : String -> Config msg -> Config msg
withAriaDescribedBy ariaDescribedBy (Config configData) =
    Config { configData | ariaDescribedBy = Just ariaDescribedBy }


{-| Renders the Modal.
-}
render : Bool -> Config msg -> Html.Html msg
render isOpen (Config { classList, header, content, footer, size, onCloseMsg, ariaDescribedBy, id }) =
    Html.div
        [ Attributes.classList
            [ ( "modal-backdrop", True )
            , ( "modal-backdrop--show", isOpen )
            ]
        , Attributes.id id
        , Commons.Attributes.role "dialog"
        , Commons.Attributes.ariaHidden (not isOpen)
        , Commons.Attributes.testId id
        , describedByAttribute id ariaDescribedBy
        , Attributes.attribute "aria-modal" "true"
        ]
        [ ariaDescribedBy
            |> Maybe.map renderDescribedBy
            |> Commons.Render.renderMaybe
        , Html.div
            [ Attributes.class "modal-close"
            , Commons.Attributes.maybe (.msg >> Events.onClick) onCloseMsg
            ]
            []
        , Html.div
            [ Attributes.classList
                [ ( "modal", True )
                , ( "modal--small", size == Small )
                , ( "modal--medium", size == Medium )
                , ( "modal--large", size == Large )
                ]
            , Attributes.classList classList
            ]
            [ header
                |> Maybe.map (Header.withCloseButton onCloseMsg)
                |> Maybe.map Header.render
                |> Commons.Render.renderMaybe
            , Html.div
                [ Attributes.class "modal__content" ]
                content
            , footer
                |> Maybe.map Footer.render
                |> Commons.Render.renderMaybe
            ]
        ]


{-| Internal. Generate described id from id
-}
describedById : String -> String
describedById =
    (++) "described-"


{-| Internal. Render describedby attribute if exists.
-}
describedByAttribute : String -> Maybe String -> Html.Attribute msg
describedByAttribute id ariaDescribedBy =
    id
        |> describedById
        |> Commons.Attributes.ariaDescribedBy
        |> Commons.Attributes.renderIf (Maybe.Extra.isJust ariaDescribedBy)


{-| Internal. Render the screen reader description.
-}
renderDescribedBy : String -> Html msg
renderDescribedBy description =
    Html.div [ Attributes.class "screen-reader-only" ]
        [ Html.text description
        ]
