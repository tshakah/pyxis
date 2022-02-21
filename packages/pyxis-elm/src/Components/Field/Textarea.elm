module Components.Field.Textarea exposing
    ( Model
    , init
    , Config
    , config
    , withSize
    , withLabel
    , withClassList
    , withDisabled
    , withName
    , withPlaceholder
    , Msg
    , isOnBlur
    , isOnFocus
    , isOnInput
    , update
    , validate
    , getValue
    , render
    )

{-|


# Textarea component

@docs Model
@docs init


## Config

@docs Config
@docs config


## Size

@docs withSize


## Generics

@docs withLabel
@docs withClassList
@docs withDisabled
@docs withName
@docs withPlaceholder


## Update

@docs Msg
@docs isOnBlur
@docs isOnFocus
@docs isOnInput
@docs update
@docs validate


## Readers

@docs getValue


## Rendering

@docs render

-}

import Commons.Attributes
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render as CommonsRender
import Components.Field.Error as Error
import Components.Field.Label as Label
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Result.Extra


{-| The Textarea model.
-}
type Model ctx
    = Model (ModelData ctx)


{-| Internal.
-}
type alias ModelData ctx =
    { value : String
    , validation : ctx -> String -> Result String String
    }


{-| Initializes the Textarea model.
-}
init : (ctx -> String -> Result String String) -> Model ctx
init validation =
    Model { value = "", validation = validation }


{-| The view configuration.
-}
type Config msg
    = Config (ConfigData msg)


{-| Internal.
-}
type alias ConfigData msg =
    { classList : List ( String, Bool )
    , disabled : Bool
    , id : String
    , name : Maybe String
    , placeholder : Maybe String
    , size : Size
    , label : Maybe Label.Config
    , tagger : Msg -> msg
    }


{-| Creates a Textarea.
-}
config : (Msg -> msg) -> String -> Config msg
config tagger id =
    Config
        { classList = []
        , disabled = False
        , id = id
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , label = Nothing
        , tagger = tagger
        }


{-| Adds a Label to the Textarea.
-}
withLabel : Label.Config -> Config msg -> Config msg
withLabel a (Config configuration) =
    Config { configuration | label = Just a }


{-| Sets the Textarea as disabled
-}
withDisabled : Bool -> Config msg -> Config msg
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


{-| Sets a Size to the Textarea
-}
withSize : Size -> Config msg -> Config msg
withSize size (Config configuration) =
    Config { configuration | size = size }


{-| Sets a ClassList to the Textarea
-}
withClassList : List ( String, Bool ) -> Config msg -> Config msg
withClassList classes (Config configuration) =
    Config { configuration | classList = classes }


{-| Sets a Name to the Textarea
-}
withName : String -> Config msg -> Config msg
withName name (Config configuration) =
    Config { configuration | name = Just name }


{-| Sets a Placeholder to the Textarea
-}
withPlaceholder : String -> Config msg -> Config msg
withPlaceholder placeholder (Config configuration) =
    Config { configuration | placeholder = Just placeholder }


{-| Represent the messages which the Textarea can handle.
-}
type Msg
    = OnInput String
    | OnFocus
    | OnBlur


{-| Returns True if the message is triggered by `Html.Events.onInput`
-}
isOnInput : Msg -> Bool
isOnInput msg =
    case msg of
        OnInput _ ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onFocus`
-}
isOnFocus : Msg -> Bool
isOnFocus msg =
    case msg of
        OnFocus ->
            True

        _ ->
            False


{-| Returns True if the message is triggered by `Html.Events.onBlur`
-}
isOnBlur : Msg -> Bool
isOnBlur msg =
    case msg of
        OnBlur ->
            True

        _ ->
            False


{-| The update function.
-}
update : ctx -> Msg -> Model ctx -> Model ctx
update ctx msg model =
    case msg of
        OnBlur ->
            model

        OnFocus ->
            model

        OnInput value ->
            setValue value model


{-| Internal.
-}
setValue : String -> Model ctx -> Model ctx
setValue value (Model data) =
    Model { data | value = value }


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx -> Result String String
validate ctx (Model { validation, value }) =
    validation ctx value


{-| Returns the current value of the Textarea.
-}
getValue : Model ctx -> String
getValue (Model { value }) =
    value


{-| Renders the Textarea.
-}
render : ctx -> Model ctx -> Config msg -> Html msg
render ctx ((Model modelData) as model) ((Config configData) as configuration) =
    Html.div
        [ Attributes.class "form-item" ]
        [ configData.label
            |> Maybe.map Label.render
            |> CommonsRender.renderMaybe
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ Html.div
                [ Attributes.classList
                    [ ( "form-field", True )
                    , ( "form-field--error", Result.Extra.isErr (modelData.validation ctx modelData.value) )
                    , ( "form-field--disabled", configData.disabled )
                    ]
                ]
                [ renderTextarea ctx model configuration
                ]
            , modelData.value
                |> modelData.validation ctx
                |> Error.fromResult
                |> Maybe.map (Error.withId configData.id >> Error.render)
                |> CommonsRender.renderMaybe
            ]
        ]



--|> Html.map configData.tagger


{-| Internal.
-}
renderTextarea : ctx -> Model ctx -> Config msg -> Html msg
renderTextarea ctx (Model modelData) (Config configData) =
    Html.textarea
        [ Attributes.id configData.id
        , Attributes.classList
            [ ( "form-field__textarea", True )
            , ( "form-field__textarea--small", Size.isSmall configData.size )
            ]
        , Attributes.classList configData.classList
        , Attributes.disabled configData.disabled
        , Attributes.value modelData.value
        , Commons.Attributes.testId configData.id
        , Commons.Attributes.maybe Attributes.name configData.name
        , Commons.Attributes.maybe Attributes.placeholder configData.placeholder
        , Commons.Attributes.renderIf
            (Result.Extra.isOk (modelData.validation ctx modelData.value))
            (Commons.Attributes.ariaDescribedBy (Error.toId configData.id))
        , Html.Events.onInput (OnInput >> configData.tagger)
        , Html.Events.onFocus (configData.tagger OnFocus)
        , Html.Events.onBlur (configData.tagger OnBlur)
        ]
        []
