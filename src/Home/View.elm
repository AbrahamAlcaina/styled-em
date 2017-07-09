module Home.View exposing (view)

import Html exposing (Html, div, text, h1, h4, b)
import Html.Attributes exposing (class, attribute)
import Home.Types exposing (Model, Msg)
import Components.Page exposing (page)

view : Model -> Html Msg
view model = page (head model) (body model)


body : Model -> Html Msg
body model =
    div []
        [ text model.title
        ]

head : Model -> Html Msg
head model =
    div [ class "page-header header-filter header-small"
    , attribute "data-parallax" "true"
    , attribute "style" "background-image: url('img/head.jpg');" ]
        [ div [ class "container" ]
            [ div [ class "row" ]
                [ div [ class "col-md-8 col-md-offset-2" ]
                    [ div [ class "brand" ]
                        [ h1 [ class "title" ]
                            [ text "Transform you Style" ]
                        , h4 []
                            [ text "JOIN A COMMUNITY OF THOUSANDS OF WOMEN SHARING THEIR STYLE."
                            , b []
                                [ text "25summer" ]
                            , text "for an extra 25% Off"
                            ]
                        ]
                    ]
                ]
            ]
        ]
