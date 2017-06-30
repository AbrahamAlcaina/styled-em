module Styles.Shared exposing (..)

import Html.CssHelpers exposing (withNamespace)
import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavLink


type CssIds
    = ReactiveLogo
    | BuyTickets


homepageNamespace =
    withNamespace "homepage"


css =
    (stylesheet << namespace "basic")
        []
