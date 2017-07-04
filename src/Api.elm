module Api exposing (decoder, encoder)

import Json.Decode exposing (Decoder, int, string, fail, andThen, succeed)
import Json.Decode.Pipeline exposing (required, decode, custom)
import Json.Encode
import Types
import Router.Types exposing (..)


decoder : Decoder Types.Model
decoder =
    decode Types.Model
        |> required "click" int
        |> required "route" routerDecoder


encoder : Types.Model -> Json.Encode.Value
encoder model =
    Json.Encode.object
        [ ( "click", Json.Encode.int model.click )
        , ( "route", routerEncoder model.currentRoute )
        ]


routerDecoder : Decoder Route
routerDecoder =
    string
        |> andThen
            (\route ->
                case route of
                    "Home" ->
                        succeed Home

                    "NotFoundRoute" ->
                        succeed NotFoundRoute

                    "Dresses" ->
                        succeed Dresses

                    _ ->
                        fail (route ++ " is not a recognized route for Route")
            )


routerEncoder : Route -> Json.Encode.Value
routerEncoder route =
    case route of
        NotFoundRoute ->
            Json.Encode.string "NotFoundRoute"

        Home ->
            Json.Encode.string "Home"

        Dresses ->
            Json.Encode.string "Dresses"
