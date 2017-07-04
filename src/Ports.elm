port module Ports exposing (..)

import Json.Encode


port save : Json.Encode.Value -> Cmd msg


port load : (String -> msg) -> Sub msg


port doload : () -> Cmd msg
