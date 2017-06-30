module Styles.Inline exposing (css)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (..)


type CssClasses
    = NavBar


type CssIds
    = Page


css =
    (stylesheet << namespace "basic")
        [ body
            [ paddingTop (px 100)
            ]
        ]
