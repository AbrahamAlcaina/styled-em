module Styles.Main exposing (css)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar


type CssIds
    = Page


css =
    (stylesheet << namespace "basic")
        [ id Page
            [ padding (px 10)
            ]
        ]
