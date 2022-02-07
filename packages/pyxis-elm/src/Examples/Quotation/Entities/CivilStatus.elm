module Examples.Quotation.Entities.CivilStatus exposing (..)

import Json.Decode as Decode exposing (Decoder)


type CivilStatus
    = Divorced
    | Married
    | MarriedWithSons
    | NotDeclared
    | Partner
    | PartnerWithSons
    | Separate
    | Single
    | Widow


list : List CivilStatus
list =
    [ Divorced, Married, MarriedWithSons, NotDeclared, Partner, PartnerWithSons, Separate, Single, Widow ]


decoder : Decoder CivilStatus
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "DIVORCED" ->
                        Decode.succeed Divorced

                    "MARRIED" ->
                        Decode.succeed Married

                    "MARRIED_WITH_SONS" ->
                        Decode.succeed MarriedWithSons

                    "NOT_DECLARED" ->
                        Decode.succeed NotDeclared

                    "PARTNER" ->
                        Decode.succeed Partner

                    "PARTNER_WITH_SONS" ->
                        Decode.succeed PartnerWithSons

                    "SEPARATE" ->
                        Decode.succeed Separate

                    "SINGLE" ->
                        Decode.succeed Single

                    "WIDOW" ->
                        Decode.succeed Widow

                    _ ->
                        Decode.fail ("Invalid CivilStatus type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : CivilStatus -> String
toString enum____ =
    case enum____ of
        Divorced ->
            "DIVORCED"

        Married ->
            "MARRIED"

        MarriedWithSons ->
            "MARRIED_WITH_SONS"

        NotDeclared ->
            "NOT_DECLARED"

        Partner ->
            "PARTNER"

        PartnerWithSons ->
            "PARTNER_WITH_SONS"

        Separate ->
            "SEPARATE"

        Single ->
            "SINGLE"

        Widow ->
            "WIDOW"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe CivilStatus
fromString enumString____ =
    case enumString____ of
        "DIVORCED" ->
            Just Divorced

        "MARRIED" ->
            Just Married

        "MARRIED_WITH_SONS" ->
            Just MarriedWithSons

        "NOT_DECLARED" ->
            Just NotDeclared

        "PARTNER" ->
            Just Partner

        "PARTNER_WITH_SONS" ->
            Just PartnerWithSons

        "SEPARATE" ->
            Just Separate

        "SINGLE" ->
            Just Single

        "WIDOW" ->
            Just Widow

        _ ->
            Nothing
