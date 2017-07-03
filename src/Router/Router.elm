module Router.Router exposing (..)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)
import Router.Types as Route exposing (Route)


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Route.Home (Url.top)
        , Url.map Route.Dresses (Url.s "dresses")
        ]


routeToString : Route -> String
routeToString route =
    let
        hasPage =
            case route of
                Route.Home ->
                    "/"

                Route.Dresses ->
                    "/dresses"
    in
        "#" ++ hasPage


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Route.Home
    else
        parseHash route location
