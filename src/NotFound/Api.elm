module NotFound.Api exposing (encoder, decoder)

import NotFound.Types as Types
import Json.Decode exposing (Decoder, int, string, fail, andThen, succeed)
import Json.Decode.Pipeline exposing (required, decode, custom)
import Json.Encode


encoder : Types.Model -> Json.Encode.Value
encoder model =
    Json.Encode.object
        [ ( "title", Json.Encode.string model.title )
        ]


decoder : Decoder Types.Model
decoder =
    decode Types.Model
        |> required "title" string
