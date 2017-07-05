module View exposing (view)

import Dresses.View
import Home.View
import Html exposing (Html, a, br, button, div, text)
import NotFound.View
import Router.Router exposing (href)
import Router.Types exposing (Route(..))
import Types exposing (Page(..), Msg(..), PageState(..))


viewLink : String -> Route -> Html msg
viewLink name route =
    a [ href route ] [ text name ]


view : Types.Model -> Html Types.Msg
view model =
    div []
        [ div []
            [ text "menu"
            , viewLink "home" HomeRoute
            , viewLink "dresses" DressesRoute
            , viewLink "notfound" NotFoundRoute
            ]
        , viewPage <| getPage model.pageState
        ]


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page


viewPage : Page -> Html Types.Msg
viewPage page =
    case page of
        Home subModel ->
            Home.View.view subModel |> Html.map HomeMsg

        Dresses subModel ->
            Dresses.View.view subModel |> Html.map DressesMsg

        NotFound subModel ->
            NotFound.View.view subModel |> Html.map NotFoundMsg
