module State exposing (update, subscriptions, init)

import Json.Decode exposing (decodeString)
import Navigation exposing (Location)
import Time
import Types exposing (..)
import Api exposing (decoder, encoder)
import Ports exposing (load, doload)
import Router.Router as Routing
import Router.Types as RoutingType
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

        UrlChange location ->
            Routing.fromLocation location |> setRoute model

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
          , pageState = Loaded home
          , homeState = HomeState.init
          , dressesState = DressesState.init
          , notFoundState = NotFoundState.init
          }
        , Ports.doload ()
        )


setRoute : Types.Model -> RoutingType.Route -> ( Types.Model, Cmd Msg )
setRoute model route =
    let
        newModel =
            model
                |> saveOldPageState
                |> setCurrentState route
    in
        ( newModel, encoder newModel |> Ports.save )


saveOldPageState : Types.Model -> Types.Model
saveOldPageState model =
    case model.pageState of
        Types.Loaded (Types.Home submodel) ->
            { model | homeState = submodel }

        Types.Loaded (Types.Dresses submodel) ->
            { model | dressesState = submodel }

        Types.Loaded (Types.NotFound submodel) ->
            { model | notFoundState = submodel }

        Types.TransitioningFrom _ ->
            model


setCurrentState : RoutingType.Route -> Types.Model -> Types.Model
setCurrentState route model =
    let
        page =
            case route of
                RoutingType.HomeRoute ->
                    Home model.homeState

                RoutingType.DressesRoute ->
                    Dresses model.dressesState

                RoutingType.NotFoundRoute ->
                    NotFound model.notFoundState
    in
        { model | currentRoute = route, pageState = Loaded page }
