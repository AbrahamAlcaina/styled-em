module State exposing (update, subscriptions, init)

import Json.Decode exposing (decodeString)
import Navigation exposing (Location)
import Time
import Types exposing (..)
import Api exposing (decoder, encoder)
import Ports exposing (load, doload)
import Router.Router as Routing
import Router.Types as Routing
import Home.State as HomeState
import Dresses.State as DressesState
import NotFound.State as NotFoundState


subscriptions : Types.Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every
            (Time.second * 30)
            SaveModelTick
        , Ports.load Types.LoadModel
        ]


update : Types.Msg -> Types.Model -> ( Types.Model, Cmd Types.Msg )
update msg model =
    case msg of
        SaveModelTick _ ->
            ( model, encoder model |> Ports.save )

        LoadModel value ->
            case decodeString Api.decoder value of
                Err msg ->
                    let
                        x =
                            Debug.log "Not saved state" msg
                    in
                        ( model, Cmd.none )

                Ok val ->
                    ( val, Routing.modifyUrl val.currentRoute )

        SaveModel ->
            ( model, encoder model |> Ports.save )

        UrlChange route ->
            ( { model | currentRoute = Routing.fromLocation route }, Cmd.none )

        HomeMsg msg ->
            ( model, Cmd.none )

        DressesMsg msg ->
            ( model, Cmd.none )

        NotFoundMsg msg ->
            ( model, Cmd.none )


init : Location -> ( Types.Model, Cmd Msg )
init location =
    let
        -- TODO Review how to load the default page
        home =
            Home { title = "home" }
    in
        ( { currentRoute = Routing.fromLocation location
          , pageState =
                Loaded home
                {--
            , homeState : HomeState.init
            , dressesState : DressesState.init
            , notFoundState : NotFoundState.init
            --}
          }
        , Ports.doload ()
        )


setRoute : Routing.Route -> Model -> ( Model, Cmd Msg )
setRoute route model =
    case route of
        Routing.HomeRoute ->
            --( { model | pageState = model.homeState }, Cmd.none )
            ( model, Cmd.none )

        Routing.DressesRoute ->
            --( { model | pageState = model.dressesState }, Cmd.none )
            ( model, Cmd.none )

        Routing.NotFoundRoute ->
            --( { model | pageState = model.notFoundState }, Cmd.none )
            ( model, Cmd.none )
