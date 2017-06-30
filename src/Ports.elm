port module Ports exposing (..)

import Types exposing (Model)


port save : Model -> Cmd msg


port load : (String -> msg) -> Sub msg


port doload : () -> Cmd msg
