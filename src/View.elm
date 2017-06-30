module View exposing (view)

import Html exposing (Html, br, button, div, text)
import Html.Events exposing (onClick)
import Types


view : Types.Model -> Html Types.Msg
view model =
    div []
        [ button [ onClick Types.Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Types.Increment ] [ text "+" ]
        , br [] []
        ]
