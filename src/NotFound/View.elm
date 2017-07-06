module NotFound.View exposing (view)

import Html exposing (Html, div, text)
import NotFound.Types exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div []
        [ text model.title
        ]
