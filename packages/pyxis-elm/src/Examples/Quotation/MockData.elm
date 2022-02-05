module Examples.Quotation.MockData exposing (Occupation, data)

import Examples.Quotation.Entities.Occupation as GraphqlOccupation
import Http
import Json.Decode as Dec exposing (Decoder)


data : Result Http.Error (List Occupation)
data =
    Dec.decodeString decoder occupations
        |> Result.mapError (\e -> Http.BadBody (Dec.errorToString e))


type alias Occupation =
    { id : GraphqlOccupation.Occupation
    , label : String
    }


decodeId : Dec.Decoder GraphqlOccupation.Occupation
decodeId =
    Dec.andThen
        (\string ->
            case GraphqlOccupation.fromString string of
                Just occ ->
                    Dec.succeed occ

                Nothing ->
                    Dec.fail "Parsing err"
        )
        Dec.string


itemDecoder : Decoder Occupation
itemDecoder =
    Dec.map2 Occupation
        (Dec.field "id" decodeId)
        (Dec.field "label" Dec.string)


decoder : Decoder (List Occupation)
decoder =
    Dec.field "occupation" (Dec.list itemDecoder)


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
