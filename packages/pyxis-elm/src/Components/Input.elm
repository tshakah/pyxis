module Components.Input exposing
    ( Input
    , Model
    , Msg
    , date
    , dateMax
    , dateMin
    , detectChanges
    , email
    , empty
    , enhanceUpdateWithMask
    , forceValidation
    , getData
    , getValue
    , iconAddon
    , init
    , medium
    , number
    , password
    , render
    , small
    , submit
    , text
    , textAddon
    , update
    , withAddon
    , withDisabled
    , withId
    , withIsSubmitted
    , withMaxLength
    , withMinLength
    , withName
    , withNumberMax
    , withNumberMin
    , withPlaceholder
    , withSize
    )

import Commons.Attributes as CommonsAttributes
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Render as CommonsRender
import Components.Icon as Icon
import Components.IconSet as IconSet
import Date exposing (Date)
import FieldState exposing (FieldState)
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import Maybe.Extra
import Result.Extra
import Utils
import Validation exposing (Validation)


{-| Non-opaque by design
Keep variants exposed
-}
type Msg
    = Focus
    | Input String
    | Blur
    | Submit


submit : Msg
submit =
    Submit


type Model data
    = Model
        { formState : FieldState
        , value : String
        , initialValue : String
        , validation : Validation String data
        , showValidation : Bool
        , validationOverride : Maybe (Result String ())
        }


init : String -> Validation String data -> Model data
init initialValue validation =
    Model
        { formState = FieldState.Untouched
        , value = initialValue
        , initialValue = initialValue
        , validation = validation
        , showValidation = False
        , validationOverride = Just (Ok ())
        }


overrideValidation : Maybe (Result String x) -> Model data -> Model data
overrideValidation result (Model model) =
    Model
        { model
            | validationOverride = Maybe.map Result.Extra.void result
        }


forceValidation :
    (field -> form -> Maybe (Result String ()))
    -> form
    -> (form -> Model field)
    -> Model field
forceValidation validation form getInputModel =
    let
        model : Model field
        model =
            getInputModel form

        selfResult : Result String field
        selfResult =
            validateBeforeOverride model
    in
    case selfResult of
        Err _ ->
            model

        Ok self ->
            overrideValidation (validation self form) model


detectChanges : Model data -> Model (Maybe data)
detectChanges (Model model) =
    let
        validation : Validation String (Maybe data)
        validation str =
            if str == model.initialValue then
                Ok Nothing

            else
                Result.map Just (model.validation str)
    in
    Model
        { formState = model.formState
        , value = model.value
        , showValidation = model.showValidation
        , initialValue = model.initialValue
        , validationOverride = model.validationOverride
        , validation = validation
        }


empty : Validation String data -> Model data
empty =
    init ""


getValue : Model data -> String
getValue (Model { value }) =
    value


getData : Model data -> Maybe data
getData (Model { validation, value, validationOverride }) =
    case validation value of
        Ok x ->
            case validationOverride of
                Nothing ->
                    Just x

                Just (Ok ()) ->
                    Just x

                Just (Err _) ->
                    Nothing

        Err _ ->
            Nothing


{-| Internal implementation detail
-}
validateBeforeOverride : Model data -> Result String data
validateBeforeOverride (Model { validation, value }) =
    validation value


type alias ValidationMessageStrategy data =
    { formState : FieldState
    , msg : Msg
    , previousValidation : Result String data
    }
    -> Maybe Bool


updateWithCustomStrategy :
    ValidationMessageStrategy data
    -> Msg
    -> Model data
    -> Model data
updateWithCustomStrategy strategy msg (Model model) =
    let
        newModel =
            case msg of
                Input str ->
                    { model
                        | value = str
                        , formState = FieldState.input model.formState
                    }

                Blur ->
                    { model
                        | formState = FieldState.blur model.formState
                    }

                Focus ->
                    { model
                        | formState = FieldState.focus model.formState
                    }

                Submit ->
                    model
    in
    Model
        { newModel
            | showValidation =
                case newModel.validation newModel.value of
                    Ok _ ->
                        False

                    Err _ ->
                        strategy
                            { formState = newModel.formState
                            , msg = msg
                            , previousValidation = model.validation model.value
                            }
                            |> Maybe.withDefault newModel.showValidation
        }


update : Msg -> Model data -> Model data
update =
    updateWithCustomStrategy validateOnBlurStrategy


enhanceUpdateWithMask :
    (String -> Maybe String)
    -> (Msg -> Model data -> Model data)
    -> Msg
    -> Model data
    -> Model data
enhanceUpdateWithMask mask update_ msg model =
    case msg of
        Input str ->
            case mask str of
                Nothing ->
                    model

                Just maskedStr ->
                    update_ (Input maskedStr) model

        _ ->
            update_ msg model



-- Default strategies


validateOnBlurStrategy : ValidationMessageStrategy value
validateOnBlurStrategy { formState, msg, previousValidation } =
    case ( formState, msg, previousValidation ) of
        ( _, Blur, _ ) ->
            Just True

        ( _, Submit, _ ) ->
            Just True

        _ ->
            Nothing



-- View


type AddonType
    = IconAddon IconSet.Icon
    | TextAddon String


type alias Addon =
    { placement : Placement
    , type_ : AddonType
    }


type Size
    = Size (Maybe String)


small : Size
small =
    Size (Just "small")


medium : Size
medium =
    Size Nothing


withSize : Size -> Input x -> Input x
withSize size (Config input) =
    Config { input | size = size }


{-| Represent the Type(s) an Input could be.
-}
type Type
    = Date
    | Email
    | Number
    | Password
    | Text


{-| Internal.
-}
typeToAttribute : Type -> Html.Attribute msg
typeToAttribute a =
    case a of
        Date ->
            Attributes.type_ "date"

        Email ->
            Attributes.type_ "email"

        Number ->
            Attributes.type_ "number"

        Password ->
            Attributes.type_ "password"

        Text ->
            Attributes.type_ "text"


{-| Creates an input with [type="email"].
-}
email : Input { email : (), canHaveAddon : () }
email =
    config Email


{-| Creates an input with [type="date"].
-}
date : Input { date : () }
date =
    config Date


dateMin : Date -> Input { r | date : () } -> Input { r | date : () }
dateMin =
    withAttribute << Attributes.min << Date.toIsoString


dateMax : Date -> Input { r | date : () } -> Input { r | date : () }
dateMax =
    withAttribute << Attributes.max << Date.toIsoString


{-| Creates an input with [type="number"].
-}
number : Input { number : (), canHaveAddon : () }
number =
    config Number


withNumberMin : Float -> Input { r | number : () } -> Input { r | number : () }
withNumberMin =
    withAttribute << Attributes.min << String.fromFloat


withNumberMax : Float -> Input { r | number : () } -> Input { r | number : () }
withNumberMax =
    withAttribute << Attributes.max << String.fromFloat


{-| Creates an input with [type="text"].
-}
text : Input { text : (), canHaveAddon : () }
text =
    config Text


{-| Creates an input with [type="password"].
-}
password : Input { password : (), canHaveAddon : () }
password =
    config Password


{-| Creates an Addon with an Icon from our IconSet.
-}
iconAddon : IconSet.Icon -> AddonType
iconAddon =
    IconAddon


{-| Creates an Addon with a String content.
-}
textAddon : String -> AddonType
textAddon =
    TextAddon


{-| Internal, DO NOT EXPOSE
-}
withAttribute : Html.Attribute Msg -> Input c -> Input c
withAttribute attr (Config model) =
    Config { model | attributes = attr :: model.attributes }


withPlaceholder : String -> Input c -> Input c
withPlaceholder =
    withAttribute << Attributes.placeholder


withName : String -> Input c -> Input c
withName =
    withAttribute << Attributes.name


withMaxLength : Int -> Input c -> Input c
withMaxLength =
    withAttribute << Attributes.maxlength


withMinLength : Int -> Input c -> Input c
withMinLength =
    withAttribute << Attributes.minlength


{-| Sets an Addon to the Input.
-}
withAddon : Placement -> AddonType -> Input { c | canHaveAddon : () } -> Input { c | canHaveAddon : () }
withAddon placement type_ (Config configuration) =
    Config { configuration | addon = Just { placement = placement, type_ = type_ } }


withIsSubmitted : Bool -> Input c -> Input c
withIsSubmitted b (Config input) =
    Config { input | isSubmitted = b }


withDisabled : Bool -> Input c -> Input c
withDisabled isDisabled (Config configuration) =
    Config { configuration | disabled = isDisabled }


withId : String -> Input c -> Input c
withId id model =
    model
        |> withAttribute (Attributes.id id)
        |> withAttribute (CommonsAttributes.testId id)


type Input constraints
    = Config
        { attributes : List (Html.Attribute Msg)
        , addon : Maybe Addon
        , classList : List ( String, Bool )
        , size : Size
        , disabled : Bool
        , type_ : Type
        , id : Maybe String
        , isSubmitted : Bool
        }


{-| Internal, DO NOT EXPOSE
-}
config : Type -> Input any
config type_ =
    Config
        { attributes = []
        , addon = Nothing
        , classList = []
        , size = medium
        , disabled = False
        , type_ = type_
        , id = Nothing
        , isSubmitted = False
        }


getFormFieldSizeClass : Size -> Maybe String
getFormFieldSizeClass (Size size) =
    Maybe.map (\s -> "form-field--" ++ s) size


typeToString : Type -> String
typeToString type_ =
    case type_ of
        Date ->
            "date"

        Text ->
            "text"

        _ ->
            -- not implemented by pyxis yet
            "text"


getResultError : Result a value -> Maybe a
getResultError result =
    case result of
        Err err ->
            Just err

        Ok _ ->
            Nothing


{-| Internal, no need to expose
-}
getErrorMessage : { r | isSubmitted : Bool } -> Model data -> Maybe String
getErrorMessage { isSubmitted } (Model model) =
    case model.validationOverride of
        Just (Err msg) ->
            Just msg

        Just (Ok ()) ->
            if model.showValidation || isSubmitted then
                getResultError (model.validation model.value)

            else
                Nothing

        _ ->
            Nothing


normalizeConfig : Input c -> Input c
normalizeConfig (Config config_) =
    case config_.type_ of
        Date ->
            Config
                { config_
                    | addon =
                        Just
                            { placement = Placement.prepend
                            , type_ = IconAddon IconSet.Calendar
                            }
                }

        _ ->
            Config config_


{-| Renders the Input.
-}
render : Model value -> (Msg -> msg) -> Input x -> Html msg
render ((Model model_) as model) tagger rawConfig =
    let
        ((Config configuration) as configuration_) =
            normalizeConfig rawConfig

        errorMessage =
            getErrorMessage configuration model
    in
    Utils.concatArgs Html.div
        [ [ Attributes.classList
                [ ( "form-field", True )
                , ( "form-field--error", errorMessage /= Nothing )
                , ( "form-field--disabled", configuration.disabled )
                ]
          ]
        , Maybe.Extra.mapToList addonToAttribute configuration.addon
        , Maybe.Extra.mapToList Attributes.class (getFormFieldSizeClass configuration.size)
        , Maybe.Extra.mapToList CommonsAttributes.ariaDescribedBy
            (Maybe.map2 (\_ -> errorMessageId) errorMessage configuration.id)
        ]
        [ configuration.addon
            |> Maybe.map (viewInputAndAddon model_.value configuration_)
            |> Maybe.withDefault (viewInput model_.value configuration_)
            |> Html.map tagger
        , Utils.concatArgs Html.div
            [ [ Attributes.class "form-field__error-message" ]
            , Maybe.Extra.mapToList (Attributes.id << errorMessageId) configuration.id
            ]
            [ Maybe.map Html.text errorMessage |> CommonsRender.renderMaybe
            ]
        ]


{-| Internal.
-}
viewInputAndAddon : String -> Input x -> Addon -> Html Msg
viewInputAndAddon value configuration addon =
    Html.label [ Attributes.class "form-field__wrapper" ]
        [ CommonsRender.renderIf (Placement.isPrepend addon.placement) (viewAddon addon.type_)
        , viewInput value configuration
        , CommonsRender.renderIf (Placement.isAppend addon.placement) (viewAddon addon.type_)
        ]


{-| Internal.
-}
viewAddon : AddonType -> Html msg
viewAddon type_ =
    case type_ of
        IconAddon icon ->
            Html.div [ Attributes.class "form-field__addon" ]
                [ Icon.create icon |> Icon.render ]

        TextAddon str ->
            Html.span [ Attributes.class "form-field__addon" ]
                [ Html.text str ]


{-| Internal
-}
addonTypeToString : AddonType -> String
addonTypeToString addonType =
    case addonType of
        IconAddon _ ->
            "icon"

        TextAddon _ ->
            "text"


{-| Internal.
-}
addonToAttribute : Addon -> Html.Attribute msg
addonToAttribute { type_, placement } =
    [ "form-field--with"
    , Placement.toString placement
    , addonTypeToString type_
    ]
        |> String.join "-"
        |> Attributes.class


{-| Internal.
-}
getFormFieldTextSizeClass : Size -> Maybe String
getFormFieldTextSizeClass (Size size) =
    Maybe.map (\s -> "form-field--text-" ++ s) size


{-| Internal.
-}
viewInput : String -> Input x -> Html Msg
viewInput value (Config configuration) =
    Utils.concatArgs Html.input
        [ List.reverse configuration.attributes
        , [ Attributes.class ("form-field__" ++ typeToString configuration.type_)
          , Attributes.classList configuration.classList
          , Attributes.disabled configuration.disabled
          , typeToAttribute configuration.type_
          , Html.Events.onFocus Focus
          , Html.Events.onBlur Blur
          , Html.Events.onInput Input
          , Attributes.value value
          ]
        , Maybe.Extra.mapToList Attributes.class (getFormFieldTextSizeClass configuration.size)
        ]
        []


{-| Internal. For screen-reader.
-}
errorMessageId : String -> String
errorMessageId id =
    id ++ "-error"
