module Examples.Quotation.MockData exposing
    ( CivilStatus
    , Occupation
    , civilStatusData
    , occupationData
    )

import Examples.Quotation.Entities.CivilStatus as GraphqlCivilStatus
import Examples.Quotation.Entities.Occupation as GraphqlOccupation
import Http
import Json.Decode as Dec exposing (Decoder)


decodeItemId : (String -> Maybe a) -> Decoder a
decodeItemId fromString =
    Dec.andThen
        (\string ->
            case fromString string of
                Just occ ->
                    Dec.succeed occ

                Nothing ->
                    Dec.fail "Parsing err"
        )
        Dec.string


decodeLabeledItem : (String -> Maybe a) -> Decoder { id : a, label : String }
decodeLabeledItem idDecoder =
    Dec.map2 (\id label -> { id = id, label = label })
        (Dec.field "id" (decodeItemId idDecoder))
        (Dec.field "label" Dec.string)


mockDataDecoder : String -> (String -> Maybe a) -> Decoder (List { id : a, label : String })
mockDataDecoder field idFromString =
    Dec.field field (Dec.list (decodeLabeledItem idFromString))


decodeData :
    { source : String
    , fieldName : String
    , idFromString : String -> Maybe a
    }
    -> Result Http.Error (List { id : a, label : String })
decodeData { source, idFromString, fieldName } =
    Dec.decodeString (mockDataDecoder fieldName idFromString) source
        |> Result.mapError (\e -> Http.BadBody (Dec.errorToString e))



-- Occupation


type alias Occupation =
    { id : GraphqlOccupation.Occupation
    , label : String
    }


occupationData : Result Http.Error (List Occupation)
occupationData =
    decodeData
        { idFromString = GraphqlOccupation.fromString
        , fieldName = "occupation"
        , source = occupations
        }


occupations : String
occupations =
    """
  {
  "occupation": [
    {
      "id": "IMPIEGATO_QUADRO_DIRIGENTE",
      "label": "Impiegato / Quadro / Dirigente"
    },
    {
      "id": "OPERAIO",
      "label": "Operaio"
    },
    {
      "id": "CASALINGA",
      "label": "Casalinga"
    },
    {
      "id": "PENSIONATO",
      "label": "Pensionato"
    },
    {
      "id": "INSEGNANTE",
      "label": "Insegnante"
    },
    {
      "id": "FORZE_ARMATE_GUARDIA_VIGILE",
      "label": "Forze Armate / Guardia / Vigile"
    },
    {
      "id": "ARTIGIANO_COMMERCIANTE",
      "label": "Artigiano / Commerciante"
    },
    {
      "id": "IMPRENDITORE",
      "label": "Imprenditore"
    },
    {
      "id": "LIBERO_PROFESSIONISTA",
      "label": "Libero professionista"
    },
    {
      "id": "PERSONALE_MEDICO",
      "label": "Personale medico"
    },
    {
      "id": "AGENTE_DI_COMMERCIO_RAPPRESENTANTE",
      "label": "Agente di commercio / Rappresentante"
    },
    {
      "id": "ALTRO",
      "label": "Altro"
    }
  ]
}
"""



-- Civil status


type alias CivilStatus =
    { id : GraphqlCivilStatus.CivilStatus
    , label : String
    }


civilStatusData : Result Http.Error (List CivilStatus)
civilStatusData =
    decodeData
        { idFromString = GraphqlCivilStatus.fromString
        , fieldName = "civilStatus"
        , source = civilStatus
        }


civilStatus : String
civilStatus =
    """
  {
  "civilStatus": [
    {
      "id": "MARRIED",
      "label": "Convivente / Sposato senza figli conviventi"
    },
    {
      "id": "MARRIED_WITH_SONS",
      "label": "Convivente / Sposato con figli conviventi"
    },
    {
      "id": "DIVORCED",
      "label": "Separato / Divorziato"
    },
    {
      "id": "SINGLE",
      "label": "Single"
    },
    {
      "id": "WIDOW",
      "label": "Vedovo"
    },
    {
      "id": "NOT_DECLARED",
      "label": "Non dichiarato"
    }
  ]
}
"""
