module Home.View exposing (view)

import Html exposing (Html, div, text)
import Home.Types exposing (Model, Msg)

view : Model -> Html msg
view model =
    div []
        [ text "Home"
        ]
