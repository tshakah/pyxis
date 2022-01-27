module Components.Field.Input exposing
    ( Model
    , date
    , email
    , number
    , text
    , password
    , AddOn
    , iconAddOn
    , textAddOn
    , withAddOn
    , withSize
    , withClassList
    , withName
    , withPlaceholder
    , render
    , addFieldStatus
    )

{-|


# Input component

@docs Model, Type
@docs date
@docs email
@docs number
@docs text
@docs password


## AddOn

@docs AddOn
@docs iconAddOn
@docs textAddOn
@docs withAddOn


## Size

@docs withSize


## Generics

@docs withClassList
@docs withName
@docs withPlaceholder


## Rendering

@docs render

-}

import Commons.Attributes as CommonsAttributes
import Commons.Properties.FieldStatus as FieldStatus exposing (FieldStatus)
import Commons.Properties.Placement as Placement exposing (Placement)
import Commons.Properties.Size as Size exposing (Size)
import Components.IconSet as IconSet
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events


{-| The Input model.
-}
type Model msg
    = Model (Configuration msg)


{-| Internal. The internal Input configuration.
-}
type alias Configuration msg =
    { addOn : Maybe AddOn
    , classList : List ( String, Bool )
    , id : String
    , events : Events msg
    , name : Maybe String
    , placeholder : Maybe String
    , size : Size
    , status : FieldStatus.StatusList
    , type_ : Type
    }


{-| Internal. The internal Input Event configuration.
-}
type alias Events msg =
    { onBlur : msg
    , onInput : String -> msg
    , onFocus : msg
    }


{-| Represent the Type(s) an Input could be.
-}
type Type
    = Date
    | Email
    | Number
    | Password
    | Text


{-| Internal. Creates an Input field.
-}
create : Type -> Events msg -> String -> Model msg
create inputType events id =
    Model
        { classList = []
        , id = id
        , events = events
        , name = Nothing
        , placeholder = Nothing
        , size = Size.medium
        , status = FieldStatus.initStatusList [ FieldStatus.untouched, FieldStatus.pristine ]
        , type_ = inputType
        , addOn = Nothing
        }


{-| Creates an input with [type="email"].
-}
email : Events msg -> String -> Model msg
email =
    create Email


{-| Creates an input with [type="date"].
-}
date : Events msg -> String -> Model msg
date =
    create Date


{-| Creates an input with [type="number"].
-}
number : Events msg -> String -> Model msg
number =
    create Number


{-| Creates an input with [type="text"].
-}
text : Events msg -> String -> Model msg
text =
    create Text


{-| Creates an input with [type="password"].
-}
password : Events msg -> String -> Model msg
password =
    create Password


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


type AddOn
    = IconAddOn Placement IconSet.Icon
    | TextAddOn Placement String


{-| Creates an AddOn with an Icon from our IconSet.
-}
iconAddOn : Placement -> IconSet.Icon -> AddOn
iconAddOn =
    IconAddOn


{-| Creates an AddOn with a String content.
-}
textAddOn : Placement -> String -> AddOn
textAddOn =
    TextAddOn


{-| Sets an AddOn to the Input.
-}
withAddOn : AddOn -> Model msg -> Model msg
withAddOn addOn (Model configuration) =
    Model { configuration | addOn = Just addOn }


{-| Internal.
-}
addOnToAttribute : AddOn -> Html.Attribute msg
addOnToAttribute a =
    case a of
        IconAddOn placement _ ->
            if Placement.isAppend placement then
                Attributes.class "form-field--with-prepend-icon"

            else
                Attributes.class "form-field--with-append-icon"

        TextAddOn placement _ ->
            if Placement.isPrepend placement then
                Attributes.class "form-field--with-prepend-text"

            else
                Attributes.class "form-field--with-append-text"


{-| Sets a Size to the Input.
-}
withSize : Size -> Model msg -> Model msg
withSize size (Model configuration) =
    Model { configuration | size = size }


{-| Sets a ClassList to the Input.
-}
withClassList : List ( String, Bool ) -> Model msg -> Model msg
withClassList classes (Model configuration) =
    Model { configuration | classList = classes }


{-| Sets a Name to the Input.
-}
withName : String -> Model msg -> Model msg
withName name (Model configuration) =
    Model { configuration | name = Just name }


{-| Sets a Placeholder to the Input.
-}
withPlaceholder : String -> Model msg -> Model msg
withPlaceholder placeholder (Model configuration) =
    Model { configuration | placeholder = Just placeholder }


addFieldStatus : FieldStatus -> Model msg -> Model msg
addFieldStatus fieldStatus (Model configuration) =
    Model { configuration | status = FieldStatus.addStatus fieldStatus configuration.status }


{-| Renders the Input.
-}
render : Model msg -> Html msg
render (Model configuration) =
    Html.div
        (CommonsAttributes.compose
            [ Attributes.classList
                [ ( "form-field", True )
                , ( "form-field--small", Size.isSmall configuration.size )
                , ( "form-field--error", FieldStatus.hasError configuration.status )
                ]
            ]
            [ Maybe.map addOnToAttribute configuration.addOn ]
        )
        [ Html.input
            (CommonsAttributes.compose
                [ Attributes.id configuration.id
                , Attributes.class "form-field__text"
                , Attributes.classList [ ( "form-field--text-small", Size.isSmall configuration.size ) ]
                , Attributes.classList configuration.classList
                , CommonsAttributes.testId configuration.id
                , Html.Events.onInput configuration.events.onInput
                , typeToAttribute configuration.type_
                ]
                [ Maybe.map Attributes.name configuration.name
                , Maybe.map Attributes.placeholder configuration.placeholder
                ]
            )
            []
        ]
