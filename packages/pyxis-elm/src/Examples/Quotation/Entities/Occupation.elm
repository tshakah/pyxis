module Examples.Quotation.Entities.Occupation exposing (..)

import Json.Decode as Decode exposing (Decoder)


type Occupation
    = AgenteDiCommercioRappresentante
    | Altro
    | Artigiano
    | ArtigianoCommerciante
    | Casalinga
    | Commerciante
    | DirigenteFunzionario
    | Ecclesiastico
    | ForzeArmateGuardiaVigile
    | Impiegato
    | ImpiegatoQuadroDirigente
    | Imprenditore
    | InCercaDiOccupazione
    | Insegnante
    | LiberoProfessionista
    | Operaio
    | Pensionato
    | PersonaleMedico
    | Sconosciuto
    | Studente


list : List Occupation
list =
    [ AgenteDiCommercioRappresentante, Altro, Artigiano, ArtigianoCommerciante, Casalinga, Commerciante, DirigenteFunzionario, Ecclesiastico, ForzeArmateGuardiaVigile, Impiegato, ImpiegatoQuadroDirigente, Imprenditore, InCercaDiOccupazione, Insegnante, LiberoProfessionista, Operaio, Pensionato, PersonaleMedico, Sconosciuto, Studente ]


decoder : Decoder Occupation
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "AGENTE_DI_COMMERCIO_RAPPRESENTANTE" ->
                        Decode.succeed AgenteDiCommercioRappresentante

                    "ALTRO" ->
                        Decode.succeed Altro

                    "ARTIGIANO" ->
                        Decode.succeed Artigiano

                    "ARTIGIANO_COMMERCIANTE" ->
                        Decode.succeed ArtigianoCommerciante

                    "CASALINGA" ->
                        Decode.succeed Casalinga

                    "COMMERCIANTE" ->
                        Decode.succeed Commerciante

                    "DIRIGENTE_FUNZIONARIO" ->
                        Decode.succeed DirigenteFunzionario

                    "ECCLESIASTICO" ->
                        Decode.succeed Ecclesiastico

                    "FORZE_ARMATE_GUARDIA_VIGILE" ->
                        Decode.succeed ForzeArmateGuardiaVigile

                    "IMPIEGATO" ->
                        Decode.succeed Impiegato

                    "IMPIEGATO_QUADRO_DIRIGENTE" ->
                        Decode.succeed ImpiegatoQuadroDirigente

                    "IMPRENDITORE" ->
                        Decode.succeed Imprenditore

                    "IN_CERCA_DI_OCCUPAZIONE" ->
                        Decode.succeed InCercaDiOccupazione

                    "INSEGNANTE" ->
                        Decode.succeed Insegnante

                    "LIBERO_PROFESSIONISTA" ->
                        Decode.succeed LiberoProfessionista

                    "OPERAIO" ->
                        Decode.succeed Operaio

                    "PENSIONATO" ->
                        Decode.succeed Pensionato

                    "PERSONALE_MEDICO" ->
                        Decode.succeed PersonaleMedico

                    "SCONOSCIUTO" ->
                        Decode.succeed Sconosciuto

                    "STUDENTE" ->
                        Decode.succeed Studente

                    _ ->
                        Decode.fail ("Invalid Occupation type, " ++ string ++ " try re-running the @dillonkearns/elm-graphql CLI ")
            )


{-| Convert from the union type representing the Enum to a string that the GraphQL server will recognize.
-}
toString : Occupation -> String
toString enum____ =
    case enum____ of
        AgenteDiCommercioRappresentante ->
            "AGENTE_DI_COMMERCIO_RAPPRESENTANTE"

        Altro ->
            "ALTRO"

        Artigiano ->
            "ARTIGIANO"

        ArtigianoCommerciante ->
            "ARTIGIANO_COMMERCIANTE"

        Casalinga ->
            "CASALINGA"

        Commerciante ->
            "COMMERCIANTE"

        DirigenteFunzionario ->
            "DIRIGENTE_FUNZIONARIO"

        Ecclesiastico ->
            "ECCLESIASTICO"

        ForzeArmateGuardiaVigile ->
            "FORZE_ARMATE_GUARDIA_VIGILE"

        Impiegato ->
            "IMPIEGATO"

        ImpiegatoQuadroDirigente ->
            "IMPIEGATO_QUADRO_DIRIGENTE"

        Imprenditore ->
            "IMPRENDITORE"

        InCercaDiOccupazione ->
            "IN_CERCA_DI_OCCUPAZIONE"

        Insegnante ->
            "INSEGNANTE"

        LiberoProfessionista ->
            "LIBERO_PROFESSIONISTA"

        Operaio ->
            "OPERAIO"

        Pensionato ->
            "PENSIONATO"

        PersonaleMedico ->
            "PERSONALE_MEDICO"

        Sconosciuto ->
            "SCONOSCIUTO"

        Studente ->
            "STUDENTE"


{-| Convert from a String representation to an elm representation enum.
This is the inverse of the Enum `toString` function. So you can call `toString` and then convert back `fromString` safely.

    Swapi.Enum.Episode.NewHope
        |> Swapi.Enum.Episode.toString
        |> Swapi.Enum.Episode.fromString
        == Just NewHope

This can be useful for generating Strings to use for <select> menus to check which item was selected.

-}
fromString : String -> Maybe Occupation
fromString enumString____ =
    case enumString____ of
        "AGENTE_DI_COMMERCIO_RAPPRESENTANTE" ->
            Just AgenteDiCommercioRappresentante

        "ALTRO" ->
            Just Altro

        "ARTIGIANO" ->
            Just Artigiano

        "ARTIGIANO_COMMERCIANTE" ->
            Just ArtigianoCommerciante

        "CASALINGA" ->
            Just Casalinga

        "COMMERCIANTE" ->
            Just Commerciante

        "DIRIGENTE_FUNZIONARIO" ->
            Just DirigenteFunzionario

        "ECCLESIASTICO" ->
            Just Ecclesiastico

        "FORZE_ARMATE_GUARDIA_VIGILE" ->
            Just ForzeArmateGuardiaVigile

        "IMPIEGATO" ->
            Just Impiegato

        "IMPIEGATO_QUADRO_DIRIGENTE" ->
            Just ImpiegatoQuadroDirigente

        "IMPRENDITORE" ->
            Just Imprenditore

        "IN_CERCA_DI_OCCUPAZIONE" ->
            Just InCercaDiOccupazione

        "INSEGNANTE" ->
            Just Insegnante

        "LIBERO_PROFESSIONISTA" ->
            Just LiberoProfessionista

        "OPERAIO" ->
            Just Operaio

        "PENSIONATO" ->
            Just Pensionato

        "PERSONALE_MEDICO" ->
            Just PersonaleMedico

        "SCONOSCIUTO" ->
            Just Sconosciuto

        "STUDENTE" ->
            Just Studente

        _ ->
            Nothing
