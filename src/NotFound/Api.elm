module NotFound.Api exposing (encoder, decoder)

import NotFound.Types as Types
import Json.Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (required, decode)
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
