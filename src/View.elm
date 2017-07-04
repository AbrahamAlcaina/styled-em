module View exposing (view)

import Html exposing (Html, br, button, div, text, a)
import Html.Events exposing (onClick)
import Types
import Router.Router exposing (href)
import Router.Types exposing (Route(..))

viewLink : String -> Route -> Html msg
viewLink name route=
  a [ href route ] [ text name ]


view : Types.Model -> Html Types.Msg
view model =
    div []
        [ button [ onClick Types.Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Types.Increment ] [ text "+" ]
        , viewLink "home" Home
        , viewLink "dresses" Dresses
        , viewLink "notfound" NotFoundRoute
        ]
