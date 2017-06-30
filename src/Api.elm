module Api exposing (decoder)

import Json.Decode exposing (Decoder, int)
import Json.Decode.Pipeline exposing (required, decode)
import Types


decoder : Decoder Types.Model
decoder =
    decode Types.Model
        |> required "click" int
