module Components.Navbar exposing (navbar)

import Html exposing (Html, div, button, text, ul, li, span, nav, a)
import Html.Attributes exposing (class, id, attribute, href)
import Router.Types exposing (Route(..))
import Router.Router exposing (routeToString)
import Translation.Components.Navbar as Translations


navbar =
    nav [ class "navbar navbar-default navbar-transparent navbar-fixed-top navbar-color-on-scroll"
    , attribute "color-on-scroll" "100"
    , id "sectionsNav" ]
        [ div [ class "container" ]
            [ div [ class "navbar-hader" ]
                [ button [ attribute "type" "button", class "navbar-toggle", attribute "data-toggle" "collapse", attribute "data-target" "#navigation-index" ]
                    [ span [ class "sr-only" ] [ text "toggle" ]
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    , span [ class "icon-bar" ] []
                    ]
                , a [ class "navbar-brand", href <| routeToString HomeRoute ]
                    [ text "Style-elm" ]
                ]
            , div [ class "collapse navbar-collapse", id "navigation-index" ]
                [ ul [ class "nav navbar-nav navbar-right" ]
                    [ viewLink Translations.menuDresses DressesRoute
                    , viewLink Translations.menuNotFound NotFoundRoute
                    ]
                ]
            ]
        ]


viewLink : String -> Route -> Html msg
viewLink name route =
    li [] [ a [ href <| routeToString route ] [ text name ] ]
