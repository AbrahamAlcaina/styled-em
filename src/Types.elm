module Types exposing (..)

import Time exposing (..)


type alias Model =
    { click : Int
    }


type Msg
    = SaveModel
    | LoadModel String
    | Increment
    | Decrement
    | SaveModelTick Time
