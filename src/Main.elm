module Main exposing (..)

import View exposing (view)
import State exposing (update)
import Types exposing (..)
import Navigation exposing (Location)
import Router.Router exposing (fromLocation)


main =
    Navigation.program UrlChange
        { view = view
        , init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        }
