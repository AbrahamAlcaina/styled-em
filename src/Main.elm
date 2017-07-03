module Main exposing (..)

import View exposing (view)
import State exposing (update)
import Navigation exposing (Location)
import Router.Router exposing (fromLocation)
import Router.Types exposing (Route)
import Types exposing (Msg)


main : Program Never Types.Model Types.Msg
main =
    Navigation.program fromLocation
        { view = view
        , init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        }
