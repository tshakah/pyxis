module Components.Field.Select exposing
    ( Model
    , init
    , update, Msg
    , getValue
    , Config, create
    , withClassList
    , withDisabled
    , withName
    , withPlaceholder
    , withId
    , Option, option
    , withOptions
    , withSize
    , render
    )

{-|


# Select component

@docs Model
@docs init
@docs update, Msg


## Readers

@docs getValue


## View

@docs Config, create
@docs withClassList
@docs withDisabled
@docs withName
@docs withPlaceholder
@docs withId


#### Options

@docs Option, option
@docs withOptions


#### Size

@docs withSize, small, medium


#### Rendering

@docs render

-}

import Commons.Attributes
import Commons.Events.KeyDown as KeyDown
import Commons.Properties.Size as Size exposing (Size)
import Commons.Render
import Components.Field.Error as Error
import Components.Icon as Icon
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events
import PrimaUpdate
import Result.Extra


{-| A type representing the internal component `Msg`
-}
type Msg
    = Selected String
    | Blur
    | KeyDown KeyDown.Event
    | ClickedLabel
    | ClickedDropdownWrapper


{-| A type representing the select field internal state
-}
type Model ctx a
    = Model (ModelConfig ctx a)


{-| Internal.
-}
type alias ModelConfig ctx a =
    { blurredAtLeastOnce : Bool
    , isOpen : Bool
    , validation : ctx -> Maybe String -> Result String a
    , value : Maybe String
    }


{-| Initialize the select internal state. This belongs to your app's `Model`
Takes a validation function as argument
-}
init : (ctx -> Maybe String -> Result String a) -> Model ctx a
init validation =
    Model
        { blurredAtLeastOnce = False
        , isOpen = False
        , validation = validation
        , value = Nothing
        }


{-| Get the (parsed) select value
-}
getValue : ctx -> Model ctx a -> Maybe a
getValue ctx (Model { value, validation }) =
    Result.toMaybe (validation ctx value)


{-| Update the internal state of the Select component
-}
update : Msg -> Model ctx a -> ( Model ctx a, Cmd Msg )
update msg model =
    case msg of
        ClickedLabel ->
            model
                |> setIsOpen True
                |> PrimaUpdate.withoutCmds

        ClickedDropdownWrapper ->
            model
                |> setIsOpen False
                |> PrimaUpdate.withoutCmds

        Selected value ->
            model
                |> setSelectedValue value
                |> PrimaUpdate.withoutCmds

        Blur ->
            model
                |> setIsOpen False
                |> setBlurredAtLeastOnce
                |> PrimaUpdate.withoutCmds

        KeyDown keyCode ->
            if KeyDown.isSpace keyCode then
                model
                    |> setIsOpen (not (getIsOpen model))
                    |> PrimaUpdate.withoutCmds

            else
                model
                    |> PrimaUpdate.withoutCmds



-- View config


{-| A type representing the select rendering options.
This should not belong to the app `Model`
-}
type Config
    = Config
        { classList : List ( String, Bool )
        , disabled : Bool
        , id : Maybe String
        , isMobile : Bool
        , name : Maybe String
        , options : List Option
        , placeholder : Maybe String
        , size : Size
        }


{-| Create a [`Select.Config`](Select#Config) with the default options applied.
You can apply different options with the `withX` modifiers
-}
create : { isMobile : Bool } -> Config
create { isMobile } =
    Config
        { classList = []
        , disabled = False
        , id = Nothing
        , isMobile = isMobile
        , name = Nothing
        , options = []
        , placeholder = Nothing
        , size = Size.medium
        }


{-| A type representing a `<select>` option
-}
type Option
    = Option
        { value : String
        , label : String
        }


{-| Create an Option
-}
option : { value : String, label : String } -> Option
option =
    Option


{-| Set the select options
-}
withOptions : List Option -> Config -> Config
withOptions options (Config select) =
    Config { select | options = options }


{-| Set the text visible when no option is selected
Note: this is not a native placeholder attribute
-}
withPlaceholder : String -> Config -> Config
withPlaceholder placeholder (Config select) =
    Config { select | placeholder = Just placeholder }


{-| Set the disabled attribute
-}
withDisabled : Bool -> Config -> Config
withDisabled disabled (Config select) =
    Config { select | disabled = disabled }


{-| Set the name attribute
-}
withName : String -> Config -> Config
withName name (Config select) =
    Config { select | name = Just name }


{-| Set the id and data-test-id attributes
-}
withId : String -> Config -> Config
withId id (Config select) =
    Config { select | id = Just id }


{-| Set the select size
-}
withSize : Size -> Config -> Config
withSize size (Config select) =
    Config { select | size = size }


{-| Set the classes of the <select> element
Note that

                select
                |> Select.withClassList ["a", True]
                |> Select.withClassList ["b", True]

Only has the "b" class

_WARNING_: this function is considered unstable and should be used only as an emergency escape hatch

-}
withClassList : List ( String, Bool ) -> Config -> Config
withClassList classList (Config select) =
    Config { select | classList = classList }



-- Render


{-| Render the html
-}
render : ctx -> (Msg -> msg) -> Model ctx a -> Config -> Html msg
render ctx tagger ((Model { value, isOpen, validation }) as model) (Config select) =
    Html.div
        [ Attributes.classList
            [ ( "form-field", True )
            , ( "form-field--with-dropdown", not select.isMobile )
            , ( "form-field--with-opened-dropdown", not select.isMobile && isOpen )
            , ( "form-field--error", getUiError ctx model /= Nothing )
            , ( "form-field--disabled", select.disabled )
            ]
        ]
        [ Html.label
            [ Attributes.class "form-field__wrapper"
            , ClickedLabel
                |> Html.Events.onClick
                |> Commons.Attributes.renderIf (not select.isMobile && not select.disabled)
            ]
            [ Html.select
                [ Attributes.classList
                    [ ( "form-field__select", True )
                    , ( "form-field__select--filled", value /= Nothing )
                    , ( "form-field__select--small", Size.isSmall select.size )
                    ]
                , Attributes.classList select.classList
                , Attributes.disabled select.disabled

                -- Conditional attributes
                , Commons.Attributes.maybe Attributes.value value
                , Commons.Attributes.maybe Attributes.name select.name
                , Commons.Attributes.maybe Attributes.id select.id
                , Commons.Attributes.maybe Commons.Attributes.testId select.id

                -- Events
                , Html.Events.onInput Selected
                , Html.Events.onBlur Blur
                , KeyDown.onKeyDownPreventDefaultOn (\key -> ( KeyDown key, not select.isMobile ))
                ]
                (Html.option
                    [ Attributes.hidden True
                    , Attributes.disabled True
                    , Attributes.selected True
                    ]
                    [ select.placeholder
                        |> Maybe.map Html.text
                        |> Commons.Render.renderMaybe
                    ]
                    :: List.map viewNativeOption select.options
                )
            , Html.div
                [ Attributes.class "form-field__addon" ]
                [ IconSet.ChevronDown
                    |> Icon.create
                    |> Icon.render
                ]
            , model
                |> getUiError ctx
                |> Maybe.map Error.create
                |> Maybe.map (\error -> select.id |> Maybe.map (\id -> Error.withId id error) |> Maybe.withDefault error)
                |> Maybe.map Error.render
                |> Commons.Render.renderMaybe
            ]
        , select
            |> Config
            |> viewDropdownWrapper
        ]
        |> Html.map tagger


{-| Internal.
-}
getUiError : ctx -> Model ctx x -> Maybe String
getUiError ctx (Model { value, isOpen, validation, blurredAtLeastOnce }) =
    if blurredAtLeastOnce then
        value
            |> validation ctx
            |> Result.Extra.error

    else
        Nothing


{-| Internal.
-}
viewDropdownWrapper : Config -> Html Msg
viewDropdownWrapper (Config select) =
    -- Currently not using renderIf for performance reasons
    if select.isMobile then
        Html.text ""

    else
        Html.div
            [ Attributes.classList
                [ ( "form-field__dropdown-wrapper", True )
                , ( "form-field__dropdown-wrapper--small", Size.isSmall select.size )
                ]
            , Html.Events.onClick ClickedDropdownWrapper
            ]
            [ Html.div
                [ Attributes.class "form-field__dropdown" ]
                (List.map viewDropdownItem select.options)
            ]


{-| Internal.
-}
viewDropdownItem : Option -> Html Msg
viewDropdownItem (Option { value, label }) =
    Html.div
        [ Attributes.class "form-field__dropdown__item"
        , Html.Events.onClick (Selected value)
        ]
        [ Html.text label
        ]


{-| Internal.
-}
viewNativeOption : Option -> Html msg
viewNativeOption (Option { value, label }) =
    Html.option
        [ Attributes.value value
        ]
        [ Html.text label ]



-- Getters boilerplate


{-| Internal.
-}
setIsOpen : Bool -> Model ctx a -> Model ctx a
setIsOpen b (Model model) =
    Model { model | isOpen = b }


{-| Internal.
-}
getIsOpen : Model ctx a -> Bool
getIsOpen (Model { isOpen }) =
    isOpen


{-| Internal.
-}
setSelectedValue : String -> Model ctx a -> Model ctx a
setSelectedValue value (Model model) =
    Model { model | value = Just value }


{-| Internal.
-}
setBlurredAtLeastOnce : Model ctx a -> Model ctx a
setBlurredAtLeastOnce (Model model) =
    Model { model | blurredAtLeastOnce = True }
