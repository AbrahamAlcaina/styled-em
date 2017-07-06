module Api exposing (decoder, encoder)

import Json.Decode exposing (Decoder, map, oneOf, field, int, string, fail, andThen, succeed, maybe, at)
import Json.Decode.Pipeline exposing (required, decode, optional, custom)
import Json.Encode
import Types
import Router.Types exposing (..)
import Dresses.Api as DressesApi
import Home.Api as HomeApi
import NotFound.Api as NotFoundApi


decoder : Decoder Types.Model
decoder =
    decode Types.Model
        |> required "route" routerDecoder
        |> required "pageState" pageStateDecoder
        |> required "homeState" HomeApi.decoder
        |> required "dressesState" DressesApi.decoder
        |> required "notFoundState" NotFoundApi.decoder


encoder : Types.Model -> Json.Encode.Value
encoder model =
    Json.Encode.object
        [ ( "route", routerEncoder model.currentRoute )
        , ( "pageState", pageStateEncoder model.pageState )
        , ( "homeState", HomeApi.encoder model.homeState )
        , ( "dressesState", DressesApi.encoder model.dressesState )
        , ( "notFoundState", NotFoundApi.encoder model.notFoundState )
        ]


pageStateDecoder : Decoder Types.PageState
pageStateDecoder =
    oneOf
        [ map Types.Loaded (field "Loaded" pageDecoder)
        , map Types.Loaded (field "TransitioningFrom" pageDecoder)
        ]


pageDecoder : Decoder Types.Page
pageDecoder =
    oneOf
        [ map Types.Home (field "Home" HomeApi.decoder)
        , map Types.Dresses (field "Dresses" DressesApi.decoder)
        , map Types.NotFound (field "NotFound" NotFoundApi.decoder)
        ]


routerDecoder : Decoder Route
routerDecoder =
    string
        |> andThen
            (\route ->
                case route of
                    "HomeRoute" ->
                        succeed HomeRoute

                    "NotFoundRoute" ->
                        succeed NotFoundRoute

                    "DressesRoute" ->
                        succeed DressesRoute

                    _ ->
                        fail (route ++ " is not a recognized route for Route")
            )


routerEncoder : Route -> Json.Encode.Value
routerEncoder route =
    case route of
        NotFoundRoute ->
            Json.Encode.string "NotFoundRoute"

        HomeRoute ->
            Json.Encode.string "HomeRoute"

        DressesRoute ->
            Json.Encode.string "DressesRoute"


pageStateEncoder : Types.PageState -> Json.Encode.Value
pageStateEncoder pageState =
    case pageState of
        Types.Loaded page ->
            Json.Encode.object
                [ ( "Loaded", pageEncoder page )
                ]

        Types.TransitioningFrom page ->
            Json.Encode.object
                [ ( "TransitioningFrom", pageEncoder page )
                ]


pageEncoder : Types.Page -> Json.Encode.Value
pageEncoder page =
    case page of
        Types.Home subModel ->
            Json.Encode.object
                [ ( "Home", HomeApi.encoder subModel )
                ]

        Types.Dresses subModel ->
            Json.Encode.object
                [ ( "Dresses", DressesApi.encoder subModel )
                ]

        Types.NotFound subModel ->
            Json.Encode.object
                [ ( "NotFound", NotFoundApi.encoder subModel )
                ]
