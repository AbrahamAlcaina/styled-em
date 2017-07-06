module Home.View exposing (view)

import Html exposing (Html, div, text)
import Home.Types exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div []
        [ text model.title
        ]
