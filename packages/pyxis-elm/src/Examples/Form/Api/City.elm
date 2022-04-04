module Examples.Form.Api.City exposing
    ( City
    , create
    , fetch
    , getIstatCode
    , getName
    , startsWith
    )

import Http
import Json.Decode as JD
import RemoteData exposing (RemoteData)


type City
    = City
        { name : String
        , istatCode : String
        }


fetch : (RemoteData Http.Error (List City) -> msg) -> Cmd msg
fetch msgMapper =
    Http.get
        { url = "https://comuni-ita.herokuapp.com/api/province?onlyname=true"
        , expect = Http.expectJson (RemoteData.fromResult >> msgMapper) decodeCity
        }


decodeCity : JD.Decoder (List City)
decodeCity =
    JD.list
        (JD.string
            |> JD.andThen
                (\city ->
                    JD.succeed
                        (create { name = city, istatCode = String.toUpper city })
                )
        )


create : { name : String, istatCode : String } -> City
create =
    City


getName : City -> String
getName (City { name }) =
    name


getIstatCode : City -> String
getIstatCode (City { istatCode }) =
    istatCode


startsWith : String -> City -> Bool
startsWith filter city =
    String.startsWith (String.toLower filter) (String.toLower (getName city))
