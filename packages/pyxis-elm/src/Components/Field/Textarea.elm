module Components.Field.Textarea exposing
    ( Model
    , create
    , withSize
    , withValidation
    , withClassList
    , withDefaultValue
    , withDisabled
    , withName
    , withPlaceholder
    , Msg
    , update
    , validate
    , getValue
    , getValidatedValue
    , render
    )

{-|


# Textarea component

@docs Model
@docs create


## Size

@docs withSize


## Validation

@docs withValidation


## Generics

@docs withClassList
@docs withDefaultValue
@docs withDisabled
@docs withName
@docs withPlaceholder


## Update

@docs Msg
@docs update
@docs validate


## Readers

@docs getValue
@docs getValidatedValue


## Rendering

@docs render

-}

import Commons.Attributes as CommonsAttributes
import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render as CommonsRender
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events


{-| The Textarea model.
-}
type Model ctx msg
    = Model (Configuration ctx msg)


{-| Internal. The internal Textarea configuration.
-}
type alias Configuration ctx msg =
    { classList : List ( String, Bool )
    , disabled : Bool
    , errorMessage : Maybe String
    , id : String
    , msgTagger : Msg -> msg
    , name : Maybe String
    , placeholder : Maybe String
    , size : Size
    , status : FieldStatus.StatusList
    , validation : ctx -> String -> Result String String
    , value : String
    }


{-| Represent the messages which the Textarea can handle.
-}
type Msg
    = OnInput String
    | OnFocus
    | OnBlur


{-| The update function.
-}
update : ctx -> Msg -> Model ctx msg -> Model ctx msg
update ctx msg =
    case msg of
        OnBlur ->
            validate ctx

        OnFocus ->
            identity

        OnInput value ->
            setValue value


{-| Creates a Textarea.
-}
create : (Msg -> msg) -> String -> Model ctx msg
create msgTagger id =
    Model
        { classList = []
        , disabled = False
        , errorMessage = Nothing
        , id = id
        , msgTagger = msgTagger
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , validation = always Ok
        , value = ""
        }


{-| Sets a default value to the Textarea.
-}
withDefaultValue : String -> Model ctx msg -> Model ctx msg
withDefaultValue defaultValue (Model configuration) =
    Model { configuration | value = defaultValue }
        |> addFieldStatus FieldStatus.default


{-| Add a Validation set of rules to the Textarea.
-}
withValidation : (ctx -> String -> Result String String) -> Model ctx msg -> Model ctx msg
withValidation validation (Model configuration) =
    Model { configuration | validation = validation }


{-| Sets the Textarea as disabled
-}
withDisabled : Bool -> Model ctx msg -> Model ctx msg
withDisabled isDisabled (Model configuration) =
    Model { configuration | disabled = isDisabled }


{-| Sets a Size to the Textarea
-}
withSize : Size -> Model ctx msg -> Model ctx msg
withSize size (Model configuration) =
    Model { configuration | size = size }


{-| Sets a ClassList to the Textarea
-}
withClassList : List ( String, Bool ) -> Model ctx msg -> Model ctx msg
withClassList classes (Model configuration) =
    Model { configuration | classList = classes }


{-| Sets a Name to the Textarea
-}
withName : String -> Model ctx msg -> Model ctx msg
withName name (Model configuration) =
    Model { configuration | name = Just name }


{-| Sets a Placeholder to the Textarea
-}
withPlaceholder : String -> Model ctx msg -> Model ctx msg
withPlaceholder placeholder (Model configuration) =
    Model { configuration | placeholder = Just placeholder }


{-| Internal.
-}
setValue : String -> Model ctx msg -> Model ctx msg
setValue value (Model configuration) =
    Model { configuration | value = value }


{-| Validate and update the internal model.
-}
validate : ctx -> Model ctx msg -> Model ctx msg
validate ctx ((Model { validation, value }) as model) =
    let
        validationResult : Result String String
        validationResult =
            validation ctx value
    in
    model
        |> addFieldStatus (FieldStatus.fromResult validationResult)
        |> setErrorMessage (getErrorMessage validationResult)


{-| Internal.
-}
getErrorMessage : Result String String -> Maybe String
getErrorMessage result =
    case result of
        Ok _ ->
            Nothing

        Err error ->
            Just error


{-| Internal.
-}
setErrorMessage : Maybe String -> Model ctx msg -> Model ctx msg
setErrorMessage error (Model configuration) =
    Model { configuration | errorMessage = error }


{-| Internal.
-}
addFieldStatus : FieldStatus -> Model ctx msg -> Model ctx msg
addFieldStatus fieldStatus (Model configuration) =
    Model { configuration | status = FieldStatus.addStatus fieldStatus configuration.status }


{-| Returns the current value of the Textarea.
-}
getValue : Model ctx msg -> String
getValue (Model configuration) =
    configuration.value


{-| Returns the validated value of the Input Text.
-}
getValidatedValue : ctx -> Model ctx msg -> Result String String
getValidatedValue ctx (Model { validation, value }) =
    validation ctx value


{-| Renders the Textarea.
-}
render : Model ctx msg -> Html msg
render (Model configuration) =
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--error", configuration.errorMessage /= Nothing )
            , ( "form-field--disabled", configuration.disabled )
            ]
        ]
        [ viewInput configuration
        , configuration.errorMessage
            |> Maybe.map (viewError configuration.id)
            |> CommonsRender.renderMaybe
        ]


{-| Internal.
-}
viewError : String -> String -> Html msg
viewError id errorMessage =
    Html.div
        [ Attributes.class "form-field__error-message"
        , Attributes.id (errorMessageId id)
        ]
        [ Html.text errorMessage
        ]


{-| Internal.
-}
viewInput : Configuration ctx msg -> Html msg
viewInput configuration =
    Html.textarea
        (CommonsAttributes.compose
            [ Attributes.id configuration.id
            , Attributes.classList
                [ ( "form-field__textarea", True )
                , ( "form-field__textarea--small", Size.isSmall configuration.size )
                ]
            , Attributes.classList configuration.classList
            , CommonsAttributes.testId configuration.id
            , Html.Events.onInput (OnInput >> configuration.msgTagger)
            , Html.Events.onFocus (configuration.msgTagger OnFocus)
            , Html.Events.onBlur (configuration.msgTagger OnBlur)
            , Attributes.disabled configuration.disabled
            , Attributes.value configuration.value
            ]
            [ Maybe.map Attributes.name configuration.name
            , Maybe.map Attributes.placeholder configuration.placeholder
            , Maybe.map
                (always (configuration.id |> errorMessageId |> CommonsAttributes.ariaDescribedBy))
                configuration.errorMessage
            ]
        )
        []


{-| Internal. For screen-reader.
-}
errorMessageId : String -> String
errorMessageId id =
    id ++ "-error"
