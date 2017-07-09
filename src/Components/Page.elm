module Components.Page exposing (page)

import Html exposing (Html, div, button, text)
import Html.Attributes exposing (class, attribute)


page header body =
    div [ class "wrapper" ]
        [ header
        , div [ class "main  main-raised" ]
            [ div [ class "container" ]
                [ body
                ]
            ]
        ]
