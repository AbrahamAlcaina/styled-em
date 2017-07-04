module State exposing (update, subscriptions, init)

import Json.Decode exposing (decodeString)
import Navigation exposing (Location)
import Time
import Types exposing (..)
import Api exposing (decoder, encoder)
import Ports exposing (load, doload)
import Router.Router as Routing


subscriptions : Types.Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every
            (Time.second * 30)
            SaveModelTick
        , Ports.load Types.LoadModel
        ]


update : Msg -> Types.Model -> ( Types.Model, Cmd Msg )
update msg model =
    case msg of
        SaveModelTick _ ->
            ( model, encoder model |> Ports.save )

        LoadModel value ->
            case decodeString Api.decoder value of
                Err msg ->
                    let
                        x =
                            Debug.log "BOOM" msg
                    in
                        ( { model | click = 99 }, Cmd.none )

                Ok val ->
                    ( { model | click = val.click }, Cmd.none )

        SaveModel ->
            ( model, encoder model |> Ports.save )

        Increment ->
            ( { model | click = model.click + 1 }, Cmd.none )

        Decrement ->
            ( { model | click = model.click - 1 }, Cmd.none )

        UrlChange route ->
            ( { model | currentRoute = Routing.fromLocation route }, Cmd.none )


init : Location -> ( Model, Cmd Msg )
init location =
    let
        route =
            Routing.fromLocation location
    in
        ( { click = 0
          , currentRoute = route
          }
        , Ports.doload ()
        )
