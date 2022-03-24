module Components.Field.FormItem exposing
    ( PartialFieldConfig
    , config
    , withAdditionalContent
    , withLabel
    , render
    )

{-|


# FormItem component


## Config

@docs PartialFieldConfig
@docs config


## Generics

@docs withAdditionalContent
@docs withLabel


## Rendering

@docs render

-}

import Commons.Render
import Components.Field.Error as Error
import Components.Field.Hint as Hint
import Components.Field.Label as Label
import Html exposing (Html)
import Html.Attributes as Attributes


{-| Partial representation of the field configuration
-}
type alias PartialFieldConfig a =
    { a
        | id : String
        , hint : Maybe Hint.Config
    }


{-| Internal.
-}
type Config a msg
    = Config
        { additionalContent : Maybe (Html Never)
        , field : Html msg
        , fieldConfig : PartialFieldConfig a
        , label : Maybe Label.Config
        }


{-| Internal
-}
customizeLabel : PartialFieldConfig a -> Label.Config -> Label.Config
customizeLabel configData =
    Label.withId (configData.id ++ "-label")
        >> Label.withFor configData.id


{-| Generate FormItem Config.
-}
config : PartialFieldConfig a -> Html msg -> Config a msg
config fieldConfig field =
    Config
        { additionalContent = Nothing
        , field = field
        , fieldConfig = fieldConfig
        , label = Nothing
        }


{-| Adds a Label to the field.
-}
withLabel : Maybe Label.Config -> Config a msg -> Config a msg
withLabel label (Config configuration) =
    Config { configuration | label = label }


{-| Append an additional custom html.
-}
withAdditionalContent : Maybe (Html Never) -> Config a msg -> Config a msg
withAdditionalContent additionalContent (Config configuration) =
    Config { configuration | additionalContent = additionalContent }


{-| FormItem render.
-}
render : Result String value -> Config a msg -> Html msg
render validationResult (Config { label, field, fieldConfig, additionalContent }) =
    Html.div
        [ Attributes.class "form-item" ]
        [ label
            |> Maybe.map (customizeLabel fieldConfig >> Label.render)
            |> Commons.Render.renderMaybe
        , Html.div
            [ Attributes.class "form-item__wrapper" ]
            [ field
            , validationResult
                |> Error.fromResult
                |> Commons.Render.renderErrorOrHint fieldConfig.id fieldConfig.hint
            ]
        , Commons.Render.renderMaybe (Maybe.map (Html.map never) additionalContent)
        ]
