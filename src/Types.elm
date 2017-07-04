module Types exposing (..)

import Time exposing (..)
import Router.Types as Routing
import Navigation
import Json.Decode


type alias Model =
    { click : Int
    , currentRoute : Routing.Route
    }


type Msg
    = SaveModel
    | LoadModel String
    | Increment
    | Decrement
    | SaveModelTick Time
    | UrlChange Navigation.Location
