module Main exposing (..)

import View exposing (view)
import State exposing (update)
import Types exposing (..)
import Navigation exposing (Location)

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { view = view
        , init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        }
