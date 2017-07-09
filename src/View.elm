module View exposing (view)

import Dresses.View
import Home.View
import Html exposing (Html, a, br, button, div, text, ul, li, nav, span)
import Html.Attributes exposing (class, attribute, id)
import NotFound.View
import Router.Router exposing (href)
import Types exposing (Page(..), Msg(..), PageState(..))
import Translation.View as Translations
import Components.Navbar exposing (navbar)


view : Types.Model -> Html Types.Msg
view model =
    div []
        [ navbar
        , div [ class "wrapper" ]
            [ viewPage <| getPage model.pageState
            ]
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
