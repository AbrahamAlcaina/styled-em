module Main exposing (..)

import Html exposing (Html)
import View exposing (view)
import State exposing (update)
import Types


main : Program Never Types.Model Types.Msg
main =
    Html.program
        { view = view
        , init = State.init
        , update = State.update
        , subscriptions = State.subscriptions
        }
