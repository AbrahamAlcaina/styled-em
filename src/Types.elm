module Types exposing (..)

import Time exposing (..)
import Navigation
import Router.Types as Routing
import Home.Types as Home
import Dresses.Types as Dresses
import NotFound.Types as NotFound


type Page
    = Home Home.Model
    | Dresses Dresses.Model
    | NotFound NotFound.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


type alias Model =
    { currentRoute : Routing.Route
    , pageState :
        PageState
        {--
    , homeState : Home.Model
    , dressesState : Dresses.Model
    , notFoundState : NotFound.Model
    --}
    }


type Msg
    = SaveModel
    | LoadModel String
    | SaveModelTick Time
    | UrlChange Navigation.Location
    | HomeMsg Home.Msg
    | DressesMsg Dresses.Msg
    | NotFoundMsg NotFound.Msg
