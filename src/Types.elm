module Types exposing (..)

import Time exposing (..)
import Router.Types exposing (Route)


type alias Model =
    { click : Int
    }


type Msg
    = SaveModel
    | LoadModel String
    | Increment
    | Decrement
    | SaveModelTick Time
    | Route
