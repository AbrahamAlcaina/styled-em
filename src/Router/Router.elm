module Router.Router exposing (..)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing (Parser, parseHash, s, string)
import Router.Types as Route exposing (Route)


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Route.HomeRoute (Url.top)
        , Url.map Route.DressesRoute (Url.s "dresses")
        ]


routeToString : Route -> String
routeToString route =
    let
        hasPage =
            case route of
                Route.HomeRoute ->
                    "/"

                Route.DressesRoute ->
                    "/dresses"

                Route.NotFoundRoute ->
                    "/notfound"
    in
        "#" ++ hasPage


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Route
fromLocation location =
    if String.isEmpty location.hash then
        Route.HomeRoute
    else
        let
            r =
                parseHash route location
        in
            case r of
                Just route ->
                    route

                Nothing ->
                    Route.NotFoundRoute
