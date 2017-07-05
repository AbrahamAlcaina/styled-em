module Dresses.View exposing (view)

import Html exposing (Html, div, text)
import Dresses.Types exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div []
        [ text "Dresses"
        ]
